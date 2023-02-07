import os, sys
import json
import argparse
from process_cypher import get_cypher


class Schema:
    """
    Simple schema which maps node lable/type edge&property to a unique identifier
    """
    def __init__(self, schema):
        self._schema = schema
        self._idMap = self._map(self._schema)

    @property
    def schema(self):
        return self._schema

    @property
    def idMap(self):
        return self._idMap

    def _map(self, schema):
        property_names_original = schema['property_names']
        tag_names_original = schema['table_names_original']
        for i, (tag_id, property) in enumerate(property_names_original):
            if tag_id == -1:
                idMap = {'*': i}
            else:
                key = tag_names_original[tag_id].lower()
                val = property.lower()
                idMap[key + "." + val] = i

        for i, tab in enumerate(tag_names_original):
            key = tab.lower()
            idMap[key] = i

        return idMap
    

def get_schemas_from_json(fpath):
    with open(fpath) as f:
        data = json.load(f)
    db_names = [db['db_id'] for db in data]

    tags = {}
    schemas = {}
    for db in data:
        db_id = db['db_id']
        schema = {} #{'tag': [property.lower, ..., ]} * -> __all__
        property_names_original = db['property_names']
        tag_names_original = db['tag_names_original']
        tags[db_id] = {'column_names_original': property_names_original, 'tag_names_original': tag_names_original}
        for i, tabn in enumerate(tag_names_original):
            tag = str(tabn.lower())
            props = [str(prop.lower()) for td, prop in property_names_original if td == i]
            schema[tag] = props
        schemas[db_id] = schema

    return schemas, db_names, tags



#TODO: update the following dirs
cypher_path = os.getcwd() + '/data/text2cypher/dev.json' 
output_file = os.getcwd() + '/data/text2cypher/dev_new.json'
raw_schema_file = os.getcwd() + '/data/text2cypher/schema.json'  

schemas, db_names, tables = get_schemas_from_json(raw_schema_file)

with open(cypher_path) as inf:
    cypher_data = json.load(inf)

cypher_data_new = []
for data in cypher_data:
    try:
        db_id = data["db_id"]
        schema = schemas[db_id]
        table = tables[db_id]
        schema = Schema(schema, table)
        cypher = data["query"]
        cypher_label = get_cypher(schema, cypher)
        data["cypher"] = cypher_label
        cypher_data_new.append(data)
    except:
        print("db_id: ", db_id)
        print("cypher: ", cypher)
        
with open(output_file, 'wt') as out:
    json.dump(cypher_data_new, out, sort_keys=True, indent=4, separators=(',', ': '))