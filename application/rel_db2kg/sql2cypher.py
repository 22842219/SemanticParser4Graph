
from __future__ import with_statement
from ast import arg
from itertools import count
import os, sys
import string
import re
from tabnanny import check
from time import sleep
from flask import g
from moz_sql_parser import parse
import json

from pandas import isna
from psycopg2 import OperationalError

from sqlalchemy import table
from torch import init_num_threads, isin, norm, norm_except_dim
from transformers import TFFlaubertForQuestionAnsweringSimple



from moz_sql_parser.keywords import PARTITION
from mo_future import text, string_types


# to add the module path
SCRIPT_DIR = os.path.dirname(os.path.realpath(os.path.join(os.getcwd(), os.path.expanduser(__file__))))
sys.path.append(os.path.normpath(os.path.join(SCRIPT_DIR)))

import utils as utils
from traverser import SchemaGroundedTraverser
from sql_keywords import sql_join_keywords
from utils import Logger

from schema2graph import DBengine

from py2neo import Graph
from py2neo.matching import *
from py2neo.data import Node, Relationship
from environs import Env
import configparser
config = configparser.ConfigParser()
config.read('../config.ini')
filenames = config["FILENAMES"]
env_file = filenames['env_file']
env = Env()
env.read_env(env_file)
graph = Graph(password=env("GRAPH_PASSWORD"))



'''
1. Integrate sql having statment into cypher match clause. Integrate sql groupby statement into cypher where statement. 

2.Comma-separated patterns in a single MATCH are connected by natural join.

3.append an all-different operator for all edge variables that appear in match.

4.process the where subclause of a single match caluse.
'''

alias_pattern = re.compile(r'(T[1-9]|[a-z])\.[a-zA-Z]\w*')	
number_pattern =  re.compile('\d+((\:\d+)|(,\d+))?')
agg_pattern = re.compile(r'^\bAvg\b|\bAVG\b|\bavg\b|\bmax\b|\bMAX\b|\bMax\b|\bmin\b|\bMIN\b|\bMin\b|\bcount\b|\bCOUNT\b|\bCount\b.*')

# both graph node and edge pattern. 
# Note: when we re-tokenize nested query, we split sub-graph-path-pattern using '-', 
# hence, it might start with '>'. Please refer to nested query example. 
graph_node_regx = re.compile(r'\(([a-z]|T[1-9])\:[a-zA-Z].*\)') 
graph_edge_regx = re.compile(r'\[([a-z]|T[1-9])\:[a-zA-Z].*\]') 

operators = ['||', '*', '/', '+', '-', '<>', '>', '<', '>=', '<=', '=', 'OR', 'AND']

def exist_operator(identifier):
	for op in operators:
		if op in identifier:
			return True
	else:
		return False

def should_quote(identifier):
    """
    Return true if a given identifier should be quoted.

    This is usually true when the identifier:

      - is a reserved word
      - contain spaces
      - does not match the regex `[a-zA-Z_]\w*`

    """
    VALID = re.compile(r'[a-zA-Z_]\w*')
    return ((not re.fullmatch(alias_pattern, identifier)) and
            (not re.fullmatch(number_pattern, identifier)) and
			(not re.fullmatch(VALID, identifier)))


def add_parentheses(x):
	# print("x:", x)
	if isinstance(x, dict):
		return x
	if x.startswith('(') and x.endswith(')'):
		return x
	return '({0})'.format(x)


def escape(identifier, ansi_quotes):
    """
    Escape identifiers.
    ANSI uses single quotes, but many databases use back quotes.
    """
    if not should_quote(identifier):
        return identifier

    quote = '"' if ansi_quotes else '`'
    identifier = identifier.replace(quote, 2*quote)
    return '{0}{1}{2}'.format(quote, identifier, quote)

# This function deals with nested query.
# Operators are part of graph patterns.
def Operator(op, parentheses=False):
	op = ' {0} '.format(op)
	def func(self, json):
		arguments = []
		# print(f'json in operator: {json}')
		if isinstance(json, string_types):
			json = [json]

		if isinstance(json, list):
			for v in json:
				res =self.dispatch(v)
				# print(f'res: {res}, op: {op},  done?: {exist_operator(res.lower())}')
				if isinstance(v, dict) and utils.is_subquery(v):
					arguments.append(add_parentheses(res))
				elif '.' in res and not exist_operator(res.lower()):
						table_key, fm = res.split('.')
						tb = self.table_alias_lookup[table_key]
						# step: normalise table name
						tb = self.normalize_mentioned_tb(tb)
						# step: check relational table
						is_rel_table, rel_table = self.rel_table_check(tb)
						if is_rel_table:
							tb = rel_table
						tfms = self.db_lookup_dict[tb]
						fms = [fm.lower() for fm in tfms]
					
						if fm.lower() in fms:
							normalized_field  = self.normalize_mentioned_field(res, tb, tfms)
							if normalized_field not in arguments:
								arguments.append(normalized_field)
						print(f'res: {res}, tb: {tb}, fm: {fm}, fms:{fms}, normalised_fm: {normalized_field}')
				# elif not exist_operator(res.lower()):	
				# 	packages = []
				# 	checker = False
					
				# 	for tb, tfms in self.db_lookup_dict.items():	
				# 		fms = [fm.lower() for fm in tfms]
				# 		if res.lower() in fms:
				# 			checker = True
				# 			packages.append((tb, tfms))
					
				# 	if checker and len(packages)==1:
				# 		normalized_field  = self.normalize_mentioned_field(res, packages[0][0], packages[0][1])
				# 		arguments.append(normalized_field)
				else:
					arguments.append(res)			
		out = op.join(arguments)
		if parentheses:
			out = add_parentheses(out)
		# print(f'arguments: {arguments}, op: {op}, operator out: {out}')	
		return out
	return func

def isNested(json ):
	check_str = str(json)
	if len(re.findall(r'FROM|from', check_str)) != 1:
		return True
	else:
		return False

class Formatter(SchemaGroundedTraverser):
	


	SQLclauses = [
	'select',
	'from_',
	'where',
	'orderby',
	'limit',
	'offset'
	]

	SQLclauses_in_execution_order = [
 	'from_',
	'where',
	'select',
	'orderby',
	'limit',
	'offset'

	]


	# simple operators
	_concat = Operator('||')
	_mul = Operator('*')
	_div = Operator('/', parentheses=True)
	_add = Operator('+')
	_sub = Operator('-', parentheses=True)
	_neq = Operator('<>')  # Cypher uses <> to represent inequality.
	_gt = Operator('>')
	_lt = Operator('<')
	_gte = Operator('>=')
	_lte = Operator('<=')
	_eq = Operator('=')
	_or = Operator('OR')
	_and = Operator('AND')
	# _max = Operator('max')
	# _min = Operator('min')
	# _avg = Operator('avg')
	# _nin = Operator('NOT')
	# _count = Operator('count')

	def __init__(self, db_lookup_dict: dict, graph, in_execution_order = True, verbose = False ):
		super().__init__( verbose)

		'''
		- Set in_execution_order being true to fit the order of cypher query. 
		- SQLclauses and SQLclauses_in_execution_order are the executing order correspondingly. 
		- See below the mapping relationship between sql and cypher.

			|  SQL    | Mapping |  Cypher     |
			-----------------------------------
			|'from_'  |  -----> | 'match'     |
			|'where'  |  -----> | 'where'     |
			|'groupby'|  -----> | 'count()'   |
			|'having' |  -----> | 'with'      |
			|'select' |  -----> | 'return'    |
			|'orderby'|  -----> | 'orderby'   |
			|'limit'  |  -----> | 'limit'     |
			|'offset' |  -----> | 'offset'    |


		'''
		# self.schema = schema
		self.in_execution_order = in_execution_order
		self.db_lookup_dict = db_lookup_dict
		self.logger =Logger()
		self.table_alias_lookup = {}
		self.graph = graph
		self.node_matcher = NodeMatcher(graph)
		self.edge_matcher =RelationshipMatcher(graph)
		
	# This function is the trigger of decomposition of every parsed sql query.
	def format(self, json):
		if 'union' in json:
			return self.union(json['union'])
		elif 'intersect' in json:
			return self.intersect(json['intersect'])
		elif 'except' in json:
			return self.except_(json['except'])
		else:
			return self.query(json)
		
	# This function is the entry of formatting w.r.t each clause of every SQL query, including nested SQL query.
	def query(self, json):
		clauses = self.sql_clauses_in_execution_order if self.in_execution_order else self.sql_clauses
		self.get_alias_table_map(json)
		if isNested(json):	
			print('isNested:', json)		
			pattern = []
			for clause in clauses:	
				for part in [getattr(self, clause)(json)]: 		
					if part:
						pattern.append(part)
						# print(f' pattern:  {pattern}')
						if clause == 'where' and utils.is_subquery(json):
							match_parts = []
							where_parts  =[]
							if pattern:
								sub_pattern = pattern.pop()	
								outer_match = pattern.pop()	
								outer_match_parts = [every.strip() for every in outer_match.split('MATCH') if every]

								outer_query = ' '.join(outer_match_parts)
								match_parts.append(outer_query)
								# print(f'sub-pattern: {sub_pattern}, outer_match: {outer_match}')
								# print(f'outer_match_parts :{outer_match_parts}, pattern: {pattern}')
							
								if isinstance(sub_pattern, list):
									for part in sub_pattern:	
										if '\n' in part:
											nested_query_parts = part.split('\n')
											# print(f'part: {part}, nested_query_parts: {nested_query_parts}')
											for every in nested_query_parts:	
												if 'MATCH' in every:
													match_parts.append(every)
													print(f'match: {every}')
												elif 'WHERE' in every:
													sub_query_where= ' '.join([i.strip() for i in every.split('WHERE') if i])
													where_parts.append(sub_query_where)
													# print(f'every: {every}, sub_query_where: {sub_query_where}')

												elif 'NOT' in every:
													sub_query_field = every.split('NOT')[-1].strip()
													if outer_query_field:
														where_parts.append('NOT {} in {}'.format(outer_query_field,sub_query_field))
														
												else:
													raise NotImplementedError
										elif isinstance(part, string_types):
											# print(f'part: {part}')
											for every in outer_match_parts:
												if  isinstance(every, string_types):
													outer_query = every.strip('()')
													if ':' in outer_query:
														alias, outer_query_tb = outer_query.split(':')
														# print(f'alias: {alias}, outer_query_tb:{outer_query_tb}' )
											try:
												outer_query_field = '{}.{}'.format(alias, part)
												print(f'outer_query_field: {outer_query_field}')
										
											except:
												raise NotImplementedError
							
								match_parts = 'MATCH {}'.format(' '.join(match_parts))
								where_parts = 'WHERE {}'.format(' AND '.join(where_parts))
								pattern = [match_parts, where_parts]
								# print(f'match_parts: {match_parts}, where_parts: {where_parts}')
						
										


						if clause == 'select' and utils.is_subquery(json):
							outer_select = 	pattern.pop()	
							outer_select_parts = [every.strip() for every in outer_select.split('RETURN') if every]
							print(f'outer_select: {outer_select}, pattern: {pattern}')
							print(f'outer_query_field: {outer_query_field}')
							return_statement = []
							for part in outer_select_parts:
								if re.match(agg_pattern, part):
									if 'count' or 'Count' or 'COUNT' in outer_select and outer_query_field:
										outer_select = 'count(DISTINCT {})'.format(outer_query_field)
										return_statement.append(outer_select)
								else:
									raise NotImplementedError
							pattern.append('RETURN {}'.format(' '.join(return_statement)))


			seq = '\n'.join(pattern)    	
		else:
			seq = '\n'.join(
			part
			for clause in clauses
			for part in [getattr(self, clause)(json)]
			if part)
		self.pop_table_alias_stack()
		return seq
				
	# def is_field(self, fm):
	# 	tbs, tfms = self.db_lookup_dict.items()
	# 	for fms in tfms:
	# 		fms = [f.lower() for f in fms]
	# 		if fm.lower() in fms:
	# 			return True
	# 	return False
	

	def normalize_mentioned_field(self, fm, tb_name, lookup_fields):
		# print("***********normalized field mention**********")
		if '.' in fm:
			table_key, fm = fm.split('.')	
		else:
			if '_' in tb_name and tb_name.startswith('rel'):
				idx = tb_name.index('_')
				tb_name = tb_name[idx+1:]
			table_key = tb_name.lower()[0]
			for k, v in self.table_alias_lookup.items():
				if v == tb_name:
					table_key = k
		if fm not in lookup_fields:
			for field in lookup_fields:
				if fm.lower()==field.lower():
					fm=field
		# print(f'table_key: {table_key}')
		return "{}.{}".format(table_key, fm)
	
	def normalize_mentioned_tb(self, tb_name ):
		# print("***********normalized mentioned table**********")
		is_alisas = False
		if '.' in tb_name:
			table_key, tb_name = tb_name.split('.')	
			is_alisas = True
		# elif tb_name.startswith('rel'):
		# 	idx = tb_name.index('_')
		# 	tb_name = tb_name[idx+1:]

		# step: check relational table
		rel_tb_name = 'rel_{}'.format(tb_name)

		lookup_tbs = list(self.db_lookup_dict.keys())
		tbs = [tb.lower() for tb in lookup_tbs]
		# print(f'lookup_tbs: {lookup_tbs}')
		
		if tb_name.lower() in tbs:
			index = tbs.index(tb_name.lower() )
		elif rel_tb_name.lower() in tbs:
			index = tbs.index(rel_tb_name.lower() )

		tb_name = lookup_tbs[index]

		if is_alisas:
			tb_name = '{}.{}'.format(table_key, tb_name)
		return tb_name
	
	def rel_table_check(self, tb):
		is_rel_table=False
		is_alisas = False
		if '.' in tb:
			table_key, tb = tb.split('.')
			is_alisas = True
		if tb.startswith('rel'):
			idx = tb.index('_')
			tb = tb[idx+1:]
			is_rel_table=True
		if is_alisas:
			tb = '{}.{}'.format(table_key, tb)
		return is_rel_table, tb

	def _reformat(self, tables, fields, mode = 'reformat_tb_fields'):
		if mode == 'reformat_tb_name':	
			for idx, table in enumerate(tables):
				if '.' in table:
					alias_key, table = table.split('.')
					tables[idx] = '({}:{})'.format(alias_key, table)
				else:
					tables[idx] = '({}:{})'.format(table.lower()[0], table)				
			return tables				
			
		if mode == 'reformat_tb_fields':
			# Attention: talbe and field are parsed from sql queries, 
			# while tb_name, tb_fields of db_lookup_dict are extracted directly from sqlite3 schema.
			# So, the issue is they might be conflict.
			# For instance, one is upper case, and the one is lower case 
			# Solution: 
			for table in tables:
				if '.' in table:
					alias_key, table = table.split('.')
				# print(table)
				tfms = self.db_lookup_dict[table]
				fms = [fm.lower() for fm in tfms]
				# print(f'reformat_tb_fields, fms: {fms}')
				if isinstance(fields, string_types) and fields.lower() in fms:
					
					return self.normalize_mentioned_field(fields, table, tfms)	
				elif isinstance(fields, list):					
					for idx, field in enumerate(fields):
						if field.lower() in fms:
							fields[idx] = self.normalize_mentioned_field(field, table, tfms)							
			return fields
	

	def dispatch(self, json,  is_table = False):

		if isinstance(json, list):
			return self.delimited_list(json)

		if isinstance(json, dict):
			if len(json) == 0:
				return ''
			elif 'value' in json:
				return self.value(json)				
				
			elif 'from' in json:
				return add_parentheses(self.format(json))

			elif 'query' in json:
				# Nested query 'query'
				nested_query = self.format(json['query'])
				
				if 'name' in json:
					return '{0} AS {1}'.format(add_parentheses(nested_query), json['name'])
				else:
					return add_parentheses(nested_query)

			elif 'union' in json:
				# Nested query 'union'
				return add_parentheses(self.union(json['union']))
			elif 'intersect' in json:
				return add_parentheses(self.intersect(json['intersect']))
			elif 'except' in json:
				return add_parentheses(self.except_(json['except']))
			else:
				return self.op(json)
		if isinstance(json, text):
			# TODO:
			return escape(json, True)
		return text(json)

	def value(self, json):
		# print("*************debug value************")
		value = self.dispatch(json['value'], is_table=('is_table' in json))
		# print(f'value: {value}, json: {json}')

		if 'name' in json.keys():
			return '{}.{}'.format(json['name'], value)
		
		if not isinstance(value, list):
			value = [value]
		return ' '.join(value)


	def delimited_list(self, json):
		return ','.join(self.dispatch(element) for element in json)

	def op(self, json):
			
		if 'on' in json:
			return self._on(json)
			
		if len(json) > 1:
			raise Exception('Operators should have only one key!')

		key, value = list(json.items())[0]

		if key in sql_join_keywords:
			return self.dispatch(value)
		
		# check if the attribute exists, and call the corresponding method;
        # note that we disallow keys that start with `_` to avoid giving access
        # to magic methods
		attr = '_{0}'.format(key)
		
		# print(f'key: {key}, value: {value}, attr: {attr}')

		if hasattr(self, attr) and not key.startswith('_'):
			method = getattr(self, attr)
			return method(value)	
				
		if isinstance(value, dict):
			return '{} {}'.format(key, self.dispatch(value))	
		
		else:
			key = key.upper()
			if key in ['DISTINCT', 'ALL']:

				return '{} {}'.format(key, self.dispatch(value))		
			else:
				res = self.dispatch(value)
				if '.' in res:
					table_key, fm = res.split('.')
					tb = self.normalize_mentioned_tb(self.alias2table[table_key])
					normalized_field = self.normalize_mentioned_field(res, tb, self.db_lookup_dict[tb])
					# print(f'res: {res}, table_key: {table_key}, tb: {tb}, normalized_field: {normalized_field}')
				else:
					normalized_field = self._reformat(list(self.db_lookup_dict.keys()), res, mode = 'reformat_tb_fields')
				
				return 	'{}{}'.format(key, add_parentheses( normalized_field))
				

	def from_(self, json):
		is_join = False	
		is_rel_table = False

		print("*******debgu from*******")
		if 'from' in json:
			from_ = json['from']

			if isinstance(from_, dict):
				# Case: MATCH ()
				table = self.dispatch(from_)
				if isinstance(table, string_types):
					table = self.normalize_mentioned_tb(table)
					self.table_alias_lookup.update({table[0].lower():table})
					return 'MATCH {}:{}'.format(table[0].lower(), table)
			
			if not isinstance(from_, list):
				if isinstance(from_, string_types):
					is_rel_table, tb = self.rel_table_check(from_)
					from_ = tb
				from_ =[from_]

			parts = []
			for every in from_:
				for join_key in sql_join_keywords:
					if join_key in every:
						is_join = True	

				
				table_name = self.dispatch(every,  is_table=isinstance(every, text))
				# step: normalise table name
				table_name = self.normalize_mentioned_tb(table_name)
				parts.append(table_name)
				# print(f'normalised table name: {table_name}')

				# Update table_alias_lookup for field normalization. 
				if '.' in table_name:
					table_key, tb = table_name.split('.')		
					self.table_alias_lookup.update({table_key:tb})
				else:
					self.table_alias_lookup.update({table_name[0].lower():table_name})
			

			if is_join:
				# If is_rel_table=True, case: (T1:)-[T2:]-(T3:) or (T1:)-[T2:]-() or ()-[T1:]-(T2:)
				# If is_rel_table=False, case1: (T1:)-[]-(T2) OR case2: (T1), (T2) 
					# where the aforementioned two nodes do not have graph relationship.
					# My solution is  to use existing graph to check the existence of graph relaitonship,
					# FOR EXAMPLE: 
					# 			MATCH (T1:Appointment) MATCH (T2:Patient)
					# 			RETURN  exists( (T1)--(T2) )
				
				node_flag = True
				reformat_parts = []		
				for i, every in enumerate(parts):
					alias, joint_table= every.split('.')
					# step: check relational table
					is_rel_table, joint_table = self.rel_table_check(joint_table)
					# print(f'joint_table: {joint_table}, is_rel_table: {is_rel_table}')
		
					if is_rel_table:

						node_flag = False # As a signal to specify only exist graph nodes. 

						# # graph edge pattern: 	
						# if reformat_parts:
						# 	reformat_parts.pop()	

						if i==0:
							# In case, edge is mentioned in the first place.
							reformat_parts.append('()')

						pattern = '-[{}:{}]-'.format(alias, joint_table)
						is_rel_table = False
						reformat_parts.append(pattern)

						if i==len(parts)-1:
							# Case: (T1:)-[T2:]-()
							node_pattern = '()'
							reformat_parts.append(node_pattern)
						print(f'reformat_part_isrel: {i, reformat_parts}')

					else:
						# graph node pattern
						pattern = '({}:{})'.format(alias, joint_table)				
						reformat_parts.append(pattern)
						print(f'reformat_part_node: {i, reformat_parts}')
						
						# NOTE: this is a test regarding the case2. 
						# matched_graph_edges = self.edge_matcher.match(nodes=pattern, r_type=None)
						# print(f'matched_graph_edges: {matched_graph_edges}')

						#--------------------OLD CODE----------------------
						# edge_pattern = '-[]-'
						# reformat_parts.append(edge_pattern)
						# if i == len(parts)-1:
						# 	# Case: (T1:)-[]-(T2)
						# 	reformat_parts.pop()
						# # print(f'reformat_part_else: {reformat_parts}')
						#--------------------OLD CODE----------------------
				
				# Check if every tow nods are connected.. 
				new_reformat_parts=[]
				if node_flag:
					for i, node0 in enumerate(reformat_parts):
						if i!=len(reformat_parts)-1:
							new_reformat_parts.append(node0)
							match = ''
							match += 'MATCH {} '.format(node0)
							if ':' in node0:
								alias0, node_label0 = node0.strip('()').split(':')
								node_alias0 = '({})'.format(alias0)
							for j, node1 in enumerate(reformat_parts[i+1:]):
								match += 'MATCH {} '.format(node1)
								if ':' in node1:
									alias1, node_label1 = node1.strip('()').split(':')
									node_alias1 = '({})'.format(alias1)
								cypher = match + 'RETURN distinct exists ({}--{}) '.format(node_alias0, node_alias1)
								exist_res = [check for res in self.graph.run(cypher).data() for check in list(res.values())]
								# print(f'cypher: {cypher}, exist_res: {exist_res}')
								if True in exist_res:
									# Case: (T1:)-[]-(T2)
									edge_pattern = '-[]-'
									new_reformat_parts.append(edge_pattern)
								new_reformat_parts.append(node1)

					# print(f'new_reformat_parts: {new_reformat_parts}')
					if '-[]-' in new_reformat_parts:
						reformat_parts = ''.join(new_reformat_parts)
					else:
						reformat_parts = ' MATCH '.join(new_reformat_parts)
					# print(f'after reformat_parts:{ reformat_parts}')
		
			else:
				if is_rel_table:
					for part in parts:
						# case: MATCH ()-[r]-()
						idx = part.index('_')
						rel_table = part[idx+1:]
						reformat_parts = '()-[{}:{}]-()'.format(rel_table[0], rel_table)

				else:
					# TODO
					reformat_parts = self._reformat(parts, [],  mode = 'reformat_tb_name' )	
			
			if is_rel_table and is_join:
				joiner = '-[]-'
			else:
				joiner = ''

			rest = joiner.join(reformat_parts)
			print(f'result in from: {rest}, reformat_parts: {reformat_parts}')
			return 'MATCH {}'.format(rest)	
	

	def where(self, json):
		if 'where' in json:	
			# print("****debug where****")
			
			if isNested(json):
				nested_pattern = self.dispatch(json['where'])
				return nested_pattern
			elif 'between' in json['where']:
				field, lower_bound, upper_bound = self.dispatch(json['where'])	
				
				if isinstance(json['from'], string_types):
					table =  self.normalize_mentioned_tb(json['from'])
					normalized_field= self.normalize_mentioned_field(field, table, self.db_lookup_dict[table] )
					return 'WHERE {}<={}<={}'.format(lower_bound, normalized_field, upper_bound)
			else:	
				
				return 'WHERE {}'.format(self.dispatch(json['where']))

	def having(self, json):

		'''
		!  Notes regarding ``HAVING`` statement in SQL:
		1. WITH which is similar to RETURN but determines which elements will be available in the next query part. 
		   When we reformat the cypher query, if there is a sql having statement, the return clause could only
		   specify the node variable from the result of having result. Pull the table mentioned in return statement 
		   in with statement as well.
		   For example:
		  	- Question: Show names of musicals which have at least three actors.
			- SQL query: SELECT T2.Name FROM actor AS T1 JOIN musical AS T2 ON T1.Musical_ID  =  T2.Musical_ID \
				         GROUP BY T1.Musical_ID HAVING COUNT(*)  >=  3
			- CYPHER query: 
						MATCH (T1:Actor)-[:HAS_IN_MUSICAL]-(T2:Musical) 
						WITH count(*) as cnt , T2.Name as Name
						WHERE cnt >= 3 
						RETURN Name 
		2. WITH also supports ordering and paging. 
			- relational database: department_management
			- Question: How many acting statuses are there?
			- SQL query:  SELECT count(DISTINCT temporary_acting) FROM management
			- CYPHER query: 
				MATCH ()-[m:Management]-()
				with distinct m.temporary_acting as temporary_acting
				RETURN count(temporary_acting)
			'''
		# print("*********debug having**********")
		if 'having' in json:	
			with_parts =[]
			res = self.dispatch(json['having'])
			# print("having:", res)
			# TODO: need more test
			if 'count(*)' in res:
				having_agg = res.split('count(*)')
				agg_op = 'count(*)'
				agg_alias = 'count'
				agg_content = having_agg[1:]
				# print("having_agg", having_agg)
				# print(agg_content)
			else:
				having_agg = [item.strip('"') for item in res.split()]
		
				agg_alias = having_agg[0].split('(')[0]
				agg_op = having_agg[0]
				agg_content = having_agg[1:]
				# print("having_agg", having_agg)

			# print("zzy:", agg_alias, agg_content)

			with_as = '{} AS {}'.format(agg_op, agg_alias)	
			with_parts.append(with_as)
			with_where = 'WHERE {} {}'.format(agg_alias, ' '.join(agg_content))	
			
			return with_parts, with_where

	def groupby(self, json):
		'''
		! Notes regarding ``GROUP BY`` statement in SQL.
			Since there isn't groupby clause in cypher, I remove groupby statement from SQLclauses execution order 
		to the select statement as a part of cypher return clause. I formulate <group by> to be  equivalent with 
		<count(*)>.
			For example:
				- Quetion:Please show the nominee who has been nominated the greatest number of times.
				- SQL query: SELECT Nominee FROM musical GROUP BY Nominee ORDER BY COUNT(*) DESC LIMIT 1
				- CYPHER query:
							MATCH (m:Musical)  \
							RETURN m.Nominee ,count(*)  \
							ORDER BY count(*) DESC
							LIMIT 1
		'''
		# print("***********debug groupby********")
		if 'groupby' in json:
			return self.dispatch(json['groupby'])

	def select(self, json):	
		print("***********debug select**********")

		final_return = []

		# get tables information, in order to normalise fields appearing in select clause.
		if 'from' in json and isinstance(json['from'], string_types):
			table = self.dispatch(json['from'])	
			table =  self.normalize_mentioned_tb(table)
			print(f'table: {table}')
		print(f'tables: {self.table_alias_lookup}')
	
		for select in ['select', 'select_distinct']:
			if select  in json:  

				select_fields = self.dispatch(json[select]).split(',')
				print("select_fields:", select_fields)
	
				

				
				return_nodes = []
				with_parts = []
		
				is_with = False
				is_where = False
				is_with_distinct = False
				is_distinct = False
		

				for i, select_field in enumerate(select_fields):
					print(f'select_field: {select_field}, is_agg: {re.match(agg_pattern, select_field)}')

					if re.match(agg_pattern, select_field):

						# TODO: NEED MORE TEST
						fms = select_field.split()
		
						if 'distinct' in fms:
							agg_op  = ''
							return_node = ''
							for fm in fms:	
								if re.match(agg_pattern, fm):
									agg_op = fm
								elif fm =='distinct':
									is_with_distinct = True
								else:
									if '.' in select_field:
										table_key, fm = select_field.split('.')
										table = self.table_alias_lookup[table_key]

									is_rel_table, table = self.rel_table_check(table)	
									normalized_field = self.normalize_mentioned_field(fm, table, self.db_lookup_dict[table])		
									with_as = '{} AS {}'.format(normalized_field, fm)
									with_parts.append(with_as)
									return_node = '{}({})'.format(agg_op, fm)					
							return_nodes.append(return_node)

						elif 'having' in json and select_field == 'count(*)':
							return_nodes.append("count")
						else:
							print(f'agg in select: {select_field}')
							return_nodes.append(select_field)
					
					else:
						if select_field.startswith('distinct'):
							select_field = select_field.split()[1]
							is_distinct = True		

						if '.' in select_field:
							table_key, fm = select_field.split('.')
							table = self.table_alias_lookup[table_key]
						else:
							for table_key, tb in self.table_alias_lookup.items():
								print(table_key, tb)
								fms = [fm.lower() for fm in self.db_lookup_dict[tb]]
								if select_field.lower() in fms:
									table = tb


						is_rel_table, table = self.rel_table_check(table)	
						print(f' is_rel_table?: {is_rel_table}, table: {table}')
						normalized_field = self.normalize_mentioned_field(select_field, table, self.db_lookup_dict[table])	
						print(f' table: {table}, normalized_field: {normalized_field}')
						
						if is_distinct:
							normalized_field = 'DISTINCT {}'.format(normalized_field)
							print("select distinct:", normalized_field)

						if 'groupby' in json:
							'''
							For example:
							- Question:  In which year were most departments established?
							- SQL query:  SELECT creation FROM department GROUP BY creation ORDER BY count(*) DESC LIMIT 1
							- Cypher query: 
								MATCH (d:Department)
								WITH count(d.Creation) AS count, d.Creation AS Creation
								RETURN Creation
								ORDER BY count  DESC
								LIMIT 1
							'''
							# Setting is_with flag beging true for the final concatenation of with_statement. 
							is_with = True
							
							groupby_fm =self.groupby(json)
							normalized_grouby = self.normalize_mentioned_field(groupby_fm, table, self.db_lookup_dict[table])
							if not 'having' in json:
								normalized_grouby = 'count({}) AS count'.format(normalized_grouby)
								with_parts.append(normalized_grouby)
						
							# rewrite select field. 
							if '.' in normalized_field:
								table_key, fm = normalized_field.split('.')
								with_part = '{} AS {}'.format(normalized_field, fm)
								with_parts.append(with_part)
								normalized_field = fm
			
						if 'having' in json:
							# Setting is_with and is_where flags beging true for the final concatenation of with_statement. 
							is_with = True
							is_where = True

							# Circle aggregation in having_statement. 
							with_part, with_where = self.having(json)
							if not set(with_parts)-(set(with_parts)-set(with_part)):
								with_parts.extend(with_part)
							# Note that WITH affects variables in scope. 
							# Any variables not included in the WITH clause are not carried over to the rest of the query. 
							# The wildcard * can be used to include all variables that are currently in scope.
							# Hence, we need to circuled the fields in select clause, in order to return them. 		
							if '.' in normalized_field:
								table_key, fm = normalized_field.split('.')
								alias_fm = '{} AS {}'.format(normalized_field, fm)
								# return new fm
								normalized_field = fm
								with_parts.append(alias_fm) 	
						
						
						return_nodes.append(normalized_field)
	
						
				if is_with:
					with_statement = 'WITH {}'.format(', '.join(set(with_parts)))
					# print(with_statement)
					final_return.append(with_statement)

					if is_where:
						# print(with_where)
						final_return.append(with_where)
				
				if is_with_distinct:
					with_statement = 'WITH DISTINCT {}'.format(', '.join(set(with_parts)))
					final_return.append(with_statement)

				# print("return_nodes", return_nodes)
					
				if 'where' in json and 'list' in json['where'] or select == 'select_distinct':	
					# list appears in intersect statement, so distinct is added.		
					return_statement =  'RETURN DISTINCT {}'.format(','.join(return_nodes))
				else:
					return_statement = 'RETURN {}'.format(','.join(return_nodes))
				
				# print(return_statement)
				final_return.append(return_statement)
				print(final_return)

				return '\n'.join(final_return)
				

	def orderby(self, json):
		if 'orderby' in json:
			# print("**************debug orderby******")
			orderby = json['orderby']
			# print(f'orderby: {orderby}')
			
			if isinstance(orderby, dict):
				orderby = [orderby]

			# Extract table_name.	
			tables = list(self.table_alias_lookup.values())
			fields = [self.dispatch(o) for o in orderby]
			modifiers = [o.get('sort', '').upper()for o in orderby]
			
			reformat_tb_fields = self._reformat(tables, fields, mode = 'reformat_tb_fields')		
			
			if 'groupby' in json:
				for idx, reformat_tb_field in enumerate(reformat_tb_fields):
					if reformat_tb_field.lower().startswith('count'):
						reformat_tb_fields[idx] = 'count'
					elif '.' in reformat_tb_field:
						table_key, fm  = reformat_tb_field.split('.')
						reformat_tb_fields[idx] = fm
			# print(f'reformat_tb_fields: {reformat_tb_fields}')			
			return 'ORDER BY {}'.format(','.join('{0} {1}'.format(reformat_tb_fields[idx], modifiers[idx]).strip()\
				for idx,_ in enumerate(zip(reformat_tb_fields, modifiers))))
	
	def limit(self, json):
			if 'limit' in json:
				return 'LIMIT {0}'.format(self.dispatch(json['limit']))

	def offset(self, json):
		if 'offset' in json:
			return 'OFFSET {0}'.format(self.dispatch(json['offset']))	
		
	def union(self, json):
		return ' UNION '.join(self.format(query) for query in json)	

	def intersect(self, json):
		'''
		! Notes regarding to map sql'INTERSECT' statement to cypher query.

		MATCH (m1:Musical)
		WHERE m1.Award IN ["Tony Award" , "Drama Desk Award"]
		RETURN distinct m1.Nominee

		'''
		ref_json ={}
		for query in json:    	
			for clause in self.sql_clauses:
				if clause != 'from_':
					for part in [getattr(self, clause)(query)]:
						if part and clause not in ref_json:
							ref_json[clause] = query[clause]
						elif part and clause in ref_json and ref_json[clause] != query[clause]:
							ref_json[clause] = {'list': [ref_json[clause], query[clause]]}
				else:
					ref_json['from'] = query['from']
		return self.format(ref_json)

	def except_(self, json):
		return ' EXCEPT '.join(self.format(query) for query in json)
	
	def _literal(self, json):
		if isinstance(json, list):
			return add_parentheses(', '.join(self._literal(v) for v in json))
		elif isinstance(json, text):
			return "'{0}'".format(json.replace("'", '"'))
		else:
			return str(json)

	def _like(self, res):
		# print("*******debug like*********")
		tables = list(self.table_alias_lookup.values())
		if isinstance(res, list) and len(res)==2:
			fm = self.dispatch(res[0])
			for tb in tables:
				tfms = self.db_lookup_dict[tb]
				fms = [fm.lower() for fm in tfms]
				if fm.lower() in fms:
					normalized_field  = self.normalize_mentioned_field(fm, tb, tfms)
			literal = self.dispatch(res[1])
			if isinstance(literal, string_types):
				literal= literal.strip('\'').strip('%')
			return "{} =~'.*[{}|{}]{}.*'".format(normalized_field, literal[0], literal[0].lower(), literal[1:])
		else:
			self.logger.error("Error in _like statement. Please check it out.")

	def _on(self, json):	
		for join_key in sql_join_keywords:
			if join_key in json:
				return self.dispatch(json[join_key])
		raise AttributeError('Unrecognized JOIN keywords: {}'.format(json))
	
	def _in(self, json):
		'''
		! Notes regarding 'do' statement in naltural language utterance. 
		
			|   SQL   | Mapping |  CYPHER 
			---------------------------------------------------------------------------------------------- 
			|'in' |   -->   | 1) MATCH ()-[]-(); (NOTE: see example1)
								or 
							  2) TODO
			
			For example1:
				- relational database: musical.db
				- Question: List the name of musicals that do have actors.
				- SQL query: SELECT Name FROM musical WHERE Musical_ID IN (SELECT Musical_ID FROM actor)
				- Cypher query: 
						MATCH (a:Actor)-[:HAS_MUSICAL]-(m:Musical)
						RETURN m.Name
		Note: 'IN' in the return working as an indentifier for the reconstruction process in function query().
		'''
		valid = self.dispatch(json[1]).strip('()').split()
		nested_node = valid[1]
		from_node = '({})'.format(nested_node[nested_node.index(':'):-1])
		return 'WHERE IN {}'.format(from_node)

	def _nin(self, json):
		'''
		! Notes regarding 'do not' or 'not' statement in naltural language utterance. 
		
			|   SQL   | Mapping |  CYPHER 
			---------------------------------------------------------------------------------------------- 
			|'not in' |   -->   | 1) WHERE NOT ()-[]-()                 (NOTE: see example2); 
									or 
								  2) MATCH ()-[]-() WHERE  NOT ?  IN ?  (NOTE: see exmple2)|

			
			For example1:	
				- relational databse: department_management.db
				- Question:  How many departments are led by heads who are not mentioned?
				- SQL query: SELECT count(*) FROM department WHERE department_id NOT IN (SELECT department_id FROM management)
				- Cypher query: 
					MATCH (d:Department)
					WHERE NOT (d:Department)-[:Management]-()
					RETURN count(*)

			For example2:	
				- relational databse: hospital_1.db
				- Question:  How many patients are not using Procrastin-X as medication?
				- SQL query: SELECT count(*) FROM patient WHERE SSN NOT IN ( SELECT T1.patient FROM Prescribes AS T1 JOIN Medication AS T2
					 ON T1.Medication  =  T2.Code WHERE T2.name  =  'Procrastin-X' )
				- Cypher query: 
					MATCH (p:Patient)
					MATCH (T1:Prescribes)-[]-(T2:Medication)
					WHERE NOT p.SSN in T1.Patient and T2.Name = 'Procrastin-X'
					RETURN COUNT(DISTINCT p.SSN)

					Note: we return distinct p.SSN, even though the aggregation is just count(*) in SQL,
					I suspect this is one of the distinctions between SQL queries and Cypher queries.
					TODO: need more research investigation here, and mention it in the pakdd2023 paper.  

		'''
		# print("*******not in********")
		# print(json, isinstance(json, list))
		# TODO: need more test, currently working with one nested sql query. \
		# **************NOTE: old_code**************
		# sub_pattern = ''
		# if isinstance(json, list):
		# 	for part in json:
		# 		if isinstance(part, dict):
		# 			nested_query = self.dispatch(part)

		# 			if '\n' in nested_query:
		# 				nested_query_parts = nested_query.split('\n')
		# 				for every in nested_query_parts:
		# 					if 'MATCH' in every:
		# 						sub_pattern = every.split('MATCH')[-1]
		# 			print("sub_pattern:", sub_pattern)
		# 			return 'NOT {}'.format(sub_pattern)
		parts = []
		if isinstance(json, list):
			for part in json:
				if isinstance(part, dict):
					nested_query = self.dispatch(part)
					sub_patterns = []
					if '\n' in nested_query:
						nested_query_parts = nested_query.strip('()').split('\n')
						for every in nested_query_parts:
						
							if 'RETURN' in every:
								sub_patterns.append('NOT {}'.format(every.split('RETURN')[-1]))
							else:
								sub_patterns.append(every)
						parts.append('\n'.join(sub_patterns))	
				else:
					parts.append(self.dispatch(part))
			return parts
		else:
			raise NotImplementedError

	def _list(self, json):
    	# Handle cypher list operator
		all = self.dispatch(json).split(',')
		list_ = []
		for item in all:
			tokens =[i.strip().strip('"') for i in item.split('=')]
			node = tokens[0]
			if node not in list_:
				list_.append(node)
			list_.extend(tokens[1:])
		return '{} IN {}'.format(list_[0], list_[1:])
	
	def _between(self, json):		
		'''
		! Notes regarding 'between' statement in naltural language utterance. 
		
			|   SQL   | Mapping |  CYPHER 
			---------------------------------------------------------------------------------------------- 
			|'between' |   -->   | where x<= field<= y |
			
			For example:
				- Question:What is the average number of employees of the departments whose rank is between 10 and 15?
				- SQL query: SELECT avg(num_employees) FROM department WHERE ranking BETWEEN 10 AND 15
				- Cypher query: 
						
		Note: 'IN' in the return working as an indentifier for the reconstruction process in function query().
		'''
		# print("between:", json)
		if isinstance(json, list):
			[field, lower_bound, upper_bound ]= self.dispatch(json).split(',')

			return field, lower_bound, upper_bound



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

		# create a dictionary of tables for each database. 
		if db_name not in lookup_dict:
			lookup_dict[db_name] = {}    
			pks_lookup_dict[db_name] = {}
		
		engine = DBengine(db_path)      
		table_infos = engine.get_table_names()

		for table_info in table_infos:
			table_name = table_info[0]                 
			primary_keys = engine.get_primay_keys(table_name) #R[(pk, )]
			table_constraints, pks_fks_dict =  engine.get_outbound_foreign_keys(table_name) #R[{"column": from_, "ref_table": table_name, "ref_column": to_}]
			
			compound_pk_check =  engine.check_compound_pk(primary_keys)
			result = engine.get_table_values(table_name)
			headers = [desc[0] for desc in result.description]   

			if compound_pk_check and len(table_constraints)==2:  # Note: atm we just focus on binary table relationship.
				table_name = 'rel_{}'.format(table_name)
			if table_name not in lookup_dict[db_name]:
				lookup_dict[db_name][table_name] = headers
				for pk in primary_keys:
					pks_lookup_dict[db_name][table_name] = pk[0]

	fields_path = os.path.join(sp_data_folder, 'spider', 'lookup_dict.json')
	with open(fields_path, "w") as f:
		json.dump(lookup_dict, f, indent = 4) 
	return lookup_dict, pks_lookup_dict
	


def execution_accuracy(split, correct, incorrect, invalid_parsed_sql):
	total = correct + incorrect + invalid_parsed_sql
	if total !=0:
		return {	'split': split,
					'correct_num': correct,
					'incorrect_num': incorrect,
					'execution_accuracy': correct/total,
					'invalid_parsed_sql': invalid_parsed_sql
				}

def main():
	import glob

	from cypher_parser import CyqueryStatmentParser
	from pygments.lexers import get_lexer_by_name
	from py2neo import Graph
	lexer = get_lexer_by_name("py2neo.cypher")
	import configparser
	config = configparser.ConfigParser()
	config.read('../config.ini')
	filenames = config["FILENAMES"]

	raw_data_folder = filenames['raw_folder']
	sp_folder = filenames['sp_folder']

	raw_spider_folder = os.path.join(raw_data_folder, 'spider')

	spider_json_folder = os.path.join(raw_data_folder, 'spider')
	spider_lookup_up= os.path.join(sp_folder, 'spider', 'lookup_dict.json')

	neo4j_uri = filenames['neo4j_uri']
	neo4j_user = filenames['neo4j_user']
	neo4j_password = filenames['neo4j_password']
	graph = Graph(neo4j_uri, auth = (neo4j_user, neo4j_password))

	logger =Logger()

	db_folder = os.path.join(raw_spider_folder,  'database')
	db_paths=glob.glob(db_folder + '/**/*.sqlite', recursive = True) 
	lookup_dict, pks_lookup_dict = build_lookup_dict(db_paths, sp_folder)


	# with open(spider_lookup_up) as f:
	# 	spider_lookup_dict = json.load(f)
	
	# Output folder path
	sp_out_folder = os.path.join(sp_folder, 'spider')  


	if not os.path.exists(sp_out_folder):
		os.makedirs(sp_out_folder) 

	for split in ['train', 'dev']:
   
		json_file = os.path.join(spider_json_folder, '{}.json'.format(split))
		# print(json_file)
		f = open(json_file)
		data = json.load(f)

		# test output file
		cypher_file_musical  = os.path.join(spider_json_folder, '{}_{}_cypher.json'.format('musical', split))

		correct_qa_pairs = []      
		incorrect_qa_pairs = []
		incorrect_num = 0
		invalid_parsed_sql = 0
		
		
		for i, every in enumerate(data):
			db_name = every['db_id']
			
			if db_name == 'hospital_1' :   
				all_table_fields = lookup_dict[db_name]	

				# 1. Extract database name, questions and SQL queries
				question = every['question']
				sql_query = every['query']	
				

				# 2. Access database, execute SQL query and get result.              
				db_path = os.path.join(db_folder, db_name, '{}.sqlite'.format(db_name))   
				engine = DBengine(db_path)
				sql_result = []
				for res in  engine.execute(sql_query).fetchall():
					if list(res) not in sql_result:
						sql_result.append(list(res) )
				# list(set(tuple(sorted(sub)) for sub in engine.execute(sql_query).fetchall()))

				print("------------------------")
				print(i)
				print(f'databse: {db_name}')
				print(f'all_table_fields: {all_table_fields}')
				print(f'question: {question}')

				print("**************SQL Query***************")
				print(f'sql: {sql_query}')
				print(f'sql_ans: {sql_result}')
				print("**************SQL Query***************")

				try:
 					# 3. Convert SQL query to Cypher query.	
					parsed_sql = parse(sql_query)	
					print(f'parsed_sql: {parsed_sql}')

					try:
						formatter  = Formatter( all_table_fields, graph)
						sql2cypher = formatter.format(parsed_sql)
						print("**************Cypher Query***************")
						print(sql2cypher)
						print("**************Cypher Query***************")

						Cyparser = CyqueryStatmentParser(sql2cypher, 'statement', lexer)
						tokenized_statment, token_types = Cyparser.get_tokenization()
						# print("tokenized_statment:", tokenized_statment, token_types)
						
						# 4. Execute cypher query.. 
						if sql2cypher:
							cypher_res = graph.run(sql2cypher).data()
							cypher_ans = []
							for dict_ in cypher_res:
								if list(dict_.values()) not in cypher_ans:
									cypher_ans.append(list(dict_.values()))
			
							# sort results for the comparision
							cypher_sorted = sorted(cypher_ans, key=lambda x: x[0])
							sql_sorted =  sorted(sql_result, key=lambda x: x[0]) 

							if cypher_sorted == sql_sorted:
								print(f'correct_ans: {cypher_ans}') 
								correct_qa_pairs.append({'db_id':db_name, 'question':question, \
								'cypher_query':sql2cypher, 'parsed_cpypher':tokenized_statment, \
								'answers':cypher_ans})
							else:
								print(f'incorrect_ans: {cypher_ans}')
								incorrect_num+=1
								incorrect_qa_pairs.append({'db_id':db_name, 'question':question, \
								'sql_query':sql_query, 'parsed_sql':parsed_sql, 'sql_ans':sql_result,\
								'cypher_query':sql2cypher, 'cypher_ans':cypher_ans})
					except:
						# accumulate invalid or none generated cypher queries.
						incorrect_num+=1
				
				except:
					invalid_parsed_sql +=1
					logger.error('Attention in {}.db. Can not parse sql query:{}'.format(db_name, sql_query))
				
		metrics = execution_accuracy(split, len(correct_qa_pairs), incorrect_num, invalid_parsed_sql)
		print(f'metrics: {metrics}')
	
		correct_output_file = os.path.join(sp_out_folder, '{}_correct.json'.format(split))   
		with open(correct_output_file, 'a')  as out:
			json.dump(correct_qa_pairs, out, indent = 4)

		incorrect_output_file = os.path.join(sp_out_folder, '{}_incorrect.json'.format(split))     
		with open(incorrect_output_file, 'a')  as out:
			json.dump(incorrect_qa_pairs, out, indent = 4)
			
		

if __name__=="__main__":
	main()