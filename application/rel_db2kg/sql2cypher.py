
from __future__ import with_statement
import os, sys
import re
from moz_sql_parser import parse
import json
from sqlalchemy import table

from mo_future import text, string_types

# to add the module path
SCRIPT_DIR = os.path.dirname(os.path.realpath(os.path.join(os.getcwd(), os.path.expanduser(__file__))))
sys.path.append(os.path.normpath(os.path.join(SCRIPT_DIR)))

import utils as utils
from traverser import SchemaGroundedTraverser
from sql_keywords import sql_join_keywords
from utils import Logger, read_json

from schema2graph import DBengine

from py2neo import Graph
from py2neo.matching import *
from py2neo.data import Node, Relationship
from environs import Env



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
	if identifier!='*':
		return '{0}{1}{2}'.format(quote, identifier, quote)
	else:
		return '*'

# This function deals with nested query.
# Operators are part of graph patterns.
def Operator(op, parentheses=False):
	op = ' {0} '.format(op)
	def func(self, json):
		arguments = []
		print(f'json in operator: {json}')
		print(f'table_alias_lookup: {self.table_alias_lookup}')
		if isinstance(json, string_types):
			json = [json]
		if isinstance(json, list):
			for v in json:
				res =self.dispatch(v)
				print(f'res: {res}, op: {op},  done?: {exist_operator(res.lower())}')
				# print("'{0}'".format(res.replace("'", '"')))
				if isinstance(v, dict) and utils.is_subquery(v):
					arguments.append(add_parentheses(res))
				elif not exist_operator(res.lower()):
					is_field = False
					if '.' in res:
						is_field = True
						table_key, res = res.split('.')
						tb = self.table_alias_lookup[table_key]
					else:
						is_field, tb = self.in_field(res)
					if is_field:
						tb = self.norm_tb(tb)
						tfms = self.db_info[tb].headers
						fms = [fm.lower() for fm in tfms]
						print(f'res: {res}, tb: {tb}, fm: {res}, fms:{fms}')
						if res.lower() in fms:
							normalized_field  = self.norm_query_fm(res, tb)
							print(f' normalised_fm: {normalized_field}')
							if normalized_field not in arguments:
								arguments.append(normalized_field)
					else:
						print("vvvvvvv:", v , type(v), res, type(res) )
						if isinstance(v, string_types):
							res = v.strip('\'').strip('\"')
							res = "'{}'".format(res)
						arguments.append(res)		
				else:
					arguments.append(res)			
		out = op.join(arguments)
		if parentheses:
			out = add_parentheses(out)
		print(f'arguments: {arguments}, op: {op}, operator out: {out}')	
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

	def __init__(self, logger, 
						db_name, 
						db_info: dict, 
						graph, 
						in_execution_order = True, 
						verbose = False ):
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

		self.logger = logger
		self.db_name = db_name
		self.db_info = db_info
		self.in_execution_order = in_execution_order
		
		self.graph = graph
		self.node_matcher = NodeMatcher(graph)
		self.edge_matcher =RelationshipMatcher(graph)
		self.table_alias_lookup = {}
		self.db_tb_names= list(self.db_info.keys())

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
		if isNested(json):	# deal with single nested query. 
			print('isNested:', json)		
			pattern = []
			for clause in clauses:	
				for part in [getattr(self, clause)(json)]: 		
					if part:
						pattern.append(part)
						print(f' pattern:  {pattern}')
						outer_path_in_sub_query = True
						if clause == 'where' and utils.is_subquery(json):
							match_parts = []
							where_parts  =[]
							if pattern:
								sub_pattern = pattern.pop()	
								outer_match = pattern.pop()	
								outer_match_parts = [every.strip() for every in outer_match.split('MATCH') if every]

								outer_query = ' '.join(outer_match_parts)
								match_parts.append(outer_query)
								print(f'sub-pattern: {sub_pattern}, outer_match: {outer_match}')
								print(f'outer_match_parts :{outer_match_parts}, pattern: {pattern}')
							
								if isinstance(sub_pattern, list):
									is_rel_table = False
									for part in sub_pattern:	
										if '\n' in part:
											nested_query_parts = part.split('\n')
											print(f'nested query part: {part}, nested_query_parts: {nested_query_parts}')
											for every in nested_query_parts:	
												if 'MATCH' in every:
													sub_match_parts = [token.strip('()[]')  for path in every.split('MATCH') if path for token in path.strip().split('-') if':' in token]	
													sub_query_where = [outer_query]

													nested_where_conditioned = {}
													if re.findall('WHERE.*\\n', part):
														where_condition = re.findall('WHERE.*\\n', part)
														if len(where_condition)==1:
															where_content = [i.strip() for i in where_condition[0].split('WHERE') if i]
															for fm_content in where_content:
																for op in ['<>', '>', '<', '>=', '<=', '=']:
																	if op in fm_content:
																		[tfm, content ]= fm_content.split(op)
																		if '.' in tfm:
																			[table_key, fm] = tfm.split('.')
																			nested_where_conditioned[table_key] = '{{ {}:{} }}'.format(fm, content)
														else:
															raise NotImplementedError
														
													print(f'sub_match_partszzy {sub_match_parts}')
													for i, path in enumerate(sub_match_parts):
														table_key, tb = path.split(":")

														is_rel_table, tb = self.is_rel(tb)
													
														# # check value condition
														if table_key in nested_where_conditioned:
															tb = '{} {}'.format(tb, nested_where_conditioned[table_key])
														if is_rel_table:
															sub_query_where.append('-[:`{}.{}`]-'.format(self.db_name, tb)) # NOTE: SHOULD NOT HAVE NODE VARIABLE
															if i==len(sub_match_parts)-1:
																sub_query_where.append('()')
														else:
															sub_query_where.append('(:`{}.{}`)'.format(self.db_name, tb)) # NOTE: SHOULD NOT HAVE NODE VARIABLE
												
													if not is_rel_table:
														sub_query_where = '-[]-'.join(sub_query_where)										

													if  'NOT' in part:
														where_parts.append('NOT {}'.format(''.join(sub_query_where)))
														break
													elif 'IN' in part:
														where_parts.append('In {}'.format(''.join(sub_query_where)))

														break
													else:
														outer_path_in_sub_query = False
														match_parts.append(every)

												if 'WHERE' in every:
													sub_query_where= ' '.join([i.strip() for i in every.split('WHERE') if i])
													where_parts.append(sub_query_where)
													print(f'nested_where_clause: {every}, sub_query_where: {sub_query_where}')

												if 'NOT' in every:
													sub_query_field = every.split('NOT')[-1].strip()
													if outer_query_field and outer_query_tb:
														outer_query_field = self.norm_query_fm(outer_query_field, outer_query_tb)
														
														where_parts.append('NOT {} in {}'.format(outer_query_field,sub_query_field))
														print(f'normalised_outer_query_field: {outer_query_field}')
														
												else:
													raise NotImplementedError
										elif isinstance(part, string_types):
											print(f'outer query part: {part}')
											for every in outer_match_parts:
												if  isinstance(every, string_types):
													every = every.strip('()')
													if ':' in every:
														alias, outer_query_tb = every.split(':')
														print(f'alias: {alias}, outer_query_tb:{outer_query_tb}' )
											try:
												outer_query_field = '{}.{}'.format(alias, part)
												print(f'outer_query_field: {outer_query_field}')
										
											except:
												raise NotImplementedError

								match_parts = 'MATCH {}'.format(' '.join(match_parts))
								where_parts = 'WHERE {}'.format(' AND '.join(where_parts))
								pattern = [match_parts, where_parts]
								print(f'match_parts: {match_parts}, where_parts: {where_parts}')
													


						if clause == 'select' and utils.is_subquery(json) and not outer_path_in_sub_query:
							outer_select = 	pattern.pop()	
							outer_select_parts = [every.strip() for every in outer_select.split('RETURN') if every]
							print(f'outer_select: {outer_select}, pattern: {pattern}')
							print(f'outer_query_field: {outer_query_field}')
							
							for i, part in enumerate(outer_select_parts):
								if re.match(agg_pattern, part):
									if 'count' or 'Count' or 'COUNT' in outer_select and outer_query_field:
										outer_select_parts[i] = 'count(DISTINCT {})'.format(outer_query_field)
							pattern.append('RETURN {}'.format(' '.join(outer_select_parts)))
			print(f'final pattern in nested query: {pattern}')
			seq = '\n'.join(pattern)    	
		else:
			seq = '\n'.join(
			part
			for clause in clauses
			for part in [getattr(self, clause)(json)]
			if part)
		self.pop_table_alias_stack()
		return seq

					
	def in_field(self, fm):
		for alias, tb_name in self.table_alias_lookup.items():
			headers = self.db_info[tb_name].headers
			if fm.lower() in [tfm.lower() for tfm in headers]:
				return True, tb_name
		return False, None

	def norm_query_fm(self, fm, tb_name):
		if '.' in fm:
			table_key, fm = fm.split('.')	
		else:
			is_rel, tb_name = self.is_rel(tb_name)
			for alias, table_name in self.table_alias_lookup.items():
				if tb_name==table_name:
					table_key = alias

		fm = self.norm_field(fm, tb_name)
		return "{}.{}".format(table_key, fm)
	
	def norm_tb(self, tb_name):
		lowercased_ = [ each.lower() for each in self.db_tb_names]
		if tb_name.lower() in lowercased_:
			norm_tb_name =self.db_tb_names[lowercased_.index(tb_name.lower())]
			return norm_tb_name
		return tb_name
	
	def norm_field(self, fm, tb_name):
		tb_name = self.norm_tb(tb_name)
		headers = self.db_info[tb_name].headers
		lowercased_= [each.lower() for each in headers]
		if fm.lower() in lowercased_:
			norm_fm = headers[lowercased_.index(fm.lower())]
			return norm_fm
		return norm_fm

	def is_rel(self, tb_name):
		print("*****************is_rel*****************")
		if '.' in tb_name:
			_, tb_name = tb_name.strip('`').split('.')

		tb_name = self.norm_tb(tb_name)
		tab = self.db_info[tb_name]
		
		if tab.fks:
			ref_tables = set([contraint_['to_tab'] for fk, contraint_ in tab.fks.items()])
			if len(ref_tables)==2 and (tab.is_compound_pk or not tab.pks):
				return True, tb_name
		return False, tb_name

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
		
		print(f'key: {key, key.lower()}, value: {value}, attr: {attr}')

		if hasattr(self, attr) and not key.startswith('_'):
			method = getattr(self, attr)
			return method(value)	
				
		if isinstance(value, dict):
			return '{} {}'.format(key, self.dispatch(value))	
		
		else:
			if key.lower() in ['distinct', 'all']:
				return '{} {}'.format(key, self.dispatch(value))		
			else:
				res = self.dispatch(value)
				
				if '.' in res:
					normalized_field = self.norm_query_fm(res, tb)
					# print(f'res: {res}, table_key: {table_key}, tb: {tb}, normalized_field: {normalized_field}')
				else:
					is_field, tb = self.in_field(res)
					if is_field:
						normalized_field = self.norm_query_fm(res, tb)
					else:
						return '{}{}'.format(key, add_parentheses( res))
				
				return 	'{}{}'.format(key, add_parentheses( normalized_field))			

	def from_(self, json):
		is_join = False	
		is_rel_table = False
		is_conjuntor = False

		print("*******debgu from*******")
		if 'from' in json:
			from_ = json['from']	

			if isinstance(from_, dict):
				raise NotImplementedError
				# # Case: MATCH () or MATCH ()-[r]-()
				# table = self.dispatch(from_)
				# if isinstance(table, string_types):
				# 	is_rel_table, table = self.is_rel(table)
				# 	# print(f'single graph node in from, is_rel_table: {is_rel_table}, tb: {tb}')
				# 	table = self.normalize_mentioned_tb(table)
				# 	if is_rel_table:
				# 		tb = 'rel_{}'.format(table)
				# 		return 'MATCH ()-[{}:{}]-()'.format(table[0].lower(), table)
					
				# 	return 'MATCH ({}:{})'.format(table[0].lower(), table)
			
			if not isinstance(from_, list):
				from_ =[from_]

			parts = []
			for every in from_:
				table_name = self.dispatch(every,  is_table=isinstance(every, text))
				parts.append(table_name)
				print(f'table_name: {table_name}')

				# Update table_alias_lookup. 
				if '.' in table_name:
					table_key, table_name = table_name.split('.')	
				else:
					table_key= table_name.lower()
				is_rel_table, tb = self.is_rel(table_name)
				print(f'is_rel_table: {is_rel_table}, tb: {tb}')
				self.table_alias_lookup.update({table_key:tb})
			joint_conds = []
			for every in from_:
				for join_key in sql_join_keywords:
					if join_key in every:
						is_join = True	

			if is_join:
				for every in from_:
					for conjuntor in ['and', 'or']:
						if 'on' in every and conjuntor in every['on']:
							is_join = False
							is_conjuntor = True
							joint_conds.append(self.dispatch(every['on'])) # e.g., hospital_1, id: 3935

					if not is_conjuntor:
						if 'on' in every:
							conds = every['on']['eq']
							for joint_on in conds:
								alias, _ = joint_on.split('.')
								joint_conds.append(alias)
						elif 'name' in every:
							joint_conds.append(every['name'])
						elif 'join' in every and 'name' in every['join']:
							joint_conds.append(every['join']['name'])
				
			
			print(f'table_alias_lookup: {self.table_alias_lookup}, joint_conds: {joint_conds}')
			if is_join:
				# If is_rel_table=True, case: (T1:)-[T2:]-(T3:) or (T1:)-[T2:]-() or ()-[T1:]-(T2:)
				# If is_rel_table=False, case1: (T1:)-[]-(T2) OR case2: (T1), (T2) 
					# where the aforementioned two nodes do not have graph relationship.
					# My solution is  to use existing graph to check the existence of graph relaitonship,
					# FOR EXAMPLE: 
					# 			MATCH (T1:Appointment) MATCH (T2:Patient)
					# 			RETURN  exists( (T1)--(T2) )
				
				reformat_parts = []	
				joint_tb_alias = {}
				no_exist_rel = True
				for i, every in enumerate(parts):
					alias, joint_table= every.split('.')

					# step: check if relational table and normalise the relaitonal table
					is_rel_table, joint_table = self.is_rel(joint_table)
					print(f'joint_table: {joint_table}, is_rel_table: {is_rel_table}')
		
					if is_rel_table:  # mention graph edge and connected graph node(s)
						no_exist_rel = False

						# graph edge pattern: 	
						if reformat_parts:
							reformat_parts.pop()	

						if i==0:
							# In case, edge is mentioned in the first place.
							reformat_parts.append('()')

						pattern = '-[{}:`{}.{}`]-'.format(alias, self.db_name, joint_table)
						is_rel_table = False
						reformat_parts.append(pattern)

						if i==len(parts)-1:
							# Case: (T1:)-[T2:]-()
							node_pattern = '()'
							reformat_parts.append(node_pattern)
						print(f'reformat_part_isrel: {i, reformat_parts}')

					else:
					
						# graph node pattern
						pattern = '({}:`{}.{}`)'.format(alias, self.db_name, joint_table)	
						reformat_parts.append(pattern)
						edge_pattern = '-[]-'
						reformat_parts.append(edge_pattern)

						joint_tb_alias[alias]=pattern # a lookup dictionary for node pattern
							
						print(f'iteration index: {i}, reformat_part_node: { reformat_parts}')

						
						# NOTE: this is a test regarding the case2. 
						# matched_graph_edges = self.edge_matcher.match(nodes=pattern, r_type=None)
						# print(f'matched_graph_edges: {matched_graph_edges}')

						#--------------------OLD CODE----------------------

						if i == len(parts)-1:
							# Case: (T1:)-[]-(T2)
							reformat_parts.pop()
							# print(f'joint_tb_alias: { joint_tb_alias}, joint_conds:{joint_conds}')
							if no_exist_rel:
								reformat_parts = []
								iterating_idx = -1
								# example (id: 3951) in hospital_1, (T3:Stay)-[]-(T1:Undergoes)-[]-(T2:Patient)
								for i, key in enumerate(joint_conds): # e.g., ['T1', 'T2', 'T1', 'T3']
									# print(key, iterating_idx, joint_tb_alias[key], reformat_parts)
									if iterating_idx!=-1:
										if iterating_idx<len(reformat_parts)-1:
											reformat_parts.insert(iterating_idx, joint_tb_alias[key])
										else:
											reformat_parts.insert(iterating_idx+1, joint_tb_alias[key])
									elif joint_tb_alias[key] not in reformat_parts and iterating_idx==-1:
										reformat_parts.append(joint_tb_alias[key])
									elif joint_tb_alias[key] in reformat_parts: 
										iterating_idx = reformat_parts.index(joint_tb_alias[key])
									
									


						# print(f'reformat_part_else: {reformat_parts}')
						#--------------------OLD CODE----------------------
				
				# Check if every tow nods are connected.. 
				print(f'reformat_parts in from: {reformat_parts}')

		
			else:
				reformat_parts =[]
				for i, part in enumerate(parts):
					# step: check if relational table and normalise the relaitonal table
					is_rel_table, table_name = self.is_rel(part)
					print(f'is_rel_table: {is_rel_table}, table_name: {table_name}')
					if '.' in part:
						alias, _= part.split('.')
					else:
						alias = table_name.lower()

					if i==0 and i==len(parts)-1 and is_rel_table: # only mention one graph edge
						# reformat_parts= '()-[{}:{}]-()'.format(alias, table_name)
						return 'MATCH {}'.format('()-[{}:`{}.{}`]-()'.format(alias, self.db_name, table_name))	

					elif not is_rel_table: # onely mention one graph node
						reformat_parts.append('({}:`{}.{}`)'.format(alias, self.db_name, table_name))

				if is_conjuntor:
					reformat_parts = ' MATCH '.join(reformat_parts)
					return 'MATCH {}\nWHERE {}'.format(reformat_parts, ' '.join(joint_conds) )

			if is_join and no_exist_rel:
				joiner = '-[]-'
			else:
				joiner = ''

			rest = joiner.join(reformat_parts)
			print(f'result in from: {rest}, reformat_parts: {reformat_parts}')

			return 'MATCH {}'.format(rest)	

	def where(self, json):
		if 'where' in json:	
			print("***********debug where***************")
		
			if isNested(json):
				nested_pattern = self.dispatch(json['where'])
				return nested_pattern
			elif 'between' in json['where']:
				field, lower_bound, upper_bound = self.dispatch(json['where'])	
				
				# TODO: need more test.
				if isinstance(json['from'], string_types):
					is_rel, tb_name =  self.is_rel(json['from'])
					normalized_field= self.norm_query_fm(field, tb_name )
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
			# is_rel_table, table =  self.is_rel(table)
			# print(f'table: {table}')
	
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
						print(f'select_field: {select_field}, fms: {fms}')
						
						if 'distinct' in fms:
							agg_op  = ''
							return_node = ''

							for fm in fms:	
								print(fm)
								if re.match(agg_pattern, fm):
									agg_op = fm
									print(f'agg_op: {agg_op}') # for the consistency purpose. e.g., COUNT -> count
								elif fm =='distinct':
									is_with_distinct = True
								else:
					
									if '.' in select_field:
										table_key, fm = select_field.split('.')
										table = self.table_alias_lookup[table_key]
										is_field = True

									else:
										is_field, table = self.in_field(fm)

									if is_field:
										normalized_field = self.norm_query_fm(fm, table)		
										# with_as = '{} AS {}'.format(normalized_field, fm)
										# with_parts.append(with_as)
										return_node = '{}(DISTINCT {})'.format(agg_op, normalized_field)	
									else:
										raise NotImplementedError
							
										
							return_nodes.append(return_node)


						elif 'distinct' not in select_field:
							if 'having' and 'groupby' not in json:
								print(f'agg in select: {select_field}')
								return_nodes.append(select_field)
							elif 'having' or 'groupby' in json:
								return_nodes.append('count')

								
					
					else:
						if select_field.startswith('distinct'):
							select_field = select_field.split()[1]
							is_distinct = True		

						if '.' in select_field:
							table_key, fm = select_field.split('.')
							table = self.table_alias_lookup[table_key]
						else:
							in_field, table = self.in_field(select_field)
							print(f' in_field: {in_field}, table: {table}')

						is_rel_table, table = self.is_rel(table)	
						print(f' is_rel_table?: {is_rel_table}, table: {table}')
						if is_rel_table:
							table = 'rel_{}'.format(table)
						normalized_field = self.norm_query_fm(select_field, table)	
						print(f'  normalized_field: {normalized_field}')
						
						if is_distinct:
							normalized_field = 'DISTINCT {}'.format(normalized_field)
							is_distinct =False
							# print("select distinct:", normalized_field)

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
							normalized_grouby = self.norm_query_fm(groupby_fm, table)
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
					final_return.append(with_statement)
		
					if is_where:
						# print(with_where)
						final_return.append(with_where)
				
				# if is_with_distinct:
				# 	with_statement = 'WITH DISTINCT {}'.format(', '.join(set(with_parts)))
				# 	final_return.append(with_statement)
					
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
			print("**************debug orderby******")
			orderby = json['orderby']
			# print(f'orderby: {orderby}')
			
			if not isinstance(orderby, list):
				orderby = [orderby]

			fields = [self.dispatch(o) for o in orderby]
			modifiers = [o.get('sort', '').upper()for o in orderby]
			for idx, fm in enumerate(fields):
				if 'groupby' in json and fm.lower().startswith('count'):
					fields[idx] = 'count'
				if '.' in fm:
					key, fm = fm.split('.')
					tb = self.table_alias_lookup[key]
					fields[idx] = self.norm_query_fm(fm, tb)
				else:
					is_field, tb = self.in_field(fm)
					if is_field:
						fields[idx] = self.norm_query_fm(fm, tb)

					
			print(f'norm_query_fms: {fields}' )
		
			return 'ORDER BY {}'.format(','.join('{0} {1}'.format(fields[idx], modifiers[idx]).strip()\
				for idx,_ in enumerate(zip(fields, modifiers))))
	
	def limit(self, json):
			if 'limit' in json:
				return 'LIMIT {0}'.format(self.dispatch(json['limit']))

	def offset(self, json):
		if 'offset' in json:
			return 'OFFSET {0}'.format(self.dispatch(json['offset']))	
		
	def union(self, json):
		# print(f'return nodes in select:', return_nodes)
		# if 'union' in json:
		# 	for idx, rn in enumerate(return_nodes):
		# 		[alias, fm] = rn.split('.')
		# 		print(rn, fm)
		# 		return_nodes[idx] = '{} AS {}'.format(rn, fm)
		union_ = []
		for query in json:
			print(f'query in union:', query)
			rest =  self.format(query)
			return_idx = rest.index('RETURN')
			print("heyyy index:", return_idx)
			return_content = rest[return_idx+6:]
			print("union heyyyy:", return_content)
			return_nodes = return_content.split(',')
			for i, node in enumerate(return_nodes):
				if '.' in node:
					[alias, fm] = node.split('.')
					rest+='  AS {}'.format(fm.lower())

			union_.append(rest)


		return ' \nUNION\n'.join(union_)	

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
			print(escape(json, True))
			return "'{0}'".format(json.replace("'", '"'))
		else:
			return str(json)

	def _like(self, json):
		print("*******debug like*********")
		print(json)
		if not isinstance(json, list):
			json = [json]
		for res in json:
			res = self.dispatch(res)
			is_field, tb = self.in_field(res)
			
			if is_field:
				normalized_field  = self.norm_query_fm(res, tb)
			else:		
				literal= res.strip('\'').strip('%')
		return "{} =~'.*[{}|{}]{}.*'".format(normalized_field, literal[0].capitalize(), literal[0].lower(), literal[1:])
		
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
				- Cypher query: (NOTE:WORKING!)
					MATCH (d:department)
					MATCH (d1:department)-[:management]-()
					WHERE NOT d.Department_ID in  d1.Department_ID
					RETURN count(*)
					
				or 
				- relational databse: musical.db
				- Question:  List the name of musicals that do not have actors.
				- SQL query: SELECT Name FROM musical WHERE Musical_ID NOT IN (SELECT Musical_ID FROM actor)
				- Cypher query: (NOTE: Should not have other variables in where statement !)
					MATCH (m:musical)
					WHERE NOT (m:musical)-[]-(:actor)
					RETURN m.Musical_ID 
					
					or ? even simpler
					MATCH (m:musical) 
					WHERE NOT (m)-[]-()
					RETURN m.Name

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

def execution_accuracy(metrics_file, split, correct, incorrect, invalid_parsed_sql, intersect_sql, except_sql, data=[]):
	incorrect_num = 0
	total =correct
	for every in [incorrect]:
		for x in list(every.values()):
			incorrect_num +=len(x)
		total += incorrect_num

	invalid_report = []
	for every in [invalid_parsed_sql, intersect_sql, except_sql]:
		counter = 0
		for x in list(every.values()):
			counter +=len(x)
		if total!=0:
			invalid_report.append(round(counter/(total+counter), 2))
		
	if total !=0:
		every_metric =  {'split': split,
					'total': total, 
					'execution_accuracy': round(correct/total, 2),
					'correct_num': correct,
					'incorrect': incorrect,
					'invalid_parsed_sql':invalid_parsed_sql,
					'intersect_sql': intersect_sql,
					'except_sql': except_sql, 
					'report of `invalid_parsed`, `intersect`, `except queries`' : invalid_report
				}
		data.append(every_metric)
		
		with open(metrics_file, 'w')  as out:
			json.dump(data, out, indent = 4)
		
		return data


def main():
	import glob, argparse
	from pygments.lexers import get_lexer_by_name
	from py2neo import Graph
	lexer = get_lexer_by_name("py2neo.cypher")
	import configparser
	import shutil
	from schema2graph import RelDBDataset

	config = configparser.ConfigParser()
	config.read('../config.ini')
	filenames = config["FILENAMES"]

	raw_data_folder = filenames['raw_folder']
	root = filenames['root']

	neo4j_uri = filenames['neo4j_uri']
	neo4j_user = filenames['neo4j_user']
	neo4j_password = filenames['neo4j_password']
	graph = Graph(neo4j_uri, auth = (neo4j_user, neo4j_password))

	raw_spider_folder = os.path.join(raw_data_folder, 'spider')
	db_folder = os.path.join(raw_spider_folder,  'database')
	db_paths=glob.glob(db_folder + '/**/*.sqlite', recursive = True) 
	logger =Logger('/sql2cypher.log')
	rel_db_dataset = RelDBDataset(db_paths, logger)

	sp_out_folder = os.path.join(root, 'sp_data_folder')
	if not os.path.exists(sp_out_folder):
		os.makedirs(sp_out_folder) 

	for split in ['train', 'dev']:
   
		json_file = os.path.join(raw_spider_folder, '{}.json'.format(split))
		f = open(json_file)
		data = json.load(f)

		spider_sub_gold_sql = []
		spider_sub_tables = []

		qa_pairs = {'correct_': [], 'incorrect_':[], 'spider_sub_pairs':[], 'spider_sub_gold_sql':[]}
		incorrect = {}
		invalid_parsed_sql = {}
		intersect_sql = {}
		except_sql =  {}
		
		for i, every in enumerate(data):
			db_name = every['db_id']
			# ['car_1', 'department_management', 'pets_1', 'concert_singer', 'real_estate_properties']:
			if db_name in ['car_1', 'department_management', 'pets_1', 'concert_singer', 'real_estate_properties']:
				
				for evaluate in [incorrect, invalid_parsed_sql, intersect_sql, except_sql]:
					if db_name not in evaluate:
						evaluate[db_name]=[]

				# - Access database, execute SQL query and get result.              
				db_path = os.path.join(db_folder, db_name, '{}.sqlite'.format(db_name))  
				engine = DBengine(db_path)

				# - Extract database name, questions and SQL queries
				question = every['question']
				sql_query = every['query']


				try:
					sql_result = engine.execute(sql_query).fetchall()
				except:
					logger.error('Attention in {}, exist Invalid sql query:{}'.format(db_name, sql_query))
					continue

				try:
					# - Convert SQL query to Cypher query.	
					parsed_sql = parse(sql_query)					
					print("------------------------")
					print(f'databse: {db_name}, question: {question}')
					print(f'sql: {sql_query}, sql_ans: {sql_result}')
					print(f'parsed_sql: {parsed_sql}')	

					try:
						formatter  = Formatter( logger, db_name, rel_db_dataset.rel_dbs[db_name], graph)
						sql2cypher = formatter.format(parsed_sql)
						print("**************Cypher Query***************")
						print(sql2cypher)

						# - Execute cypher query.
						if sql2cypher:
							cypher_res = graph.run(sql2cypher).data()
							cypher_ans = []
							for dict_ in cypher_res:
								cypher_ans.append(tuple(dict_.values()))	

							if set(cypher_ans)==set(sql_result):
								print(f'correct_ans: {cypher_ans}') 
								qa_pairs['correct_'].append(
									{
										'db_id':db_name, 
										'sql': sql_query, 
										'cypher_query':sql2cypher,
										'question':question,
										'answers':cypher_ans
									})
								qa_pairs['spider_sub_pairs'].append(data[i])
								qa_pairs['spider_sub_gold_sql'].append(data[i]['query'])
							else:
								print(f'incorrect_ans: {cypher_ans}')
								incorrect[db_name].append(i)
								qa_pairs['incorrect_'].append(
									{
										'db_id':db_name, 
										'query':question,
										'sql_query':sql_query, 
										'parsed_sql':parsed_sql, 
										'sql_ans':sql_result,
										'sql2cypher':sql2cypher, 
										'cypher_ans':cypher_ans
									})
					except:
						print()
						incorrect[db_name].append(i)
					
				except:
					if 'intersect' in sql_query.lower():
						intersect_sql[db_name].append(i)
					if 'except' in sql_query.lower():
						except_sql[db_name].append(i)	

					invalid_parsed_sql[db_name].append(i)
					logger.error('Attention in {}.db. Can not parse sql query:{}'.format(db_name, sql_query))

		metrics_file = os.path.join(root, 'application', 'rel_db2kg', 'metrics.json')
		metrics = execution_accuracy(metrics_file, split, len(qa_pairs['correct_']), incorrect, invalid_parsed_sql,
			intersect_sql, except_sql)
		print(f'metrics: {metrics}')

		correct_output_file = os.path.join(sp_out_folder, '{}.json'.format(split))   
		with open(correct_output_file, 'a')  as f1:
			json.dump(qa_pairs['correct_'], f1, indent = 4)

		incorrect_output_file = os.path.join(sp_out_folder, '{}_incorrect.json'.format(split))     
		with open(incorrect_output_file, 'a')  as f2:
			json.dump(qa_pairs['incorrect_'], f2, indent = 4)

		sub_spider = os.path.join(sp_out_folder, '{}_spider_sub.json'.format(split))
		with open(sub_spider, 'a')  as f3:
			json.dump(qa_pairs['spider_sub_pairs'], f3, indent = 4)
		
		sub_gold = os.path.join(sp_out_folder, '{}_gold.sql'.format(split))
		with open(sub_gold, 'a')  as f4:
			for item in qa_pairs['spider_sub_gold_sql']:
				# write each item on a new line
				f4.write("%s\n" % item)
				print('Done')

		sub_tables = os.path.join(sp_out_folder, 'tables.json')     
		with open(sub_tables, 'a')  as f5:
			json.dump(spider_sub_tables, f5, indent = 4)
		
		# Output selected relational dbs folder path
		sub_rel_dbs_folder = os.path.join(sp_out_folder, 'database')  
		if not os.path.exists(sub_rel_dbs_folder):
			os.makedirs(sub_rel_dbs_folder) 
	
		# for db_name in seleted_rel_dbs:
		# 	source_dir = os.path.join(db_folder, db_name)
		# 	destination_dir = os.path.join(sub_rel_dbs_folder, db_name)
		# 	if not os.path.exists(destination_dir):
		# 		shutil.copytree(source_dir, destination_dir)

	all_db_list = tuple(set([every['db_name'] for every in read_json(os.path.join(root, 'application', 'rel_db2kg', 'consistency_check', 'data_stat.json'))]))
	filtered_list = tuple(set([every['db_name'] for every in read_json(os.path.join(root, 'application', 'rel_db2kg', 'consistency_check', 'data_stat.json'))  if every['num_of_rows']>4000]))
	graph_db_list = set(all_db_list) - set(filtered_list)
	print(len(all_db_list), len(filtered_list), len(graph_db_list))

if __name__=="__main__":
	main()