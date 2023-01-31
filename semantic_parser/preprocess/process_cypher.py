################################
# Assumptions:
#   1. cypher is correct
#   2. only table name has alias
#
# val: number(float)/string(str)/cypher(dict)
# col_unit: (agg_id, col_id, isDistinct(bool))
# val_unit: (unit_op, col_unit1, col_unit2)
# table_unit: (table_type, col_unit/cypher)
# cond_unit: (not_op, op_id, val_unit, val1, val2)
# condition: [cond_unit1, 'and'/'or', cond_unit2, ...]
# cypher {
#   'return': (isDistinct(bool), [(agg_id, val_unit), (agg_id, val_unit), ...])
#   'match': {'table_units': [table_unit1, table_unit2, ...], 'conds': condition}
#   'where': condition
#   'orderBy': ('asc'/'desc', [val_unit1, val_unit2, ...])
#   'having': condition
#   'limit': None/limit value
# }
################################

import json, re
from nltk import word_tokenize

alias_pattern = re.compile(r'(t[1-9]|[a-z])')	
labels_pattern = re.compile(r':`[a-z|A-Z].*`')

CLAUSE_KEYWORDS = ('match', 'where', 'with', 'return', 'order', 'limit')

WHERE_OPS = ('=', '>', '<', '>=', '<=', '<>', 'in', "~'.*")  # "~.'.* -> like"
UNIT_OPS = ('none', '-', '+', "*", '/')
AGG_OPS = ('none', 'max', 'min', 'count', 'sum', 'avg')
TABLE_TYPE = {
    'cypher': "cypher",
    'table_unit': "table_unit",
}

COND_OPS = ('and', 'or')
# CYPHER_OPS = ('intersect', 'union', 'except')
ORDER_OPS = ('desc', 'asc')

class Schema:
    """
    Simple schema which maps graph nodes/edges and their properties to a unique identifier
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
        idMap = {'*': "__all__"}
        id = 1
        for key, vals in schema.items():
            for val in vals:
                if val is None:
                    continue
                idMap[key.lower() + "." + val.lower()] = "__" + key.lower() + "." + val.lower() + "__"
                id += 1

        for key in schema:
            idMap[key.lower()] = "__" + key.lower() + "__"
            id += 1

        return idMap


def get_schema_from_json(fpath):
    """
    Get the graph database's schema, which is a dict with the key in the format of :`db_name.tb_name`, e.g., :`department_management.head`
    and list of property names as value
    :param file: the schema json file
    :return: schema dict
    """

    with open(fpath) as reader:
        schema = json.load(reader)
        return schema


def tokenize(string):
    print("+++++++++++++++++++++++++++++++++tokenize++++++++++++++++++++++++++++++")
    string = str(string) #SELECT count(*) FROM singer --> match (n:`singer.singer`) return count(*)
    string = string.replace("\'", "\"")  # ensures all string values wrapped by "" problem??
    quote_idxs = [idx for idx, char in enumerate(string) if char == '"'] #[]
    assert len(quote_idxs) % 2 == 0, "Unexpected quote"

    # keep string value as token
    vals = {}
    for i in range(len(quote_idxs)-1, -1, -2):
        qidx1 = quote_idxs[i-1]
        qidx2 = quote_idxs[i]
        val = string[qidx1: qidx2+1]
        key = "__val_{}_{}__".format(qidx1, qidx2)
        string = string[:qidx1] + key + string[qidx2+1:]
        vals[key] = val
 
    toks=[]
    chunk_start_id=0
    for id, tok in enumerate(word_tokenize(string)):
        # print(f'id: {id}, tok: {tok}, chunk_start_id: {chunk_start_id}, {chunk_start_id+3}')
        if tok==':':
            chunk_start_id = id
            toks.append(''.join(word_tokenize(string)[id+1:id+4]).lower())
        elif  chunk_start_id==0:
            toks.append(tok.lower())
        elif  id > chunk_start_id+3:
            toks.append(tok.lower())
            
        if tok=='[':
            toks.pop()
            toks.pop()
            toks.append('-[')
        if word_tokenize(string)[id-1]==']':
            toks.pop()
            toks.pop()
            toks.append(']-')
       
    # replace with string value token
    for i in range(len(toks)):
        if toks[i] in vals:
            toks[i] = vals[toks[i]]

    # find if there exists !=, >=, <=
    eq_idxs = [idx for idx, tok in enumerate(toks) if tok == "="]
    eq_idxs.reverse()
    prefix = ('!', '>', '<')
    for eq_idx in eq_idxs:
        pre_tok = toks[eq_idx-1]
        if pre_tok in prefix:
            toks = toks[:eq_idx-1] + [pre_tok + "="] + toks[eq_idx+1: ]
    return toks


def scan_alias(toks):
    """Scan the index of 'as' and build the map for all alias"""
    alias_idxs = [idx for idx, tok in enumerate(toks) if tok.startswith(':`')]
    alias = {}
    for idx in alias_idxs:
        if re.fullmatch(alias_pattern, toks[idx-1].lower()):
            alias[toks[idx - 1]] = toks[idx]
    return alias


def get_tables_with_alias(schema, toks):
    tables = scan_alias(toks)
    print(f'scan tables: {tables}')
    existing = list(tables.values())
    for tok in toks:
        if tok.startswith(':`'):
            domain = tok.split('.')[0]
    for key in schema:
        if key.startswith(domain):
            assert key not in tables, "Alias {} has the same name in table".format(key)
            alias = key.strip('`').split('.')[-1] 
            if key not in existing:
                tables[alias] = key
    return tables


def parse_col(toks, start_idx, tables_with_alias, schema, default_tables=None):
    """
        :returns next idx, column id
    """
    tok = toks[start_idx]
    if tok == "*":
        return start_idx + 1, schema.idMap[tok]

    if '.' in tok:  # if token is a composite
        alias, col = tok.split('.')
        key = tables_with_alias[alias] + "." + col
        return start_idx+1, schema.idMap[key]

    assert default_tables is not None and len(default_tables) > 0, "Default tables should not be None or empty"

    for alias in default_tables:
        table = tables_with_alias[alias]
        if tok in schema.schema[table]:
            key = table + "." + tok
            return start_idx+1, schema.idMap[key]

    assert False, "Error col: {}".format(tok)


def parse_col_unit(toks, start_idx, tables_with_alias, schema, default_tables=None):
    """
        :returns next idx, (agg_op id, col_id)
    """
    idx = start_idx
    len_ = len(toks)
    isBlock = False
    isDistinct = False
    if toks[idx] == '(':
        isBlock = True
        idx += 1

    if toks[idx] in AGG_OPS:
        agg_id = AGG_OPS.index(toks[idx])
        idx += 1
        assert idx < len_ and toks[idx] == '('
        idx += 1
        if toks[idx] == "distinct":
            idx += 1
            isDistinct = True
        idx, col_id = parse_col(toks, idx, tables_with_alias, schema, default_tables)
        assert idx < len_ and toks[idx] == ')'
        idx += 1
        return idx, (agg_id, col_id, isDistinct)

    if toks[idx] == "distinct":
        idx += 1
        isDistinct = True
    agg_id = AGG_OPS.index("none")
    idx, col_id = parse_col(toks, idx, tables_with_alias, schema, default_tables)

    if isBlock:
        assert toks[idx] == ')'
        idx += 1  # skip ')'

    return idx, (agg_id, col_id, isDistinct)


def parse_val_unit(toks, start_idx, tables_with_alias, schema, default_tables=None):
    idx = start_idx
    len_ = len(toks)
    isBlock = False
    if toks[idx] == '(':
        isBlock = True
        idx += 1

    col_unit1 = None
    col_unit2 = None
    unit_op = UNIT_OPS.index('none')

    idx, col_unit1 = parse_col_unit(toks, idx, tables_with_alias, schema, default_tables)
    if idx < len_ and toks[idx] in UNIT_OPS:
        unit_op = UNIT_OPS.index(toks[idx])
        idx += 1
        idx, col_unit2 = parse_col_unit(toks, idx, tables_with_alias, schema, default_tables)

    if isBlock:
        assert toks[idx] == ')'
        idx += 1  # skip ')'

    return idx, (unit_op, col_unit1, col_unit2)


def parse_table_unit(toks, start_idx, tables_with_alias, schema):
    """
        :returns next idx, table id, table name
    """

    idx = start_idx
    len_ = len(toks)
    
    key = tables_with_alias[toks[idx]]
    print(f'parse table unit, idx: {idx}, len_: {len_}, toks[idx]: {toks[idx]}')
    print(f'key: {key}, schema.idMap[key]: {schema.idMap[key]}')
    if re.fullmatch(alias_pattern, toks[idx]):
        idx += 2
    else:
        idx += 1
    
    return idx, schema.idMap[key], key


def parse_value(toks, start_idx, tables_with_alias, schema, default_tables=None):
    idx = start_idx
    len_ = len(toks)

    isBlock = False
    if toks[idx] == '(':
        isBlock = True
        idx += 1

    if toks[idx] == 'return':
        idx, val = parse_cypher(toks, idx, tables_with_alias, schema)
    elif "\"" in toks[idx]:  # token is a string value
        val = toks[idx]
        idx += 1
    else:
        try:
            val = float(toks[idx])
            idx += 1
        except:
            end_idx = idx
            while end_idx < len_ and toks[end_idx] != ',' and toks[end_idx] != ')'\
                and toks[end_idx] != 'and' and toks[end_idx] not in CLAUSE_KEYWORDS and toks[end_idx] not in JOIN_KEYWORDS:
                    end_idx += 1

            idx, val = parse_col_unit(toks[start_idx: end_idx], 0, tables_with_alias, schema, default_tables)
            idx = end_idx

    if isBlock:
        assert toks[idx] == ')'
        idx += 1

    return idx, val


def parse_condition(toks, start_idx, tables_with_alias, schema, default_tables=None):
    idx = start_idx
    len_ = len(toks)
    conds = []

    while idx < len_:
        idx, val_unit = parse_val_unit(toks, idx, tables_with_alias, schema, default_tables)
        not_op = False
        if toks[idx] == 'not':
            not_op = True
            idx += 1

        assert idx < len_ and toks[idx] in WHERE_OPS, "Error condition: idx: {}, tok: {}".format(idx, toks[idx])
        op_id = WHERE_OPS.index(toks[idx])
        idx += 1
        val1 = val2 = None
        if op_id == WHERE_OPS.index('between'):  # between..and... special case: dual values
            idx, val1 = parse_value(toks, idx, tables_with_alias, schema, default_tables)
            assert toks[idx] == 'and'
            idx += 1
            idx, val2 = parse_value(toks, idx, tables_with_alias, schema, default_tables)
        else:  # normal case: single value
            idx, val1 = parse_value(toks, idx, tables_with_alias, schema, default_tables)
            val2 = None

        conds.append((not_op, op_id, val_unit, val1, val2))

        if idx < len_ and (toks[idx] in CLAUSE_KEYWORDS or toks[idx] in (")", ";") or toks[idx] in JOIN_KEYWORDS):
            break

        if idx < len_ and toks[idx] in COND_OPS:
            conds.append(toks[idx])
            idx += 1  # skip and/or

    return idx, conds


def parse_match(toks, start_idx, tables_with_alias, schema):

    assert 'match' in toks[start_idx:], "'match' not found"

    len_ = len(toks)
    idx = toks.index('match', start_idx) + 2
    default_tables = []
    table_units = []
    conds = []

    while idx < len_:
        print(idx, toks[idx],len_)
        if toks[idx] == 'union': # TODO
            idx, cypher = parse_cypher(toks, idx, tables_with_alias, schema)
            table_units.append((TABLE_TYPE['cypher'], cypher))
        else:
            if idx < len_ and toks[idx] == '-[' and toks[idx+1] ==']-':
                idx += 3  # skip edge and the right bracket of tail node pattern
            if re.fullmatch(labels_pattern, toks[idx]):
                table_unit = schema.idMap(toks[idx])
                table_units.append((TABLE_TYPE['table_unit'],table_unit))
                idx+=1
            
        if re.fullmatch(alias_pattern, toks[idx]):
            idx, table_unit, table_name = parse_table_unit(toks, idx, tables_with_alias, schema)
            table_units.append((TABLE_TYPE['table_unit'],table_unit))
            default_tables.append(table_name)
            idx+=1

        if idx < len_ and toks[idx] in CLAUSE_KEYWORDS:
            break

    return idx, table_units, conds, default_tables

def parse_with_as(toks, start_idx, tables_with_alias, schema, default_tables):
    idx = start_idx
    len_ = len(toks)

    if idx >= len_ or toks[idx] != 'with':
        return idx, []

    idx += 1
    idx, conds = parse_condition(toks, idx, tables_with_alias, schema, default_tables)
    return idx, conds


def parse_where(toks, start_idx, tables_with_alias, schema, default_tables):
    idx = start_idx
    len_ = len(toks)

    if idx >= len_ or toks[idx] != 'where':
        return idx, []

    idx += 1
    idx, conds = parse_condition(toks, idx, tables_with_alias, schema, default_tables)
    return idx, conds



def parse_return(toks, start_idx, tables_with_alias, schema, default_tables=None):
    idx = start_idx
    len_ = len(toks)
    print(f'parse_return: idx:{idx}, len_:{len_}, toks[idx]: {toks[idx]}')

    assert toks[idx] == 'return', "'return' not found"
    idx += 1
    isDistinct = False

    if idx < len_ and toks[idx] == 'distinct':
        idx += 1
        isDistinct = True
    val_units = []

    while idx < len_ and toks[idx] not in CLAUSE_KEYWORDS:
        agg_id = AGG_OPS.index("none")
        if toks[idx] in AGG_OPS:
            agg_id = AGG_OPS.index(toks[idx])
            print("heyyy return/toks[idx]", toks[idx]) # count
            print("agg_id:", agg_id) #3
            idx += 1
        idx, val_unit = parse_val_unit(toks, idx, tables_with_alias, schema, default_tables)
        print("val_unit, idx:", val_unit, idx) #(0, (0, '__all__', False), None), 5
        val_units.append((agg_id, val_unit))
        if idx < len_ and toks[idx] == ',':
            idx += 1  # skip ','
    return idx, (isDistinct, val_units)


def parse_order_by(toks, start_idx, tables_with_alias, schema, default_tables):
    idx = start_idx
    len_ = len(toks)
    val_units = []
    order_type = "asc"  # default type is 'asc'

    if idx >= len_ or toks[idx] != "order":
        return idx, val_units

    idx += 1
    assert toks[idx] == "by"
    idx += 1

    while idx < len_ and not (toks[idx] in CLAUSE_KEYWORDS or toks[idx] in (")", ";")):
        idx, val_unit = parse_val_unit(
            toks, idx, tables_with_alias, schema, default_tables
        )
        val_units.append(val_unit)
        if idx < len_ and toks[idx] in ORDER_OPS:
            order_type = toks[idx]
            idx += 1
        if idx < len_ and toks[idx] == ",":
            idx += 1  # skip ','
        else:
            break

    return idx, (order_type, val_units)


def parse_limit(toks, start_idx):
    idx = start_idx
    len_ = len(toks)

    if idx < len_ and toks[idx] == "limit":
        idx += 2
        return idx, int(toks[idx - 1])

    return idx, None

def parse_cypher(toks, start_idx, tables_with_alias, schema):
    isBlock = False # indicate whether this is a block of cypher/sub-cypher
    len_ = len(toks) 
    idx = start_idx 

    cypher = {}
    if toks[idx] == '(':
        isBlock = True
        idx += 1

    # parse match clause in order to get default tables
    match_end_idx, table_units, conds, default_tables = parse_match(toks, start_idx, tables_with_alias, schema)
    cypher['match'] = {'table_units': table_units, 'conds': conds}

    print(f'toks: {toks}')
    print(f'tables_with_alis: {tables_with_alias}')
    print(f'match start_idx: {start_idx}, match_end_idx: {match_end_idx}' ) 
    print(f'table_units: {table_units}, conds: {conds}, default_tables: {default_tables}')
    print(f'cypher: {cypher}')

    # where clause
    idx = match_end_idx
    idx, where_conds = parse_where(toks, idx, tables_with_alias, schema, default_tables)
    cypher['where'] = where_conds #[]

    print(f'default_tables in where: {default_tables}')
    print(f'where_end_idx: {idx}, where_conds: {where_conds}')
    print(f'cypher: {cypher}')

    # return clause
    _, return_col_units = parse_return(toks, idx, tables_with_alias, schema, default_tables)
    cypher['return'] = return_col_units

    print(f'return_col_units: {return_col_units}')

    # order by clause
    idx, order_col_units = parse_order_by(
        toks, idx, tables_with_alias, schema, default_tables
    )
    cypher["orderBy"] = order_col_units
    print(f'idx in order by: {idx}, order_col_units: {order_col_units}')
    print(f'cypher: {cypher}')


    # limit clause
    idx, limit_val = parse_limit(toks, idx)
    cypher["limit"] = limit_val

    print(f'idx in limit: {idx}')
    print(f'cypher: {cypher}')

    idx = skip_semicolon(toks, idx)
    if isBlock:
        assert toks[idx] == ")"
        idx += 1  # skip ')'
    idx = skip_semicolon(toks, idx)



    return idx, cypher



def get_cypher(schema, query):
    toks = tokenize(query)
    tables_with_alias = get_tables_with_alias(schema.schema, toks)  #schema.schema: dict
    _, cypher = parse_cypher(toks, 0, tables_with_alias, schema)
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
