#!/usr/bin/env python
# -*- coding: utf-8 -*-

import torch
from torch import nn
from transformers import AutoTokenizer
from .base import PushToHubFriendlyModel
from ..prompt.modeling_auto import AutoModelForSeq2SeqLM



class Model(PushToHubFriendlyModel):
    def __init__(self, args):
        super().__init__()
        self.args = args

        """The prefix-tuning code"""

        self.preseqlen = args.prefix_tuning.prefix_sequence_length
        self.mid_dim = args.prefix_tuning.mid_dim


        # Load tokenizer and model.
        self.tokenizer = AutoTokenizer.from_pretrained(args.bert.location, use_fast=False)
        self.pretrain_model = AutoModelForSeq2SeqLM.from_pretrained(
            args.bert.location
        )
        self.config = self.pretrain_model.config
        print('self.confi:', self.config)
        from ..prompt.modeling_bart import BartForConditionalGeneration
        from ..prompt.modeling_t5 import T5ForConditionalGeneration

        if isinstance(self.pretrain_model, BartForConditionalGeneration):
            self.match_n_layer = self.config.decoder_layers
            self.match_n_head = self.config.decoder_attention_heads
            self.n_embd = self.config.d_model
            assert self.n_embd % self.match_n_head == 0
            self.match_n_embd = self.n_embd // self.match_n_head # huggingface BART's dim of kv need to be calculated
        elif isinstance(self.pretrain_model, (T5ForConditionalGeneration)):
            self.match_n_layer = self.config.num_decoder_layers
            self.match_n_head = self.config.num_heads
            self.n_embd = self.config.d_model
            self.match_n_embd = self.config.d_kv
        else:
            raise ValueError("Other models are not supported yet!")

        if args.special_tokens:
            self.tokenizer.add_tokens([v for k, v in args.special_tokens])
            self.pretrain_model.resize_token_embeddings(len(self.tokenizer))

        # Prefix related.
        self.register_buffer('input_tokens', torch.arange(self.preseqlen).long())
        print(f'match_n_layer: {self.match_n_layer}, match_n_head: {self.match_n_head}, n_embd: {self.n_embd}, match_n_embd:{self.match_n_embd}' )
        # match_n_layer: 12, match_n_head: 12, n_embd: 768, match_n_embd:64

        self.wte = nn.Embedding(self.preseqlen, self.n_embd)
        self.control_trans = nn.Sequential(
            nn.Linear(self.n_embd, self.mid_dim),
            nn.Tanh(),
            nn.Linear(self.mid_dim, self.match_n_layer * 2 * self.match_n_head * self.match_n_embd),
        )
        if self.args.model.knowledge_usage == 'separate':
            self.knowledge_trans = nn.Sequential(
                nn.Linear(self.n_embd, self.mid_dim),
                nn.Tanh(),
                nn.Linear(self.mid_dim, self.match_n_layer * 2 * self.match_n_head * self.match_n_embd),
            )

        self.wte_enc = nn.Embedding(self.preseqlen, self.n_embd)
        self.control_trans_enc = nn.Sequential(
            nn.Linear(self.n_embd, self.mid_dim),
            nn.Tanh(),
            nn.Linear(self.mid_dim, self.match_n_layer * 2 * self.match_n_head * self.match_n_embd),
        )
        if self.args.model.knowledge_usage == 'separate':
            self.knowledge_trans_enc = nn.Sequential(
                nn.Linear(self.n_embd, self.mid_dim),
                nn.Tanh(),
                nn.Linear(self.mid_dim, self.match_n_layer * 2 * self.match_n_head * self.match_n_embd),
            )

        self.wte_dec = nn.Embedding(self.preseqlen, self.n_embd)
        self.control_trans_dec = nn.Sequential(
            nn.Linear(self.n_embd, self.mid_dim),
            nn.Tanh(),
            nn.Linear(self.mid_dim, self.match_n_layer * 2 * self.match_n_head * self.match_n_embd),
        )

        # Knowledge prompt.
        if self.args.model.knowledge_usage == 'separate':
            self.knowledge_trans_dec = nn.Sequential(
                nn.Linear(self.n_embd, self.mid_dim),
                nn.Tanh(),
                nn.Linear(self.mid_dim, self.match_n_layer * 2 * self.match_n_head * self.match_n_embd),
            )

        # ZZHAO: Comp_GCN leverage
        if self.args.model.use_pretrained_gcn:
            self.gcn_emb_trans = nn.Sequential(
                nn.Linear(self.args.model.gcn_dim, self.mid_dim//2),
                nn.Tanh(),
                nn.Linear(self.mid_dim//2, self.mid_dim),
            )
            # self.combined = nn.Sequential(
            #     nn.Linear(self.n_embd, self.mid_dim),
            #     nn.Tanh(),
            #     nn.Linear(self.mid_dim, self.n_embd),
            # )
            # self.lstm = nn.LSTM(self.n_embd, self.n_embd, 1,bidirectional=True)
            # self.layer_1 = nn.Linear(self.n_embd*6, self.n_embd)

        self.dropout = nn.Dropout(args.prefix_tuning.prefix_dropout)

        if self.args.model.freeze_plm:
            for param in self.pretrain_model.parameters():
                param.requires_grad = False
        if self.args.model.freeze_prefix:
            for param in self.wte.parameters():
                param.requires_grad = False
            for param in self.control_trans.parameters():
                param.requires_grad = False
            for param in self.wte_dec.parameters():
                param.requires_grad = False
            for param in self.control_trans_dec.parameters():
                param.requires_grad = False
            for param in self.wte_enc.parameters():
                param.requires_grad = False
            for param in self.control_trans_enc.parameters():
                param.requires_grad = False

    def get_prompt(self, bsz=None, sample_size=1, description=None, knowledge=None):
        old_bsz = bsz
        bsz = bsz * sample_size
        input_tokens = self.input_tokens.unsqueeze(0).expand(bsz, -1) #[2, 10]
        temp_control = self.wte(input_tokens) # [2, 10, 768])

        if description is not None:
            temp_control = temp_control + description.repeat_interleave(sample_size, dim=0).unsqueeze(1)
        past_key_values = self.control_trans(temp_control)  # bsz, seqlen, layer*emb : [2, 10, 18432]
    
        if knowledge is not None:
            past_key_values = torch.cat([past_key_values, self.knowledge_trans(knowledge.repeat_interleave(sample_size, dim=0))], dim=1)
            #[2, 522, 18432])


        bsz, seqlen, _ = past_key_values.shape
        past_key_values = past_key_values.view(
            bsz, seqlen, self.match_n_layer * 2, self.match_n_head, self.match_n_embd
        ) #[2, 522, 24, 12, 64])
        past_key_values = self.dropout(past_key_values)
        past_key_values = past_key_values.permute([2, 0, 3, 1, 4]).split(2) # 12*[2, 2, 12, 522, 64]


        # Cross prefix
        temp_control_dec = self.wte_dec(input_tokens)
        if description is not None:
            temp_control_dec = temp_control_dec + description.repeat_interleave(sample_size, dim=0).unsqueeze(1)
        past_key_values_dec = self.control_trans_dec(
            temp_control_dec
        )  # bsz, seqlen, layer*emb
        if knowledge is not None:
            past_key_values_dec = torch.cat([past_key_values_dec, self.knowledge_trans_dec(knowledge.repeat_interleave(sample_size, dim=0))], dim=1)

        bsz, seqlen, _ = past_key_values_dec.shape
        past_key_values_dec = past_key_values_dec.view(
            bsz, seqlen, self.match_n_layer * 2, self.match_n_head, self.match_n_embd
        )
        past_key_values_dec = self.dropout(past_key_values_dec)
        past_key_values_dec = past_key_values_dec.permute([2, 0, 3, 1, 4]).split(2)

        # Encoder prefix
        input_tokens_enc = (
            self.input_tokens.unsqueeze(0).expand(old_bsz, -1)
        )
        temp_control_enc = self.wte_enc(input_tokens_enc)
        if description is not None:
            temp_control_enc = temp_control_enc + description.unsqueeze(1)
        past_key_values_enc = self.control_trans_enc(
            temp_control_enc
        )  # bsz, seqlen, layer*emb
        if knowledge is not None:
            past_key_values_enc = torch.cat([past_key_values_enc, self.knowledge_trans_enc(knowledge)], dim=1)

        bsz_enc, seqlen, _ = past_key_values_enc.shape
        past_key_values_enc = past_key_values_enc.view(
            bsz_enc,
            seqlen,
            self.match_n_layer * 2,
            self.match_n_head,
            self.match_n_embd,
        )
        past_key_values_enc = self.dropout(past_key_values_enc)
        past_key_values_enc = past_key_values_enc.permute([2, 0, 3, 1, 4]).split(2)

        result = []
        for i, key_val in enumerate(past_key_values):
            temp = dict()
            temp["decoder_prompt"] = {
                "prev_key": key_val[0].contiguous(),# [2, 12, 10, 64]
                "prev_value": key_val[1].contiguous(),# [2, 12, 10, 64]
                "prev_key_padding_mask": torch.zeros(bsz, seqlen) #[2, 10]
                    .to(key_val.device)
                    .bool()
                # bsz, preseqlen 
            } 
            key_val_dec = past_key_values_dec[i]
            temp["cross_attention_prompt"] = {
                "prev_key": key_val_dec[0].contiguous(),
                "prev_value": key_val_dec[1].contiguous(),
                "prev_key_padding_mask": torch.zeros(bsz, seqlen)
                    .to(key_val_dec.device)
                    .bool(),
            } 
            key_val_enc = past_key_values_enc[i]
            temp["encoder_prompt"] = {
                "prev_key": key_val_enc[0].contiguous(),
                "prev_value": key_val_enc[1].contiguous(),
                "prev_key_padding_mask": torch.zeros(bsz_enc, seqlen)
                    .to(key_val_enc.device)
                    .bool(),
            } 
            result.append(temp)

        return result

    def get_description_representation(self, kwargs):
        if self.args.model.use_description and self.args.model.map_description:
            description_input_ids = kwargs.pop("description_input_ids")
            description_attention_mask = kwargs.pop("description_attention_mask")
            if self.args.bert.location in ["t5-small", "t5-base", "t5-large", "t5-3b", "t5-11b"]:
                description_outputs = self.pretrain_model.encoder(
                    input_ids=description_input_ids,
                    attention_mask=description_attention_mask,
                )
                description = description_outputs.last_hidden_state[:, 0]  # TODO: the first token from the encoder.
            elif self.args.bert.location in ["facebook/bart-base", "facebook/bart-large"]:
                description_outputs = self.pretrain_model.model.encoder(
                    input_ids=description_input_ids,
                    attention_mask=description_attention_mask,
                )
                description = description_outputs.last_hidden_state[:, 0]  # TODO: the first token from the encoder.
            else:
                raise ValueError()
        else:
            description = None

        return description

    def get_knowledge_representation(self, kwargs):
        if self.args.model.knowledge_usage == 'separate':
            knowledge_input_ids = kwargs.pop("knowledge_input_ids", None)
            knowledge_attention_mask = kwargs.pop("knowledge_attention_mask", None)
            if self.args.bert.location in ["t5-small", "t5-base", "t5-large", "t5-3b", "t5-11b", "Salesforce/codet5-base"]:
                knowledge_outputs = self.pretrain_model.encoder(
                    input_ids=knowledge_input_ids,
                    attention_mask=knowledge_attention_mask,
                )
                knowledge = knowledge_outputs.last_hidden_state
            elif self.args.bert.location in ["facebook/bart-base", "facebook/bart-large"]:
                knowledge_outputs = self.pretrain_model.model.encoder(
                    input_ids=knowledge_input_ids,
                    attention_mask=knowledge_attention_mask,
                )
                print(f'knowledge_outputs:', knowledge_outputs)
                knowledge = knowledge_outputs.last_hidden_state # [2, 512, 768]
            else:
                raise ValueError()
        elif self.args.model.knowledge_usage == 'concatenate':
            knowledge = None
        else:
            raise ValueError()

        return knowledge



    def forward(self,
                input_ids,
                attention_mask,
                labels,
                **kwargs, # extra data inputs, e.g., tag_embeddings and property_embddings
                ):
        
        for key, value in kwargs.items():
            print(f'{key}:{value.shape}') #[2, 90, 200]

        bsz = input_ids.shape[0]

        # Encode description.
        description_representation = self.get_description_representation(kwargs)


        # Encode knowledge.
        knowledge_representation = self.get_knowledge_representation(kwargs) #[2, 512]

        past_prompt = self.get_prompt(
            bsz=bsz, description=description_representation, knowledge=knowledge_representation,
        )#12 

        out = self.pretrain_model(
                        input_ids=input_ids,
                        attention_mask=attention_mask,
                        labels=labels, #[2, 512]
                        past_prompt=past_prompt,
                    )
        ##################################ZZHAO#############################################
        # ZZHAO: illustrating the vanillar decoder output and encoder input in text
        # for k, v in out.items():
        #     print(k)
        decoder_input_ids = self.pretrain_model._shift_right(labels) # [2, 512]. It represents the input to the decoder part of the model. 
        output_ids = self.pretrain_model.generate(input_ids=decoder_input_ids, past_prompt=past_prompt)
        for item in input_ids:
            print('encoder padding input sequence:', self.tokenizer.decode(item))
        for item in decoder_input_ids:
            print('decoder padding target sequence:', self.tokenizer.decode(item))
        for item in output_ids:
            print('generated Cypher tokens:', self.tokenizer.decode(item)) 
        ##################################ZZHAO#############################################

        encoder_last_hidden_state = out.encoder_last_hidden_state  #[2, 512, 768]
        if self.args.model.use_pretrained_gcn:
            tag_gcn_emb = self.gcn_emb_trans(kwargs['tag_embeddings']) #[2, 90, 512]
            prop_gcn_emb = self.gcn_emb_trans(kwargs['property_embeddings'])
            ent_gcn_emb = torch.einsum('ijk, ijk->ik', tag_gcn_emb, prop_gcn_emb) #[2, 512]

            entity_gcn_emb= torch.unsqueeze(ent_gcn_emb, -1)  #[2, 512, 1]
            aligned_entity_gcn_emb= nn.functional.interpolate(
                entity_gcn_emb, size=encoder_last_hidden_state.size()[2:], mode='linear', align_corners=False
            )#[2, 512, 768])

            encoder_outputs= tuple([torch.einsum('ijk,ijk->ijk', encoder_last_hidden_state, aligned_entity_gcn_emb) for _ in range(self.match_n_layer)]) 

            out_ = self.pretrain_model(input_ids=input_ids, 
                                        attention_mask=attention_mask,
                                        encoder_outputs=encoder_outputs,
                                        labels = labels,
                                        past_prompt=past_prompt) # logits shape: [2, 521, 32103]
            print(f'T5 loss: {out.loss}, leveraged_model loss output: {out_.loss}')

            return {'loss': out_.loss}

        return {'loss': out.loss}

    def generate(self,
                 input_ids,
                 attention_mask,
                 **kwargs):

        bsz = input_ids.shape[0]

        # Encode description.
        description_representation = self.get_description_representation(kwargs)

        # Encode knowledge.
        knowledge_representation = self.get_knowledge_representation(kwargs)

        past_prompt = self.get_prompt(
            bsz=bsz, sample_size=kwargs['num_beams'], description=description_representation, knowledge=knowledge_representation,
        )


        generated_ids = self.pretrain_model.generate(
            input_ids=input_ids,
            attention_mask=attention_mask,
            past_prompt=past_prompt,
            use_cache=True,
            **kwargs,
        )

        return generated_ids



