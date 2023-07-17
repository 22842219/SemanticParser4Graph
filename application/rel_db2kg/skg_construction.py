'''
Author: Ziyu Zhao
Affiliation: UWA NLT-TLP GROUP
'''

import os, re, math,codecs, json
from typing import Set
from py2neo import Graph
from py2neo.matching import *
from py2neo.data import Node, Relationship
from environs import Env


import numpy as np
import sqlite3
import pandas as pd
import dill

class DBengine:
    
    """
    An Entity, which takes a sqlite3 database schema.
    Parameters:
    
    """

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
        return cursor.execute('SELECT * from "{}"'.format(table_name)) 

    def get_schema(self, table_name):
        cursor = self.conn.cursor()  
        cursor.execute('SELECT sql FROM sqlite_master WHERE type = "table" and name= "{}";'.format(table_name))  
        result = cursor.fetchone()
        if result is None:
            raise ValueError("Table %s does not exist" % table_name)
        return result[0].strip()  
   
    def get_data_type(self, table_name, headers):
        cursor = self.conn.cursor() 
        infos = cursor.execute("PRAGMA table_info('{}')".format(table_name))
        data_types = {}
        '''
        Parameters:  
            cid: Column ID
            name: Column name
            type: Column data type
            notnull: Non-null constraint flag (1 if the column has a NOT NULL constraint, 0 otherwise)
            dflt_value: Default value for the column (if any)
            pk: Primary key flag (1 if the column is part of the primary key, 0 otherwise)
        '''
        for info in infos:
            cid, col_name, dtype, notnull, dflt_value, pk = info
            col_name = headers[cid]
            if dtype.lower() in ['text', 'varchar', 'varchar(20)']:
                dtype=str
            if dtype in ['INTEGER', 'INT']:
                dtype=int
            data_types[col_name] = dtype
        return data_types

    def get_outbound_foreign_keys(self, table_name, headers, db_tabs):
        cursor = self.conn.cursor() 
        infos = cursor.execute("PRAGMA foreign_key_list('{}')".format(table_name)).fetchall()
        constraints_ = {}
        id_fks = {}
        '''
        Parameters:
            id: A unique identifier for the foreign key constraint.
            seq: The sequence number of the column in the foreign key constraint.
            table: The name of the table that contains the foreign key constraint.
            from: The name of the column in the current table that is part of the foreign key relationship.
            to: The name of the column in the referenced table that is being referenced by the foreign key.
            on_update: The action to be performed when the referenced column is updated.
            on_delete: The action to be performed when the referenced column is deleted.
            match: The match type for the foreign key constraint. 
        '''
        for info in infos:
            id, seq, to_table, fk, to_col, on_update, on_delete, match = info 
            print(f'table: {table_name}, fk: {fk}, ref_table: {to_table}, to_col:{to_col}')
            fk_idx = [h.lower() for h in headers].index(fk.lower())
            fk = headers[fk_idx]
            if to_col:
                if to_table and to_table not in db_tabs:
                    db_ = [tab.lower() for tab in db_tabs]
                    if to_table.lower() in db_:
                        to_table = db_tabs[db_.index(to_table.lower())]  
                    else:
                        continue
                to_tab_headers = [desc[0] for desc in self.get_table_values(to_table).description]
                to_ = [h.lower() for h in to_tab_headers]
                if to_col.lower() not in to_: # amend mismatch reference foreign key
                    to_pks = self.get_primay_keys(to_table) 
                    if to_pks and len(to_pks)==1:
                        to_col= to_pks[0]
                    else:
                        continue
                    
                to_col_idx = to_.index(to_col.lower())
                to_col = to_tab_headers[to_col_idx]

                if id not in id_fks:
                    id_fks[id]=[fk]
                else:
                    id_fks[id].append(fk)
                
                if id not in constraints_:
                    constraints_[id]= {  
                            "to_tab": to_table, 
                            "to_col_list": [to_col]
                        }
                else:
                    constraints_[id]["to_col_list"].append(to_col)
        constraints = {}
        for id, _ in constraints_.items():
            if id in id_fks:
                constraints[','.join(id_fks[id])]=constraints_[id]

        if bool(constraints):
            return constraints
    

    def get_primay_keys(self, table_name):
        cursor = self.conn.cursor() 
        pks = cursor.execute('SELECT l.name FROM pragma_table_info("{}") as l WHERE l.pk <> 0;'.format(table_name)).fetchall()
        return [pk[0] for pk in pks]  
    
    def check_compound_pk(self, primary_keys):
        if len(primary_keys)>1: 
            return True
        return False

    def close(self):
        self.conn.cursor.close()

class RelTable:
    
    """
    Parameters:
        db_name (Strint):
        table_name (String):
        headers (List)): A list of table headers.
        data_type (Dict): A dictionary of each column's data type. 
        pks (List): A list of primary and foreign keys appearing in this table. 
        fks (Dict):
        is_coumpound_pk (bool):
        rows (List): A list of rows appearing in this table. 
        cols (Dict): A dictionary of each column appearing in this table.
        
    """

    def __init__(self, db_name, table_name):
        self.db_name = db_name
        self.table_name = table_name
        self.headers = []
        self.data_type = {}
        self.pks = []
        self.fks= {} 
        self.is_compound_pk = False
        self.rows = []
        self.cols = {}

    def add_row(self, row_dict):
        """
        Add a row to this table.
        Args:
            table (Table object): The table to add.
        """
        self.rows.append(row_dict)

 
class RelDBDataset(DBengine):
    """dtaset class takes a relational databse `schema` as input. 

    A class that represents the whole relational database dataset, i.e. a dataset that constains its whole tables.
    Parameters:
        rel_dbs (Dict): 
                    {

                    }
        fdb: The schema path of a relational database.
        fk_constraints (Dict): Store the information of each table's fk constraints.        
    """
    def __init__(self, paths, data_split):
        self.rel_dbs, self.db_fk_constraints, self.db_data_type, self.db_pks= self.read_dataset(paths, data_split)

    def fix_reference(self, tbs_fk_constraints, tbs_pks, db_tbs):
        for tb_name, fks in tbs_fk_constraints.items():
            pks = tbs_pks[tb_name]
            for fk, constraint in fks.items():
                to_col_list = constraint['to_col_list']
                to_tb_name = constraint['to_tab']
                if to_tb_name==tb_name:
                    for tb_name_ , pks in tbs_pks.items():
                        pks_  = [pk.lower() for pk in pks]
                        assert ',' not in fk
                        if fk.lower() in pks_:
                            constraint['to_tab'] = tb_name_
                            for i, to_col in enumerate(to_col_list):
                                if to_col.lower() not in pks_:
                                    constraint['to_col_list'][i]= pks[pks_.index(fk.lower())]
                    fks.update({fk:constraint})
                    db_tbs[tb_name].fks.update({fk:constraint})

    def fix_fk(self, tbs_fk_constraints, tbs_data_type, db_tbs):
        for tb_name, fks in tbs_fk_constraints.items():
            for fk_, constraint in fks.items():
                to_col_list = constraint['to_col_list']
                to_tb_name = constraint['to_tab']
                fks = [fk.strip() for fk in fk_.split(',')]
                to_col_types = [tbs_data_type[to_tb_name][col] for col in to_col_list]
                fk_data_type_mapping = dict(zip(fks, to_col_types))
                for i, row_dict in enumerate(db_tbs[tb_name].rows):
                    for fk in fks:
                        row_value = row_dict[fk]
                        to_col_value_type = fk_data_type_mapping[fk]
                        if row_value:
                            if (to_col_value_type== 'int' or to_col_value_type==int) and not isinstance(row_value, int):
                                if type(row_value)==str:
                                    row_value=int(row_value)
                                row_dict[fk] = int(row_value) if not math.isnan(row_value) else None
                            elif (to_col_value_type == 'float' or to_col_value_type==float) and not isinstance(row_value, float):
                                if type(row_value)==str:
                                    row_value=float(row_value)
                                row_dict[fk] = float(row_value) if not math.isnan(row_value) else None
                            elif (to_col_value_type == 'str' or to_col_value_type==str) and not isinstance(row_value, str):
                                row_dict[fk] = "'{}'".format(str(row_value).strip('\'').strip('\"')) if row_value else None
                #update corresponding 'cols'
                db_tbs[tb_name].cols = pd.DataFrame(db_tbs[tb_name].rows).to_dict( orient='list')

    def read_dataset(self, paths, data_split):
        rel_dbs = {}
        db_fk_constraints = {}
        db_data_type = {}
        db_pks = {}
        for db_path in paths:
            path_compodbnents = db_path.split(os.sep)
            db_name = path_compodbnents[-1].split('.')[0] 
            ###########################################This is for data consistency checking code#######################
            
            # missing_data_file = '/Users/ziyuzhao/Desktop/phd/SemanticParser4Graph/application/rel_db2kg/consistency_check/diff_stat.json'
            # check_dbs = []
            # isFile = os.path.isfile(missing_data_file)
            # if isFile:
            #     if len(read_json(missing_data_file))==1:
            #         missing_dbs = read_json(missing_data_file)[0]['dff_dbs']
            #         for missing in missing_data:
            #             if '.' in missing:
            #                 missing_db, missing_table = missing.split('.')
            #                 if missing_db not in check_dbs:
            #                      check_dbs.append(missing_db)
            #     if db_name not in check_dbs:
            #         pass
            ###########################################to make sure the acutal data is the same as expected data#######################
           # in [ 'car_1',  'department_management', 'musical', 'pets_1', 'real_estate_properties', "local_govt_and_lot", 'concert_singer', ]
            if db_name:
                rel_dbs[db_name]={}               
                db_fk_constraints[db_name] = {}
                db_data_type[db_name]={}
                db_pks[db_name]={}
                engine = DBengine(db_path)
                tab_names = [tab_info[0] for tab_info in engine.get_table_names()]
                drop_flag = False
                print(f'db:{db_name}, tab_names: {tab_names}')
   
                for table_name in tab_names:
                    tb_object = RelTable(db_name, table_name)                     
                    table_records = engine.get_table_values(table_name)
                    tb_object.headers = [desc[0] for desc in table_records.description]     
                    tb_object.data_type= engine.get_data_type(table_name, tb_object.headers)
                    tb_object.fks =  engine.get_outbound_foreign_keys(table_name, tb_object.headers, tab_names) 
                    tb_object.pks = engine.get_primay_keys(table_name) 
                    tb_object.is_compound_pk =  engine.check_compound_pk(tb_object.pks)

                    db_data_type[db_name][table_name] = tb_object.data_type 
                    db_pks[db_name][table_name] = tb_object.pks
        
                    if bool(tb_object.fks):
                        db_fk_constraints[db_name][table_name]=tb_object.fks

                    # Do not drop duplicate rows in place, because this action would affect the query results.
                    df = pd.DataFrame(table_records.fetchall(), columns = tb_object.headers)
                    # df.drop_duplicates(inplace=True)
                    # data = df.transpose().to_dict().values()  # to keep the origial data types.
                    data = [d for d in df.transpose().to_dict().values()  if any(d.values())]

                    tb_object.cols = df.to_dict(orient='list')
                    
                    if data_split=='Cy-Spider':
                        print('drop surely?' )
                        if len(data)>4000 or tb_object.headers == None:  # we set a threshold for the experiment
                            drop_flag =True
                            break
                        


                    rows = data or [ {k: '' for k in tb_object.headers} ]
                    list(map(lambda row: tb_object.add_row(row), rows))
                    rel_dbs[db_name][table_name] = tb_object    
                
                if drop_flag:
                    del rel_dbs[db_name]              
                    del db_fk_constraints[db_name] 
                    del db_data_type[db_name]
                    del db_pks[db_name]
                                                                                                                       
                if db_name in rel_dbs:
                    self.fix_reference(db_fk_constraints[db_name], db_pks[db_name], rel_dbs[db_name])
                    self.fix_fk(db_fk_constraints[db_name], db_data_type[db_name] , rel_dbs[db_name])

        return rel_dbs, db_fk_constraints, db_data_type, db_pks
            
        
class RelDB2KGraphBuilder(RelDBDataset):
    
    """
    RelDB2KG graph builder takes, a relational databse `schema` as inputs. 
    and constructs a Neo4J graph via py2neo.

    Parameters:
        paths (string): 
        logger: 
        defined_fields (dict): A dictionary of defined structured fields. 
        node_normaliser (LexicalNormaliser): A LexicalNormaliser whose purpose is to clean the nodes, \\
             resolving issues such as making 'leaks', 'leaking' etc resolve to a single 'leak' node. 
        Note: defined_fields and node_normaliser are placeholders. 
    """

    def __init__( self, paths,  benchmark, split_fpths, data):
        super().__init__(paths, data )
        self.paths = paths
        self.benchmark = benchmark
        self.split_fpths = split_fpths
        self.data = data

        
        self.triplets = {}
        self.tb2node = {}
        self.tb2edge={}


    def create_dtc_triples(self, db_name, tbs_dict):
        if db_name not in  self.triplets:
            self.triplets[db_name]=[]

        self.triplets[db_name].append((db_name, 'has', '*'))
        for tb_name, tab in tbs_dict.items():
            l1_triple = (db_name, 'has', '{}.{}'.format(db_name, tb_name))
            if l1_triple not in self.triplets[db_name]:
                self.triplets[db_name].append(l1_triple)
            self.triplets[db_name].append(('{}.{}'.format(db_name, tb_name), 'has', '*'))
            for col in list(tab.cols.keys()):
                l2_triple =('{}.{}'.format(db_name, tb_name), 'has', '{}.{}.{}'.format(db_name, tb_name, col)) 
                if l2_triple not in self.triplets[db_name]:
                    self.triplets[db_name].append(l2_triple)
            if self.data.lower()=='spider-w-content':
                for row_dict in tab.rows:
                    for col, value in row_dict.items():
                        l3_triple =('{}.{}.{}'.format(db_name, tb_name, col), 'value_match', value)
                        print('0', col, value)
                        print('1', l3_triple)
                        assert 1>2
                        if l3_triple not in self.triplets[db_name]:
                            self.triplets[db_name].append(l3_triple)

    def table2nodes(self, db_name, tbs_dict): 
        print("************START BUILDING GRAPH NODES****************")
        for tb_name, tab in tbs_dict.items():
            if  not tab.fks or  len(tab.fks)!=2 \
                or (len(tab.fks)==2 and bool(tab.pks) and not tab.is_compound_pk):
                # or (len(table.fk_constraints)==2 and not table.check_compound_pk):
                '''
                Case: a whole table is turned into corresponding graph nodes,
                this covers the following cases:
                1) the examples, that exist just one primary key and several forign keys,
                2) the examples, that exist compound primary keys, but no foreign keys. 
                e.g., in musical.db, the table `musical` is the case.
                '''
                if db_name not in self.tb2node:
                    self.tb2node[db_name]=[]
                self.tb2node[db_name].append(tb_name)
                
    def table2edges(self, db_name, tbs_dict):
        # Note: Open graph transaction again.
        print("************Start Building Graph Edges****************")
        for tb_name, tab in tbs_dict.items():
            if tab.fks:
                if len(tab.fks)==2 and (tab.is_compound_pk or not tab.pks):
                
                    # and  (not primary_keys or table.check_compound_pk):
                    # class py2neo.data.Relationship(start_node, type, end_node, **properties)
                    print(f'******Building graph edge directly from {tb_name}.*******')   
                    '''
                    NOTE 1: deal with one-to-one by the table itself as edges, aka, a whole table is turned into graph edges,                         
                    NOTE 2: we remove the foreign keys from each graph edge's property set, for the sake of the consistency of graph database.
                        to make sure the update of head or tail nodes would not violate the data consistency.                    
                    '''
                    # update_row_dict = {k: row_dict[k] for k in row_dict if k not in fks}  
                    # self.logger.warning(f'update_row_dict: {update_row_dict}')
                    triple = [None, '{}.{}'.format(db_name, tb_name), None]
                    constraints = list(tab.fks.values())
                  
                    triple[0] = '{}.{}'.format(db_name, constraints[0]['to_tab'])
                    triple[2] = '{}.{}'.format(db_name, constraints[1]['to_tab'])
                    if tuple(triple) not in self.triplets[db_name]:
                        self.triplets[db_name].append(tuple(triple))  

                    if db_name not in self.tb2edge:
                        self.tb2edge[db_name]=[]
                    self.tb2edge[db_name].append(tb_name)      

    def build_edges(self, db_name, tbs_dict):
        # Note: Open graph transaction again.
        print("************Start Building Curated Graph Edges****************")
        for tb_name, tab in tbs_dict.items():   
            if tab.fks:
                if not (len(tab.fks)==2 and tab.is_compound_pk):
                    print(f"Running {tb_name} in {db_name} with {tab.headers}")
                    s='{}.{}'.format(db_name, tb_name)     
                    for concated_fk, constraint in tab.fks.items():
                        o='{}.{}'.format(db_name, constraint['to_tab'])
                        triple = (s, '{}_HAS_{}'.format( s, o ), o) 
                        self.triplets[db_name].append(triple)

    def write(self, split_fpths):
        ent_set, rel_set =set(), set()
        for i, split in enumerate(self.split_fpths):
            split_dbs = []
            with codecs.open(split, 'r', 'utf-8-sig') as f:
                split_data = json.load(f)
                for each in split_data:
                    db = each['db_id']
                    if db not in split_dbs:
                        split_dbs.append(db)
            split_schema  =[]
            for db in split_dbs:
                if db in self.triplets:
                    split_schema.extend(self.triplets[db])  
                    for each in self.triplets[db]:
                        sub, rel, obj = each
                        ent_set.add(sub)
                        rel_set.add(rel)
                        ent_set.add(obj)

            fpath= os.getcwd() +  '/{}/{}.txt'.format(self.data, i)
            print(fpath)
            with open(fpath, 'w') as out:
                for item in split_schema:
                    out.write('\t'.join(str(element) for element in item) + '\n')

        ent2id = {ent: idx for idx, ent in enumerate(ent_set)}
        print(f'the number of entities is: ', len(ent2id))
        ent_fpth = os.getcwd() +  '/{}/ent2id_vocabulary.txt'.format(self.data)
        with open(ent_fpth, 'w') as out:
            for ent, idx in ent2id.items():
                if ent:
                    out.write(ent + '\n')

    def build_graph(self):

        for db_name, tbs_dict in self.dataset.rel_dbs.items():      
            print("************Start building graph directly from relational table schema****************")
            self.create_dtc_triples(db_name, tbs_dict)
            self.table2nodes(db_name, tbs_dict)
            self.table2edges(db_name, tbs_dict)
            self.build_edges(db_name, tbs_dict) # this process should run based on table2node process
        
        print("the number of dataset triplets is: ", len(self.triplets))
        self.write(self.split_fpths)
 
def skg_construction(fpth,  env_file):
    # build the schema graph
    env = Env()
    env.read_env(env_file)
    graph = Graph(password=env("GRAPH_PASSWORD")) 
    
    graph.delete_all()
    for line in open(fpth):
        tx = graph.begin()
        # sub, rel, obj = map(str.lower, line.strip().split('\t'))
        sub, rel, obj = line.strip().split('\t')
        s_node = Node('Entity', name = sub)
        o_node = Node('Entity',name = obj)
        # Merge nodes and relationship into the graph
        tx.merge(s_node, 'Entity', 'name')
        tx.merge(o_node, 'Entity', 'name')
        rel = Relationship(s_node, rel, o_node) 
        tx.create(rel)
        graph.commit(tx)
        

                  
    
def main():
    import glob, argparse, os
    import configparser
    config = configparser.ConfigParser()
    config.read('../config.ini')
    filenames = config["FILENAMES"]
    root = filenames['root']
    benchmark = filenames['benchmark']
    env_file = os.path.join(root, 'application', '.env')

    parser = argparse.ArgumentParser(description='Parser For Arguments', formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument('-data', default='Spider', help='Dataset to use, default: spider, option: Cy-Spider, Spider-w-content')
    
    args = parser.parse_args()

    # data_folder = '/Users/ziyuzhao/Desktop/phd/SemanticParser4Graph/application/data/spider'
    # benchmark_dbs = glob.glob(os.path.join(data_folder, 'database') + '/**/*.sqlite', recursive = True) 
    # benchmark = 'spider'

    # if args.data =='Cy-Spider':
    #     data_folder = '/group/pmc003/zzhao/SemanticParser4Graph/semantic_parser/data/text2cypher'
    # split_fpths=[os.path.join(data_folder, 'train.json'), os.path.join(data_folder, 'dev.json')]

    # RelDB2KGraphBuilder(benchmark_dbs,  benchmark, split_fpths, args.data, env_file).build_graph()
    triplets_fpth = '/Users/ziyuzhao/Desktop/phd/SemanticParser4Graph/application/data/spider/skg_triplets.txt'
    skg_construction(triplets_fpth,env_file)


if __name__ == "__main__":
    main()
