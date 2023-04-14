################################
# Assumptions:
#   1. cypher is correct
#   2. only a graph node label/graph edge type has alias
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
    
    alias = {}
    for idx, tok in enumerate(toks):
        if tok[0]=='Token.Name.Variable' and idx+2<len(toks)-1 and \
            (toks[idx+1][0]=='Token.Punctuation' and toks[idx+1][1] in [':', '.'] or \
                toks[idx+1]==('Token.Operator', '.')) and \
                    idx<len(toks)-2 and toks[idx+2][0]=='Token.Name.Label':
                    alias[tok[1]]=toks[idx+2][1]
    len_ = len(toks)
    toks_ = [tok[1].lower() for tok in toks]
    as_idxs = [idx for idx, tok in enumerate(toks) if tok==('Token.Keyword', 'AS')]
    with_ids =  [idx for idx, tok in enumerate(toks) if tok==('Token.Keyword', 'WITH')]
    for with_idx in with_ids:
        idx = with_idx +1
        att = ''
        while idx < len_:
            if idx<len_ and toks[idx][0] in ['Token.Text.Whitespace']:
                idx+=1

            if idx+2<len_ and toks[idx][0]=='Token.Name.Variable' and toks[idx+1]==('Token.Operator','.'):
                # sort out new variables containing the results of expressions in the scope
                att = toks[idx+2][1]
                key = toks[idx][1]
                att = ':{}.{}'.format(alias[key], att)
                idx+=2 #

            if idx in as_idxs and idx+2<len_ and len(att)>0:
                alias[toks[idx+2][1]] = att
                att = ''           

            if idx<len_ and (toks_[idx] in CLAUSE_KEYWORDS):
                break
            else:
                idx+=1            
    return alias


def parse_col(toks, start_idx, labels_with_alias, schema, default_tables=None):
    """
        :returns next idx, column id
    """
    tok = toks[start_idx]
    if tok == "*":
        return start_idx + 1, schema.idMap[tok]

    if '.' in tok:  # if token is a composite
        alias, col = tok.split('.')
        key = labels_with_alias[alias] + "." + col
        return start_idx+1, schema.idMap[key]

    assert default_tables is not None and len(default_tables) > 0, "Default tables should not be None or empty"

    for alias in default_tables:
        table = labels_with_alias[alias]
        if tok in schema.schema[table]:
            key = table + "." + tok
            return start_idx+1, schema.idMap[key]

    assert False, "Error col: {}".format(tok)


def parse_col_unit(toks, start_idx, labels_with_alias, schema, default_tables=None):
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
        idx, col_id = parse_col(toks, idx, labels_with_alias, schema, default_tables)
        assert idx < len_ and toks[idx] == ')'
        idx += 1
        return idx, (agg_id, col_id, isDistinct)

    if toks[idx] == "distinct":
        idx += 1
        isDistinct = True
    agg_id = AGG_OPS.index("none")
    idx, col_id = parse_col(toks, idx, labels_with_alias, schema, default_tables)

    if isBlock:
        assert toks[idx] == ')'
        idx += 1  # skip ')'

    return idx, (agg_id, col_id, isDistinct)

def parse_table_unit(toks, start_idx, labels_with_alias, schema):
    """
        :returns next idx, table id, table name
    """
    idx = start_idx
    len_ = len(toks)
    key = labels_with_alias[toks[idx][1]]

    if idx + 2 < len_ and toks[idx+2][0] == "Token.Name.Label":
        idx += 3
    else:
        idx += 1

    return idx, schema.idMap[key], key 


def parse_val_unit(toks, start_idx, labels_with_alias, schema, default_tables=None):
    idx = start_idx
    len_ = len(toks)
    isBlock = False
    if toks[idx] == '(':
        isBlock = True
        idx += 1

    col_unit1 = None
    col_unit2 = None
    unit_op = UNIT_OPS.index('none')

    idx, col_unit1 = parse_col_unit(toks, idx, labels_with_alias, schema, default_tables)
    if idx < len_ and toks[idx] in UNIT_OPS:
        unit_op = UNIT_OPS.index(toks[idx])
        idx += 1
        idx, col_unit2 = parse_col_unit(toks, idx, labels_with_alias, schema, default_tables)

    if isBlock:
        assert toks[idx] == ')'
        idx += 1  # skip ')'

    return idx, (unit_op, col_unit1, col_unit2)


def parse_value(toks, start_idx, labels_with_alias, schema, default_tables=None):
    idx = start_idx
    len_ = len(toks)

    isBlock = False
    if toks[idx] == '(':
        isBlock = True
        idx += 1

    if toks[idx] == 'return':
        idx, val = parse_cypher(toks, idx, labels_with_alias, schema)
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

            idx, val = parse_col_unit(toks[start_idx: end_idx], 0, labels_with_alias, schema, default_tables)
            idx = end_idx

    if isBlock:
        assert toks[idx] == ')'
        idx += 1

    return idx, val


def parse_condition(toks, start_idx, labels_with_alias, schema, default_tables=None):
    idx = start_idx
    len_ = len(toks)
    conds = []

    while idx < len_:
        idx, val_unit = parse_val_unit(toks, idx, labels_with_alias, schema, default_tables)
        not_op = False
        if toks[idx] == 'not':
            not_op = True
            idx += 1

        assert idx < len_ and toks[idx] in WHERE_OPS, "Error condition: idx: {}, tok: {}".format(idx, toks[idx])
        op_id = WHERE_OPS.index(toks[idx])
        idx += 1
        val1 = val2 = None
        if op_id == WHERE_OPS.index('between'):  # between..and... special case: dual values
            idx, val1 = parse_value(toks, idx, labels_with_alias, schema, default_tables)
            assert toks[idx] == 'and'
            idx += 1
            idx, val2 = parse_value(toks, idx, labels_with_alias, schema, default_tables)
        else:  # normal case: single value
            idx, val1 = parse_value(toks, idx, labels_with_alias, schema, default_tables)
            val2 = None

        conds.append((not_op, op_id, val_unit, val1, val2))

        if idx < len_ and (toks[idx] in CLAUSE_KEYWORDS or toks[idx] in (")", ";") or toks[idx] in JOIN_KEYWORDS):
            break

        if idx < len_ and toks[idx] in COND_OPS:
            conds.append(toks[idx])
            idx += 1  # skip and/or

    return idx, conds


def parse_match(toks, start_idx, labels_with_alias, schema):
    # parse "match" clause in order to get default entity labels (i.e., graph node labels/edge types
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
        
        # if idx < len_ and toks_[idx] == "with":
        #     idx += 1  # skip with
        #     idx, this_conds = parse_condition(toks, idx, labels_with_alias, schema, default_tables)
        #     if len(conds) > 0:
        #         conds.append('and')
        #     conds.extend(this_conds)

        if idx < len_ and ((toks_[idx] in CLAUSE_KEYWORDS or toks_[idx] in (";"))):
            break
        else:
            idx+=1

    return idx, table_units, default_tables


def parse_where(toks, start_idx, labels_with_alias, schema, default_tables):
    idx = start_idx
    len_ = len(toks)

    if idx >= len_ or toks[idx] != 'where':
        return idx, []

    idx += 1
    idx, conds = parse_condition(toks, idx, labels_with_alias, schema, default_tables)
    return idx, conds


def parse_return(toks, start_idx, labels_with_alias, schema, default_tables=None):
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
        idx, val_unit = parse_val_unit(toks, idx, labels_with_alias, schema, default_tables)
        print("val_unit, idx:", val_unit, idx) #(0, (0, '__all__', False), None), 5
        val_units.append((agg_id, val_unit))
        if idx < len_ and toks[idx] == ',':
            idx += 1  # skip ','
    return idx, (isDistinct, val_units)


def parse_order_by(toks, start_idx, labels_with_alias, schema, default_tables):
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
            toks, idx, labels_with_alias, schema, default_tables
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

def parse_cypher(toks, start_idx, labels_with_alias, schema):
    idx = start_idx 
    cypher = {}
    
    # parse 'match' clause
    match_end_idx, table_units, conds, default_tables = parse_match(toks, start_idx, labels_with_alias, schema)
    cypher['match'] = {'table_units': table_units, 'conds': conds}

    # parse 'with' clause
    idx = match_end_idx
    idx, with_col_units = parse_with(toks, idx, labels_with_alias, schema, default_tables)
    cypher['with'] = with_col_units

    # parse 'where' clause
    idx, where_conds = parse_where(toks, idx, labels_with_alias, schema, default_tables)
    cypher['where'] = where_conds

    # return clause
    _, return_col_units = parse_return(toks, idx, labels_with_alias, schema, default_tables)
    cypher['return'] = return_col_units

    print(f'return_col_units: {return_col_units}')

    # order by clause
    idx, order_col_units = parse_order_by(
        toks, idx, labels_with_alias, schema, default_tables
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
