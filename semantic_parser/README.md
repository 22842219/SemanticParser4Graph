# Weakly Supervised Text-to-Cypher Semantic Parsing Oriented for Property Graph Database


Note: This README file is inspired by [Spider](https://github.com/taoyds/spider).

### Changelog

- `30/01/2023` 
    - Reformat input dataset which includes three json files, namely train.json, dev.json and schema.json. 
    - Create a small dataset in `department_management` domain.
    - 
### TODO LIST

- ddl: `30/01/2023` 
    - Encoder-Decoder architecture using a running example
    - Test training/Evaluation [data generator](https://github.com/22842219/SemanticParser4Graph/blob/main/semantic_parser/tasks/text2cypher.py)


- cypher parser to get a normalised/parsed Cypher in order to evaluation models using exact match.


### Environment
- CUDA 11.4
- Python 3.8

### Dependency Installation
```
pip install datasets==1.14.0
# The following line to be replaced depending on your cuda version.
pip install torch==1.13.1 torchaudio==0.13.1 torchvision==0.14.1
pip install -r semantic_parsing/requirement.sp.txt
```
<!-- Note: One can install the required dependency via the instruction of [UnifiedSKG](https://github.com/HKUNLP/UnifiedSKG) -->
Note: I've found the torch version above works best alongside CUDA11.4 and ubuntu 20.04.5 LTS 64-bit after several trial and errors. 

### Data Content and Format

#### Question, Cypher, and Parsed Cypher(TODO)

Each file in`train.json` and `dev.json` contains the following fields:
- `question`: the natural language question
- `query`: the Cypher query corresponding to the question. 
- `db_id`: the database id to which this question is addressed.
<!-- - `query_toks`: the Cypher query tokens corresponding to the question. (TODO)
- `Cypher`: parsed results of this Cypher query using `process_cypher.py`. Please refer to `parsed_cypher_examples.cypher` in the`preprocess` directory for the detailed documentation. (TODO) -->


```
 {

        "question": "How many heads of the departments are older than 56 ?",
        "query": "MATCH (head:`department_management.head`)\nWHERE head.age > 56\nRETURN count(*)",
        "db_id": "department_management",
    },

```
#### Vocabulary

Please refer to [this page](https://github.com/22842219/SemanticParser4Graph/blob/main/semantic_parser/data/text2cypher/vocabulary.txt) for more details.

#### Graph Database Schema

We showcase the schema of `department_management` domain in `schema.json` which contains the following information for each node labels/edge types:

For the whole property graph database schema, please refer to [this page](https://github.com/22842219/SemanticParser4Graph/blob/main/semantic_parser/data/text2cypher/schema.json).
``` 
":`department_management.department`": {
        "property_names": [
            "Name",
            "Creation",
            "Department_ID",
            "Ranking",
            "Budget_in_Billions",
            "Num_Employees"
        ],
        "property_types": [
            "String",
            "String",
            "Long",
            "Long",
            "Double",
            "Double"
        ]
    },
    ":`department_management.head`": {
        "property_names": [
            "name",
            "born_state",
            "age",
            "head_ID"
        ],
        "property_types": [
            "String",
            "String",
            "Double",
            "Long"
        ]
    },
    ":`department_management.management`": {
        "property_names": [
            "temporary_acting"
        ],
        "property_types": [
            "String"
        ]
    },

```

### Evaluation

<!-- Our evaluation metrics include Component Matching, Exact Matching, and Execution Accuracy. For component and exact matching evaluation, instead of simply conducting string comparison between the predicted and gold SQL queries, we decompose each SQL into several clauses, and conduct set comparison in each SQL clause.  -->

For Execution Accuracy, our current models do not predict any value in Cypher conditions so that we do not provide execution accuracies. However, we encourage you to provide it in the future submissions. For value prediction, you can assume that a list of gold values for each question is given. Your model has to fill them into the right slots in the SQL.

Please refer to [Spider paper]() and [this page](https://github.com/taoyds/spider/tree/master/evaluation) for more details and examples.

```
{

  "Tensor shape of input": [64, 512, 32102] # [Minibach size, sequence length, embedding dimention size]
  "Tensor shape of output": [64, 512, 32102] # [Minibach size, sequence length, embedding dimention size]
  
  "beam size": 2
} 
```
Note: [PICARD](https://arxiv.org/abs/2109.05093) paper has pointed out that beam size with 4 is the best, however due to the computation capacity, we have to set it as 2 at the moment. (could change to 4 once the mode is ready to upload to kaya.)
### FAQ



