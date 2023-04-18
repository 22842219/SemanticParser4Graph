################################
# Assumptions:
#   1. CYPHER IS CORRECT.
#   2. ONLY ONE UNION

#
# val: number(float)/string(str)/cypher(dict)
# col_unit: (agg_id, col_id, isDistinct(bool))
# val_unit: (unit_op, col_unit1, col_unit2)
# table_unit: (table_type, col_unit/cypher)
# cond_unit: (not_op, op_id, val_unit, val1, val2)
# condition: [cond_unit1, 'and'/'or', cond_unit2, ...]
# cypher {
#   'match': {'table_units': [table_unit1, table_unit2, ...], 'conds': condition}
#   'with' : [(agg_id, alias_name, col_id, isDistinct)]
#   'where': condition #TODO
#   'return': (isDistinct(bool), [(agg_id, val_unit), (agg_id, val_unit), ...])
#   'orderBy': ('asc'/'desc', [val_unit1, val_unit2, ...])
#   'limit': None/limit value
#   'union': None/cypher
# }
################################

import json, re
from nltk import word_tokenize

from pygments.lexers import get_lexer_by_name
from cypher_parser import CyqueryStatmentParser
lexer = get_lexer_by_name("py2neo.cypher")

alias_pattern = re.compile(r'(t[1-9]|[a-z])')	
labels_pattern = re.compile(r':`[a-z|A-Z].*`')

CLAUSE_KEYWORDS = (
    "match",
    "with", 
    "where",
    "return",
    "order by",
    "limit",
    "union",
)
CYPHER_OPERATORS = (
    'and',
    'as',
    'contains',
    'distinct',
    'ends',
    'in',
    'is',
    'not',
    'or',
    'starts',
    'xor'
)



WHERE_OPS = (
    "=",
    ">"
    "<",
    ">=",
    "<=",
    "<>",
    "=~"
)
UNIT_OPS = ("none", "-", "+", "*", "/")
AGG_OPS = ("none", "max", "min", "count", "sum", "avg")
ORDER_OPS = ("desc", "asc")

TABLE_TYPE = {
    "cypher": "cypher",
    "table_unit": "table_unit",
}



class DerivedFieldAliasError(ValueError):
    pass

class DerivedTableAliasError(ValueError):
    pass

class ParenthesesInConditionError(ValueError):
    pass

class ValueListError(ValueError):
    pass

class Schema:
    """
    Simple schema which maps graph nodes/edges and their properties to a unique identifier (aka, digital index)
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
        tabs = schema['tag_names']
        column_names_original = schema['property_names']
        for i, (tab_id, col) in enumerate(column_names_original):
            if tab_id == -1:
                idMap = {'*': i}
            else:
                key = tabs[tab_id]
                val = col
                idMap[key + "." + val] = i

        for i, tab in enumerate(tabs):
            key = tab
            idMap[key] = i
        return idMap

def get_schema_from_json(fpath, db_id):
    """
    Get the graph database's schema, which is a dict with the key in the format of :`db_name.tb_name`, e.g., :`department_management.head`
    and list of property names as value
    :param file: the schema json file
    :return: schema dict
    """
    with open(fpath) as reader:
        data = json.load(reader)
        schema = data[db_id]   
    return schema


def tokenize(string):
    print("+++++++++++++++++++++++++++++++++tokenize++++++++++++++++++++++++++++++")
    cypher_parser = CyqueryStatmentParser(string, 'statement', lexer)
    tokens = cypher_parser.get_tokenization()
    return tokens

def scan_labels_with_alias(toks):
    """Scan Token.Name.Variable, distinguish alias from properties, and build the map for all alias"""
    
    len_ = len(toks)
    toks_ = [tok[1].lower() for tok in toks]
    alias = {}

    start_idx = 0
    idx = start_idx
    while idx<len_:
        if toks_[idx]=='match':
            idx+=1
        if idx < len_ and toks_[idx]!=':' and toks[idx][0] in ['Token.Punctuation', 'Token.Text.Whitespace' ] :
            idx+=1  # skip whitespace and edge indicators
        if toks[idx-1][0]=='Token.Name.Variable' and toks_[idx]==':' and \
            toks[idx+1][0]=='Token.Name.Label':
            alias[toks[idx-1][1]]=toks[idx+1][1]
            idx+=3 
        else:
            idx+=1
        # assert 1>2
        if idx < len_ and ((toks_[idx] in CLAUSE_KEYWORDS[1:] or toks_[idx] in (";"))):
            break
    if idx>=len_ or toks_[idx]!='with':
        return alias
        
    idx+=1

    as_ids = [idx for idx, tok in enumerate(toks_) if tok == 'as']

    if as_ids:
        for id in as_ids:
            while idx < len_:
                if idx<len_ and toks[idx][0] in['Token.Punctuation', 'Token.Text.Whitespace' ]:
                    idx+=1
                if toks[idx][0]=='Token.Name.Function':
                    if '*' in toks_[idx:id]:
                        idx+= toks_[idx:id].index('*')   
                    else:
                        idx+1                         
                if idx+2< len_ and toks[idx][0]=='Token.Name.Variable':
                    if toks[idx+1][0]=='Token.Operator':      
                        key = alias[toks[idx][1]]
                        schema_key = '{}.{}'.format(key, toks[idx+2][1])
                        alias[toks[id+2][1]]=schema_key
                        idx=id+3
                 
                    elif '*' in toks_:
                        alias[toks[idx][1]]='*'
                        idx+=1
                    break
                if idx < len_ and (toks_[idx] in CLAUSE_KEYWORDS or toks_[idx] in ( ";") ):
                    break
                else:
                    idx+=1                    
    return alias

def parse_col(toks, start_idx, labels_with_alias, schema, default_tables=None):
    """
        :returns next idx, column id
    """
    toks_ = [tok[1].lower() for tok in toks]
    idx = start_idx
    tok = toks_[idx]
    if tok == "*":
        return idx + 1, schema.idMap[tok]

    if toks[idx][0] in ['Token.Punctuation', 'Token.Text.Whitespace' ]:
        idx+=1
    
    if toks[idx][0]=='Token.Name.Variable' or toks[idx][1] in labels_with_alias: # if token is a composite
        if toks[idx][1] in labels_with_alias:
            key = labels_with_alias[toks[idx][1]]
        else:
            key = toks[idx][1]
        if '.' in toks_[idx:]:
            schema_key = '{}.{}'.format(key, toks[idx+2][1])
            idx+=3
        else:
            schema_key = key
            idx+=1
        return idx, schema.idMap[schema_key]

    assert default_tables is not None and len(default_tables) > 0, "Default tables should not be None or empty"

    for alias in default_tables:
        table = labels_with_alias[alias]
        table_original = table.strip('`').split('.')[-1]
        if tok in schema.schema[table_original]:
            key = table + "." + tok
            return idx+1, schema.idMap[key]

    assert False, "Error col: {}".format(tok)

def parse_col_unit(toks, start_idx, labels_with_alias, schema, default_tables=None):
    """
        :returns next idx, (agg_op id, col_id)
    """
    toks_ = [tok[1].lower() for tok in toks]
    idx = start_idx
    len_ = len(toks)
    isDistinct = False
    
    if toks[idx][0] in ['Token.Punctuation', 'Token.Text.Whitespace']:
        idx += 1
    if toks_[idx] in AGG_OPS and toks[idx][0]=='Token.Name.Function':
        agg_id = AGG_OPS.index(toks_[idx])
        idx += 1
        assert idx < len_ and toks_[idx] == '('
        idx += 1
        if toks_[idx] == "distinct":
            idx += 1
            isDistinct = True
       
        idx, col_id = parse_col(toks, idx, labels_with_alias, schema, default_tables)
        assert idx < len_ and toks[idx][0] in ['Token.Punctuation', 'Token.Text.Whitespace']
        idx += 1
        return idx, (agg_id, col_id, isDistinct)

    if toks_[idx] == "distinct":
        idx += 1
        isDistinct = True
    agg_id = AGG_OPS.index("none")
    
    idx, col_id = parse_col(toks, idx, labels_with_alias, schema, default_tables)

    return idx, (agg_id, col_id, isDistinct)

def parse_val_unit(toks, start_idx, labels_with_alias, schema, default_tables=None):
    idx = start_idx
    len_ = len(toks)

    col_unit1 = None
    col_unit2 = None
    unit_op = UNIT_OPS.index('none')
    idx, col_unit1 = parse_col_unit(toks, idx, labels_with_alias, schema, default_tables)
    if idx < len_ and toks[idx] in UNIT_OPS:
        unit_op = UNIT_OPS.index(toks[idx])
        idx += 1
        idx, col_unit2 = parse_col_unit(toks, idx, labels_with_alias, schema, default_tables)
    return idx, (unit_op, col_unit1, col_unit2)

def parse_value(toks, start_idx, labels_with_alias, schema, default_tables=None):
    idx = start_idx
    len_ = len(toks)
    toks_ = [tok[1].lower() for tok in toks]
    if toks[idx][0] in ['Token.Punctuation', 'Token.Text.Whitespace']:
        idx+=1
    if toks_[idx] == 'return':
        idx, val = parse_cypher(toks, idx, labels_with_alias, schema)
    elif toks[idx][0] in ['Token.Literal.String', 'Token.Literal.Number.Integer', 'Token.Literal.Number.Float']:  # token is a string value
        val = toks[idx][1]
        idx += 1
    else:
        try:
            val = float(toks[idx])
            idx += 1
        except:
            end_idx = idx
            while end_idx < len_ and toks_[end_idx] not in CLAUSE_KEYWORDS:
                end_idx += 1

            idx, val = parse_col_unit(toks[start_idx: end_idx], 0, labels_with_alias, schema, default_tables)
            idx = end_idx
    return idx, val

def parse_condition(toks, start_idx, labels_with_alias, schema, default_tables=None):
    idx = start_idx
    len_ = len(toks)
    toks_ = [tok[1].lower() for tok in toks]
    conds = []
    
    while idx < len_ and toks_[idx] not in CLAUSE_KEYWORDS:

        if  toks_[idx] in ['and', 'or']:
            conds.append(toks[idx][1])
            idx += 1  # skip and/or=
        idx, val_unit = parse_val_unit(toks, idx, labels_with_alias, schema, default_tables)
        not_op = False
        if toks_[idx] == 'not':
            not_op = True
            idx += 1
        if toks[idx][0] in ['Token.Punctuation', 'Token.Text.Whitespace']:
            idx+=1
        assert idx < len_ and toks_[idx] in WHERE_OPS, "Error condition: idx: {}, tok: {}".format(idx, toks[idx])
        op_id = WHERE_OPS.index(toks_[idx])
        idx += 1
        val = None
        idx, val = parse_value(toks, idx, labels_with_alias, schema, default_tables)
        conds.append((not_op, op_id, val_unit, val))
        if idx < len_ and (toks_[idx] in CLAUSE_KEYWORDS or toks_[idx] in (";") ):
            break
        idx += 1  # skip and/or
    return idx, conds

def parse_table_unit(toks, start_idx, labels_with_alias, schema):
    """
        :returns next idx, table id, table name
    """
    idx = start_idx
    len_ = len(toks)
    schema_key = labels_with_alias[toks[idx][1]]
    table_alias = toks[idx][1]

    if idx + 2 < len_ and toks[idx+2][0] == "Token.Name.Label":
        idx += 3
    else:
        idx += 1

    return idx, schema.idMap[schema_key], table_alias 

def parse_match(toks, start_idx, labels_with_alias, schema):
    """
        :returns next idx, table_units, default_tables
        where table_units = [TABLE_TYPE['cypher']/TABLE_TYPE['table_unit], table_unit)], 
        and   table_unit = schmea.idMap[schema_key]
    """
    """
    Assume in the from clause, all table units are combined with join
    """
    toks_ = [tok[1].lower() for tok in toks]
    assert 'match' in toks_[start_idx:], "'match' not found"

    len_ = len(toks)
    idx = toks_.index('match', start_idx) + 1
    default_tables = []
    table_units = []

    while idx < len_:

        if toks_[idx] == 'match':
            idx, parsed_cypher = parse_cypher(toks, idx, labels_with_alias, schema)
            table_units.append((TABLE_TYPE['cypher'], parsed_cypher))
        else:
            if idx < len_ and toks[idx][0] in ['Token.Punctuation', 'Token.Text.Whitespace' ]:
                idx += 1  # skip whitespace and edge indicators
            if toks[idx][0]=='Token.Name.Variable':
                idx, table_unit, table_name = parse_table_unit(toks, idx, labels_with_alias, schema)
                table_units.append((TABLE_TYPE['table_unit'],table_unit))
                default_tables.append(table_name)

        if idx < len_ and ((toks_[idx] in CLAUSE_KEYWORDS or toks_[idx] in (";"))):
            break
        else:
            idx+=1

    return idx, table_units, default_tables

def parse_with(toks, start_idx, labels_with_alias, schema):
    """
        :returns next idx, with_units
        where with_units = [with_unit], 
        and   with_unit = (agg_id, alias_name, col_id, isDistinct)
    """
    toks_ = [tok[1].lower() for tok in toks]
    len_ = len(toks)
    idx = start_idx
    isDistinct = False

    if idx>=len_ or toks_[idx]!='with':
        return idx, []
    
    idx+=1
    as_ids = [idx for idx, tok in enumerate(toks_) if tok == 'as']
    with_units = []
    agg_id = AGG_OPS.index('none')
    for id in as_ids:
        while idx <  len_:
            if idx < len_ and toks[idx][0] in ['Token.Punctuation', 'Token.Text.Whitespace' ]:
                idx += 1  # skip whitespace and edge indicators
            if toks[idx][0]=='Token.Name.Function':
                agg_id = AGG_OPS.index(toks_[idx])
                if  'distinct' in toks_[idx: id]:
                    idx+=toks_[idx:id].index('distinct')
                    isDistinct=True
                if '*' in toks_[idx:id]:
                    with_unit = (agg_id, toks[id+2][1], schema.idMap['*'], isDistinct)
                    with_units.append(with_unit)
                    idx+= toks_[idx:id].index('*')
            if idx+2< len_ and toks[idx][0]=='Token.Name.Variable':
                if toks[idx+1][0]=='Token.Operator':      
                    key = labels_with_alias[toks[idx][1]]
                    schema_key = '{}.{}'.format(key, toks[idx+2][1])
                    with_unit =( agg_id, toks[id+2][1], schema.idMap[schema_key], isDistinct)
                    with_units.append(with_unit)
                    idx = id+3
                else:
                    idx+=1
                break

            if idx < len_ and (toks_[idx] in CLAUSE_KEYWORDS or toks_[idx] in ( ";") ):
                break
            else:
                idx+=1
    return idx, with_units

def parse_where(toks, start_idx, labels_with_alias, schema, default_tables):
    idx = start_idx
    len_ = len(toks)
    toks_ = [tok[1].lower() for tok in toks]
    if idx >= len_ or toks_[idx] != 'where':
        return idx, []

    idx += 1
    idx, conds = parse_condition(toks, idx, labels_with_alias, schema, default_tables)

    return idx, conds

def parse_return(toks, start_idx, labels_with_alias, schema, default_tables=None):
    toks_ = [tok[1].lower() for tok in toks]
    idx = start_idx
    len_ = len(toks)
    assert 'return' in toks_[idx:], "'return' not found"

    idx = toks_.index('return', idx)+1
    isDistinct = False

    if idx < len_ and toks[idx] == 'distinct':
        idx += 1
        isDistinct = True
    val_units = []

    while idx < len_ and toks_[idx] not in CLAUSE_KEYWORDS:
        if idx < len_ and toks[idx][0] in ['Token.Punctuation', 'Token.Text.Whitespace' ]:
            idx += 1  
        agg_id = AGG_OPS.index("none")
        if toks_[idx] in AGG_OPS and toks[idx][0]=='Token.Name.Function':
            agg_id = AGG_OPS.index(toks_[idx])
            idx += 1
        idx, val_unit = parse_val_unit(toks, idx, labels_with_alias, schema, default_tables)
        val_units.append((agg_id, val_unit))
        if idx < len_ and toks[idx][0] in ['Token.Punctuation', 'Token.Text.Whitespace' ]:
            idx += 1  
    return idx, (isDistinct, val_units)

def parse_order_by(toks, start_idx, labels_with_alias, schema, default_tables):
    """
        :returns next idx, (order_type, val_units), \
            where val_units = (unit_op, col_unit1, col_unit2), \
            and   col_unit  = (agg_id, col_id, isDistinct), \
            and   col_id    = schema.idMap[key]
    """
    toks_ = [tok[1].lower() for tok in toks]
    idx = start_idx
    len_ = len(toks)
    val_units = []  

    order_type = "asc"  # default type is 'asc'
    if idx>=len_ or toks_[idx]!='order by':
        return idx, val_units
    idx+=1 

    while idx<len_ and not (toks_[idx] in CLAUSE_KEYWORDS or toks_[idx] in ( ";")):
        idx, val_unit = parse_val_unit(toks, idx, labels_with_alias, schema, default_tables)
        print(f'val_unit: {val_unit}')
        val_units.append(val_unit)
        if idx < len_ and toks_[idx] in ORDER_OPS:
            order_type = toks_[idx]
            idx += 1
        if idx < len_ and toks[idx][0] in ['Token.Punctuation', 'Token.Text.Whitespace' ]:
            idx += 1  # skip ','
        else:
            break

    return idx, (order_type, val_units)

def parse_limit(toks, start_idx):
    idx = start_idx
    len_ = len(toks)
    toks_ = [tok[1].lower() for tok in toks]
    idx+=1
    while idx < len_:
        if idx < len_ and toks[idx][0] in ['Token.Punctuation', 'Token.Text.Whitespace' ]:
            idx += 1  # skip ','
        if toks[idx][0].startswith('Token.Literal.Number'):
            return  idx, int(toks_[idx])
        if idx < len_ and  toks_[idx] in CLAUSE_KEYWORDS:
            break
        idx+=1

    return idx, None

def parse_cypher(toks, start_idx, labels_with_alias, schema):
    idx = start_idx 
    cypher = {}
    
    # parse 'match' clause
    match_end_idx, table_units, default_tables = parse_match(toks, start_idx, labels_with_alias, schema)
    cypher['match'] = {'table_units': table_units}

    # parse 'with' clause
    idx = match_end_idx
    idx, with_units = parse_with(toks, idx, labels_with_alias, schema)
    cypher['with'] = with_units   #(agg_id, alias_name, col_id, isDistinct)

    # TODO: parse 'where' clause
    idx, where_conds = parse_where(toks, idx, labels_with_alias, schema, default_tables)
    cypher['where'] = where_conds

    idx, return_col_units = parse_return(toks, idx, labels_with_alias, schema, default_tables)
    cypher['return']=return_col_units
    # order by clause
    idx, order_col_units = parse_order_by(toks, idx, labels_with_alias, schema, default_tables)
    cypher['order by'] = order_col_units

    # limit clause
    idx, limit_val = parse_limit(toks, idx)
    cypher["limit"] = limit_val

    print(f'cypher: {cypher}')

    idx = skip_semicolon(toks, idx)

    return idx, cypher



def get_cypher(schema, query):
    toks = tokenize(query)
    labels_with_alias = scan_labels_with_alias(schema.schema, toks)  #schema.schema: dict
    _, cypher = parse_cypher(toks, 0, labels_with_alias, schema)
    return cypher


def skip_semicolon(toks, start_idx):
    idx = start_idx
    while idx < len(toks) and toks[idx] == ";":
        idx += 1
    return idx


def skip_semicolon(toks, start_idx):
    idx = start_idx
    while idx < len(toks) and toks[idx] == ";":
        idx += 1
    return idx
