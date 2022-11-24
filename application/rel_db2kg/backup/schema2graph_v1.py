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
from fire import Fire


from utils import Logger, save2json, read_json
import sqlite3
import pandas as pd


class DBengine:
    
    """
    An Entity, which takes a sqlite3 database schema.
    Attributes:
    
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

    def get_outbound_foreign_keys(self, table_name):
        cursor = self.conn.cursor() 
        infos = cursor.execute("PRAGMA foreign_key_list([{}])".format(table_name)).fetchall()
        table_constraints = []
        pks_fks_dict ={}
        for info in infos:
            if info is not None:
                id, seq, ref_table, from_, to_, on_update, on_delete, match = info
                table_constraints.append(
                {"this_table": table_name, "column": from_, "ref_table": ref_table, "ref_column": to_}
                )
                pks_fks_dict[from_]= to_  # ref_column (aka pk in ref_table) is supposed to be the same with column. 
        return table_constraints, pks_fks_dict

    def get_primay_keys(self, table_name):
        cursor = self.conn.cursor() 
        pks = cursor.execute('SELECT l.name FROM pragma_table_info("{}") as l WHERE l.pk <> 0;'.format(table_name)).fetchall()
        return pks  
    
    def check_compound_pk(self, primary_keys):
        compound_pk_check=False
        if len(primary_keys)!=1:  
            compound_pk_check=True
        return compound_pk_check



    def close(self):
        self.conn.cursor.close()
   

# A RelDB (relational database) that stores database name, tables' names and tables' content.
# Initially has no table content.
class RelDB(DBengine):

    """
    A RelDB represents a single relational database in the dataset.

    Attributes:
        fdb: The schema path of a relational database.
        database_name (String): The name of the relational database.
        tables (List): A list of Table objects appearing in this rel_database.
        triples (List): A list of Triple objects appearing in this rel_database.
        tables_pks (Dict): A dictionary to store the primary keys of all tables in this rel_database. 
    """

    def __init__(self, fdb, db_name):
        super().__init__(fdb)
        self.fdb = fdb
        self.db_name = db_name
        self.tables = []
        self.triples = []
        self.db_schema = []
        self.engine = DBengine(fdb)
        self.tables_pks={} 
        self.tables_headers = {}


    def add_tables(self, table):
        """
        Add a table to this rel_db.

        Args:
            table (Table object): The table to add.
        """
        self.tables.append(table)

    def add_triple(self, triple):
        """Add a triple to this rel_database."""
        self.triples.append(triple)

    def add_schema(self, table_schema):
        """Add a table schema to this rel_database.
        
        Args:
            table_schem (TableSchema object)
        """
        self.db_schema.append(table_schema)

    def __str__(self):
        s = ""
        # s += "Index: %d\n" % (self.index)
        s += "Database Name: %s \n" % (self.db_name)
        # s += "Tables:\n"
        for t in self.tables:
            s += str(t)
            s += "\n"
        s += "Triples:\n"
        for t in self.triples:
            s += str(t)
            s += "\n"
        return s

class RelTable:
    
    """
    A Table, which takes the form {[{index: <value>, table_header: <value>}], table_name: <table_name>}

    Attributes:
        table_name (String): The name of this table.
        table_headers (List): The headers of this table.
        row_dict ((Dict): A dictionary of each row appearing in this table, including as follows:
            -table_header (String): The name of table headers.
            -table_name (String): The name of the table, i.e. "activity_1".
        rows (List): A list of rows appearing in this table. 
        phrase_type (String): The type of phrase, i.e. "Table".
        table_constraints (List): Store the information of table constraints. 
    """

    def __init__(self, table_name, table_headers):
        self.table_name = table_name
        self.table_headers = table_headers
        self.rows = []
        self.phrase_type = "Table"
        self.table_constraints=[] #R[{"column": from_, "ref_table": table_name, "ref_column": to_}]
        self.check_compound_pk = False


    def add_row(self, row_dict):
        """
        Add a row to this table.
        Args:
            table (Table object): The table to add.
        """
        self.rows.append(row_dict)

    def __str__(self):
        s = ""
        s += "Table name: %s \n" % (self.table_name)
        s += "Table rows:\n"
        for row_dict in self.rows:
            s += "+++++++++++++++++++++++++++++++++++++++++\n"
            for header, value in row_dict.items():
                s += "%s: %s\n" % (header.ljust(20), value)
        s += "Triples:\n"
        for t in self.triples:
            s += str(t)
            s += "\n"
        return s

    __repr__ = __str__

class TableSchema:
    
    """An Entity, which stores the entity name as a string, and a reference to its table name, and database name.
    Attributes:
        table_headers (TableSchema): The TableSchema corresponding to the table headers.
        table_name (String): The table name of this category.
        db_name (TableSchema): The TableSchema corresponding to the database of this TableSchema.
        # base_class (TableSchema): The TableSchema w.r.t. the base class of this entity, e.g. "Domain", "Table"
    """

    def __init__(self, db_name, table_name, table_headers):
        self.db_name = db_name
        self.table_name = table_name
        self.table_headers = table_headers
        # self.base_class = base_class

    def __str__(self):
        return "( %s ) -> ( %s ) -> ( %s )" % (
            self.table_headers,
            self.table_name,
            self.db_name,
        )

    __repr__ = __str__


class EntityCategory:
    
    """An Entity, which stores the entity name as a string, and a reference to its parent.

    Attributes:
        base_class (EntityCategory): The EnityCategory corresponding to the base class of this entity, e.g. "Item".
        name (String): The name of this category.
        parent (EntityCategory): The EntityCategory corresponding to the parent of this EntityCategory.
    """

    def __init__(self, name, parent_ref, base_class):
        self.name = name
        self.parent = parent_ref
        self.base_class = base_class

    def __str__(self):
        return "( %s ) -> ( %s )" % (
            self.name,
            self.parent if self.parent is not None else "(None)",
        )

    __repr__ = __str__


class RelDBDataset:
    """dtaset class takes a relational databse `schema` as input. 

    A class that represents the whole relational database dataset, i.e. a dataset that constains its whole tables.
    Attributes:
        rel_db (List): A list of RelDB objects in this dataset.
    """
    def __init__(self, paths,  logger):
        self.rel_dbs = self.read_dataset(paths)
        self.logger = logger
     
    def read_dataset(self, paths):
        rel_dbs = []

        for i, db_path in enumerate(paths):
            path_compodbnents = db_path.split(os.sep)
            db_name = path_compodbnents[-1].split('.')[0]
            drop_flag = False

            ###########################################This is for data consistency checking code#######################
            
            missing_data_file = '/Users/ziyuzhao/Desktop/phd/SemanticParser4Graph/application/rel_db2kg/consistency_check/diff_stat.json'
            check_dbs = []
            isFile = os.path.isfile(missing_data_file)
            if isFile:
                if len(read_json(missing_data_file))==1:
                    missing_data = read_json(missing_data_file)[0]['belongs_to_registered_dbs']
                    for missing in missing_data:
                        if '.' in missing:
                            missing_db, missing_table = missing.split('.')
                            if missing_db not in check_dbs:
                                check_dbs.append(missing_db)
                if db_name not in check_dbs:
                    continue
            ###########################################to make sure the acutal data is the same as expected data#######################
            
            if db_name in ['hospital_1']:
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

                    if len(data)>4000:  # we set a threshold for the experiments.
                        drop_flag=True
                        
                    if table_headers == None:
                        self.logger.error("There is no table headers in {} of {}!".format(table_name, db_name))
                        continue 

                    # create table object. Note: one file w.r.t. one table object. 
                    table_object = RelTable(table_name=table_name, table_headers=table_headers)

                    # Check if relational table. If yes, then we rewrite the table name starting with
                    table_constraints, pks_fks_dict =  rel_db_object.engine.get_outbound_foreign_keys(table_name) #R[{"column": from_, "ref_table": table_name, "ref_column": to_}]
                    primary_keys = rel_db_object.engine.get_primay_keys(table_name) #R[(pk, )]


                    # Create a dictionary {table_name:table_headers}
                    rel_db_object.tables_headers[table_name] = table_headers

                    check_compound_pk =  rel_db_object.engine.check_compound_pk(primary_keys)
                    # Create a dictionary {table_name:pks},
                    if not check_compound_pk:
                        rel_db_object.tables_pks[table_name] = primary_keys[0][0]
                    else:
                        rel_db_object.tables_pks[table_name] = [pk[0] for pk in primary_keys]

                    table_object.table_constraints = table_constraints
                    table_object.check_compound_pk = check_compound_pk
                    
                    # create table header category in the format of table_header -> table_name -> db_name. 
                    if table_headers:
                        
                        entity_ref = TableSchema(
                                db_name, table_name, table_headers
                            )
                        rel_db_object.add_schema(entity_ref)
                        for row in data:
                            table_row = {k: row[k] for k in row}                
                            table_object.add_row( row_dict=table_row)
                        rel_db_object.add_tables(table_object)
                rel_dbs.append((drop_flag, rel_db_object))

        return rel_dbs
            
        
class RelDB2KGraphBuilder(RelDBDataset):
    
    """
    RelDB2KG graph builder takes, a relational databse `schema` as inputs. 
    and constructs a Neo4J graph via py2neo.

    Attributes:
        paths (string): 
        logger: 
        defined_fields (dict): A dictionary of defined structured fields. 
        node_normaliser (LexicalNormaliser): A LexicalNormaliser whose purpose is to clean the nodes, \\
             resolving issues such as making 'leaks', 'leaking' etc resolve to a single 'leak' node. 
        Note: defined_fields and node_normaliser are placeholders. 
    """

    def __init__( self, paths, logger, env_file, node_normaliser=None, defined_fields=None):
        super().__init__(paths, logger )
        self.paths = paths
        self.logger = logger
        self.node_normaliser = node_normaliser
        self.defined_fields = defined_fields
        self.env_file = env_file
    
        env = Env()
        env.read_env(self.env_file)
        self.graph = Graph(password=env("GRAPH_PASSWORD"))

        self.node_matcher = NodeMatcher(self.graph)
        self.rel_matcher = RelationshipMatcher(self.graph)

        self.dataset = RelDBDataset(self.paths, self.logger)

    def build_schema_nodes(self, tx):
        print("**********TOTEST: Graph Schema  Builder********")
        # print("Constructing rel_db oriented domain base nodes...")
        self.domain_base_node = Node("Domain", name="Schema_Node:Domain")
        tx.create(self.domain_base_node)
        # print("domain_base_node:", self.domain_base_node)

        # print("Constructing rel_db oriented table schema entity nodes...")
        self.table_base_node = Node("Table", name="Schema_Node:Table")
        tx.create(self.table_base_node)
        # print("table_base_node:", self.table_base_node)

        # "Table" is a part of "Domain".
        tb = Relationship(self.table_base_node, "Schema_Reltionship:Part_of", self.domain_base_node)
        tx.create(tb)
        print(tb)   

    def table2nodes(self, db, tx):
        
        # Note: Open graph transaction again.
        self.tx = self.graph.begin()
        tx = self.tx

        print("************START BUILDING GRAPH NODES****************")
        if  db.db_name is not None:
            # create databse node
            db_node = Node("Domain", name='db:{}'.format( db.db_name))
            print("db_node:", db_node)
            tx.create(db_node)

            # e.g. musical_db is an instance of "Domain".
            tb = Relationship(db_node, "Instance_of_Domain", self.domain_base_node)
            tx.create(tb)
            print(tb)

        for table in db.tables:
            table_name = table.table_name
            primary_keys = db.tables_pks[table_name]
            print(f"{table_name} in {db.db_name}")

            table_node = Node("Table", name='tb:{}'.format( table_name))
            tx.create(table_node)
            # e.g. musical_db is an instance of "Domain".
            rel_tb = Relationship(table_node, "Part_Of", db_node)
            tx.create(rel_tb)
            print(rel_tb)

            # if len(table.rows)==0:
            #     continue

            # DONE: not table.table_constraints
            if  primary_keys:
                if  (not table.table_constraints) or (not table.check_compound_pk):
        
                    # Case: a whole table is turned into corresponding graph nodes,
                    # this covers the following cases:
                    # 1) the examples, that exist just one primary key and several forign keys,
                    # 2) the examples, that exist compound primary keys, but no foreign keys. 
                    # e.g., in musical.db, the table `musical` is the case.
                    for i, row_dict in enumerate(table.rows):
                        print(row_dict)
                        r = Node('{}.{}'.format(db.db_name, table.table_name), **row_dict)
                        print("row node:", r)
                        tx.create(r)
            
        self.graph.commit(tx)

    def create_relationship(self, table_name, 
                        tables_pks, 
                        fk_statement, 
                        table_headers_dict):
        ref_table = fk_statement['ref_table']
        ref_column = fk_statement['ref_column']
        this_column = fk_statement['column']
        if ref_table == table_name: 
            tfms = [fm.lower() for fm in list(tables_pks.values())]
            if this_column.lower() not in tfms:
                is_self_constraint_kf = True
                self.logger.error("Warning! there is an invalid constraint in table {}. ".format(table_name))
                            
                # sql_query = 'SELECT T1.{3}, T2.{3} FROM {0} as T1 join {2} as T2 where T1.{1} = T2.{3}'.format(\
                # table_name, this_column, ref_table, ref_column)
                # print("SELF CONSTRAINT SQL:", sql_query)        
                
            else:
                # Query on the same table by referencing one of this table's columns which is the primary key of the reference table. 
                # e.g. in musical.db, table 'actor' got an example as follows.
                # - FOREIGN KEY ("Musical_ID") REFERENCES "actor"("Actor_ID")
                is_self_constraint_kf = False
                assert len(set(tables_pks.values())) == len(set(tables_pks.keys())), 'FIX ME'
                table_primary_key_pairs_vk = {v:k for k,v in tables_pks.items()}
                ref_table = table_primary_key_pairs_vk.get(this_column)    
                ref_column =  tables_pks[ref_table] 
                # sql_query = 'SELECT {0}.{3}, {0}.{1} FROM {0} join {2} where {0}.{1} = {2}.{1}'.format(\
                #     table_name, this_column , ref_table, ref_column) 
        else:
            # Correct the wrong reference column.
            # e.g. in restaurants.db, table 'LOCATION' references table 'RESTAURANT' with column 'RESTAURANT_ID' which does not 
            # appear in the reference table. 
            is_self_constraint_kf = False
            if ref_column not in table_headers_dict[ref_table]:
                ref_column = tables_pks[ref_table]
            # sql_query = 'SELECT {0}.{1}, {2}.{3} FROM {0} join {2} where {0}.{1} = {2}.{3}'.format(\
            #     table_name, this_column, ref_table ,ref_column)
        return  ref_table, ref_column, is_self_constraint_kf

    def build_graph_components(self, db):
        # Note: Open graph transaction again.
        self.tx = self.graph.begin()
        tx = self.tx
        print("************Start Building Graph Components****************")
        for table in db.tables:
            table_name = table.table_name
            primary_keys = db.tables_pks[table_name]
            print(f"Running {table_name} in {db.db_name}")
            # if len(table.rows)==0:
            #     self.logger.error("There is no content in table {} of {}!".format(table_name, db.db_name))
            #     continue
            if table.table_constraints:    
                for i, row_dict in enumerate(table.rows):
                    print(f'row: {row_dict}')
                    matched_nodes = []
                    fks = [constraint['column'] for constraint in table.table_constraints]
                    for constraint in table.table_constraints:
                        print(f'constraint: {constraint}')
                        ref_table = constraint['ref_table']
                        ref_column = constraint['ref_column']
                        this_column = constraint['column']
                        value = row_dict[this_column]

                        if not isinstance(value, str)  and math.isnan(value):
                            print(f'{this_column} is {value}.')
                            continue 
                        elif type(value)!=int:
                            value = '"{}"'.format(value)
                            if isinstance(value, str) and not re.findall(r'[a-zA-Z].*', value):
                                continue
                            
                        ref_table, ref_column, is_self_constraint_kf = self.create_relationship(table_name, \
                            db.tables_pks, constraint, db.tables_headers)
                        # print( f'ref_column: {ref_column}, ref_table: {ref_table} , is_self_constraint_kf:{is_self_constraint_kf}, table_name: {table_name}, this_column: {this_column}')
                        # print(f' The type of {value} is {type(value)}')
                        # print(f'is_self_constraint_kf: {is_self_constraint_kf}')
                
                        if table.check_compound_pk:   
                            cypher_query =  "match (n:`{}.{}`) where n.{}={} return n".format(db.db_name, ref_table, ref_column, value)
                            matched = self.graph.run(cypher_query).data()
                            print(f'cypher_query: {cypher_query}')
                            print(f'matched: {matched, len(matched)}')
                            
                            if matched:
                                print(f'matched[0]: {matched[0]}')
                                matched_nodes.extend([matched[0]])
                                print(matched_nodes, len(matched_nodes))
                            # else:
                            #     self.logger.error("There are multiple matched graph nodes {} when building graph edge, \
                            #     regarding {} table in {} database.".format(matched, table_name, db.db_name))  
                            #     raise NotImplementedError
                        
                        if not primary_keys and len(table.table_constraints) ==2:
                            # class py2neo.data.Relationship(start_node, type, end_node, **properties)
                            # Note: we consider tables whose do not have the no primary keys but 2 constraints, and turn them into graph edges. 
                            cypher_query =   "match (m:`{}.{}`) match (n:`{}.{}`) where m.{}={} and n.{}={} return m, n".format(db.db_name, table_name, db.db_name, ref_table, \
                                    this_column, value,  ref_column, value)
                            matched = self.graph.run(cypher_query).data()
                            print(f'cypher_query: {cypher_query}')
                            print(f'matched: {matched, len(matched)}')

                            if matched:
                                print(f'matched[0]: {matched[0]}')
                                matched_nodes.extend([matched[0]])
                                print(matched_nodes, len(matched_nodes))
               

                        if not table.check_compound_pk and len(table.table_constraints) !=2:
                            # Case: a whole table is turned into corresponding graph nodes, and some curated graph edges based on w.r.t. foreign keys.
                            # e.g., in musical.db, the table `actor` is the case, 
                            # along with `HAS_MUSICAL` is curated based on the FK, musical
                        
                            # TODO
                            if table_name!=ref_table:
                                cypher_query =  "match (m:`{}.{}`)-[r]-(n:`{}.{}`) return r".format(db.db_name, table_name, db.db_name, ref_table)
                                returned_rels = self.graph.run(cypher_query).data()
                                print(f'cypher_query: {cypher_query}, db_name: {db.db_name}')
                                print(f'returned_rels: {returned_rels}, db_name: {db.db_name}')

                                if len(returned_rels)==0:
                                    # NOTE: deal with many-to-one mapping, or one-to-many mapping. 
                                    print("----------------------------------------------debug------------------------------------------------------")
                                    matching_query =  "match (m:`{}.{}`) match (n:`{}.{}`) where m.{}={} and n.{}={} return m, n".format(db.db_name, table_name, db.db_name, ref_table, \
                                    this_column, value,  ref_column, value)
                                    returned_nodes = self.graph.run(matching_query).data()
                                    for matching in returned_nodes:
                                        rel_type = '{}.{}_HAS_{}.{}'.format(db.db_name, table_name.capitalize(), db.db_name, ref_table.capitalize())
                                        rel = Relationship(matching['m'], rel_type, matching['n'])
                                        tx.create(rel)
                                        print(rel)
                    

                    print(matched_nodes, len(matched_nodes))
                    if len(matched_nodes) ==2:
                        # Case: a whole table is turned into graph edges, 
                        # e.g., in department_management.db, the table `management` is the case, 
                        # however, there is an issue in this particular case. To be able to sucessfully 
                        # build a graph edge, graph nodes should be created already. Unlike case two, the 
                        # head and tail nodes of a edge come form the same table, this case's targeted nodes 
                        # come from other tables, which means other tables should be sucessfully turned into 
                        # graph components already. 
                        # To solve this problem, I retrive the whole database a second time. 
                      
                        
                        # class py2neo.data.Relationship(start_node, type, end_node, **properties)
                        print(f'********************************Building graph edge directly from {table_name}.***************************')   
                        # NOTE: we remove the foreign keys from each graph edge's property set, for the sake of the consistency of graph database.
                        # to make sure the update of head or tail nodes would not violate the data consistency. 
                        update_row_dict = {k: row_dict[k] for k in row_dict if k not in fks}  
                        print(f'update_row_dict: {update_row_dict}')
                        rel = Relationship(matched_nodes[0]['n'], '{}.{}'.format(db.db_name, table_name), matched_nodes[1]['n'], **update_row_dict) 
                        tx.create(rel)

                    else:
                        print(f'********************Building curate graph from the contraints of {table_name}.***********************')   
                        # TODO: A place holder for hyper graph, where each row of this table is a hyper edge? 
                        # NOTE: It is supposed to a hyper_edge, but Neo4j can not visulize hyper edges, so we refer each hyper edge as a graph node. 
                        checking_nodes_query =  "match (n:`{}.{}`)  return n".format(db.db_name, table.table_name)
                        checking_res = self.graph.run(checking_nodes_query).data()
                        # print(f'checking_nodes_query: {checking_nodes_query}')
                        # print(f'matched: {checking_res, len(checking_res)}')
                        if not checking_res:
                            hyper_node = Node('{}.{}'.format(db.db_name, table.table_name), **row_dict) 
                            print(f'table_name: {table_name}, potential_hyper_node?: {hyper_node}')
                            tx.create(hyper_node)
                            for node in matched_nodes:
                                rel = Relationship(hyper_node, '{}.{}_HAS_{}.{}'.format(db.db_name, table_name.capitalize(), db.db_name, ref_table.capitalize()), node['n']) 
                                tx.create(rel)  

            
        self.graph.commit(tx)

    
    def build_graph(self):
        self.tx = self.graph.begin()
        tx = self.tx
       
        
        for i, rel_db in enumerate(self.dataset.rel_dbs):          
            (drop_flag, db) = rel_db
            if i==0:
                # Note: i is the index of relational database. 
                self.graph.delete_all()
                self.build_schema_nodes(tx)
            print("************Start building graph directly from relational table schema****************")
            if not drop_flag:
                # test
                # if db.db_name in ['department_management', 'musical']:
                self.table2nodes(db, tx)
                self.build_graph_components(db)
            
        

     
            
    
def main():
    import glob, argparse
    import configparser
    config = configparser.ConfigParser()
    config.read('../config.ini')
    filenames = config["FILENAMES"]

    raw_folder = filenames['raw_folder']
    env_file = filenames['env_file']

    parser = argparse.ArgumentParser(description='relational database to graph database.')
    # parser.add_argument('--consistencyChecking', help='Check the consistency between fields in sql query and schema', action='store_true')
    parser.add_argument('--spider', help='build graph from spider.', action='store_true')
    parser.add_argument('--wikisql', help='build graph from wikisql.', action='store_true')
    args = parser.parse_args()

    if args.spider:
        raw_spider_folder = os.path.join(raw_folder, 'spider')
        db_folder = os.path.join(raw_spider_folder,  'database')
        spider_dbs = glob.glob(db_folder + '/**/*.sqlite', recursive = True) 
        RelDB2KGraphBuilder(spider_dbs,  Logger(), env_file).build_graph()
    
    if args.wikisql:
        raw_wikisql_folder = os.path.join(raw_folder, 'wikisql1.1')
        wikisql_dbs = glob.glob(raw_wikisql_folder + '/*.db', recursive = True) 
        print(f'wikisql db files: {wikisql_dbs}')

        # RelDB2KGraphBuilder(wikisql_dbs,  Logger(), env_file).build_graph()

if __name__ == "__main__":
    main()


