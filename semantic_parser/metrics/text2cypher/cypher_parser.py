import json
from pygments.lexers import get_lexer_by_name
import os
from pathlib import Path
here = Path(__file__).parent

class CyqueryStatmentParser:
	def __init__(self, 
				queries, 
				queries_type,
				# structure_in, 
				lexer):
		self.queries = queries
		self.queries_type = queries_type
		self.lexer = lexer
		# self.structure_in = structure_in
	
	# def get_domain_schem_dict(self):
	# 	properties = self.structure_in.split('|')
	# 	domain_schema_dict = {}
	# 	for each in properties:
	# 		if ':' in each:
	# 			schema_items = [item.strip() for item in each.split(',')]
	# 			another_item = schema_items[0].split(':')[-1]
	# 			tag = schema_items[0][:len(schema_items[0])-len(another_item)-2].strip()
	# 			db, tag = tag.strip(':').strip("`").split('.')
	# 			domain_schema_dict[tag]=[another_item.strip()] + schema_items[1:]
	# 	return  domain_schema_dict

	def set_key(self, 
				dictionary, 
				key, 
				value):
		if key not in dictionary:
			dictionary[key] = value
		elif type(dictionary[key]) == list and value not in dictionary[key]:
			dictionary[key].append(value)
		elif value not in dictionary[key]:
			dictionary[key] = [dictionary[key], value]

		return dictionary
			
	def save2file(self, ls_name, ls, mode):
		folder ='{}/{}/{}/'.format(here, "output", "tokenized_cypher")
		if not os.path.exists(os.path.dirname(folder)):
			try:
				os.makedirs(os.path.dirname(folder))
			except OSError as exc:
				if exc.errno != errno.EEXITST:
					raise		
		else:
			mode = 'a'
			
		if isinstance(ls, list):
			with open(folder + ls_name, mode) as out:
				print(ls, file = out)
		else:
			with open(folder + ls_name, mode) as f:
				json.dump(ls, f, indent = 6)
				f.close()


	def get_tokenization(self):
		if self.queries_type=='file':
			with open(self.queries, 'r') as f:
				queries = f.read()
			queries = list(queries.split(';'))
		elif self.queries_type=='statement':
			queries=[self.queries]
		print("raw queries:", queries, type(queries))
		token_types = []
		tokenized_statment = {}
		tokens = []
		# domain_schema_dict = self.get_domain_schem_dict()
		# print(domain_schema_dict)
		for query in queries:
			# post_processed_query = []
			# db_query_candidates_list = []
			get_tokens = list(self.lexer.get_tokens(query))		
			self.save2file('get_tokens.txt', get_tokens, 'a')
			for every in get_tokens:
				if every[1]!='\n':
					tokens.append((str(every[0]), every[1]))
				tokenized_statment = self.set_key(tokenized_statment, str(every[0]), every[1])
				if every[0] not in token_types:
					token_types.append(every[0])


		self.save2file('get_lexer', token_types, 'w')
		self.save2file('tokenized_statment.json', tokenized_statment, 'w')
		
		return tokens

def main():

	lexer = get_lexer_by_name("py2neo.cypher")
	
	queries_file = 'input/queries'
	Cyparser = CyqueryStatmentParser(queries_file, 'file', lexer)
	tokens = Cyparser.get_tokenization()
	print(f'tokens: {tokens}')



if __name__ == "__main__":
	main()
