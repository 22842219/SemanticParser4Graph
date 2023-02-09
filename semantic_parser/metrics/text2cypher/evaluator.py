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


        if isValidCypher(predicted, self.graph):
            print(f"self.scores[exec]: {self.scores['exec']}")
            print("hyyyyyyy check it out:", eval_exec_match(
                self.graph, predicted, gold))
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
            print(f'heyyyyyyyyyyy preds befor split: {preds}')
            preds = [pred.split("|", 1)[-1].strip() for pred in preds]
            print(f'heyyyyyyyyyyy preds in evaluator: {preds}')

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

    p_res=[]
    for dict_p in prediction_res:
        p_res.append(tuple(dict_p.values()))
    

    # sort results for the comparision
    print(f'q_res: {q_res}')
    print(f'p_res: {p_res}')
    p_sorted = sorted(p_res, key=lambda x: x[0])
    q_sorted =  sorted(q_res, key=lambda x: x[0]) 
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
