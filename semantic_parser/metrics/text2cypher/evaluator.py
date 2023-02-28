################################
# val: number(float)/string(str)/cypher(dict)
# col_unit: (agg_id, col_id, isDistinct(bool))
# val_unit: (unit_op, col_unit1, col_unit2)
# table_unit: (table_type, col_unit/cypher)
# cond_unit: (not_op, op_id, val_unit, val1, val2)
# condition: [cond_unit1, 'and'/'or', cond_unit2, ...]
# cypher {
#   'match': (isDistinct(bool), [(agg_id, val_unit), (agg_id, val_unit), ...])
#   'from': {'table_units': [table_unit1, table_unit2, ...], 'conds': condition}
#   'where': condition
#   'groupBy': [col_unit1, col_unit2, ...]
#   'orderBy': ('asc'/'desc', [val_unit1, val_unit2, ...])
#   'having': condition
#   'limit': None/limit value
#   'intersect': None/cypher
#   'except': None/cypher
#   'union': None/cypher
# }
################################

import os, sys
import json
import traceback
import argparse
from typing import Dict, Any
# sys.path.append('../..')
# from seq2seq_construction.bridge_content_encoder import get_database_matches


from py2neo import Graph
import configparser
config = configparser.ConfigParser()
config.read('/home/22842219/Desktop/phd/SemanticParser4Graph/application/config.ini')
filenames = config["FILENAMES"]

neo4j_uri = filenames['neo4j_uri']
neo4j_user = filenames['neo4j_user']
neo4j_password = filenames['neo4j_password']
graph = Graph(neo4j_uri, auth = (neo4j_user, neo4j_password))

schema_fpath = '/home/22842219/Desktop/phd/SemanticParser4Graph/semantic_parser/data/text2cypher/schema.json'
with open(schema_fpath, 'r', encoding="utf-8") as f:
    schema = json.load(f)
    print(len(schema))

def prediction_normalisation(preds):
    # tag_pattern = re.compile(r'(`*.*`')	
    preds = preds.replace(" ` ", "`").replace(' -[', '-[').replace(']- ', ']-')
    print(f'preds: {preds}')
    mentioned_tag_prop_pairs = {}
    tag_span_start_id=tag_span_end_id = 0
    for id, c in enumerate(preds):
        if c == '`': 
            # the indicator starting postprocessing the predicted query, 
            # including the space sitting ahead of the graph nodes/edges and the case of property names regarding targeted labels/types
            if tag_span_start_id!=0:
                tag_span_end_id=id
                splits = preds[tag_span_start_id+1: tag_span_end_id].split('.')
                if len(splits)>=2:
                    db, tag = splits[:2]
                    # print("heyyy", splits[:2])
                    dbs = [db.lower() for db in schema.keys()]
                    if db.lower() in dbs:
                        db = list(schema.keys())[dbs.index(db.lower())]
                        lower_cased_tags = [original_tag.lower() for original_tag in schema[db]['tag_names_original']]
                        # 1) check the case sensitivity of tag names
                        if tag.lower() in lower_cased_tags:
                            tag_idx = lower_cased_tags.index(tag.lower())
                            # normalised the existing predicted tag names.
                            preds = preds.replace(preds[tag_span_start_id+1:tag_span_end_id], '{}.{}'.format(db, schema[db]['tag_names_original'][tag_idx]))
                            property_names = schema[db]['property_names']
                            mentioned_tag_prop_pairs[tag] = [ prop[1]  for prop in property_names if prop[0]==tag_idx]
                            # 2) check if any targeted property name is predicted and its capitalization. 
                    tag_span_end_id=0
            else:
                tag_span_start_id = id

    for tag, props in mentioned_tag_prop_pairs.items():
        # print(tag, props)
        for id, c in enumerate(preds):
            if c=='.' and preds[id-len(tag):id]==tag:
                if id+len(tag)+2 < len(preds) -1 and preds[id+1: id+len(tag)+2]!='{}`'.format(tag):
                    for prop in props:
                        # print("checking prop", prop, preds[id+1: id+1+len(prop)])
                        if preds[id+1: id+1+len(prop)].lower() ==prop.lower():
                            preds = preds.replace(preds[id+1:id+1+len(prop)], prop)
    # print("finally: ", preds)
    return preds
    

class Evaluator:
    """A simple evaluator"""

    def __init__(self, graph, etype):
        self.graph = graph
        self.etype = etype

        self.scores = {
                "count": 0,
                "exec": 0,
        }

    def evaluate_one(self, gold, predicted):
        self.scores["count"] += 1
        syntactic_error = False

        # ZZY: TODO align the predicted field names with our graph database schema items, because Cypher query is case sensitive, 
        # but the tokenization of T5 family models seems not supporting to generate capitalized tokens. 
        # 1) remove the space between the specify token "`" and node labels/type edges.
        # 2) normalise the 
        predicted = predicted.replace(" ` ", "`")
        # print(f'post processed predicted by removing space: {predicted}')
        # print(f'gold query: {gold}')

        predicted = prediction_normalisation(predicted)
        # print(f'normalised_predicted: {predicted}')
        
        if isValidCypher(predicted, self.graph):
            # print(f"self.scores[exec]: {self.scores['exec']}")
            # print("hyyyyyyy check it out:", eval_exec_match(
            #     self.graph, predicted, gold))
            self.scores["exec"] += eval_exec_match(
                self.graph, predicted, gold)
        else:
            syntactic_error = True
            
        return {
            "predicted": predicted,
            "gold": gold,
            "syntactic_error": syntactic_error
        }

    def finalize(self):
        finalize(self.scores, self.etype)


def compute_execuation_acc_metric(predictions, references) -> Dict[str, Any]:
    evaluator = Evaluator(graph, "all")
    for prediction, reference in zip(predictions, references):
        turn_idx = reference.get("turn_idx", 0)
        # skip final utterance-query pairs
        if turn_idx < 0:
            continue
        _ = evaluator.evaluate_one( reference["query"], prediction)
    evaluator.finalize()
    return {
        "exectuation accuracy": evaluator.scores["exec"],
    }

class EvaluateTool(object):
    def __init__(self, args):
        self.args = args

    def evaluate(self, preds, golds, section):
    
        if self.args.seq2seq.target_with_db_id:
            # Remove database id from all predictions
            # print(f'heyyyyyyyyyyy preds befor split: {preds}')
            preds = [pred.split("|", 1)[-1].strip() for pred in preds]
            # print(f'heyyyyyyyyyyy preds in evaluator: {preds}')

        exact_match = compute_execuation_acc_metric(preds, golds)
        # test_suite = compute_test_suite_metric(preds, golds, db_dir=self.args.test_suite_db_dir)

        return {**exact_match}


def finalize(scores, etype):
    if scores["count"] == 0:
        pass
    if etype in ["all", "exec"]:
        scores["exec"] /= scores["count"]


def isValidCypher(cypher, graph):

    try:
        graph.run(cypher)
    except:
        return False
    return True


def print_scores(scores, etype):

    counts = scores["count"] 
    print(counts)
    print("{:20} {:<20d} ".format("count", counts))

    if etype in ["all", "exec"]:
        print("=====================   EXECUTION ACCURACY     =====================")
        this_scores = scores["exec"] 
        print(
            "{:20} {:<20.3f} ".format(
                "execution", this_scores
            )
        )

    # if etype in ["all", "match"]:
    #     print("\n====================== EXACT MATCHING ACCURACY =====================")
    #     exact_scores = scores["exact"] 
    #     print(
    #         "{:20} {:<20.3f}".format(
    #             "exact match", exact_scores
    #         )
    #     )


def evaluate(gold, predict, graph, etype):
    with open(gold) as f:
        glist = [l.strip().split("\t") for l in f.readlines() if len(l.strip()) > 0]

    with open(predict) as f:
        plist = [l.strip().split("\t") for l in f.readlines() if len(l.strip()) > 0]
    
    # plist = [("MATCH (T1:`concert_singer.concert`)-[]-(T2:`concert_singer.stadium`)\nWITH T2.Name AS Name, count(T1.Stadium_ID) AS count\nRETURN Name,count")]
    # glist = [("MATCH (T1:`concert_singer.concert`)-[]-(T2:`concert_singer.stadium`)\nWITH T2.Name AS Name, count(T1.Stadium_ID) AS count\nRETURN Name,count")]
    evaluator = Evaluator(graph, etype)
    results = []
    for predicted, gold in zip(plist, glist):
        results.append(evaluator.evaluate_one(gold, predicted))
    evaluator.finalize()

    print_scores(evaluator.scores, etype)
    return {
        "per_item": results,
        "total_scores": evaluator.scores,
    }


def eval_exec_match(graph, p_str, g_str):
    """
    return 1 if the values between prediction and gold are matching.
    """

    try:
        prediction_res = graph.run(p_str).data()
    except:
        return False

    cypher_res = graph.run(g_str).data()
    q_res = []
    for dict_q in cypher_res:
        q_res.append(tuple(dict_q.values()))
    # sort results for the comparision
    q_sorted = sorted(q_res, key=lambda x: x[0])


    p_res=[]
    for dict_p in prediction_res:
        p_res.append(tuple(dict_p.values()))
    # sort results for the comparision
    if not all(map(lambda x: all(x), p_res)): # check any of the element is None.
        return False
    else:
        p_sorted =  sorted(p_res, key=lambda x: x[0]) 


    print(f'q_res: {q_res}')
    print(f'p_res: {p_res}')
    print(f'sorted results. p_sorted: {p_sorted}, q_sorted: {q_sorted}')

        
    if not set(p_sorted)-set(q_sorted):
        return True
    else:
        return  False


def main(gold, pred, graph, etype, output):
    if etype not in [ 'exec', 'all']:
        raise ValueError()

    results = evaluate(gold, pred, graph, etype)
    if output:
        with open(output, "w") as f:
            json.dump(results, f)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--gold", dest="gold", type=str)
    parser.add_argument("--pred", dest="pred", type=str)
    parser.add_argument("--etype", dest="etype", type=str)
    parser.add_argument("--output")
    args = parser.parse_args()

    from py2neo import Graph
    import configparser
    config = configparser.ConfigParser()
    config.read('/home/22842219/Desktop/phd/SemanticParser4Graph/application/config.ini')
    filenames = config["FILENAMES"]

    neo4j_uri = filenames['neo4j_uri']
    neo4j_user = filenames['neo4j_user']
    neo4j_password = filenames['neo4j_password']
    graph = Graph(neo4j_uri, auth = (neo4j_user, neo4j_password))


    main(args.gold, args.pred, graph, args.etype, args.output)
