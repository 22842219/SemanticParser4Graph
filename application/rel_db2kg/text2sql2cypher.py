import glob, os, json, argparse
from moz_sql_parser import parse
from schema2graph import DBengine

from cypher_parser import CyqueryStatmentParser
from pygments.lexers import get_lexer_by_name
from py2neo import Graph
lexer = get_lexer_by_name("py2neo.cypher")

import configparser
import shutil
from sql2cypher import build_lookup_dict, Formatter, execution_accuracy

from utils import Logger
logger = Logger()
config = configparser.ConfigParser()
config.read('../config.ini')
filenames = config["FILENAMES"]

raw_data_folder = filenames['raw_folder']
root = filenames['root']
raw_spider_folder = os.path.join(raw_data_folder, 'spider')

# spider_lookup_up= os.path.join(sp_folder, 'spider', 'lookup_dict.json')

neo4j_uri = filenames['neo4j_uri']
neo4j_user = filenames['neo4j_user']
neo4j_password = filenames['neo4j_password']
graph = Graph(neo4j_uri, auth = (neo4j_user, neo4j_password))


def main():

    parser = argparse.ArgumentParser(description='text2sql2cypher.')
    parser.add_argument('--uncased', help='uncased evaluation', action='store_true')
    args = parser.parse_args()


    db_folder = os.path.join(raw_spider_folder,  'database')
    db_paths=glob.glob(db_folder + '/**/*.sqlite', recursive = True) 


    # Output folder path
    sp_out_folder = os.path.join(root, 'sp_data_folder')  

    if not os.path.exists(sp_out_folder):
        os.makedirs(sp_out_folder) 

    # lookup_dict, pks_lookup_dict = build_lookup_dict(db_paths, sp_out_folder, uncased_flag = True)
    lookup_dict_json_file = '/home/22842219/Desktop/phd/SemanticParser4Graph/sp_data_folder/text2cypher/uncased/lookup_dict.json'
    with open(lookup_dict_json_file, 'r', encoding='utf-8') as f:
        lookup_dict=json.load(f)

    # read tables json file
    with open(os.path.join(raw_spider_folder, 'tables.json'), encoding='utf-8') as tables_file:
        tables = json.loads(tables_file.read())



    json_file = '/home/22842219/Desktop/phd/SemanticParser4Graph/application/rel_db2kg/text2sql2cypher/subspider/CodeT5_base_finetune_spider_with_cell_value/predictions_predict.json'
    # print(json_file)
    with open(json_file, 'r', encoding='utf-8') as f:
        data = json.load(f)

    # # test output file
    # cypher_file_musical  = os.path.join(raw_spider_folder, '{}_{}_cypher.json'.format('musical', split))

            
    spider_sub_pairs = []
    spider_sub_gold_sql = []
    spider_sub_tables = []

    correct_qa_pairs = [] 
    seleted_rel_dbs = []
    incorrect_qa_pairs = []

    incorrect = {}
    invalid_parsed_sql = {}
    intersect_sql = {}
    except_sql =  {}


    for i, every in enumerate(data):
        db_name = every['db_id']
        print(f'hey db: {db_name}')
        # if db_name in graph_db_list:
        if db_name:
            for evaluate in [incorrect, invalid_parsed_sql, intersect_sql, except_sql]:
                if db_name not in evaluate:
                    evaluate[db_name]=[]
                
            # 1. Extract database name, questions and SQL queries
            all_table_fields = lookup_dict[db_name.lower() if args.uncased else db_name]	
            print(every)
            question = every['question']
            sql_prediction = every['prediction']
            sql_gold= every['query']

            # 2. Access database, execute SQL query and get result.              
            db_path = os.path.join(db_folder, db_name, '{}.sqlite'.format(db_name))  
            # print(db_path) 
            engine = DBengine(db_path)
            sql_gold_result = []
            sql_preds_result = []
            try:
                # for res in  engine.execute(sql_query).fetchall():
                # 	if list(res) not in sql_result:
                # 		sql_result.append(list(res) )
                sql_gold_result = engine.execute(sql_gold).fetchall()
                sql_preds_result = engine.execute(sql_prediction).fetchall()
            except:
                logger.error('Attention in {}, exist Invalid sql query:{}'.format(db_name, sql_gold))
                continue


            try:
                # 3. Convert SQL prediction to Cypher query.	
                parsed_sql = parse(sql_prediction)	
                print(f'parsed_sql: {parsed_sql}')

                parsed_sql_gold = parse(sql_gold)

                try:
                    formatter  = Formatter( db_name, all_table_fields, graph)
                    sql_pred_2cypher = formatter.format(parsed_sql)
                    sql_gold_2cypher = formatter.format(parsed_sql_gold)
                    print("**************Cypher Query***************")
                    print(sql_pred_2cypher)
                    print("**************Cypher Query***************")

                    Cyparser = CyqueryStatmentParser(sql_pred_2cypher, 'statement', lexer)
                    tokenized_statment, token_types = Cyparser.get_tokenization()
                    # print("tokenized_statment:", tokenized_statment, token_types)
                    
                    # 4. Execute cypher query.. 
                    if sql_pred_2cypher and sql_gold_2cypher:
                        cypher_pred_res = graph.run(sql_pred_2cypher).data()
                        cypher_pred_ans = []
                        for dict_ in cypher_pred_res:
                            # if tuple(dict_.values()) not in cypher_ans:
                            cypher_pred_ans.append(tuple(dict_.values()))

                        cypher_gold_res = graph.run(sql_gold_2cypher).data()
                        cypher_gold_ans = []
                        for dict_ in cypher_gold_res:
                            # if tuple(dict_.values()) not in cypher_ans:
                            cypher_gold_ans.append(tuple(dict_.values()))

                        # sort results for the comparision
                        cypher_pred_sorted = sorted(cypher_pred_ans, key=lambda x: x[0])
                        cypher_gold_sorted =  sorted(cypher_gold_ans, key=lambda x: x[0] if bool(x[0]) else 0)
                        sql_preds_sorted =  sorted(sql_preds_result, key=lambda x: x[0] if bool(x[0]) else 0)
                        sql_gold_sorted =  sorted(sql_gold_result, key=lambda x: x[0] if bool(x[0]) else 0)
                        # print(f'sql_sorted: {sql_sorted}')
                        # print(f'cypher_sorted: {cypher_sorted}')


                        

                        if not set(sql_gold_sorted)-set(cypher_gold_sorted):
                            print(f'correct_ans: {cypher_pred_ans}') 
                            correct_qa_pairs.append({'db_id':db_name, 'question':question, 'text2sql': sql_prediction, 'sql_pred_2cypher':sql_pred_2cypher,\
                            'sql_gold':sql_gold, 'sql_gold_2cypher':sql_gold_2cypher, 'cypher_pred_ans':cypher_pred_ans, 'cypher_gold_ans': cypher_gold_ans})
                            spider_sub_pairs.append(data[i])
                            spider_sub_gold_sql.append(data[i]['query'])
                            if data[i]['db_id'] not in seleted_rel_dbs:
                                seleted_rel_dbs.append(data[i]['db_id'])
                                for db_tables in tables:
                                    if db_name==db_tables['db_id']:
                                        spider_sub_tables.append(db_tables)	
                        else:
                            print(f'incorrect_ans: {cypher_pred_ans}')
                            incorrect[db_name].append(i)
                            incorrect_qa_pairs.append({'db_id':db_name, 'question':question, 'sql_gold':sql_gold, 'sql_gold_2cypher':sql_gold_2cypher,\
                            'text2sql':sql_prediction, 'sql_pred_2cypher':sql_pred_2cypher, 'cypher_pred_ans':cypher_pred_ans, 'cypher_gold_ans': cypher_gold_ans})
                except:
                    # accumulate invalid or none generated cypher queries.
                    incorrect[db_name].append(i)
            
            except:
                invalid_parsed_sql[db_name].append(i)
                # logger.error('Attention in {}.db. Can not parse sql query:{}'.format(db_name, sql_query))

    # Output folder path
    text2sql2cypher_out = os.path.join(sp_out_folder, 'text2sql2cypher')  

    if not os.path.exists(text2sql2cypher_out):
        os.makedirs(text2sql2cypher_out) 

    metrics_file = os.path.join(text2sql2cypher_out, 'metrics.json')
    metrics = execution_accuracy(metrics_file, 'text2sql2cypher', len(correct_qa_pairs), incorrect, invalid_parsed_sql,
        intersect_sql, except_sql)
    print(f'metrics: {metrics}')

    correct_output_file = os.path.join(text2sql2cypher_out, '{}.json'.format('text2sql2cypher'))   
    with open(correct_output_file, 'a')  as f1:
        json.dump(correct_qa_pairs, f1, indent = 4)

    incorrect_output_file = os.path.join(text2sql2cypher_out, '{}_incorrect.json'.format('text2sql2cypher'))     
    with open(incorrect_output_file, 'a')  as f2:
        json.dump(incorrect_qa_pairs, f2, indent = 4)

    sub_spider = os.path.join(text2sql2cypher_out, '{}_spider_sub.json'.format('text2sql2cypher'))
    with open(sub_spider, 'a')  as f3:
        json.dump(spider_sub_pairs, f3, indent = 4)

    sub_gold = os.path.join(text2sql2cypher_out, '{}_gold.sql'.format('text2sql2cypher'))
    with open(sub_gold, 'a')  as f4:
        for item in spider_sub_gold_sql:
            # write each item on a new line
            f4.write("%s\n" % item)
            print('Done')

    sub_tables = os.path.join(text2sql2cypher_out, 'tables.json')     
    with open(sub_tables, 'a')  as f5:
        json.dump(spider_sub_tables, f5, indent = 4)

    # Output selected relational dbs folder path
    sub_rel_dbs_folder = os.path.join(text2sql2cypher_out, 'database')  
    if not os.path.exists(sub_rel_dbs_folder):
        os.makedirs(sub_rel_dbs_folder) 

    for db_name in seleted_rel_dbs:
        source_dir = os.path.join(db_folder, db_name)
        destination_dir = os.path.join(sub_rel_dbs_folder, db_name)
        if not os.path.exists(destination_dir):
            shutil.copytree(source_dir, destination_dir)


if __name__=="__main__":
	main()
