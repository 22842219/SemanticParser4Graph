# encoding=utf8

from .text2cypher_exec import compute_execuation_acc_metric
# from .text2cypher_test_suite import compute_test_suite_metric


class EvaluateTool(object):
    def __init__(self, args):
        self.args = args

    def evaluate(self, preds, golds, section):
    
        if self.args.seq2seq.target_with_db_id:
            # Remove database id from all predictions
            preds = [pred.split("|", 1)[-1].strip() for pred in preds]
        exact_match = compute_execuation_acc_metric(preds, golds)
        # test_suite = compute_test_suite_metric(preds, golds, db_dir=self.args.test_suite_db_dir)
        print(f'metrics/text2cypher/evaluator.py, preds: {preds}, golds: {golds}, section: {section}')

        return {**exact_match}
