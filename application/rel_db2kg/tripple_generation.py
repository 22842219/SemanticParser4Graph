'''
Author: Ziyu Zhao
Affiliation: UWA NLT-TLP GROUP
'''

import pandas, os
import pandas
from py2neo import Graph
from py2neo.matching import *
from py2neo.data import Node, Relationship
from environs import Env
from fire import Fire

from utils.utils import Logger

env = Env()
env.read_env('/Users/ziyuzhao/Desktop/SemanticParser4Graph/.env')



env = Env()
env.read_env('/media/ziyu/e49f0873-c304-4523-a240-6c3b6cfd1df2/zzy/Phd/projects/SemanticParser4Graph/.env')

# A RelDB (relational database) that stores database name, tables' names and tables' content.
# Initially has no table content.
class RelDB:

    """
    A RelDB represents a single relational database in the dataset.

    Attributes:
        # index (Integer): The rel_database index.
        database_name (String): The name of the relational database.
        tables (List): A list of Table objects appearing in this rel_database.
        triples (List): A list of Triple objects appearing in this rel_database.
    """

    def __init__(self,  db_name):
        # self.index = index
        self.db_name = db_name
        self.tables = []
        self.triples = []
        self.db_schema = []


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
        table_header (TableSchema): The TableSchema corresponding to the table headers.
        table_name (String): The table name of this category.
        db_name (TableSchema): The TableSchema corresponding to the database of this TableSchema.
        # base_class (TableSchema): The TableSchema w.r.t. the base class of this entity, e.g. "Domain", "Table"
    """

    def __init__(self, db_name, table_name, table_header):
        self.db_name = db_name
        self.table_name = table_name
        self.table_header = table_header
        # self.base_class = base_class

    def __str__(self):
        return "( %s ) -> ( %s ) -> ( %s )" % (
            self.table_header,
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
    """
    A class that represents the whole relational database dataset, i.e. a dataset that constains its whole tables.
    Attributes:
        rel_db (List): A list of RelDB objects in this dataset.
    """
    def __init__(self, path):
        self.rel_dbs = self.read_dataset(path)
        
    def read_dataset(self, paths):
        rel_dbs = []
        for i, table_file in enumerate(paths):
            file_path_components=table_file.split('/')
            db_name = file_path_components[-2]
            table_name = file_path_components[-1].split('.')[0]

            # create realational database object.
            rel_db_object = RelDB(db_name=db_name)

            # the reason to use pandas to read csv file is it keep the datatype of each column in csv file. 
            data = pandas.read_csv(table_file)
            table_headers = data.columns.values.tolist()
            data_ = data.transpose().to_dict().values()

            if table_headers == None:
                print(db_name, table_headers)
                continue

            # create table object. Note: one file w.r.t. one table object. 
            table_object = RelTable(table_name=table_name, table_headers=table_headers)
            
            # create table header category in the format of table_header -> table_name -> db_name. 
            if table_headers:
                for table_header in table_headers:
                    entity_ref = TableSchema(
                            db_name, table_name, table_header
                        )
                    rel_db_object.add_schema(entity_ref)
                
                for row in data_:
                    table_row = {k: row[k] for k in row}                
                    table_object.add_row( row_dict=table_row)
                rel_db_object.add_tables(table_object)
            rel_dbs.append(rel_db_object)
        return rel_dbs
    


class RelDB2KGraphNodeBuilder:
    
    """
    RelDB2KG graph builder takes a relational databse dataset as input and constructs a Neo4J graph via py2neo.

    Attributes:
        dataset (in csv format): A relational database of csv files.
        graph (Graph): The Neo4J graph that will be populated.
        defined_fields (dict): A dictionary of defined structured fields.
        node_normaliser (LexicalNormaliser): A LexicalNormaliser whose purpose is to clean the nodes, resolving issues such as making 'leaks', 'leaking' etc resolve to a single 'leak' node.
        nodes_properties (List): A list of node properties (dict).    
    """

    def __init__( self,
        dataset,
        node_normaliser=None,
        defined_fields=None
    ):
        self.dataset = dataset
        self.graph = Graph(password=env("GRAPH_PASSWORD"))
        self.node_normaliser = node_normaliser
        self.defined_fields = defined_fields
        self.nodes_properties =[]

        self.node_matcher = NodeMatcher(self.graph)

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
                
    def build_nodes(self, tx):
        seen_docs = {}
        for db in self.dataset.rel_dbs: 
            # table_instance_edges = {}
            if db.db_name is not None and db.db_name not in seen_docs:
                seen_docs[db.db_name] = db
                # create databse node
                db_node = Node("Domain", name='db:{}'.format(db.db_name))
                print("db_node:", db_node)
                tx.create(db_node)

                # e.g. musical_db is an instance of "Domain".
                tb = Relationship(db_node, "Instance_of_Domain", self.domain_base_node)
                tx.create(tb)
                print(tb)
                        
            for table in db.tables:
                
                if table.table_name.startswith('HAS'):
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
                      
    def build_graph(self):
        """
        Constructs the graph.
        # TODO: Clean this entire function up.
        """
        self.graph.delete_all()
        self.tx = self.graph.begin()
        tx = self.tx
        self.build_schema_nodes(tx)

        self.build_nodes(tx)
        self.graph.commit(tx)
          
    
class RelDB2KGraphEdgeBuilder:
    
    """
    RelDB2KG graph builder takes a relational databse dataset as input and constructs a Neo4J graph via py2neo.

    Attributes:
        dataset (in csv format): A relational database of csv files.
        graph (Graph): The Neo4J graph that will be populated.
        defined_fields (dict): A dictionary of defined structured fields.
        node_normaliser (LexicalNormaliser): A LexicalNormaliser whose purpose is to clean the nodes, resolving issues such as making 'leaks', 'leaking' etc resolve to a single 'leak' node.
        nodes_properties (List): A list of node properties (dict).    
    """

    def __init__( self, dataset, logger, node_normaliser=None, defined_fields=None):
        self.dataset = dataset
        self.logger = logger
        self.graph = Graph(password=env("GRAPH_PASSWORD"))
        self.node_normaliser = node_normaliser
        self.defined_fields = defined_fields
        self.nodes_properties =[]

        self.node_matcher = NodeMatcher(self.graph)

    def start_end_handler(self, row_dict):   
        for key, value in row_dict.items(): 
            print(key, value)
            if key.startswith('START_ID'):
                splits=key.split('|')
                start_node_label=splits[1]
                propterty_name=splits[2]
                start_node = self.node_matcher.match(start_node_label, **{propterty_name:value}).first() 
                print("start_node_label:", start_node_label)
                print("propterty_name:", propterty_name)
                print("start_node:", start_node)                                                                                                     
            elif key.startswith('END_ID'):
                splits=key.split('|')
                end_node_label=splits[1]
                propterty_name=splits[2]
                end_node= self.node_matcher.match(end_node_label, **{propterty_name: value}).first()
                print("end_node_label:", end_node_label)
                print("propterty_name:", propterty_name)
                print("end_node", end_node)
            else:
                start_node = end_node = ''
              
        return start_node, end_node

    def edge_handler(self, row_dict):
        targeted_nodes = []
        for key, value in row_dict.items():
            print(key, value)             
            if type(value)!=int:
                cypher_query = "MATCH (n) where n.{}='{}' return n".format(key, value)
            else:
                cypher_query = "MATCH (n) where n.{}={} return n".format(key, value)
            node = self.graph.run(cypher_query).data()
            print(node)
            if node:
                targeted_nodes.append(node)
        if len(targeted_nodes)==2:
            start_nodes = targeted_nodes[0]
            print("start_nodes", start_nodes)
            end_nodes = targeted_nodes[1]
            print("end_nodes",end_nodes)
        if not targeted_nodes:
            self.logger.error("There is {} matching graph node!".format(len(targeted_nodes)))
            raise ValueError("No matching node!")
        if len(targeted_nodes)>2:            
            self.logger.error("There is {} matching graph node!".format(len(targeted_nodes)))
            raise ValueError("Attention! Exist multiple connections. Check it out please!")
        return start_nodes, end_nodes

    def build_edges(self, tx):
        print("Building table schema relationship...")

        for db in self.dataset.rel_dbs:     
            for table in db.tables:
                if len(table.rows)==0:
                    continue
                if table.table_name.startswith('HAS'):
                    for i, row_dict in enumerate(table.rows):
                        print(row_dict)
                        start_node, end_node = self.start_end_handler(row_dict)
                        if start_node and end_node:      
                            rel = Relationship(start_node, table.table_name, end_node)
                            tx.create(rel)
                            print("rel:", rel)
                elif table.table_name.startswith('rel'):
                    rel_type = table.table_name.split('rel_')[1]
                    print(rel_type)
                    if len(table.rows)==0:
                        continue
                    for i, row_dict in enumerate(table.rows):
                        print(row_dict)
                        start_node, end_node = self.start_end_handler(row_dict)
                        if bool(start_node) and bool(end_node):      
                            rel = Relationship(start_node, rel_type, end_node)
                            tx.create(rel)
                            print("rel:", rel)
                        else:
                            start_nodes, end_nodes = self.edge_handler(row_dict)
                            if len(start_nodes)==1 and len(end_nodes)==1:
                                rel = Relationship(start_nodes[0]['n'], rel_type, end_nodes[0]['n'])
                                tx.create(rel)
                                print("heyyy rel:", rel)

                            
                                
                                
            # self.graph.commit(tx)
                    

    def build_graph(self):
        """
        Constructs the graph.
        # TODO: Clean this entire function up.
        """
        # self.graph.delete_all()
        self.tx = self.graph.begin()
        tx = self.tx
        self.build_edges(tx)
        self.graph.commit(tx)
        
    
def main():
    import glob

    neo4j_folder = '/Users/ziyuzhao/Desktop/neo4j-community-4.4.11/import'
    neo4j_folder_spider = os.path.join(neo4j_folder, 'spider') 
    spider_dbs= glob.glob(neo4j_folder_spider + '/**/*.csv') 

    spider_dbs = glob.glob('/home/ziyu/Desktop/neo4j-community-4.3.3/import/spider/**/*.csv') 


    dataset = RelDBDataset(spider_dbs)


    graph_node_builder = RelDB2KGraphNodeBuilder(
            dataset).build_graph()

    graph_edge_builder = RelDB2KGraphEdgeBuilder(
            dataset, Logger()).build_graph()

if __name__ == "__main__":
    Fire(main)


