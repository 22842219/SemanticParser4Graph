import os
import pandas as pd
from schema2graph import DBengine, RelDB, RelTable, TableSchema
from utils import Logger, save2json

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
    save2json(data_stat, '/Users/ziyuzhao/Desktop/phd/SemanticParser4Graph/application/rel_db2kg/data_stat.json')
        


def main():
    import glob, argparse
    import configparser
    config = configparser.ConfigParser()
    config.read('../config.ini')
    filenames = config["FILENAMES"]

    raw_folder = filenames['raw_folder']


    raw_spider_folder = os.path.join(raw_folder, 'spider')
    db_folder = os.path.join(raw_spider_folder,  'database')
    spider_dbs = glob.glob(db_folder + '/**/*.sqlite', recursive = True) 
    read_dataset(spider_dbs, Logger())

if __name__ == "__main__":
    main()