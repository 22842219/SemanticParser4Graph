import os, json
import pickle
from transformers import AutoTokenizer
import torch
from torch import nn
from transformers import AutoTokenizer, T5ForConditionalGeneration
model = T5ForConditionalGeneration.from_pretrained('t5-base', return_dict=True)
tokenizer = AutoTokenizer.from_pretrained('t5-base')
tokenizer.add_tokens([' <', ' <='])
root = '/home/22842219/Desktop/phd/SemanticParser4Graph/semantic_parser/data/text2cypher'

for split in ['train', 'dev']:

    with open(root+'/{}.txt'.format(split), 'r') as fp:
        tuples = fp.readlines()
        triplets = {}
        triplets_subword_token ={}
        triplets_embs = {}
        for each in tuples:
            triple = each.strip('\n').split('\t')
            if triple[1]=='has':
                triple[1]='has_column'
            schema_subword_token = tokenizer(triple, padding="max_length", max_length=100, return_tensors='pt')
            schema_ids = schema_subword_token.word_ids()[:-1]
            # print(f'schema_ids: {schema_ids}')
            schema_embs = model.encoder.embed_tokens(schema_subword_token['input_ids'])
            print(schema_embs.shape)
            # schema_subword_token = {
            #     'input_ids': schema_subword_token['input_ids'],
            #     'attention_mask': schema_subword_token['attention_mask']
            #     }
            # print(schema_subword_token)
            db_id = triple[0].split('.')[0]
            if db_id not in triplets:
                triplets[db_id]=[]
            if db_id not in triplets_subword_token:
                triplets_subword_token[db_id]= []
            if db_id not in triplets_embs:
                triplets_embs[db_id]=[]
            
            triplets[db_id].append(triple)
            triplets_subword_token[db_id].append(schema_subword_token['input_ids'].view(-1))
            triplets_embs[db_id].append(schema_embs)
            # print(triplets)
            # print(triplets_subword_token)
            # assert 1>2

    with open(root+'/{}_schema_subword_token.pkl'.format(split), 'wb') as fpp:
        pickle.dump(triplets_subword_token, fpp)
    
    with open(root+'/{}_schema_embs.pkl'.format(split), 'wb') as fp:
        pickle.dump(triplets_embs, fp)


    with open(root+'/{}_org.json'.format(split), 'r') as f:
        data = json.load(f)
        for ex in data:
            db_id = ex['db_id']
            schema = triplets[db_id]
            # print(schema)
            ex['schema_knowledge']=schema
            # ex['schema_subword_token']=schema['schema_subword_token']
        

    with open(root+'/{}.json'.format(split), 'w') as ff:
        json.dump(data, ff, indent=4)
