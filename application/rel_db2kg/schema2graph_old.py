'''
Author: Ziyu Zhao
Affiliation: UWA NLT-TLP GROUP
'''

import os, re
from mysqlx import Row
from py2neo import Graph
from py2neo.matching import *
from py2neo.data import Node, Relationship
from environs import Env
from fire import Fire
from torch import row_indices_copy
from transformers import TFXLMMainLayer

from utils import Logger
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
                print(info)
            
                table_constraints.append(
                {"column": from_, "ref_table": ref_table, "ref_column": to_}
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
        triples (List): A list of Triple objects appearing in this table.
        phrase_type (String): The type of phrase, i.e. "Table".
    """

    def __init__(self, table_name, table_headers):
        self.table_name = table_name
        self.table_headers = table_headers
        self.rows = []
        self.triples = []
        self.phrase_type = "Table"

    def add_row(self, row_dict):
        """
        Add a row to this table.
        Args:
            table (Table object): The table to add.
        """
        self.rows.append(row_dict)
    
    def add_triple(self, triple):
        """Add a triple to this document."""
        self.triples.append(triple)

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

class Triple:
    
    """

    # A triple, which connects a subject with an object via a relation.

    Attributes:
        head (Entity): The object Entity.
        tail (Entity): The subject Entity.
        rel (Phrase): The relation phrase.
    """

    def __init__(self, head, rel, tail):
        self.head = head
        self.rel = rel
        self.tail = tail

    def __str__(self):
        return "(%s)-[%s]->(%s)" % (
            self.head.short_print(),
            self.rel.short_print(),
            self.tail.short_print(),
        )

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
            # test
            if db_name == 'musical':
                # create realational database object.
                rel_db_object = RelDB(fdb = db_path, db_name=db_name)
                # engine = rel_db_object.engine
                table_infos = rel_db_object.engine.get_table_names()
                for table_info in table_infos:
                    table_name = table_info[0]
                    # Export tables to neo4j/import as csv files.                           
                    table_records = rel_db_object.engine.get_table_values(table_name)
                    table_headers = [desc[0] for desc in table_records.description]    
                    print("table_headers:", table_headers )

                    df = pd.DataFrame(table_records.fetchall(), columns = table_headers)
                    # Drop duplicate rows in place.
                    df.drop_duplicates(inplace=True)
                    data = df.transpose().to_dict().values()  # to keep the origial data types.

                    if table_headers == None:
                        self.logger.error("There is no table headers in {} of {}!".format(table_name, db_name))
                        continue 

                    # Check if relational table. If yes, then we rewrite the table name starting with
                    # 'rel_' as a single during the graph constructing process. 
                    foreign_keys, pks_fks_dict =  rel_db_object.engine.get_outbound_foreign_keys(table_name) #R[{"column": from_, "ref_table": table_name, "ref_column": to_}]
                    primary_keys = rel_db_object.engine.get_primay_keys(table_name) #R[(pk, )]

                    # Create a dictionary {table_name:table_headers}
                    rel_db_object.tables_headers[table_name] = table_headers

                    compound_pk_check =  rel_db_object.engine.check_compound_pk(primary_keys)
                    if compound_pk_check and foreign_keys:
                        table_name = 'rel_{}'.format(table_name)
                    
                    # Create a dictionary {table_name:pks},
                    if not compound_pk_check:
                        rel_db_object.tables_pks[table_name] = primary_keys[0][0]

                    # create table object. Note: one file w.r.t. one table object. 
                    table_object = RelTable(table_name=table_name, table_headers=table_headers)
                    
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
                rel_dbs.append(rel_db_object)

        return rel_dbs
            
        
class RelDB2KGraphBuilder(RelDBDataset):
    
    """
    RelDB2KG graph builder takes, a relational databse `schema` as inputs. 
    and constructs a Neo4J graph via py2neo.

    Attributes:
        paths (string): 
        logger: 
        defined_fields (dict): A dictionary of defined structured fields.
        node_normaliser (LexicalNormaliser): A LexicalNormaliser whose purpose is to clean the nodes, resolving issues such as making 'leaks', 'leaking' etc resolve to a single 'leak' node.
        nodes_properties (List): A list of node properties (dict).    
    """

    def __init__( self, paths, logger, env_file, node_normaliser=None, defined_fields=None):
        super().__init__(paths, logger )
        self.paths = paths
        self.logger = logger
        self.node_normaliser = node_normaliser
        self.defined_fields = defined_fields
        self.env_file = env_file
        self.nodes_properties =[]
        env = Env()
        env.read_env(self.env_file)
        self.graph = Graph(password=env("GRAPH_PASSWORD"))
        self.node_matcher = NodeMatcher(self.graph)

        self.dataset = RelDBDataset(self.paths, self.logger)

    
    def build_schema_nodes(self, tx):
        print("Constructing rel_db oriented domain base nodes...")
        self.domain_base_node = Node("Domain", name="Schema_Node:Domain")
        tx.create(self.domain_base_node)
        print("domain_base_node:", self.domain_base_node)

        print("Constructing rel_db oriented table schema entity nodes...")
        self.table_base_node = Node("Table", name="Schema_Node:Table")
        tx.create(self.table_base_node)
        print("table_base_node:", self.table_base_node)

        # "Table" is a part of "Domain".
        tb = Relationship(self.table_base_node, "Schema_Reltionship:Part_of", self.domain_base_node)
        tx.create(tb)
        print(tb)
                
    def build_nodes(self):
        """
        Constructs the graph nodes.
        # TODO: Clean this entire function up.
        """
        self.graph.delete_all()
        self.tx = self.graph.begin()
        tx = self.tx

        self.build_schema_nodes(tx)

        seen_docs = {}

        for db in self.dataset.rel_dbs: 
            print("**********Debug Graph Node Builder********")
            if  db.db_name is not None and  db.db_name not in seen_docs:
                seen_docs[db.db_name] = db
                # create databse node
                db_node = Node("Domain", name='db:{}'.format( db.db_name))
                print("db_node:", db_node)
                tx.create(db_node)

                # e.g. musical_db is an instance of "Domain".
                tb = Relationship(db_node, "Instance_of_Domain", self.domain_base_node)
                tx.create(tb)
                print(tb)
                        
            for table in db.tables:
                
                if table.table_name.lower().startswith('has'):
                    continue
                elif table.table_name.startswith('rel'):
                    continue
                else:
                    
                    # create table entity node with table headers, and connect to table base node. 
                    table_node = Node( 'Schema_Table:{}'.format(table.table_name), name= table.table_headers)
                    tx.create(table_node)
                    
                    # A specific table is an instance of Table. 
                    tb = Relationship(table_node, "Instance_of_Table", self.table_base_node)
                    tx.create(tb)
                    print(tb)             
                    for i, row_dict in enumerate(table.rows):
                        self.nodes_properties.append(row_dict)
                        r = Node(table.table_name,**row_dict)
                        print("row node:", r)
                        tx.create(r)

                        rt = Relationship(r, "IsA_Row_of", table_node)
                        tx.create(rt)
                        print(rt)
        
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

    def build_edges(self):
        """
        Constructs the graph edge.
        # TODO: Clean this entire function up.
        """
        # self.graph.delete_all()
        self.tx = self.graph.begin()
        tx = self.tx

        print("Building graph edge directly from relational table...")

        for db in self.dataset.rel_dbs:     
            for table in db.tables:
                table_name = table.table_name
                if len(table.rows)==0:
                    continue
                if table_name.lower().startswith('has'):
                    for i, row_dict in enumerate(table.rows):
                        print("chek it out:", row_dict)
                        assert 1>2
                        # start_node, end_node = self.start_end_handler(row_dict)
                        # print("jlk", start_node, end_node )
                        # if start_node and end_node:      
                        #     rel = Relationship(start_node, table.table_name, end_node)
                        #     tx.create(rel)
                        #     print("rel:", rel)
                        # else:
                        #     start_nodes, end_nodes = self.edge_handler(row_dict)
                        #     if len(start_nodes)==1 and len(end_nodes)==1:
                        #         rel = Relationship(start_nodes[0]['n'], rel_type, end_nodes[0]['n'], **row_dict) # class py2neo.data.Relationship(start_node, type, end_node, **properties)
                        #         tx.create(rel)
                            
                elif table_name.startswith('rel'):
                    rel_type = table_name.split('rel_')[1]
                    primary_keys = db.engine.get_primay_keys(rel_type) #R[(pk, )]
                    table_constraints, pks_fks_dict =  db.engine.get_outbound_foreign_keys(rel_type) #R[{"column": from_, "ref_table": table_name, "ref_column": to_}]
                    # print("table_name:", rel_type)
                    # print("primary_keys:", primary_keys)
                    # print("table_constraints:", table_constraints)
                    # print("pks_fks_dict:", pks_fks_dict)
                    if len(table.rows)==0:
                        self.logger.error("There is no content in table {}!".format(rel_type))
                        continue

                    for i, row_dict in enumerate(table.rows):
                        matched_nodes = []
                        for constraint in table_constraints:
                            ref_table = constraint['ref_table']
                            ref_column = constraint['ref_column']
                            this_column = constraint['column']
                            value = row_dict[this_column]
                            print("value", this_column, value)
                            print("heyyy", ref_table, ref_column, rel_type, this_column)
                            cypher_query =  "MATCH (n:{}) where n.{}={} return n".format(ref_table, ref_column, value)
                            matched = self.graph.run(cypher_query).data()
                            if len(matched)==1:
                                matched_nodes.append(matched[0])
                            else:
                                self.logger.error("There are multiple matched graph nodes when building graph edge, \
                                regarding {} table in {} database.".format(table_name, db.db_name))
                        print(matched_nodes, len(matched_nodes))

                        # class py2neo.data.Relationship(start_node, type, end_node, **properties)
                        rel = Relationship(matched_nodes[0]['n'], rel_type, matched_nodes[1]['n'], **row_dict) 
                        tx.create(rel)
                else:
                   
                    table_constraints, pks_fks_dict =  db.engine.get_outbound_foreign_keys(table_name) #R[{"column": from_, "ref_table": table_name, "ref_column": to_}]
                    # print("table_name:", table_name)
                    # print("primary_keys:", primary_keys)
                    # print("table_constraints:", table_constraints)
                    # print("pks_fks_dict:", pks_fks_dict)
                    if table_constraints:
                        for i, row_dict in enumerate(table.rows):
                            print(row_dict)
                            matched_nodes = []
                            for constraint in table_constraints:
                                ref_table = constraint['ref_table']
                                ref_column = constraint['ref_column']
                                this_column = constraint['column']
 
                                ref_table, ref_column, is_self_constraint_kf = self.create_relationship(table_name, \
                                    db.tables_pks, constraint, db.tables_headers)
                                
                                if not is_self_constraint_kf:
                                    cypher_query0 =  "MATCH (n:{}) where n.{}={} return n".format(table_name, this_column, row_dict[this_column])
                                    head_nodes = self.graph.run(cypher_query0).data()
                                    
                                    cypher_query1 =  "MATCH (n:{}) where n.{}={} return n".format(ref_table, ref_column, row_dict[ref_column])
                                    tail_nodes = self.graph.run(cypher_query1).data()
                                    
                                    # class py2neo.data.Relationship(start_node, type, end_node, **properties)
                                    for head in head_nodes:
                                        for tail in tail_nodes:
                                            rel = Relationship(head['n'], 'HAS_{}'.format(ref_table.upper()), tail['n']) 
                                            tx.create(rel)
                                            print(rel)
                    
        
        self.graph.commit(tx)                                   

    def build_graph(self):
        """
        Constructs the graph nodes.
        # TODO: Clean this entire function up.
        """
        self.build_nodes()
        self.build_edges()
            
    
def main():
    import glob
    import configparser
    config = configparser.ConfigParser()
    config.read('../config.ini')
    filenames = config["FILENAMES"]

    raw_folder = filenames['raw_folder']
    env_file = filenames['env_file']

    raw_spider_folder = os.path.join(raw_folder, 'spider')

    db_folder = os.path.join(raw_spider_folder,  'database')

    spider_dbs = glob.glob(db_folder + '/**/*.sqlite', recursive = True) 

    RelDB2KGraphBuilder(spider_dbs,  Logger(), env_file).build_graph()

if __name__ == "__main__":
    Fire(main)


