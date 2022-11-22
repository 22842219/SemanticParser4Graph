import os
import pandas as pd
from schema2graph import DBengine, RelDB, RelTable, TableSchema
from utils import Logger, save2json, read_json



def read_dataset(paths, logger):

    data_stat =[]

    for i, db_path in enumerate(paths):
        path_compodbnents = db_path.split(os.sep)
        db_name = path_compodbnents[-1].split('.')[0]

        # create realational database object.
        rel_db_object = RelDB(fdb = db_path, db_name=db_name)
        # engine = rel_db_object.engine
        table_infos = rel_db_object.engine.get_table_names()
        
        for table_info in table_infos:
            table_name = table_info[0]
            # Export tables to neo4j/import as csv files.                           
            table_records = rel_db_object.engine.get_table_values(table_name)
            table_headers = [desc[0] for desc in table_records.description]    
            print(f'table_name: {table_name}, table_headers {table_headers}' )
            

            df = pd.DataFrame(table_records.fetchall(), columns = table_headers)
            # Do not drop duplicate rows in place, because this action would affect the query results.
            # df.drop_duplicates(inplace=True)
            data = df.transpose().to_dict().values()  # to keep the origial data types.

            #NOTE: for statistics          
            every = {}  
            every['db_name'] = db_name
            every['table_name']= table_name
            every['num_of_rows'] = len(data)

            if table_headers == None:
                logger.error("There is no table headers in {} of {}!".format(table_name, db_name))
                every['empty_table'] = True
            else:
                every['empty_table'] = False
            

            # create table object. Note: one file w.r.t. one table object. 
            table_object = RelTable(table_name=table_name, table_headers=table_headers)

            # Check if relational table. If yes, then we rewrite the table name starting with
            table_constraints, pks_fks_dict =  rel_db_object.engine.get_outbound_foreign_keys(table_name) #R[{"column": from_, "ref_table": table_name, "ref_column": to_}]
            primary_keys = rel_db_object.engine.get_primay_keys(table_name) #R[(pk, )]

            check_compound_pk =  rel_db_object.engine.check_compound_pk(primary_keys)
                        
            every['primary_keys'] = primary_keys
            every['if_compound_pk'] = check_compound_pk
            every['table_headers'] = table_headers
            every['num_of_headers'] = len(table_headers)
            every['table_constraints'] = table_constraints
            if len(table_constraints)>2:
                every['hyper_edge_candidate'] = True
            else:
                 every['hyper_edge_candidate'] = False
            if len(table_constraints)==len(table_headers)==2 and len(primary_keys)==0:
                every['edge_candidate'] = True
            else:
                every['edge_candidate'] = False

            # create table header category in the format of table_header -> table_name -> db_name. 
            values = []
            if table_headers:
                for row in data:
                    table_row = tuple(row.values())
                    print(table_row)
                    values.append(table_row)
            if len(values)> len(set(values)):
                every['has_duplicate_rows'] = True
            else:
                every['has_duplicate_rows'] = False

            data_stat.append(every)
    save2json(data_stat, '/Users/ziyuzhao/Desktop/phd/SemanticParser4Graph/application/rel_db2kg/consistency_check/data_stat.json')

def check_difference(root, logger):
    # Check whether a path pointing to a file
    file_path = os.path.join(root, 'application', 'rel_db2kg', 'consistency_check', 'data_stat.json')
    isFile = os.path.isfile(file_path)

    if isFile:
        all_db_list = tuple(set([every['db_name'] for every in read_json(file_path)]))
        filtered_list = tuple(set([every['db_name'] for every in read_json(file_path) \
            if every['num_of_rows']>4000]))
        expected_graph_db_list = list(set(all_db_list) - set(filtered_list))
        print(f' num_of_all_dbs: {len(all_db_list)}, num_of_filtered_dbs: {len(filtered_list)}, num_of_expected_graph_dbs: {len(expected_graph_db_list)}')


        all_tables_list = list([every['table_name'] for every in read_json(file_path)])
        expected_graph_tables_list = list(['{}.{}'.format(every['db_name'], every['table_name'] ) \
            for every in read_json(file_path) \
            if every['db_name'] not in filtered_list])
        print(f' num_of_all_tables: {len(all_tables_list)}, num_of_expected_graph_tables: {len(expected_graph_tables_list)}')
       
        schema_map_file = os.path.join(root, 'pakdd2023', 'schemaMap.csv')
        isSchemaMap = os.path.isfile(schema_map_file)
        if isSchemaMap:
            actual_dbs = []
            actual_tables = []
            with open(schema_map_file, 'r') as f:
                for line in f.readlines():
                    graph_label, _, _, _,_,_ = line.split(',')
                    if '.' in graph_label:
                        actual_db, actual_table = graph_label.split('.')
                        if actual_db not in actual_dbs:
                            actual_dbs.append(actual_db)
                        if graph_label not in actual_tables:
                            actual_tables.append(graph_label)



                
            diff_dbs = list(set(tuple(expected_graph_db_list)) - set(tuple(actual_dbs)))
            diff_tbs = list(set(tuple(expected_graph_tables_list)) - set(tuple(actual_tables)))
            belongs_to_missing_dbs = []
            belongs_to_registered_dbs = []
            for reforamt_diff_db in  diff_tbs:
                if '.' in reforamt_diff_db:
                    diff_db, diff_tb = reforamt_diff_db.split('.')
                    if diff_db in diff_dbs:
                        belongs_to_missing_dbs.append(reforamt_diff_db)
                    else:
                        belongs_to_registered_dbs.append(reforamt_diff_db)
            

            
            print(f'num_of_diff_dbs: {len(diff_dbs)}, num_of_diff_tbs: {len(diff_tbs)}, \
                belongs_to_missing_dbs: {len(belongs_to_missing_dbs)}, \
                belongs_to_registered_dbs: {len(belongs_to_registered_dbs)} ')

            check_registered_dbs=[]
            for registed in belongs_to_registered_dbs:
                registed_db, _  = registed.split('.')
                if registed_db not in check_registered_dbs:
                    check_registered_dbs.append(registed_db)
            print(check_registered_dbs)


            diff_stat = [{'num_of_expected_graph_dbs':len(expected_graph_db_list), 
                        'num_of_expected_graph_tables_list': len(expected_graph_tables_list), 
                        'num_of_diff_dbs': len(diff_dbs), 
                        'num_of_diff_tbs': len(diff_tbs),
                        'num_of_missing_tables_in_missing_dbs': len(belongs_to_missing_dbs),
                        'num_of_missing_tables_in_registered_dbs': len(belongs_to_registered_dbs),
                        'diff_dbs': diff_dbs,
                        'belongs_to_missing_dbs': belongs_to_missing_dbs,
                        'belongs_to_registered_dbs': belongs_to_registered_dbs,
                        'diff_tbs':  diff_tbs,
                        'expected_graph_db_list' :expected_graph_db_list, 
                        'expected_graph_tables_list': expected_graph_tables_list}]
                    

            save2json(diff_stat, '/Users/ziyuzhao/Desktop/phd/SemanticParser4Graph/application/rel_db2kg/diff_stat.json')


    else:
        logger.warning("Do not exist {} or {}!".format(file_path, schema_map_file))
        raise NotImplementedError


def main():
    import glob, argparse
    import configparser
    config = configparser.ConfigParser()
    config.read('../config.ini')
    filenames = config["FILENAMES"]

    raw_folder = filenames['raw_folder']
    root = filenames['root']

    raw_spider_folder = os.path.join(raw_folder, 'spider')
    db_folder = os.path.join(raw_spider_folder,  'database')
    spider_dbs = glob.glob(db_folder + '/**/*.sqlite', recursive = True) 

    parser = argparse.ArgumentParser(description='check the consistency of mapping relational database to graph database.')
    # parser.add_argument('--consistencyChecking', help='Check the consistency between fields in sql query and schema', action='store_true')
    parser.add_argument('--get', help='get statistical data', action='store_true')
    parser.add_argument('--check', help='check the difference between expected data and actual graph data', action='store_true')
    args = parser.parse_args()

    if args.get:
        read_dataset(spider_dbs, Logger())
    
    if args.check:
        check_difference(root, Logger())


if __name__ == "__main__":
    main()