import os
import sys
import argparse
import json
import torch
import torch.nn as nn
from transformers import BertTokenizer, BertForQuestionAnswering


import json
import configparser
config = configparser.ConfigParser()

def main():

    tokenizer = BertTokenizer.from_pretrained('bert-base-uncased')
    model = BertForQuestionAnswering.from_pretrained('bert-base-uncased')


    config.read('../../../config.ini')
    filenames = config["FILENAMES"]
    train_folder = filenames['input_data_folder']
    json_folder = os.path.join(train_folder, 'spider')

    csv_output_folder = filenames['neo4j_import_folder']
    
    for split in ['train', 'dev']:
        #   output_file = os.path.join(output_base_folder, '{}.json'.format(split))           
        json_file = os.path.join(json_folder, '{}.json'.format(split))
        f = open(json_file)
        data = json.load(f)
        print(data[:2])

        for every in data[:2]:
            db_name = every['db_id']
            question = every['question']
            sql_query = every['sql_query']
            inputs = tokenizer(question, '', return_tensors='pt')
            print(inputs)




    # # question, text = "Who was Jim Henson?", "Jim Henson was a nice puppet"
    # # inputs = tokenizer(question, text, return_tensors='pt')
    # start_positions = torch.tensor([1])
    # end_positions = torch.tensor([3])

    # outputs = model(**inputs, start_positions=start_positions, end_positions=end_positions)
    # loss = outputs.loss
    # start_scores = outputs.start_logits
    # end_scores = outputs.end_logits

    # print(end_scores)

    # # Load train and validate data.
    # print("Loading train and validate data from '%s'" % opt.data)
    # train = torch.load(os.path.join(opt.data, 'train.pt'))
    # valid = torch.load(os.path.join(opt.data, 'valid.pt'))
    # print(' * number of training sentences: %d' % len(train))
    # print(' * maximum batch size: %d' % opt.batch_size)

    # # Load checkpoint if we resume from a previous training.
    # if opt.train_from:
    #     print('Loading checkpoint from %s' % opt.train_from)
    #     checkpoint = torch.load(
    #         opt.train_from, map_location=lambda storage, loc: storage)
    #     model_opt = checkpoint['opt']
    #     # I don't like reassigning attributes of opt: it's not clear
    #     opt.start_epoch = checkpoint['epoch'] + 1
    # else:
    #     checkpoint = None
    #     model_opt = opt

    # # Load fields generated from preprocess phase.
    # fields = load_fields(train, valid, checkpoint)

    # # Build model.
    # model = build_model(model_opt, fields, checkpoint)

    # # Build optimizer.
    # optim = build_optim(model, checkpoint)

    # # Do training.
    # train_model(model, train, valid, fields, optim)


if __name__ == "__main__":
    main()