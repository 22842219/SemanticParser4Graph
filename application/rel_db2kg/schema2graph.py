'''
Author: Ziyu Zhao
Affiliation: UWA NLT-TLP GROUP
'''

import os, re, math
from typing import Set
from py2neo import Graph
from py2neo.matching import *
from py2neo.data import Node, Relationship
from environs import Env


import numpy as np
import sqlite3
import pandas as pd


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
        return cursor.execute('SELECT * from {}'.format(table_name))  

    def get_schema(self, table_name):
        cursor = self.conn.cursor()  
        cursor.execute('SELECT sql FROM sqlite_master WHERE type = "table" and name= "{}";'.format(table_name))  
        result = cursor.fetchone()
        if result is None:
            raise ValueError("Table %s does not exist" % table_name)
        return result[0].strip()  
    def get_data_type(self, table_name):
        cursor = self.conn.cursor() 
        infos = cursor.execute("PRAGMA table_info({})".format(table_name))
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
            if dtype.lower() in ['text', 'varchar', 'varchar(20)']:
                dtype=str
            if dtype in ['INTEGER', 'INT']:
                dtype=int
            data_types[col_name] = dtype
        return data_types

    def get_outbound_foreign_keys(self, table_name):
        cursor = self.conn.cursor() 
        infos = cursor.execute("PRAGMA foreign_key_list({})".format(table_name)).fetchall()
        constraints = {}
        for info in infos:
            id, seq, to_table, fk, to_col, on_update, on_delete, match = info
            constraints[fk]= {  
                    "to_tab": to_table, 
                    "to_col": to_col
                }
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
    def __init__(self, paths, logger):
        self.rel_dbs, self.db_fk_constraints, self.db_data_type, self.db_pks= self.read_dataset(paths)
        self.logger = logger
        
    def fix_reference(self, tbs_fk_constraints, tbs_pks, db_tbs):
        for tb_name, fks in tbs_fk_constraints.items():
            pks = tbs_pks[tb_name]
            for fk, constraint in fks.items():
                to_col = constraint['to_col']
                to_tb_name = constraint['to_tab']
                if to_tb_name==tb_name:
                    for tb_name_ , pks in tbs_pks.items():
                        pks_  = [pk.lower() for pk in pks]
                        if fk.lower() in pks_:
                            constraint['to_tab'] = tb_name_
                            if to_col.lower() not in pks_:
                                constraint['to_col']= pks[pks_.index(fk.lower())]
                    fks.update({fk:constraint})
                    db_tbs[tb_name].fks.update({fk:constraint})

    def fix_fk(self, tbs_fk_constraints, tbs_data_type, db_tbs):
        for tb_name, fks in tbs_fk_constraints.items():
            for fk, constraint in fks.items():
                to_col = constraint['to_col']
                to_tb_name = constraint['to_tab']
                assert type(fk)==type(to_col), 'FIX ME'
                if tb_name in db_tbs and to_tb_name in db_tbs:
                    print('yes', tb_name, to_tb_name)
                    to_col_type  = tbs_data_type[to_tb_name][to_col]
                    tbs_data_type[tb_name].update({fk: to_col_type}) #update each table's dataype dictionary, aka each fk's data type to allign with its reference's datatype. 

                    # update the actual value type of each fk to allign with updated fk's data type.
                    for i, row_dict in enumerate(db_tbs[tb_name].rows): 
                        if db_tbs[to_tb_name].cols[to_col]:
                            to_col_value_type = db_tbs[to_tb_name].cols[to_col][0]
                            stripped_value = str(row_dict[fk]).strip('\'').strip('\"')
                            if isinstance(to_col_value_type, int) and not isinstance(row_dict[fk], int):
                                if isinstance(row_dict[fk], float) and not math.isnan(row_dict[fk]):
                                    db_tbs[tb_name].rows[i].update({fk: int(row_dict[fk])})
                                elif stripped_value:
                                    db_tbs[tb_name].rows[i].update({fk: int(stripped_value)})
                            elif isinstance(to_col_value_type, str) and  not isinstance(row_dict[fk], str):
                                db_tbs[tb_name].rows[i].update({fk: "'{}'".format(stripped_value)}) 
                            elif isinstance(to_col_value_type, float) and not isinstance(row_dict[fk], float):
                                db_tbs[tb_name].rows[i].update({fk: float(stripped_value)})

                    
                    # update tb_object.cols
                    for col, col_val_list in db_tbs[tb_name].cols.items(): 
                        if col==fk and db_tbs[to_tb_name].cols[to_col] and row_dict[fk]:
                            to_col_value_type = db_tbs[to_tb_name].cols[to_col][0]
                            stripped_value = str(row_dict[fk]).strip('\'').strip('\"')
                            if isinstance(to_col_value_type, int) and not isinstance(col_val_list[0], int):
                                if isinstance(row_dict[fk], float) and not math.isnan(row_dict[fk]):
                                    col_val_list = [int(val) for val in col_val_list]
                                elif stripped_value:
                                    col_val_list = [int(str(val).strip('\'').strip('\"')) for val in col_val_list if val]
                                db_tbs[tb_name].cols.update({fk: col_val_list})
                            elif isinstance(to_col_value_type, str) and  not isinstance(col_val_list[0], str):
                                col_val_list = ["'{}'".format(str(val).strip('\'').strip('\"')) for val in col_val_list if val]
                                db_tbs[tb_name].cols.update({fk: col_val_list}) 
                            
                            elif isinstance(to_col_value_type, float) and not isinstance(row_dict[fk], float):
                                # print('tb_name', tb_name)
                                db_tbs[tb_name].rows[i].update({fk: float(stripped_value)})
                    

    def read_dataset(self, paths):
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
            #                     check_dbs.append(missing_db)
            #     if db_name not in check_dbs:
            #         pass
            ###########################################to make sure the acutal data is the same as expected data#######################
           # in [, 'car_1', , 'pets_1', , 'real_estate_properties']['concert_singer', 'department_management', 'musical']
            if db_name:
                print('db_name:', db_name)
                rel_dbs[db_name]={}               
                db_fk_constraints[db_name] = {}
                db_data_type[db_name]={}
                db_pks[db_name]={}
                engine = DBengine(db_path)
                tab_names = [tab_info[0] for tab_info in engine.get_table_names()]
                for i, table_name in enumerate(tab_names):
                    print("table_name:", table_name)
                    tb_object = RelTable(db_name, table_name)                         
                    table_records = engine.get_table_values(table_name)
                    tb_object.headers = [desc[0] for desc in table_records.description]     
                    tb_object.data_type= engine.get_data_type(table_name)
                    tb_object.fks =  engine.get_outbound_foreign_keys(table_name) 
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
                    
                    if len(data)>4000:  # we set a threshold for the experiments.
                        continue
                    if tb_object.headers == None:
                        self.logger.error("There is no table headers in {} of {}!".format(table_name, db_name))
                        assert 1>2
                    rows = data or [ {k: '' for k in tb_object.headers} ]
                    list(map(lambda row: tb_object.add_row(row), rows))
                    rel_dbs[db_name][table_name] = tb_object
                
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

    def __init__( self, paths, 
                        logger, 
                        env_file, 
                        if_cased, 
                        node_normaliser=None, 
                        defined_fields=None):
        super().__init__(paths, logger )
        self.paths = paths
        self.logger = logger
        self.node_normaliser = node_normaliser
        self.defined_fields = defined_fields
        self.env_file = env_file
        self.if_cased = if_cased

        env = Env()
        env.read_env(self.env_file)
        self.graph = Graph(password=env("GRAPH_PASSWORD"))
        self.dataset = RelDBDataset(self.paths, self.logger)


    def get_matched_node(self, db_name, tb_name, col, val, val_type):
        alias = tb_name.lower()
        print(f'tb_name: {tb_name}, val: {val}, val_type: {val_type}, tb_name: {tb_name}, col: {col}')
        # assert   isinstance(val, val_type), 'FIX ME'
        if val and isinstance(val, val_type):
            if type(val)==str:
                val = '"{}"'.format(str(val).strip('\'').strip('\"'))
                # elif not re.findall(r'[\'|\"][a-zA-Z].*', val):
                #     return None
                # if isinstance(val, str) and not re.findall(r'[a-zA-Z].*', val):
                #     return None
            elif type(val)==int:
                val = int(str(val).strip('\'').strip('\"'))     
            match_ =  "match ({}:`{}.{}`) ".format(alias, db_name, tb_name)
            condi = []
            condi.append('{}.{}={}'.format( alias, col, val))
            if bool(condi):
                where_ = ' where ' + ' and '.join(condi) 
            else:
                where_ = ''
            cypher = match_ + where_ + ' return {}'.format(alias)
            self.logger.warning(f'cypher_query: {cypher}')
            results = self.graph.run(cypher).data()
            for result in results:
                yield result

        else:
            print(f"Value '{val}' is not an instance of {val_type}")


   

    def build_schema_nodes(self, tx):
        self.logger.info("**********TOTEST: Graph Schema  Builder********")
        self.domain_base_node = Node("Domain", name="Schema_Node:Domain")
        tx.create(self.domain_base_node)

        self.table_base_node = Node("Table", name="Schema_Node:Table")
        tx.create(self.table_base_node)

        rel = Relationship(self.table_base_node, "Schema_Reltionship:Part_of", self.domain_base_node)
        tx.create(rel)

    def table2nodes(self, db_name, tbs_dict, tx): 
        self.logger.info("************START BUILDING GRAPH NODES****************")
        self.tx = self.graph.begin()
        tx = self.tx
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
           
                for i, row_dict in enumerate(tab.rows):
                    graph_row_dict = dict((k.lower(), v) for k, v in row_dict.items()) if not self.if_cased else row_dict
                    graph_db_name = db_name if self.if_cased else db_name.lower()
                    graph_node_label = tb_name if self.if_cased else tb_name.lower()
                    r = Node('{}.{}'.format(graph_db_name, graph_node_label), **graph_row_dict)
                    tx.create(r)
        self.graph.commit(tx)

    def table2edges(self, db_name, tbs_dict):
        # Note: Open graph transaction again.
        self.logger.warning("************Start Building Graph Edges****************")
        self.tx = self.graph.begin()
        tx = self.tx
        for tb_name, tab in tbs_dict.items():
            if tab.fks:
                ref_tables = set([contraint_['to_tab'] for fk, contraint_ in tab.fks.items()])
                fks = [contraint_['to_col'] for fk, contraint_ in tab.fks.items() ]
                if len(ref_tables)==2 and (tab.is_compound_pk or not tab.pks):
                    for row_dict in tab.rows:
                        # and  (not primary_keys or table.check_compound_pk):
                        # class py2neo.data.Relationship(start_node, type, end_node, **properties)
                        self.logger.warning(f'******Building graph edge directly from {tb_name}.*******')   
                        '''
                        NOTE 1: deal with one-to-one by the table itself as edges, aka, a whole table is turned into graph edges,                         
                        NOTE 2: we remove the foreign keys from each graph edge's property set, for the sake of the consistency of graph database.
                            to make sure the update of head or tail nodes would not violate the data consistency.                    
                        '''
                        # update_row_dict = {k: row_dict[k] for k in row_dict if k not in fks}  
                        # self.logger.warning(f'update_row_dict: {update_row_dict}')
                        matched = {}
                        matched_labels = []
                        for fk, constraint in tab.fks.items():
                            to_tab = constraint['to_tab']
                            to_col = constraint['to_col']            
                            value = row_dict[fk]
                            if not tbs_dict[to_tab].cols[to_col]:
                                continue
                            ref_value_type = type(tbs_dict[to_tab].cols[to_col][0])
                            # val = np.array(value).astype(ref_value_type) # allign value_type with ref_value_type
                            assert tb_name!=to_tab, 'FIX ME'  
                            matched_res = [res for res in self.get_matched_node(db_name, to_tab, to_col, value, ref_value_type) if res is not None]
                            self.logger.warning(f"matched_res : {matched_res}, {len(matched_res)}")   
                            
                            if len(matched_res)>1:
                                print(f'tb_name:, {tb_name}, fk: {fk}, to_tab: {to_tab}, to_col: {to_col}')
                                assert 1>2
                            else:
                                for label, node in matched_res[0].items():
                                    matched[label] =  node
                                    matched_labels.append(label)
                        if len(matched)==2:
                            rel = Relationship(matched[matched_labels[0]], '{}.{}'.format(db_name, tb_name), matched[matched_labels[1]], **row_dict) 
                            tx.create(rel)
                        elif len(matched)>2:
                            self.logger.warning("Hyper edge exist in {db_name}: {tb_name}")
                        else:
                            print("Error: Insufficient matched_labels. Cannot create relationship.")



     
        self.graph.commit(tx)

    def build_edges(self, db_name, tbs_dict):
        # Note: Open graph transaction again.
        self.logger.warning("************Start Building Graph Edges****************")
        self.tx = self.graph.begin()
        tx = self.tx
        for tb_name, tab in tbs_dict.items():   
            if tab.fks:
                ref_tables = set([constraint['to_tab'] for fk, constraint in tab.fks.items() ])
                if not (len(ref_tables)==2 and tab.is_compound_pk):
                    self.logger.warning(f"Running {tb_name} in {db_name} with {tab.headers}")
                    for row_dict in tab.rows:
                        for fk, constraint in tab.fks.items():
                            to_tab = constraint['to_tab']
                            to_col = constraint['to_col']            
                            value = row_dict[fk]
    
                            if tbs_dict[to_tab].cols[to_col]:
                                ref_value_type = type(tbs_dict[to_tab].cols[to_col][0])
                                alias = constraint['to_tab'].lower()
                                # val = np.array(value).astype(ref_value_type) # allign value_type with ref_value_type
                                assert tb_name!=to_tab, 'FIX ME'
                                self.logger.warning(f'this_table: {tb_name}, fk: {fk}, value: {value}, datatype: {type(value)}, to_table: {alias}, to_col: {to_col}, ref_value_type: {ref_value_type}')
   
                                for this in self.get_matched_node(db_name, tb_name, fk, value, type(value)):    
                                    for s_label, this_node in this.items():
                                        start_node_label='{}.{}'.format(db_name, s_label)
                                    for ref in self.get_matched_node(db_name, to_tab, to_col, value, ref_value_type):
                                        for ref_label, ref_node in ref.items():
                                            end_node_label='{}.{}'.format(db_name, ref_label)
                                        rel = Relationship(this_node, '{}_LinkTo_{}'.format( start_node_label, end_node_label ), ref_node) 
                                        tx.create(rel)

        self.graph.commit(tx)

    def build_graph(self, index):
        self.tx = self.graph.begin()
        tx = self.tx
       
        for db_name, tbs_dict in self.dataset.rel_dbs.items():          
            if index==0:
                # Note: i is the index of relational database. 
                self.graph.delete_all()
                # self.build_schema_nodes(tx)
            
            self.logger.warning("************Start building graph directly from relational table schema****************")
            self.table2nodes(db_name, tbs_dict, tx)
            self.table2edges(db_name, tbs_dict)
            self.build_edges(db_name, tbs_dict) # this process should run based on table2node process
        
          
    
def main():
    import glob, argparse
    import configparser
    from utils import Logger
    config = configparser.ConfigParser()
    config.read('../config.ini')
    filenames = config["FILENAMES"]

    raw_folder = filenames['raw_folder']
    env_file = filenames['env_file']

    parser = argparse.ArgumentParser(description='relational database to graph database.')
    # parser.add_argument('--consistencyChecking', help='Check the consistency between fields in sql query and schema', action='store_true')
    parser.add_argument('--spider', help='build graph from spider.', action='store_true')
    parser.add_argument('--wikisql', help='build graph from wikisql.', action='store_true')
    parser.add_argument('--uncased', help='build graph from spider and lowercasing all properties.', action='store_true')
    args = parser.parse_args()

    if args.spider:
        raw_spider_folder = os.path.join(raw_folder, 'spider')
        db_folder = os.path.join(raw_spider_folder,  'database')
        spider_dbs = glob.glob(db_folder + '/**/*.sqlite', recursive = True) 
       
        if args.uncased:
            for i, db_path in enumerate(spider_dbs):
                RelDB2KGraphBuilder([db_path],  Logger('/rel_schema2graph.log'), env_file, if_cased=False).build_graph(index = i)
        else:
            for i, db_path in enumerate(spider_dbs):
                RelDB2KGraphBuilder([db_path],  Logger('/rel_schema2graph.log'), env_file, if_cased=True).build_graph(index = i)

    
    if args.wikisql:
        raw_wikisql_folder = os.path.join(raw_folder, 'wikisql1.1')
        wikisql_dbs = glob.glob(raw_wikisql_folder + '/*.db', recursive = True) 
        # self.logger.warning(f'wikisql db files: {wikisql_dbs}')

        # RelDB2KGraphBuilder(wikisql_dbs,  Logger(), env_file).build_graph()

if __name__ == "__main__":
    main()