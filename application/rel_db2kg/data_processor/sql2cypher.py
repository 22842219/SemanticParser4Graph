import os
import re
from moz_sql_parser import parse
import json, jsonlines
import configparser
config = configparser.ConfigParser()
from mo_future import text
import utils as utils
from rel_db2kg.data_processor.traverser import SchemaGroundedTraverser
from rel_db2kg.data_processor.sql_keywords import sql_join_keywords


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
	op = ' {0} '.format(op)
	def func(self, json):
		arguments = []
		# print("json in operator", json)
		for v in json:
			if isinstance(v, str):
				if '.' not in v:
					for tb_name, tb_fields in self.db_lookup_dict.items():
						bool_in_field, aligned_ex_field = self.in_field(self.dispatch(v), tb_fields)
						if bool_in_field:
							v = '{}.{}'.format(tb_name.lower()[0], aligned_ex_field)
					if should_quote(v):
						v = '"{}"'.format(v)
					arguments.append(v)
				else:
					arguments.append(self.dispatch(v))
				out = op.join(arguments)
			elif isinstance(v, dict) and utils.is_subquery(v):	
				arguments.append(op)			
				arguments.append(self.dispatch(v))
				out = arguments
			else:
				# Reformat 
				v_ = self.dispatch(v)
				for tb_name, tb_fields in self.db_lookup_dict.items():
					bool_in_field, aligned_ex_field = self.in_field(self.dispatch(v), tb_fields)
					if bool_in_field:
						v_ = '{}.{}'.format(tb_name.lower()[0], aligned_ex_field)			
				if re.fullmatch(number_pattern, v_):
					v_ = '"{}"'.format(v_)
				arguments.append(v_)
				out = op.join(arguments)
		if parentheses:
			out = add_parentheses(out)
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

	def __init__(self, db_lookup_dict: dict, in_execution_order = True, verbose = False):
		super().__init__(verbose)

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

		self.in_execution_order = in_execution_order
		self.db_lookup_dict = db_lookup_dict
	
	def in_field(self, ex_field, fields):
		in_field = False

		for std_field in fields:
			# print(ex_field, std_field, utils.similar(ex_field.lower(), std_field))
			if ex_field.lower() == std_field.lower():
				in_field = True
				# if in_field, we replace extracted field with standard field name in case not being identified by graph.
				# Because graph label and properties are sensitive with letter case.  
				ex_field = std_field
		
		return in_field, ex_field
		
		
	
	def _reformat(self, ext_tables, ext_fields = [], mode = 'ref_fields'):
		if mode == 'ref_table_name':
			for idx, token in enumerate(ext_tables):
				if token in self.db_lookup_dict:		
					ext_tables[idx] = '({}:{})'.format(token.lower()[0], token)		
			return ext_tables		

		else:
			for idx, field in enumerate(ext_fields):
				for table in ext_tables:			
					for tb_name, tb_fields in self.db_lookup_dict.items():			
						bool_in_field, aligned_ex_field = self.in_field(field, tb_fields)
						if table in self.db_lookup_dict and bool_in_field:    							
							ext_fields[idx] = '{}.{}'.format(tb_name.lower()[0], aligned_ex_field)	
			return ext_fields
	
	def get_nodes(self, key_word, json):
		# Extract table_name and field_names for the graph node reformat purpos.
		# Graph node requirs node variable.

		fields = self.dispatch(json[key_word])
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
				return  fields.split(',')
			else:
				fields = fields.split(',')			
				ref_fields = self._reformat(tables, fields, mode = 'ref_table_name')	
				return ref_fields
    		

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
		
	def dispatch(self, json, is_table = False):
    		
		if isinstance(json, list):
			return self.delimited_list(json)

		if isinstance(json, dict):
			if len(json) == 0:
				return ''
			elif 'value' in json:
				return self.value(json)				
				
			elif 'from' in json:
				# Nested query 'from'
				# print("nested query 'from:", self.format(json))
				return add_parentheses(self.format(json))
			
			elif 'between' in json:

				return self._between(json)

			# elif 'query' in json:
			# 	# Nested query 'query'
			# 	nested_query = self.format(json['query'])
			# 	if 'name' in json:
			# 		return '{0} AS {1}'.format(add_parentheses(nested_query), json['name'])
			# 	else:
			# 		return add_parentheses(nested_query)

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

			if is_table:
				return json.capitalize() 
			else:
				return json
		return text(json)

	def value(self, json):
		# print("value json:", json)
		parts = [self.dispatch(json['value'])]
		if 'name' in json:    			
			key_ = self.dispatch(json['name'])
			value_ = self.dispatch(json['value'])
			parts = {key_:value_}
			return parts
		return ' '.join(parts)

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
		if hasattr(self, attr) and not key.startswith('_'):
			method = getattr(self, attr)
			return method(value)			

		if isinstance(value, dict) and len(value) == 0:
			return key + '()'
		else:
			if key in ['DISTINCT', 'ALL']:
				return '{} {}'.format(key, self.dispatch(value))		
			else:
				return '{}{}'.format(key, add_parentheses(self.dispatch(value)))
				
	def _literal(self, json):
			if isinstance(json, list):
				return add_parentheses(', '.join(self._literal(v) for v in json))
			elif isinstance(json, text):
				return "'{0}'".format(json.replace("'", '"'))
			else:
				return str(json)

	def _like(self, pair):
		return '{0} CONTAINS {1}'.format(self.dispatch(pair[0]), self.dispatch(pair[1]))

	def _on(self, json):		
		for join_key in sql_join_keywords:
			join_dict = {}
			if join_key in json:
				join_dict.update(self.dispatch(json[join_key], is_table=isinstance(json[join_key], text)))		
			
				join_dict.update({'on':self.dispatch(json['on']).split(' AND ')})	

				return join_dict
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
		# value = self.dispatch(json)
		# print(value)
		# nested_node = valid[1]
		# from_node = '({})'.format(nested_node[nested_node.index(':'):-1])
		# return 'WHERE IN {}'.format(from_node)

	def select(self, json):	
		groupby_nodes=''
		if 'groupby' in json and 'having' not in json:
    		# Map sql groupby statement to cypher aggregation and attach it to the cypher return clause.
			groupby_nodes = self.groupby(json)

		if "having" in json: 
			# Break down having statement in the format of with-as-where pattern.
			with_as, with_where  = self.having(json) 
		
			select_nodes = self.get_nodes('select', json) + list(set(groupby_nodes) - set(self.get_nodes('select', json)))

			node_as = [with_as]
			return_node_alias = []

			for node in select_nodes:
				print("node in select nodes:", type(node), node)
				if node.startswith('count'):
					print("aggregation node:", node)
					node_as.append('{}'.format(node))
				else:
					# e.g. (m:Musical)
					node_strip = node.strip('(').strip(')') # R: "m:Musical"
					
					if '.' in node_strip:
						node_alise = node_strip.split('.')[0]
					elif ':' in node_strip:
						node_alise = node_strip.split(':')[0]
					node_as.append(node_alise)
					return_node_alias.append(node_alise)

				with_statement = ','.join(node_as) + '\n' + with_where
				
				return_statement = 'RETURN {}'.format(','.join(return_node_alias))

				return '\n'.join([with_statement, return_statement])		
		
		for select in ['select', 'select_distinct']:
			if select  in json:  
				agg__pattern = r'^\bavg\b|\bmax\b|\bmin\b|\bcount\b.*'
				table= json['from']
				print("from table:", table)
				
				select_fields = self.dispatch(json[select]).split(',')
				print(select_fields)
				return_nodes = []
				for select_field in select_fields:
					is_agg = re.match(agg__pattern, select_field)
					print(select_field, bool(is_agg))
					if type(table) == str and not bool(is_agg):
						return_nodes.append('{}.{}'.format(table.lower()[0], select_field))
					else:
						if select_field.startswith('count'):
							return_nodes.append(select_field)	
						else:
							select_nodes = self.get_nodes('select', json) + list(set(groupby_nodes) - set(self.get_nodes('select', json)))
							agg_opt = select_field.split('(')[0]
							agg_field = select_field.split('(')[1]
							print(select_nodes,select_nodes[0].split('.'))
							print( agg_opt, agg_field)
							return_field = agg_opt + '(' + table.lower()[0]+'.'+agg_field
							return_nodes.append(return_field)
    							
													
				if groupby_nodes:
					if groupby_nodes not in return_nodes:
						return_nodes.append(groupby_nodes)
				if 'where' in json and 'list' in json['where'] or select == 'select_distinct':	
					# list appears in intersect statement, so distinct is added.		
					return 'RETURN DISTINCT {}'.format(','.join(return_nodes))
				else:
					return 'RETURN {}'.format(','.join(return_nodes))	
				

	def from_(self, json):
		is_join = False	
		is_nested = False
		if 'from' in json:
			from_ = json['from']

			if isinstance(from_, dict):
				return 'MATCH {}'.format(self.dispatch(from_))
			
			if not isinstance(from_, list):
				from_ = [from_]
			parts = []
			for token in from_:
				for join_key in sql_join_keywords:
					if join_key in token:
						is_join = True
				parts.append(self.dispatch(token, is_table = isinstance(token, text)))
			
			if isNested(json):
				is_nested = True
			
			if is_join:
				alias_lookup = {}	
				for idx, every in enumerate(parts):
					for item in list(every.items()):
						alias_pair = {item[0]:item[1]}
						if 'on' not in item:
							alias_lookup.update(alias_pair)
				reformat_parts = []		
				for every in parts:
					if 'on' in every:
						# TODO 
						for every_on in every['on']:
							pattern_info = every_on.split('=')	
							start_node_variable = pattern_info[0].split('.')[0].strip().strip('"')
							start_node_label = alias_lookup[start_node_variable]
							end_node_variable = pattern_info[1].split('.')[0].strip(' ').strip('"')
							end_node_label = alias_lookup[end_node_variable]							
							pattern = '({}:{})-[:HAS_{}]->({}:{})'.format(start_node_variable,start_node_label.capitalize(),\
								end_node_label.upper(),end_node_variable, end_node_label.capitalize() )
							reformat_parts.append(pattern)

			else:
				# Reformat   					
				reformat_parts = self._reformat(parts, [],  mode = 'ref_table_name' )	
				
			


			joiner = ' \n ' if is_join else ', '
			rest = joiner.join(reformat_parts)
			graph_pattern = 'MATCH {}'.format(rest)

			return graph_pattern

	def where(self, json):
		if 'where' in json:	
			if isNested(json):
				nested_pattern = self.dispatch(json['where'])
				return nested_pattern				
			else:
				where_clause = json['where']
				print(where_clause)
				print(self.dispatch(where_clause))
				return 'WHERE {}'.format(self.dispatch(json['where']))


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
		if 'groupby' in json:
			# groupby_nodes =  self.get_nodes('groupby', json)
			# x = []
			# for node in groupby_nodes:
			# 	# x.extend('count(*),max({0}),min({0})'.format(node).split(','))
			# 	x.append('count(*)')
			return 'count(*)'

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
		'''
		if 'having' in json:
			having_agg = [item.strip('"') for item in self.dispatch(json['having']).split()]
			with_as = 'WITH {} AS {}'.format(having_agg[0], having_agg[0][0])	
			with_where = 'WHERE {} {}'.format(having_agg[0][0], ' '.join(having_agg[1:]))		
			return with_as, with_where

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
					ref_fields = self._reformat(tables, fields)		
					
					return 'ORDER BY {}'.format(','.join('{0} {1}'.format(ref_fields[idx], modifiers[idx]).strip()\
						for idx,_ in enumerate(zip(ref_fields, modifiers))))
	
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


def main():

	config.read('../config.ini')
	filenames = config["FILENAMES"]
	raw_data_folder = filenames['raw_folder']
	sp_folder = filenames['sp_folder']

	spider_json_folder = os.path.join(raw_data_folder, 'spider')
	spider_all_table_fields_file = os.path.join(sp_folder, 'spider', 'db_table_field.json')

	for split in ['train', 'dev']:
   
		json_file = os.path.join(spider_json_folder, '{}.json'.format(split))
		print(json_file)
		f = open(json_file)
		data = json.load(f)

		
		question_answer_pairs = []

		# test output file
		cypher_file_musical  = os.path.join(spider_json_folder, '{}_{}_cypher.json'.format('musical', split))

		for every in data:
			all_table_fields = []	

			# Get table_fields information.
			with jsonlines.open(spider_all_table_fields_file, "r") as f:
				for line in f:
					if line['db_name'] == every['db_id']:
						all_table_fields.append(line['table_fields'])

			db_name = every['db_id']
			question = every['question']
			sql_query = every['query']	
			print("----")
			print("databse:", db_name)
			print("question:", question)
			print("sql_query:", sql_query)
			

			parsed_sql = parse(sql_query)	
			print(parsed_sql)

			formatter  = Formatter(all_table_fields)

			sql2cypher = formatter.format(parsed_sql)
			print(sql2cypher)
		
		

if __name__=="__main__":
	main()