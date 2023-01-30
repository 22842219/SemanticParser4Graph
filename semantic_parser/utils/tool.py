import importlib


def get_model(model):
    Model = importlib.import_module('models.{}'.format(model)).Model
    return Model


def get_constructor(constructor):
    print("constructor:", constructor)
    Constructor = importlib.import_module('{}'.format(constructor)).Constructor
    print(f'importlib Constrctor: {Constructor}')
    return Constructor


def get_evaluator(evaluate_tool):
    print(f'evaluate_tool: {evaluate_tool}')
    EvaluateTool = importlib.import_module('{}'.format(evaluate_tool)).EvaluateTool
    return EvaluateTool
