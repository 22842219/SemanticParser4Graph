################################
# val: number(float)/string(str)/cypher(dict)
# col_unit: (agg_id, col_id, isDistinct(bool))
# val_unit: (unit_op, col_unit1, col_unit2)
# table_unit: (table_type, col_unit/cypher)
# cond_unit: (not_op, op_id, val_unit, val1, val2)
# condition: [cond_unit1, 'and'/'or', cond_unit2, ...]
# cypher {
#   'select': (isDistinct(bool), [(agg_id, val_unit), (agg_id, val_unit), ...])
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
        if isValidCypher(predicted, self.graph):

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
        p_res = graph.run(p_str).data()
    except:
        return False

    q_res = graph.run(g_str)

    # sort results for the comparision
    p_sorted = sorted(p_res, key=lambda x: x[0])
    q_sorted =  sorted(q_res, key=lambda x: x[0]) 
    
    if not set(p_sorted)-set(q_sorted):
        return True



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
