'''
Author: Ziyu Zhao

This script's goals are the following:
   1. to export tabular dataset into csv format, preparing to import csv files into neo4j graph.
   2. to extract question-answering pairs. We extract three fields from the referenced project, 
      namely, db_id, question and query. We execute the sql query over the database to get the 
      result corresponding to question.        

[
   Reference1: spider dataset of TabularSemanticParsing project. link: https://github.com/salesforce/TabularSemanticParsing
   Reference2:  original dataset link: https://yale-lily.github.io/spider/
]
'''

import sys, os, glob, json
import pandas as pd
from signal import signal, SIGPIPE, SIG_DFL
import csv

sys.path.append('..')
from table_schema_to_graph import DBengine
from utils import save2graph, check_compound_pk

signal(SIGPIPE, SIG_DFL)
csv.field_size_limit(sys.maxsize)

def build_lookup_dict(db_paths, sp_data_folder):
   '''
   Return: {'db_name':{'table_name': [table_headers]}}
   '''
   # Extract table_field dictionary with ``table`` and ``fields``.      

   lookup_dict={}
   pks_lookup_dict = {}

   for db_path in db_paths:
      path_compodbnents = db_path.split(os.sep)                         
      db_name = path_compodbnents[-2]
        
      engine = DBengine(db_path)      
      table_infos = engine.get_table_names()
     

      for table_info in table_infos:
         table_name = table_info[0]                 
         primary_keys = engine.get_primay_keys(table_name) #R[(pk, )]
             
         result = engine.get_table_values(table_name)
         headers = [desc[0] for desc in result.description]   

         # create a dictionary of tables for each database. 
         if db_name not in lookup_dict:
            lookup_dict[db_name] = {}    
            pks_lookup_dict[db_name] = {}
         if table_name not in lookup_dict[db_name]:
            lookup_dict[db_name][table_name] = headers
            for pk in primary_keys:
               pks_lookup_dict[db_name][table_name] = pk[0]
   print(len(lookup_dict.items()))

   fields_path = os.path.join(sp_data_folder, 'spider', 'lookup_dict.json')
   with open(fields_path, "w") as f:
      json.dump(lookup_dict, f, indent = 4) 
   return lookup_dict, pks_lookup_dict

def create_relationship(table_name, 
                        table_primary_key_pairs, 
                        fk_statement, 
                        table_headers_dict):
   ref_table = fk_statement['ref_table']
   ref_column = fk_statement['ref_column']
   this_column = fk_statement['column']
   print("heyyy", table_name, this_column, ref_table, ref_column)
   if ref_table == table_name: 
      if this_column not in list(table_primary_key_pairs.values()):
         is_self_constraint_kf = True
         sql_query = 'SELECT T1.{3}, T2.{3} FROM {0} as T1 join {2} as T2 where T1.{1} = T2.{3}'.format(\
         table_name, this_column, ref_table, ref_column)
         print("SELF CONSTRAINT SQL:", sql_query)        
      else:
         # Query on the same table by referencing one of this table's columns which is the primary key of the reference table. 
         # e.g. in musical.db, table 'actor' got an example as follows.
         # - FOREIGN KEY ("Musical_ID") REFERENCES "actor"("Actor_ID")
         is_self_constraint_kf = False
         assert len(set(table_primary_key_pairs.values())) == len(set(table_primary_key_pairs.keys())), 'FIX ME'
         table_primary_key_pairs_vk = {v:k for k,v in table_primary_key_pairs.items()}
         ref_table = table_primary_key_pairs_vk.get(this_column)         
         sql_query = 'SELECT {0}.{3}, {0}.{1} FROM {0} join {2} where {0}.{1} = {2}.{1}'.format(\
            table_name, this_column , ref_table, ref_column) 
   else:
      # Correct the wrong reference column.
      # e.g. in restaurants.db, table 'LOCATION' references table 'RESTAURANT' with column 'RESTAURANT_ID' which does not 
      # appear in the reference table. 
      is_self_constraint_kf = False
      if ref_column not in table_headers_dict[ref_table]:
         ref_column = table_primary_key_pairs[ref_table]
      sql_query = 'SELECT {0}.{1}, {2}.{3} FROM {0} join {2} where {0}.{1} = {2}.{3}'.format(\
         table_name, this_column, ref_table ,ref_column)
   return sql_query, ref_table, ref_column, is_self_constraint_kf

def spiderProcessor(db_paths, 
                     neo4j_folder, 
                     sp_data_folder, 
                     lookup_dict, 
                     pks_lookup_dict):

   for db_path in db_paths:
      path_compodbnents = db_path.split(os.sep)
      db_name = path_compodbnents[-1].split('.')[0]
      # test example
      if db_name == 'department_management':
      
         table_primary_key_pairs= pks_lookup_dict[db_name]
         output_folder = os.path.join(neo4j_folder, db_name) 
      
         print('-------------------------------------------------')
         print("db_name:", db_name)
         print(db_path)
         print(output_folder)
         print("table_primary_key_pairs:", table_primary_key_pairs)
               

         if not os.path.exists(output_folder):
            os.makedirs(output_folder)    

                     
         engine = DBengine(db_path)

         table_infos = engine.get_table_names() # I observe the enginee would shut down after executing the function 'engine.get_table_value'   

         missing_pks_tables_counter = 0
         missing_pks_tables_dict = {} #{table_name:db_name}
         

         for table_info in table_infos:
            table_name = table_info[0]
            table_headers_dict = lookup_dict[db_name]
            schema = engine.get_schema(table_name)
            primary_keys = engine.get_primay_keys(table_name) #R[(pk, )]
            foreign_keys, pks_fks_dict =  engine.get_outbound_foreign_keys(table_name) #R[{"column": from_, "ref_table": table_name, "ref_column": to_}]
            print("table_name:", table_name)
            print("schema:", db_name,schema)
            print("primary_keys:", primary_keys)
            print("foreign_keys:", foreign_keys)
            print("pks_fks_dict:", pks_fks_dict)
            print(table_headers_dict)
      
            # Export tables to neo4j/import as csv files.                           
            table_records = engine.get_table_values(table_name)
            table_headers = [desc[0] for desc in table_records.description]    
            print("table_headers:", table_headers )   

            is_inconsistent = False
            # 1. Csv files For graph nodes
            if primary_keys:                
               compound_pk_check =  check_compound_pk(primary_keys)
               print("compound_pk_check:", compound_pk_check)
               if not compound_pk_check:  
                  out_path = os.path.join(output_folder, '{}.csv'.format(table_name.capitalize()))
                  save2graph(out_path, table_headers, table_records) 
               elif compound_pk_check and foreign_keys: 
                  # This is a relational table, where there is a compound primary key and forign keys in the table schema,
                  # e.g. 'pitStops' in formula_1.db, or 'airport_aircraft' in aircraft.db     
                  
                  # There is an inconsistency issue here. For example, the table `accelerator_compatible_browser` in browser_web.db. 
                  # Even though it can be a relationship table, but the foreign keys are inconsistent with their corresponding primary keys 
                  # of reference table. Hence the solution is to be a node table, and create edge. 
                  
                  fks = [(every['ref_column'],) for every in foreign_keys]
                  print("fks:", set(primary_keys)-set(fks))
                  if set(primary_keys)-set(fks):
                     print("****************")
                     print(db_name)
                     print(primary_keys, fks)
                     for pk in primary_keys:
                        pk = pk[0]
                        if pks_fks_dict[pk]!=pk:   
                           is_inconsistent = True
                     # out_path = os.path.join(output_folder, '{}.csv'.format(table_name.capitalize()))  
                  
                  # if is_inconsistent:                           
                     out_path = os.path.join(output_folder, 'rel_{}.csv'.format(table_name.capitalize()))    
                     rel_table_name = 'rel_{}'.format(table_name)

                     update_dict = {}
                     update_dict[rel_table_name] = table_headers
                     lookup_dict[db_name].update(update_dict)    
                     # del lookup_dict[db_name][table_name]     
                     #raise ValueError("A compound primary key! Check it out.")   

                  save2graph(out_path, table_headers, table_records)   
                  

            # 2. CSV files for graph relationships.      
            if foreign_keys:

               compound_pk_check =  check_compound_pk(primary_keys)
         
               if not compound_pk_check or is_inconsistent:
                  for idx, every in enumerate(foreign_keys):
                     if not primary_keys: 
                        # For the case that, there is no primary key in a table. It is a syntax error, but we take care of it. 
                        # Questions: is it reasonable to treat this kinda table as helper to creat edges, but not the edge itself for graph.
                        # I guess the missing primary key supposed to be the composition of all the foreinkeys. 
                        missing_pks_tables_counter +=1
                        if table_name not in missing_pks_tables_dict:
                           missing_pks_tables_dict[table_name] = db_name  
                     sql_query, ref_table, ref_column, is_self_constraint_kf = create_relationship(table_name, table_primary_key_pairs, \
                        every, table_headers_dict)
         
                     if is_self_constraint_kf:
                        print("is_self_constraint_kf:", is_self_constraint_kf)
                        rel_headers = ['START_ID|{}|{}'.format(table_name.capitalize(), ref_column), \
                        'END_ID|{}|{}'.format(ref_table.capitalize(), ref_column)]
                        rel_out_path = os.path.join(output_folder, 'rel_{}.csv'.format(every['column'].upper()))  
                     else:
                        rel_headers = ['START_ID|{}|{}'.format(table_name.capitalize(),  every['column'] ), \
                        'END_ID|{}|{}'.format(ref_table.capitalize(), ref_column)]
                        rel_out_path = os.path.join(output_folder, 'HAS_{}.csv'.format(ref_table.upper()))  
                     rel_records = engine.execute(sql_query) 
                  
                     save2graph(rel_out_path, rel_headers, rel_records)


         print("missing_pks_tables_dict:", missing_pks_tables_dict)
         print("missing_pks_tables_counter:", missing_pks_tables_counter)
      
         fields_path = os.path.join(sp_data_folder, 'spider', 'lookup_dict.json')
         with open(fields_path, "w") as f:
            json.dump(lookup_dict, f, indent = 4) 
         return lookup_dict, pks_lookup_dict


def main():

   import argparse
   import configparser
   config = configparser.ConfigParser()

   parser = argparse.ArgumentParser(description='spider dataset processor')
   # parser.add_argument('--consistencyChecking', help='Check the consistency between fields in sql query and schema', action='store_true')
   parser.add_argument('--dbProcessing', help='Run spiderProcessor.', action='store_true')
   parser.add_argument('--sql2cypher', help='Run spider2pair.', action='store_true')
   args = parser.parse_args()


   config.read('../../config.ini')
   filenames = config["FILENAMES"]

   raw_folder = filenames['raw_folder']
   sp_folder = filenames['sp_folder']
   neo4j_import = filenames['neo4j_import_folder']


   raw_spider_folder = os.path.join(raw_folder, 'spider')

   db_folder = os.path.join(raw_spider_folder,  'database')
   neo4j_folder = os.path.join(neo4j_import, 'spider')  
   db_paths=glob.glob(db_folder + '/**/*.sqlite', recursive = True) 

 

   lookup_dict, pks_lookup_dict = build_lookup_dict(
                  db_paths, 
                  sp_folder)
      
  
   if args.dbProcessing:

      spiderProcessor(
         db_paths,
         neo4j_folder,
         sp_folder,
         lookup_dict,
         pks_lookup_dict)



if __name__=="__main__":
   main()