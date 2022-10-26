'''
Author: Ziyu Zhao

This script's goals are the following:
   1. to export tabular dataset into csv format preparing to import csv files into neo4j graph.
   2. to extract question-answering pairs. We extract three fields from the referenced project, 
      namely, db_id, question and query. We execute the sql query over the database to get the 
      result corresponding to question.        

[
   Reference1: spider dataset of TabularSemanticParsing project. link: https://github.com/salesforce/TabularSemanticParsing
   Reference2:  original dataset link: https://yale-lily.github.io/spider/
]
'''
from sqlite3.dbapi2 import Cursor
import sys, os, glob, re, json, jsonlines
from mo_sql_parsing.keywords import PRIMARY, PRIMARY_KEY
import pandas as pd
from collections import Counter
from mo_sql_parsing import parse
import sqlite3
from sqlite3 import Error
from signal import signal, SIGPIPE, SIG_DFL
import csv
from csv import writer
signal(SIGPIPE, SIG_DFL)
csv.field_size_limit(sys.maxsize)

import argparse
import configparser
config = configparser.ConfigParser()

from sql2cypher import add_parentheses, Operator, isNested, Formatter
import utils as utils


class SQLSchema_parser:

   def __init__(self, chunk):
      self.chunk = chunk      
         

   def is_create(self):
      """
      Returns true if the line begins a SQL create tabel statement.
      """
      if self.chunk.startswith('\n'):
         self.chunk = self.chunk[1:]
      return self.chunk.upper().startswith('CREATE TABLE') or False

   @classmethod
   def get_schema(cls, chunk):
      """
      Returns table name, table columns and relationships between tables among the same database.
      Note: a database consists of more than one table.
      """

      fieldnames = []
      primary_keys = []

      relationships = []
      rel_properties = []

      # remove empty line, head space, end comma and semi-comma
      lines = [every.lstrip().rstrip(',') for every in list(filter(None, chunk.split('\n')[:-1]))]

      for idx, line in enumerate(lines):   
         tokens = [token.strip('`"\'(),') for token in line.split()]        
         if line.upper().startswith('CREATE TABLE') :
            table_name = tokens[-2]
         elif line.upper().startswith('PRIMARY KEY'):  
            primary_keys.extend([every.strip() for every in tokens[2].split(',')]  )
         elif line.upper().startswith('FOREIGN KEY'):
            relationship = {}
            if 'REFERENCES' in tokens:                   
               parent = tokens[4]
               start_id = tokens[2]
               end_id = tokens[5]
               if start_id != end_id and relationships != []:
                  rel_properties.append(start_id)     

                  # Only add ('properties':rel_properties) to relationship dictionary when last reference key is accessed.
                  if idx == len(lines) -1:
                     get_dict = next((rel for rel in relationships if rel['end_id'] == end_id), {})
                     get_dict.update({'properties':rel_properties})
               else:
                  relationship['type'] = 'APPEAR_IN_{}'.format(parent.upper())
                  relationship['start_id'] = start_id
                  relationship['end_id'] = end_id
                  relationship['parent'] = parent            
                  relationships.append(relationship)                   
            else:
               continue
         elif line.upper().startswith('UNIQUE'):
            pass
         elif line.startswith(');'):
            pass
         else:          
            fieldnames.append(tokens[0])
   
      schema = dict()
      schema['table_name'] = table_name
      schema['fieldnames'] = [('{}:ID({})'.format(field, table_name) if field in primary_keys else field) for field in fieldnames]
      schema['primary_keys'] = primary_keys
      schema['relationships'] = relationships

      return schema





class DBEngine:              
      
   def __init__(self, fdb):
      self.conn = sqlite3.connect(fdb)      
      self.conn.text_factory = lambda b: b.decode(errors = 'ignore')
   
   def execute(self, query):
      cursor = self.conn.cursor()  
      return cursor.execute(query)  
    
   def get_table_names(self):
      cursor = self.conn.cursor()  
      return cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")     
   
   def get_table_values(self, table_name):
      cursor = self.conn.cursor()  
      return cursor.execute('SELECT * from {}'.format(table_name))  

   def get_schema(self, table_name):
      cursor = self.conn.cursor()  
      cursor.execute('SELECT sql FROM sqlite_master WHERE type = "table" and name= "{}";'.format(table_name))  
      result = cursor.fetchone()
      if result is None:
         raise ValueError("Table %s does not exist" % table_name)
      return result[0].strip()  
          

   def get_all_primary_keys(self, schema): 
      results = schema[schema.index('(') + 1:schema.rindex(')')]
      primary_keys = []
      results = [item.strip() for item in results.split('\n')]
      for field_desc in results:
         field_desc = field_desc.replace('`', '"')         
         if field_desc.upper().strip(',').endswith('PRIMARY KEY'):
            primary_keys.append(field_desc.split()[0].strip('"'))
         elif 'PRIMARY KEY'in field_desc.upper():
            p = re.findall('"([^"]*)"', field_desc)
            if p:
               primary_keys.extend(p)
            elif re.findall('\(.*?\)', field_desc):
               for item in re.findall('\(.*?\)', field_desc):
                  p.extend([i.strip(',') for i in item.strip('()').split()])  
               primary_keys.extend(p)   
            else:
               primary_keys.append(field_desc.split()[0])   
      
      return primary_keys 

   def get_all_foreign_keys(self, schema): 
         results = schema[schema.index('(') + 1:schema.rindex(')')]
         foreign_keys = []
         results = [item.strip() for item in results.split('\n')]
         for field_desc in results: 
            field_desc = field_desc.replace('`', '"')          
            if 'FOREIGN KEY' in field_desc.upper():                    
               f = re.findall('"([^"]*)"', field_desc)               
               if f and len(f) == 3:                     
                  foreign_keys.append(f)     
               else:  
                  field_desc = field_desc.replace(' (', '(')
                  print(field_desc)
                  f = []
                  for item in re.findall('\w+\(.*?\)', field_desc):
                     # if ',' in item:
                     #    item = item.replace(' ','').replace(',', '),(')
                     #    print('item:', item)
                     tokens = item.split('(')
                     print('tokens', tokens)
                     if 'KEY' in item.upper().split('('):      
                        f.append(tokens[-1].strip(')'))
                     # elif len(tokens) == 2: 
                        
                     else:
                        f.extend([tokens[0], tokens[-1].strip(')')])                    
                  foreign_keys.append(f)  # Return: [f_key, ref_table, p_key_of_ref_table]
         return foreign_keys 
   
   
   def close(self):
      self.conn.cursor.close()


def extract_all_table_field(raw_wikisql_folder, neo4j_folder, qa_data_folder):
       
   # Extract table_field dictionary with ``table`` and ``fields``.      
   db_folder = os.path.join(raw_wikisql_folder,  'database')
   neo4j_folder = os.path.join(neo4j_folder, 'wikisql')  

   db_paths= glob.glob(db_folder + '/**/*.sqlite') 

   all_db_table_fields = []

   for db_path in db_paths:
      path_compodbnents = db_path.split(os.sep)
      db_name = path_compodbnents[-2]

      output_folder = os.path.join(neo4j_folder, db_name)         

      if not os.path.exists(output_folder):
         os.makedirs(output_folder)    
      
      engin = DBEngine(db_path)      
      table_infos = engin.get_table_names()

      for table_info in table_infos:
            table_name = table_info[0]                       
            result = engin.get_table_values(table_name)
            headers = [desc[0] for desc in result.description]   

            every_table_fields = {}
            every_table_fields['db_name'] = db_name     
            table_fields = {}
            table_fields['table'] = table_name.capitalize()
            table_fields['fields'] = headers
            every_table_fields['table_fields'] = table_fields
            all_db_table_fields.append(every_table_fields)

   fields_path = os.path.join(qa_data_folder, 'wikisql', 'db_table_field.json')
   utils.save2json(all_db_table_fields,fields_path )

   return all_db_table_fields



def wikiSQLProcessor(raw_wikisql_folder, neo4j_folder, qa_data_folder):

   db_folder = os.path.join(raw_wikisql_folder,  'database')
   neo4j_folder = os.path.join(neo4j_folder, 'wikisql')  

   db_paths= glob.glob(db_folder + '/**/*.sqlite') 


   all_db_table_fields = extract_all_table_field(raw_wikisql_folder, neo4j_folder, qa_data_folder)

   for db_path in db_paths:
      path_compodbnents = db_path.split(os.sep)
      db_name = path_compodbnents[-2]

   # test example
   # if db_name == 'musical':
      output_folder = os.path.join(neo4j_folder, db_name)         

      if not os.path.exists(output_folder):
         os.makedirs(output_folder)    

      try:            
         
         engin = DBEngine(db_path)
         
         table_infos = engin.get_table_names()

         table_primary_key_pairs = {}

         for table_info in table_infos:
            table_name = table_info[0]
            schema = engin.get_schema(table_name)
            print("schema:", db_name,schema)
            primary_keys = engin.get_all_primary_keys(schema)
            foreign_keys =  engin.get_all_foreign_keys(schema)
            table_primary_key_pairs.update({table_name:primary_keys})
            # print('primary_keys:', primary_keys)
            # print('fk:', foreign_keys)
            print(table_primary_key_pairs)

            # 1. Export tables to neo4j/import as csv files.                           
            result = engin.get_table_values(table_name)
            headers = []         
            if primary_keys:        
               for desc in result.description:                     
                  if desc[0] in primary_keys:
                     headers.append('{}:ID({})'.format(desc[0],table_name.capitalize() ))              
                  else:
                     headers.append(desc[0]) 
            elif primary_keys == [] and foreign_keys:  # amend missing primary key for the reltionship construction               
               for desc in result.description:                     
                  if desc[0] in foreign_keys[0]:
                     headers.append('{}:ID({})'.format(desc[0],table_name.capitalize() ))              
                  else:
                     headers.append(desc[0]) 
            else:
               headers = [desc[0] for desc in result.description]         
           
                 
            # Write table records (including reformatted headers) into csv files.
            nodes_out_path = os.path.join(output_folder, '{}.csv'.format(table_name.capitalize()))  
            node_outfile = open(nodes_out_path, 'w')
            while True:
               df = pd.DataFrame(result.fetchall())
               if len(df) == 0:
                  break
               else:
                  df.to_csv(node_outfile, header = headers, index = False)
            node_outfile.close()



            # 2. Creat relationships to CSV file based on foreign key statement in table schema.      
            if foreign_keys:
               for idx, every in enumerate(foreign_keys):
                  if ',' in every[0] and ',' in every[-1]:
                     from_field = every[0].split(',')[-1]
                     to_field = every[-1].split(',')[-1].strip()
                  else:
                     from_field = every[0]
                     to_field = every[-1]
                  if len(every) == 2:
                     print()
                     to_node = list(table_primary_key_pairs.keys())[list(table_primary_key_pairs.values()).index(every[-1])]   
                  else:
                     to_node = every[1]

                  # Check if the referenced fields name match the ones existing in table.
                  for line in all_db_table_fields:                         
                     if db_name == line['db_name'] and to_node.lower().capitalize() == line['table_fields']['table']:
                        print(line['table_fields']['fields'])  
                        print(to_field)                      
                        if to_field not in line['table_fields']['fields']: 
                           to_field =  table_primary_key_pairs[to_node][0]      
                  sql_query = 'SELECT {0}.{1}, {2}.{3} FROM {0} join {2} where {0}.{1} = {2}.{3}'.format(\
                     table_name, from_field, to_node, to_field)
                  
                  rel_records = engin.execute(sql_query)                              
                  rel_headers = [':START_ID({})'.format(table_name.capitalize()), ':END_ID({})'.format(to_node.capitalize())]
                  print('sql:', sql_query)
                  # Write table records (including reformatted headers) into csv files.
                  edge_out_path = os.path.join(output_folder, 'HAS_{}.csv'.format(to_node.upper()))  
                  edge_outfile = open(edge_out_path, 'w')
                  while True:
                     df = pd.DataFrame(rel_records.fetchall())
                     if len(df) == 0:
                        break
                     else:
                        df.to_csv(edge_outfile, header = rel_headers, index = False)
                  edge_outfile.close()


           





      except KeyboardInterrupt:
         sys.exit(0)




def wikiSQL2QA(raw_wikisql_folder, qa_data_folder):

   # wikisql raw dataset path
   db_folder = os.path.join(raw_wikisql_folder,  'database')
   db_paths= glob.glob(db_folder + '/**/*.sqlite') 

   # Output folder path
   qa_data_folder = os.path.join(qa_data_folder, 'wikisql')  

   if not os.path.exists(qa_data_folder):
      os.makedirs(qa_data_folder) 

 
   all_table_fields_file = os.path.join(qa_data_folder, 'db_table_field.json')

   for split in ['train', 'dev']:      
      
      json_file = os.path.join(raw_wikisql_folder, '{}.json'.format(split))
      f = open(json_file)
      data = json.load(f)

      qa = []      
      for every in data:
         all_table_fields = []	

         # Get table_fields information.
         with jsonlines.open(all_table_fields_file, "r") as f:
            for line in f:
               if line['db_name'] == every['db_id']:
                  all_table_fields.append(line['table_fields'])

         if every['db_id'] == 'musical':       

            # 1. Extract database name, questions and SQL queries
            db_name = every['db_id']
            question = every['question']
            sql_query = every['query']
         
            parsed_sql = parse(sql_query)

            try:              
               check_tokens = ['FROM', 'JOIN']
               sql_mentioned_tables = []
               sql_query_token = sql_query.split()
               for idx, token in enumerate(sql_query_token):
                  if token in check_tokens:
                     sql_mentioned_tables.append(sql_query_token[idx+1])  

               # 2. Access database, execute SQL query and get result.              
               db_path = os.path.join(db_folder, db_name, '{}.sqlite'.format(db_name))   
               engin = DBEngine(db_path)
               result = [item[0] for item in engin.execute(sql_query).fetchall()]
 
              
               
            except KeyboardInterrupt:
               sys.exit(0)

            # 3. Convert SQL query to Cypher query.		
            formatter  = Formatter(all_table_fields)
            sql2cypher = formatter.format(parsed_sql)
      
            qa.append({'db_id':db_name, 'question':question, 'sql_query':sql_query, 'parsed_sql':parsed_sql , 'cypher_query':sql2cypher, 'result':result})

      output_file = os.path.join(qa_data_folder, '{}.json'.format(split))     
      with open(output_file, 'w')  as out:
         json.dump(qa, out, indent = 4)


def main():

   parser = argparse.ArgumentParser(description='wikisql dataset processor')
   parser.add_argument('--dbProcessing', help='Run wikisqlProcessor.', action='store_true')
   parser.add_argument('--qaExtractor', help='Run wikisql2pair.', action='store_true')
   args = parser.parse_args()


   config.read('../../config.ini')
   filenames = config["FILENAMES"]

   raw_wikisql_folder = filenames['wikisql_folder']
   neo4j_folder = filenames['neo4j_import_folder']

   qa_data_folder = filenames['input_data_folder']

   if args.dbProcessing:
      wikiSQLProcessor(raw_wikisql_folder, neo4j_folder, qa_data_folder)

   if args.qaExtractor:
      wikiSQL2QA(raw_wikisql_folder, qa_data_folder)


if __name__=="__main__":
   main()