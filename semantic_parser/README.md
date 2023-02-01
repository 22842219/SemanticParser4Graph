# Weakly Supervised Text-to-Cypher Semantic Parsing Oriented for Property Graph Database


Note: This README file is inspired by [Spider](https://github.com/taoyds/spider).

### :point_right: Changelog

- `30/01/2023` 
    - Reformat input dataset which includes three json files, namely train.json, dev.json and schema.json. 
    - Create a small dataset in `department_management` domain.
-  `31/01/2023`
    - Define text2cypher :point_right: [data features](https://github.com/22842219/SemanticParser4Graph/blob/main/semantic_parser/seq2seq_construction/text2cypher_dataset_builder.py)
-  `01/02/2023`
    - DB content encoder :point_right: [picklist](https://github.com/22842219/SemanticParser4Graph/blob/main/semantic_parser/seq2seq_construction/bridge_content_encoder.py)

### :point_right: TODO LIST
- ddl: `01/02/2023`
    - Debugging [Seq2seq constructor](https://github.com/22842219/SemanticParser4Graph/blob/main/semantic_parser/seq2seq_construction/text2cypher_constructor.py)

- ddl: `3/02/2023` 
    - Encoder-Decoder architecture using a running example
    - Test training/Evaluation [data generator](https://github.com/22842219/SemanticParser4Graph/blob/main/semantic_parser/tasks/text2cypher.py)
    - Hopefully get a model running!!


- cypher parser to get a normalised/parsed Cypher in order to evaluation models using exact match.


### :point_right: Environment
- CUDA 11.4
- Python 3.8

### :point_right: Dependency Installation
```
pip install datasets==1.14.0
# The following line to be replaced depending on your cuda version.
pip install torch==1.13.1 torchaudio==0.13.1 torchvision==0.14.1
pip install -r semantic_parsing/requirement.sp.txt
```
<!-- Note: One can install the required dependency via the instruction of [UnifiedSKG](https://github.com/HKUNLP/UnifiedSKG) -->
Note: I've found the torch version above works best alongside CUDA11.4 and ubuntu 20.04.5 LTS 64-bit after several trial and errors. 

### :point_right: Data Structure

#### Question, Cypher, and Parsed Cypher(TODO)

Each file in`train.json` and `dev.json` contains the following fields:
- `question`: the natural language question
- `query`: the Cypher query corresponding to the question. 
- `db_id`: the database id to which this question is addressed.
- `answers`: List[List(str)]
<!-- - `query_toks`: the Cypher query tokens corresponding to the question. (TODO)
- `Cypher`: parsed results of this Cypher query using `process_cypher.py`. Please refer to `parsed_cypher_examples.cypher` in the`preprocess` directory for the detailed documentation. (TODO) -->


```
 {

        "question": "What are the names of the heads who are born outside the California state?",
        "query": "MATCH (head:`department_management.head`)\nWHERE head.born_state <> 'California'\nRETURN head.name",
        "db_id": "department_management",
        "answers": [
            [
                "Tiger Woods"
            ],
            [
                "K. J. Choi"
            ],
            [
                "Jeff Maggert"
            ],
            [
                "Stewart Cink"
            ],
            [
                "P\u00e1draig Harrington"
            ],
            [
                "Franklin Langham"
            ]
        ]
        
    },

```
#### Vocabulary

Please refer to [this page](https://github.com/22842219/SemanticParser4Graph/blob/main/semantic_parser/data/text2cypher/vocabulary.txt) for more details.

#### Graph Database Schema

We showcase the schema of `department_management` domain in `schema.json` which contains the following information for each node labels/edge types:

For the whole property graph database schema, please refer to [this page](https://github.com/22842219/SemanticParser4Graph/blob/main/semantic_parser/data/text2cypher/schema.json).
``` 
    "department_management": {
        "property_types": [
            "String",
            "String",
            "Long",
            "Long",
            "Double",
            "Double",
            "String",
            "String",
            "Double",
            "Long",
            "String"
        ],
        ":`department_management.department`": [
            {
                "Name": [
                    "Justice",
                    "Commerce",
                    "Interior",
                    "Education",
                    "Veterans Affairs",
                    "Energy",
                    "Homeland Security",
                    "State",
                    "Housing and Urban Development",
                    "Agriculture",
                    "Labor",
                    "Transportation",
                    "Defense",
                    "Treasury",
                    "Health and Human Services"
                ]
            },
            {
                "Creation": [
                    "1979",
                    "1966",
                    "1889",
                    "1977",
                    "1965",
                    "1947",
                    "1903",
                    "1953",
                    "1913",
                    "1870",
                    "1989",
                    "1789",
                    "1849",
                    "2002"
                ]
            },
            {
                "Department_ID": [
                    1,
                    2,
                    3,
                    4,
                    5,
                    6,
                    7,
                    8,
                    9,
                    10,
                    11,
                    12,
                    13,
                    14,
                    15
                ]
            },
            {
                "Ranking": [
                    1,
                    2,
                    3,
                    4,
                    5,
                    6,
                    7,
                    8,
                    9,
                    10,
                    11,
                    12,
                    13,
                    14,
                    15
                ]
            },
            {
                "Budget_in_Billions": [
                    439.3,
                    6.2,
                    9.96,
                    10.7,
                    11.1,
                    73.2,
                    77.6,
                    46.2,
                    44.6,
                    21.5,
                    23.4,
                    58.0,
                    59.7,
                    62.8,
                    543.2
                ]
            },
            {
                "Num_Employees": [
                    3000000.0,
                    36000.0,
                    208000.0,
                    17347.0,
                    116100.0,
                    4487.0,
                    109832.0,
                    10600.0,
                    235000.0,
                    71436.0,
                    112557.0,
                    67000.0,
                    115897.0,
                    30266.0,
                    58622.0
                ]
            }
        ],
        ":`department_management.head`": [
            {
                "name": [
                    "Tiger Woods",
                    "Billy Mayfair",
                    "Jeff Maggert",
                    "K. J. Choi",
                    "Franklin Langham",
                    "Nick Faldo",
                    "P\u00e1draig Harrington",
                    "Dudley Hart",
                    "Sergio Garc\u00eda",
                    "Stewart Cink"
                ]
            },
            {
                "born_state": [
                    "Delaware",
                    "Alabama",
                    "Connecticut",
                    "California",
                    "Florida"
                ]
            },
            {
                "age": [
                    67.0,
                    68.0,
                    69.0,
                    43.0,
                    50.0,
                    52.0,
                    53.0,
                    56.0
                ]
            },
            {
                "head_ID": [
                    1,
                    2,
                    3,
                    4,
                    5,
                    6,
                    7,
                    8,
                    9,
                    10
                ]
            }
        ],
        ":`department_management.management`": [
            {
                "temporary_acting": [
                    "Yes",
                    "No"
                ]
            }
        ]
    },

```

### Evaluation

<!-- Our evaluation metrics include Component Matching, Exact Matching, and Execution Accuracy. For component and exact matching evaluation, instead of simply conducting string comparison between the predicted and gold SQL queries, we decompose each SQL into several clauses, and conduct set comparison in each SQL clause.  -->

<!-- For Execution Accuracy, our current models do not predict any value in Cypher conditions so that we do not provide execution accuracies. However, we encourage you to provide it in the future submissions. For value prediction, you can assume that a list of gold values for each question is given. Your model has to fill them into the right slots in the SQL. -->

Execution Accuracy Metric

Please refer to [Spider paper]() and [this page](https://github.com/taoyds/spider/tree/master/evaluation) for more details and examples.


### Model Main Parameters
```
{

  "Tensor shape of input": [64, 512, 32102] # [Minibach size, sequence length, embedding dimention size]
  "Tensor shape of output": [64, 512, 32102] # [Minibach size, sequence length, embedding dimention size]
  
  "beam size": 2
} 
```
Note: [PICARD](https://arxiv.org/abs/2109.05093) paper has pointed out that beam size with 4 is the best, however due to the computation capacity, we have to set it as 2 at the moment. (could change to 4 once the mode is ready to upload to kaya.)
### FAQ



