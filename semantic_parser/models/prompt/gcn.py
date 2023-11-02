import torch
import torch.nn as nn
import torch.nn.functional as F
import numpy as np
from torch.nn.utils.rnn import pad_packed_sequence, pack_padded_sequence
from torch.autograd import Variable
from torch.utils.data import Dataset, DataLoader
from torch.nn import Parameter
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
import pickle
from transformers import AutoTokenizer, T5ForConditionalGeneration

# from transformers import T5Tokenizer, T5EncoderModel
# t5_encoder = T5EncoderModel.from_pretrained('t5-base')

class GCN(nn.Module):
	def __init__(self, t5, kg_emb_mode, ent_emb_dim, k_w, ker_sz, k_h, num_filt, hidden_dim, feat_drop, dropout,  gamma=40.0):
		super(GCN, self).__init__()
		self.kg_emb_mode = kg_emb_mode
		# self.ent_num = ent_num
		self.ent_emb_dim = ent_emb_dim
		self.k_w = k_w
		self.ker_sz = ker_sz
		self.k_h = k_h
		self.num_filt = num_filt
		self.gamma = gamma

		# self.relation_dim = self.ent_emb_dim
		self.hidden_dim = hidden_dim
		self.t5_model = T5ForConditionalGeneration.from_pretrained(t5, return_dict=True)
		

		# set entity and word embedding matrix
		# self.ent_embs = nn.Embedding( ent_emb_dim, hidden_dim)
		# self.hidden2rel = nn.Linear(self.hidden_dim, self.relation_dim)

		# CompGCN encoder
		self.hidden_drop2	= torch.nn.Dropout(dropout)
		flat_sz_h		= int(2*self.k_w) - self.ker_sz + 1
		flat_sz_w		= self.k_h - self.ker_sz + 1
		self.bn0	= torch.nn.BatchNorm2d(1)
		self.bn1	= torch.nn.BatchNorm2d(self.num_filt)
		self.bn2	= torch.nn.BatchNorm1d(self.ent_emb_dim)
		self.feature_drop	= torch.nn.Dropout(feat_drop)
		self.m_conv1		= torch.nn.Conv2d(1, out_channels=self.num_filt, kernel_size=(self.ker_sz, self.ker_sz), stride=1, padding=0, bias=True)
		self.flat_sz		= flat_sz_h*flat_sz_w*self.num_filt
		self.fc			= torch.nn.Linear(self.flat_sz, self.ent_emb_dim)
		self.register_parameter('bias', Parameter(torch.zeros(self.ent_emb_dim)))
		
	
		# KG embed mode
		if self.kg_emb_mode == 'ConvE':
			self.getScores = self.ConvE
		elif self.kg_emb_mode == 'TransE':
			self.getScores = self.TransE
		elif self.kg_emb_mode == 'Distmult':
			self.getScores = self.Distmult
		elif self.kg_emb_mode == 'ComplEx':
			self.getScores = self.ComplEx
		else:
			print('Incorrect model specified:', self.kg_emb_mode)
			exit(0)

		self.criteria = torch.nn.BCELoss()

	def loss(self, pred, true_label):
		return self.criteria(pred, true_label)

	# def applyNonLinear(self, outputs):
	# 	outputs = self.hidden2rel(outputs)
	# 	return outputs

	def concat(self, e1_embed, rel_embed):
		e1_embed	= e1_embed.view(-1, 1, self.ent_emb_dim)
		rel_embed	= rel_embed.view(-1, 1, self.ent_emb_dim)
		stack_inp	= torch.cat([e1_embed, rel_embed], 1)
		stack_inp	= torch.transpose(stack_inp, 2, 1).reshape((-1, 1, 2*self.k_w, self.k_h))
		return stack_inp

	def TransE(self,sub_emb, rel_emb, all_ent):
		# all_ent = self.ent_embs.weight.data
		obj_emb	= sub_emb + rel_emb
		x = self.gamma - torch.norm(obj_emb.unsqueeze(1) - all_ent, p=1, dim=2)		
		# score	= torch.sigmoid(x)
		return x

		
	def Distmult(self, sub_emb, rel_emb, all_ent):
		# all_ent = self.ent_embs.weight.data #[512, 768]
		obj_emb	= sub_emb * rel_emb
		x = torch.mm(obj_emb, all_ent.transpose(1, 0)) #[100, 512]
		# x += self.bias.expand_as(x) #[100. 512]
		# score = torch.sigmoid(x)
		return x
	
		
	def ComplEx(self, sub_emb, rel_emb, all_ent):
		# all_ent = self.ent_embs.weight.data
		rel_emb_re, rel_emb_im = (t.contiguous() for t in rel_emb.chunk(2, dim=1))
		o_emb_re, o_emb_im = (t.contiguous() for t in all_ent.chunk(2, dim=1))
		s_all = torch.cat((sub_emb, sub_emb), dim=1)
		r_all = torch.cat((rel_emb_re, rel_emb, -rel_emb_im), dim=1)
		o_all = torch.cat((all_ent, o_emb_im, o_emb_re), dim=1)
		obj_emb = (s_all * r_all).mm(o_all.transpose(0, 1))
		# score = torch.sigmoid(obj_emb)
		return obj_emb

		
	def ConvE(self, sub_emb, rel_emb, all_ent):
		# all_ent = self.ent_embs.weight.data
		stk_inp			= self.concat(sub_emb, rel_emb) # torch.Size([100, 1, 2*16, 24])
		x				= self.bn0(stk_inp)
		x				= self.m_conv1(x)
		x				= self.bn1(x)
		x				= F.relu(x)
		x				= self.feature_drop(x)
		x				= x.view(-1, self.flat_sz)
		x				= self.fc(x)
		x				= self.hidden_drop2(x)
		x				= self.bn2(x)
		x				= F.relu(x)
		x = torch.mm(x, all_ent.transpose(1,0))
		# x += self.bias.expand_as(x)
		# score = torch.sigmoid(x)
		return x
	


	def forward(self, schema_input_ids):
		t5_schema_emb = self.t5_model.encoder.embed_tokens(schema_input_ids) #[ 300, 768]
		# t5_encoder_outputs = t5_encoder(input_ids=schema_input_ids.unsqueeze(dim=0))
		# t5_schema_emb = t5_encoder_outputs.last_hidden_state.squeeze(dim=0)#[1, 300, 768]
		# print("t5_schema_emb:", t5_schema_emb.shape, t5_schema_emb.get_device())
		sub_emb = t5_schema_emb[:100]
		rel_emb = t5_schema_emb[100:200]
		pred_dist = self.getScores(sub_emb, rel_emb, t5_schema_emb)
		return  pred_dist 
	

	def get_score_ranked(self, t5_schema_emb):
		sub_emb = t5_schema_emb[:100]
		rel_emb = t5_schema_emb[100:200]
		# obj_emb = t5_schema_emb[200:]
		scores = self.getScores(sub_emb, rel_emb)
		return scores

	def load_ent_embs(self, embedding_matrix):
		self.ent_embs.weight.data.copy_(torch.from_numpy(embedding_matrix))
		self.ent_embs.weight.requires_grad = True
		return





