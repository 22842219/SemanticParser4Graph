
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
import configparser
from psycopg2 import OperationalError

from sqlalchemy import table
from torch import init_num_threads, isin, norm, norm_except_dim
from transformers import TFFlaubertForQuestionAnsweringSimple

config = configparser.ConfigParser()

from moz_sql_parser.keywords import PARTITION
from mo_future import text, string_types

# to add the module path
SCRIPT_DIR = os.path.dirname(os.path.realpath(os.path.join(os.getcwd(), os.path.expanduser(__file__))))
sys.path.append(os.path.normpath(os.path.join(SCRIPT_DIR)))

import utils as utils
from traverser import SchemaGroundedTraverser
from src.data_processor.schema_graph import SchemaGraph
from sql_keywords import sql_join_keywords
from utils import Logger

'''
1. Integrate sql having statment into cypher match clause. Integrate sql groupby statement into cypher where statement. 

2.Comma-separated patterns in a single MATCH are connected by natural join.

3.append an all-different operator for all edge variables that appear in match.

4.process the where subclause of a single match caluse.
'''

alias_pattern = re.compile(r'(T[1-9]|[a-z])\.[a-zA-Z]\w*')	
number_pattern =  re.compile('\d+((\.\d+)|(,\d+))?')

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
            (not re.fullmatch(number_pattern, identifier)))


def add_parentheses(x):
	# print("x:", x)
	if isinstance(x, dict):
		return x
	if x.startswith('(') and x.endswith(')'):
		return x
	return '({0})'.format(x)


# This function deals with nested query.
# Operators are part of graph patterns.
def Operator(op, parentheses=False):
	op = '{0}'.format(op)
	def func(self, json):
		arguments = []
		print("operator:", json)
		if isinstance(json, string_types):
			for tb, tfms in self.db_lookup_dict.items():	
				fms = [fm.lower() for fm in tfms]
				if json.lower() in fms:
					normalized_field  = self.normalize_field_mention(json, tb, tfms)
					normalized_field = add_parentheses(normalized_field)
					normalized_field = "{}{}".format(op, normalized_field)
					arguments.append(normalized_field)

		elif isinstance(json, list):
			for v in json:
				if isinstance(v, dict) and utils.is_subquery(v):
					arguments.append(add_parentheses(self.dispatch(v)))
				else:
					res =self.dispatch(v)
					print(v, res)
					if re.fullmatch(number_pattern, res):
						arguments.append(res)

					elif isinstance(res, string_types) and isinstance(v, dict):
						arguments.append(res)
					else:
						is_alias = False
						if '.' in res:
							table_key, fm = res.split('.')
							is_alias = True
						tb = self.table_alias_lookup[table_key]
						tfms = self.db_lookup_dict[tb]
						fms = [fm.lower() for fm in tfms]
						if is_alias:
							check = fm
						else:
							check = res
						if check.lower() in fms:
							normalized_field  = self.normalize_field_mention(res, tb, tfms)
							if normalized_field not in arguments:
								arguments.append(normalized_field)

		out = op.join(arguments)
		if parentheses:
			out = add_parentheses(out)
		print("operator out:", op, out)	
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
	_max = Operator('max')
	_min = Operator('min')
	_avg = Operator('avg')
	# _count = Operator('count')

	def __init__(self, schema, db_lookup_dict: dict, in_execution_order = True, verbose = False):
		super().__init__(schema,  verbose)

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
		self.schema = schema
		self.in_execution_order = in_execution_order
		self.db_lookup_dict = db_lookup_dict
		self.logger =Logger()
		self.table_alias_lookup = {}

		
		
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
						if clause == 'where' and utils.is_subquery(json):
							sub_pattern = pattern.pop()	
							# print("where in nesedted:", json)
							# print("sub-pattern:", sub_pattern)
							# print("update pattern :", pattern)
							if 'NOT' in sub_pattern:
								outer_match = pattern.pop()						
								to_node = outer_match.split()[1]
								to_node_label = to_node.strip('()').split(':')[-1].upper()
								sub_pattern = '{}-[:HAS_{}]->{}'.format(sub_pattern,to_node_label, to_node )
								pattern = [outer_match, sub_pattern]
							elif 'IN' in sub_pattern:	
								# 'IN' as a template flag, it would be removed during construction in order to genereate a valid Cypher query.
								sub_pattern = sub_pattern.replace('IN','')							
								outer_match = pattern.pop()						
								to_node = outer_match.split()[1]
								to_node_label = to_node.strip('()').split(':')[-1].upper()
								sub_pattern = '{}-[:HAS_{}]->{}'.format(sub_pattern,to_node_label, to_node )
								pattern = [outer_match, sub_pattern]
							else:
								outer_match = pattern.pop()						
								inner_condition_var = sub_pattern[-1][:3]
								sub_pattern = sub_pattern[-1].replace('RETURN', 'WITH')
								sub_pattern = '{} AS {}'.format(sub_pattern, inner_condition_var)
								outer_agg = 'WHERE {} {}'.format(' '.join(sub_pattern[:-2]),inner_condition_var )
								pattern = [outer_match, outer_agg]
    							

			seq = '\n'.join(pattern)    	
		else:
			seq = '\n'.join(
			part
			for clause in clauses
			for part in [getattr(self, clause)(json)]
			if part)
		self.pop_table_alias_stack()
		return seq
				
	def normalize_field_mention(self, fm, tb_name, lookup_fields):
		print("***********normalized field mention**********")
		if '.' in fm:
			table_key, fm = fm.split('.')	
		else:
			table_key = tb_name.lower()[0]
		if fm not in lookup_fields:
			for field in lookup_fields:
				if fm.lower()==field.lower():
					fm=field
		return "{}.{}".format(table_key, fm)
	
	
	def _reformat(self, tables, fields = [], mode = 'reformat_tb_fields'):
		print("***********reformat************")
		print(mode)
		if mode == 'reformat_tb_name':
			for idx, table in enumerate(tables):
				tables[idx] = '({}:{})'.format(table.lower()[0], table.capitalize())				
			return tables		
		if mode == 'reformat_tb_fields':
			# Attention: talbe and field are parsed from sql queries, 
			# while tb_name, tb_fields of db_lookup_dict are extracted directly from sqlite3 schema.
			# So, the issue is they might be conflict.
			# For instance, one is upper case, and the one is lower case 
			# Solution: 
			for table in tables:
				if table.lower() in self.db_lookup_dict:
					tfms = self.db_lookup_dict[table.lower()]
				else:
					tfms = self.db_lookup_dict[table]
				fms = [fm.lower() for fm in tfms]
				for idx, field in enumerate(fields):
					if field in fms:
						fields[idx] = self.normalize_field_mention(field, table, tfms)							
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
				return json
		return text(json)

	def value(self, json):
		print("*************debug value************")
		value = self.dispatch(json['value'], is_table=('is_table' in json))
		# print("value", value)
		if 'name' in json:
			return '{}.{}'.format(json['name'], value)
		if not isinstance(value, list):
			value = [value]
		# print("parts", value)
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

		attr = '_{0}'.format(key)

		print("op:", key, value, attr)
		print(json)


		if hasattr(self, attr) and not key.startswith('_'):
			method = getattr(self, attr)
			return method(value)	
				
		if isinstance(value, dict):
			return '{} {}'.format(key, self.dispatch(value))	
		
		else:
			if key in ['DISTINCT', 'ALL']:
				return '{} {}'.format(key, self.dispatch(value))		
			else:
				return '{}{}'.format(key, add_parentheses(self.dispatch(value)))
				

	def from_(self, json):
		is_join = False	
		is_rel_table = False

		print("*******debgu from*******")

		if 'from' in json:
			from_ = json['from']
			if isinstance(from_, dict):
				# Case: MATCH ()
				table = self.dispatch(from_)
				self.table_alias_lookup.update({table[0]:table})
				return 'MATCH {}:{}'.format(table[0], table.capitalize())
			
			if not isinstance(from_, list):
				check_rel_table = 'rel_{}'.format(from_)
				if check_rel_table in list(self.db_lookup_dict.keys()):
					is_rel_table=True
					from_ = [check_rel_table]
				else:
					from_ = [from_]			

			parts = []
			for every in from_:
				for join_key in sql_join_keywords:
					if join_key in every:
						is_join = True	
				print("every:", every)
				table_name = self.dispatch(every,  is_table=isinstance(every, text))
				parts.append(table_name)
				print("table_name", table_name)

				# Update table_alias_lookup for field normalization. 
				if '.' in table_name:
					table_key, tb = table_name.split('.')			
					self.table_alias_lookup.update({table_key:tb})
				else:
					self.table_alias_lookup.update({table_name[0]:table_name})
				
			if is_join:
				# If is_rel_table=True, case: (T1:)-[T2:]->(T3:) or (T1:)-[T2:]->() or ()-[T1:]->(T2:)
				# If is_rel_table=False, case: (T1:)-[]->(T2)
				reformat_parts = []		
				for i, every in enumerate(parts):
					alias, joint_table= every.split('.')
					check_rel_table = 'rel_{}'.format(joint_table)
					lookup_dict = [f.lower() for f in list(self.db_lookup_dict.keys())]

					if check_rel_table in lookup_dict:
						is_rel_table=True	
					if is_rel_table:
						# graph edge pattern: 	
						if reformat_parts:
							reformat_parts.pop()					
						if i==0:
							# In case, edge is mentioned in the first place.
							reformat_parts.append('()')
							pattern = '<-[{}:{}]-'.format(alias, joint_table.capitalize())
						else:
							pattern = '-[{}:{}]->'.format(alias, joint_table.capitalize())
						is_rel_table = False
						reformat_parts.append(pattern)
						if i==len(parts)-1:
							# Case: (T1:)-[T2:]->()
							node_pattern = '()'
							reformat_parts.append(node_pattern)
					else:
						# graph node pattern
						pattern = '({}:{})'.format(alias, joint_table.capitalize())				
						reformat_parts.append(pattern)

						edge_pattern = '-[]->'
						reformat_parts.append(edge_pattern)
						if i == len(parts)-1:
							# Case: (T1:)-[]->(T2)
							reformat_parts.pop()

			else:
				if is_rel_table:
					for part in parts:
						# case: MATCH ()-[r]->()
						rel_table = part.split('_')[1]
						reformat_parts = '()-[{}:{}]->()'.format(rel_table[0], rel_table.capitalize())
		
				else:
					# TODO
					reformat_parts = self._reformat(parts, [],  mode = 'reformat_tb_name' )	
			
			if is_rel_table and is_join:
				joiner = '-[]->'
			else:
				joiner = ''
			rest = joiner.join(reformat_parts)
			print("*******reformat_parts********")
			# print(reformat_parts)
			# print(rest)
			graph_pattern = 'MATCH {}'.format(rest)
			
			return graph_pattern

	def where(self, json):
		if 'where' in json:	
			print("**** where****")
			
			if isNested(json):
				nested_pattern = self.dispatch(json['where'])
				return nested_pattern				
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
						MATCH (T1:Actor)-[:HAS_IN_MUSICAL]->(T2:Musical) 
						WITH count(*) as cnt , T2.Name as Name
						WHERE cnt >= 3 
						RETURN Name 
		2. WITH also supports ordering and paging. 
			- relational database: department_management
			- Question: How many acting statuses are there?
			- SQL query:  SELECT count(DISTINCT temporary_acting) FROM management
			- CYPHER query: 
				MATCH ()-[m:Management]->()
				with distinct m.temporary_acting as temporary_acting
				RETURN count(temporary_acting)
			'''
		print("*********debug having**********")
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
		print("***********debug groupby********")
		if 'groupby' in json:
			
			return self.dispatch(json['groupby'])

	def select(self, json):	
		print("***********debug select**********")

		final_return = []
		
		for select in ['select', 'select_distinct']:
			if select  in json:  
				agg_pattern = r'^\bavg\b|\bmax\b|\bmin\b|\bcount\b.*'

				select_fields = self.dispatch(json[select]).split(',')
				print("select_fields:", select_fields)
				

				# get tables information, in order to normalise fields appearing in select clause.
				if 'from' in json:		
					if isinstance(json['from'], string_types):
						table = self.dispatch(json['from'])	
				
				return_nodes = []
				with_parts = []
				is_having = False
				is_with_distinct = False
				for i, select_field in enumerate(select_fields):
					print("select_field", select_field)
					is_agg = re.match(agg_pattern, select_field)
					is_distinct = False

					if '.' in select_field:
						table_key, fm = select_field.split('.')
						table = self.table_alias_lookup[table_key]

					if is_agg:
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
									normalized_field = self.normalize_field_mention(fm, table, self.db_lookup_dict[table])		
									with_as = '{} AS {}'.format(normalized_field, fm)
									with_parts.append(with_as)
									return_node = '{}({})'.format(agg_op, fm)
						
									
							return_nodes.append(return_node)
						else:
							return_nodes.append(select_field)
					else:
						if select_field.startswith('distinct'):
							select_field = select_field.split()[1]
							is_distinct = True
					

						normalized_field = self.normalize_field_mention(select_field, table, self.db_lookup_dict[table])		
						if is_distinct:
							normalized_field = 'DISTINCT {}'.format(normalized_field)
						
						if 'having' in json:
							# Setting is_having flag beging true for the final concatenation of with_statement. 
							is_having = True

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
						
						if 'groupby' in json:
							# TODO
							groupby_statement = 'GROUP BY {}'.format(self.groupby(json)	)
							print("with_parts in select:", i, with_parts)
						
						return_nodes.append(normalized_field)

				# print("return_nodes", return_nodes)
					
				if is_having:
					with_statement = 'WITH {}'.format(', '.join(with_parts))
					print(with_statement)
					print(with_where)
					final_return.append(with_statement)
					final_return.append(with_where)
				
				if is_with_distinct:
					with_statement = 'WITH DISTINCT {}'.format(', '.join(with_parts))
					final_return.append(with_statement)
					
				if 'where' in json and 'list' in json['where'] or select == 'select_distinct':	
					# list appears in intersect statement, so distinct is added.		
					return_statement =  'RETURN DISTINCT {}'.format(','.join(return_nodes))
				else:
					return_statement = 'RETURN {}'.format(','.join(return_nodes))
				
				# print(return_statement)
				final_return.append(return_statement)
				# print(final_return)

				return '\n'.join(final_return)
				

	def orderby(self, json):
		if 'orderby' in json:
			orderby = json['orderby']
			if isinstance(orderby, dict):
				orderby = [orderby]

			# Extract table_name.	
			is_join = False
			if 'from' in json:
				from_ = json['from']

				if isinstance(from_, dict):
					raise NotImplementedError

				if not isinstance(from_, list):
						from_ = [from_]
				
				tables = []
				for token in from_:
					for join_key in sql_join_keywords:
						if join_key in token:
							is_join = True
					tables.append(self.dispatch(token, is_table = isinstance(token, text)))
				if is_join:				
					return 'ORDER BY {0}'.format(
						','.join(['{0} {1}'.format(self.dispatch(o), o.get('sort', '').upper()).strip() for o in orderby]))
				else:
					fields = [self.dispatch(o) for o in orderby]
					modifiers = [o.get('sort', '').upper()for o in orderby]
					reformat_tb_fields = self._reformat(tables, fields, mode = 'reformat_tb_fields')		
					print("*************order by***********")
					# print(reformat_tb_fields)
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
		print("*******debug like*********")
		tables = list(self.table_alias_lookup.values())
		if isinstance(res, list) and len(res)==2:
			fm = self.dispatch(res[0])
			for tb in tables:
				tfms = self.db_lookup_dict[tb]
				fms = [fm.lower() for fm in tfms]
				if fm.lower() in fms:
					normalized_field  = self.normalize_field_mention(fm, tb, tfms)
			literal = self.dispatch(res[1])
			if isinstance(literal, string_types):
				literal= literal.strip('\'').strip('%')
			return "{0} =~'.*{1}.*'".format(normalized_field, literal)
		else:
			self.logger.error("Error in _like statement. Please check it out.")

	def _on(self, json):	
		for join_key in sql_join_keywords:
			if join_key in json:
				return self.dispatch(json[join_key])
		raise AttributeError('Unrecognized JOIN keywords: {}'.format(json))
	
	def _in(self, json):
		'''
		! Notes regarding 'do not' or 'not' statement in naltural language utterance. 
		
			|   SQL   | Mapping |  CYPHER 
			---------------------------------------------------------------------------------------------- 
			|'in' |   -->   | where ()-[]->()  |
			
			For example:
				- Question: List the name of musicals that do have actors.
				- SQL query: SELECT Name FROM musical WHERE Musical_ID IN (SELECT Musical_ID FROM actor)
				- Cypher query: 
						MATCH (m:Musical)
						where (:Actor)-[:HAS_MUSICAL]->(m)
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
			|'not in' |   -->   | where NOT ()-[]->()  |
			
			For example:
				- Question: List the name of musicals that do not have actors.
				- SQL query: SELECT Name FROM musical WHERE Musical_ID NOT IN (SELECT Musical_ID FROM actor)
				- Cypher query: 
						MATCH (m:Musical)
						where NOT (:Actor)-[:HAS_MUSICAL]->(m)
						RETURN m.Name
		'''
		valid = self.dispatch(json[1]).strip('()').split()
		nested_node = valid[1]
		from_node = '({})'.format(nested_node[nested_node.index(':'):-1])
		return 'WHERE NOT {}'.format(from_node)

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
		field, lower_bound, upper_bound = self.dispatch(json['where']['between']).split(',')
		table = json['from']
		normalized_field= self.normalize_field_mention(field, table, self.db_lookup_dict[table] )
		return 'WHERE {}<={}<={}'.format(lower_bound, normalized_field, upper_bound)


def main():
	import glob
	logger =Logger()
	config.read('../../config.ini')
	filenames = config["FILENAMES"]
	raw_data_folder = filenames['raw_folder']
	sp_folder = filenames['sp_folder']

	raw_spider_folder = os.path.join(raw_data_folder, 'spider')

	spider_json_folder = os.path.join(raw_data_folder, 'spider')
	spider_lookup_up= os.path.join(sp_folder, 'spider', 'lookup_dict.json')

	with open(spider_lookup_up) as f:
		spider_lookup_dict = json.load(f)

	db_folder = os.path.join(raw_spider_folder,  'database')

	for split in ['train', 'dev']:
   
		json_file = os.path.join(spider_json_folder, '{}.json'.format(split))
		# print(json_file)
		f = open(json_file)
		data = json.load(f)

		
		question_answer_pairs = []

		# test output file
		cypher_file_musical  = os.path.join(spider_json_folder, '{}_{}_cypher.json'.format('musical', split))

		
		
		for i, every in enumerate(data):
			
			
			db_name = every['db_id']
			question = every['question']
			sql_query = every['query']		
			db_paths=glob.glob(db_folder + '/{}/*.sqlite'.format(db_name), recursive = True) 
			if len(db_paths)==1:
				schema = SchemaGraph(db_name, db_path=db_paths[0])

			if db_name == 'department_management' and i==13:    
				print("------------------------")
				print(i)
				print("databse:", db_name)
				print("question:", question)
				print("sql_query:", sql_query)
				all_table_fields = spider_lookup_dict[db_name]
			
				try:

					parsed_sql = parse(sql_query)	
					print(parsed_sql)
					formatter  = Formatter(schema, all_table_fields)

					sql2cypher = formatter.format(parsed_sql)
					print("**************cypher***************")
					print(sql2cypher)
					print("**************cypher***************")
				
				except:
					logger.error('Attention in {}.db. Can not parse sql query:{}'.format(db_name, sql_query))
				
			
		

if __name__=="__main__":
	main()