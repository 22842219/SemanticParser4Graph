#!/usr/bin/env python
# -*- coding: utf-8 -*-
import torch
from torch import nn
from .base import PushToHubFriendlyModel
from transformers import AutoModelForSeq2SeqLM, AutoTokenizer


class Model(PushToHubFriendlyModel):
    def __init__(self, args):
        super().__init__()
        self.args = args
        self.mid_dim = args.fine_tuning.mid_dim

        # Load tokenizer and model.
        self.tokenizer = AutoTokenizer.from_pretrained(args.bert.location, use_fast=False)
        self.pretrain_model = AutoModelForSeq2SeqLM.from_pretrained(
            args.bert.location,
        )
        self.config = self.pretrain_model.config

        if args.special_tokens:
            self.tokenizer.add_tokens([v for k, v in args.special_tokens])
            self.pretrain_model.resize_token_embeddings(len(self.tokenizer))

        # ZZHAO: Comp_GCN leverage
        if self.args.model.use_pretrained_gcn:
            self.gcn_emb_trans = nn.Sequential(
                nn.Linear(self.args.model.gcn_dim, self.mid_dim//2),
                nn.Tanh(),
                nn.Linear(self.mid_dim//2, self.mid_dim),
            )


    def forward(self, input_ids, attention_mask, labels, **kwargs):
        out = self.pretrain_model(
            input_ids=input_ids,
            attention_mask=attention_mask,
            use_cache=False,
            labels=labels,
        )
        encoder_last_hidden_state = out.encoder_last_hidden_state  #[2, 512, 768]
        if self.args.model.use_pretrained_gcn and  'tag_embeddings' in kwargs:
            tag_gcn_emb = self.gcn_emb_trans(kwargs['tag_embeddings']) #[2, 90, 512]
            prop_gcn_emb = self.gcn_emb_trans(kwargs['property_embeddings'])
            ent_gcn_emb = torch.einsum('ijk, ijk->ik', tag_gcn_emb, prop_gcn_emb) #[2, 512]

            entity_gcn_emb= torch.unsqueeze(ent_gcn_emb, -1)  #[2, 512, 1]
            aligned_entity_gcn_emb= nn.functional.interpolate(
                entity_gcn_emb, size=encoder_last_hidden_state.size()[2:], mode='linear', align_corners=False
            )#[2, 512, 768])

            encoder_outputs= tuple([torch.einsum('bij,bij->bij', encoder_last_hidden_state, aligned_entity_gcn_emb) for _ in range(self.match_n_layer)]) # batch element-wise product 

            out_ = self.pretrain_model(input_ids=input_ids, 
                                        attention_mask=attention_mask,
                                        encoder_outputs=encoder_outputs,
                                        labels = labels,
                                        past_prompt=past_prompt) # logits shape: [2, 521, 32103]
            print(f'T5 loss: {out.loss}, leveraged_model loss output: {out_.loss}')

            return {'loss': out_.loss}
        return {'loss': out.loss}

    def generate(self, input_ids, attention_mask, **kwargs):
        generated_ids = self.pretrain_model.generate(
            input_ids=input_ids,
            attention_mask=attention_mask,
            use_cache=True,
            **kwargs,
        )

        return generated_ids
