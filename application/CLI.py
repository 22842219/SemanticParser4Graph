import os, sys, json, glob
from rel_db2kg.utils import Logger
from moz_sql_parser import parse
from ConvertDB import ConvertDB
from configparser import ConfigParser, ParsingError, NoSectionError
from unsw.SQLParser import SQLParser
from py2neo import Graph
from rel_db2kg.schema2graph import RelDBDataset
from rel_db2kg.sql2cypher import Formatter
import torch

config = ConfigParser()
config.read('config.ini')
filenames = config["FILENAMES"]
raw_data_folder = filenames['raw_folder']
text2sql_data_folder = filenames['text2sql_data_folder']

db_folder = os.path.join(raw_data_folder, 'database', 'spider')
db_paths=glob.glob(db_folder + '/**/*.sqlite', recursive = True) 

neo4j_uri = filenames['neo4j_uri']
neo4j_user = filenames['neo4j_user']
neo4j_password = filenames['neo4j_password']
graph = Graph(neo4j_uri, auth = (neo4j_user, neo4j_password))


class CLI:
    _config_path = "conf/db.ini"

    def __init__(self, output, db_name='mysql'):
        # init the logger
        self.db_name = db_name
        # to declare whether output the cypher query
        self.output = output
        self.logger = Logger('/sql2cypher.log')
        self.config = None
        self.cb = None

    def _load_config(self):
        """
        load the config file. Set it as private function
        :return: the config Parser
        """
        try:
            self.logger.warning("starting get the config file in ./conf/db.ini")
            config = ConfigParser()
            config.read(self._config_path)
            return config
        except ParsingError as err:
            self.logger.error("Can not find the config file in ./conf/db.ini")
            raise FileNotFoundError("Can not find config file in ./conf/db.ini")

    def _load_convert(self, db_name):
        try:
            self.logger.warning("Start getting the database config info")
            psql_config = self.config["psql"] if db_name == 'psql' else None
            mysql_config = self.config["mysql"] if db_name == 'mysql' else None
            sqlite3_config = self.config["sqlite3"] if db_name == 'sqlite3' else None
            neo4j_config = self.config["neo4j"]
          

        except NoSectionError as err:
            self.logger.error("Can not find the config of {}".format(err.section))
            print("Can not find the section {} in db.ini".format(err))
            raise KeyError(err.section)

        MySQLConfig = {
            'host': mysql_config['host'],
            'user': mysql_config['username'],
            'password': mysql_config['password'],
            'database': mysql_config['database'],
            'auth_plugin': 'mysql_native_password'
        } if mysql_config is not None else None

        PSQLConfig = {
            'host': psql_config['host'],
            'user': psql_config['username'],
            'password': psql_config['password'],
            'database': psql_config['database'],
        } if psql_config is not None else None

        Sqlite3Config = {
            'spider_path': sqlite3_config['spider_path'],
            'database': sqlite3_config['database']
        } if sqlite3_config is not None else None

        NEO4jConfig = {
            'host': neo4j_config['host'],
            'port': neo4j_config['port'],
            'username': neo4j_config['username'],
            'password': neo4j_config['password']
        }
        cb = ConvertDB(MySQLConfig, Sqlite3Config, NEO4jConfig, PSQLConfig, db_name, self.logger, self.output)
        return cb

    @staticmethod
    def transfer_sql():
        """
        transfer the sql to cypher
        :return:
        """
        print("Please input some sql languages: ")
        lines = sys.stdin.readlines()
        for sql in lines:
            sql_parser = SQLParser()
            sql_parser.generate_cypher(parse(sql), sql)
            print(sql_parser.get_cypher())

    def convert_sql_with_str(self, sql_query):
        """
        transfer the sql to cypher with a string sql
        :return: the cypher query result
        """
        sql_parser = SQLParser()
        sql_parser.generate_cypher(parse(sql_query), sql_query)
        return sql_parser.get_cypher()
    
    def sql2cypher(self, sql_query):
   
        config = self._load_config()
        if  self.db_name == 'sqlite3':
            sqlite3_config = config['sqlite3']
        print(sqlite3_config['database'])
        
        logger =Logger('/sql2cypher.log')
        rel_db_dataset = RelDBDataset(db_paths, logger)
        print(rel_db_dataset.rel_dbs[sqlite3_config['database']])    
        parsed_sql = parse(sql_query)	
        print(parsed_sql)
        formatter  = Formatter( logger, sqlite3_config['database'],  rel_db_dataset.rel_dbs[sqlite3_config['database']], graph)
        sql2cypher = formatter.format(parsed_sql)
        print("sql2cypher:", sql2cypher)
        return sql2cypher
    
    def text2cypher(self, text, model, tokenizer):
        #model
        print("=====❓Request=====")
        print(text)
        tokenized_txt = tokenizer([text], max_length=1024, padding="max_length", truncation=True)
        pred = tokenizer.batch_decode(
            model.generate(
                torch.LongTensor(tokenized_txt.data['input_ids']),
                torch.LongTensor(tokenized_txt.data['attention_mask']),
                num_beams=1, 
                max_length=256
                ), 
            skip_special_tokens=True 
        ) # More details see utils/dataset.py and utils/trainer.py
        print("=====💡Answer=====")
        print(pred)
        # text2cypher = 'MATCH (singer:`concert_singer.singer`) RETURN count(*)'
        return pred

    def load_web_conf(self):
        """
        load the config file for the web server
        :return:
        """
        self.config = self._load_config()
        self.cb = self._load_convert(self.db_name)

    def convert_db(self):
        """
        convert the whole database in mysql
                db = "spider_musical"
                user = "root"
                password = "Zea@890606"
                cypher_user = "neo4j"
                cypher_password = "zzy"
        :return:
        """
        # print(cb.execute_sql("show tables", ()))
        # cb.read_relations()
        self.config = self._load_config()
        self.cb = self._load_convert(self.db_name)
        self.cb.exporting()
