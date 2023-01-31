"""Spider exact match metric."""
"""Borrow from the PICARD code"""
from typing import Dict, Any
from semantic_parser.metrics.text2cypher.evaluation import evaluation as text2cypher_evaluation

from py2neo import Graph
import configparser
config = configparser.ConfigParser()
config.read('/home/22842219/Desktop/phd/SemanticParser4Graph/application/config.ini')
filenames = config["FILENAMES"]

neo4j_uri = filenames['neo4j_uri']
neo4j_user = filenames['neo4j_user']
neo4j_password = filenames['neo4j_password']
graph = Graph(neo4j_uri, auth = (neo4j_user, neo4j_password))


def compute_execuation_acc_metric(predictions, references) -> Dict[str, Any]:
    print("metrics/text2cypher/text2cypher_exact_match.py, references", references)
    evaluator = text2cypher_evaluation.Evaluator(graph, "all")
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
