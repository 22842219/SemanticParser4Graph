# Weakly Supervised Text-to-Cypher Semantic Parsing Oriented for Property Graph Database


Note: This README file is inspired by [Spider](https://github.com/taoyds/spider).

### :point_right: Changelog
- `17/04/2023`


<!-- - `05/03/2023`
    - design two baseline approaches.
        - text2cypher
        - text2sql2cypher
    - three evaluation metrics.
        - evaulation accuracy
        - edit similarity
        - bleu
    - two evaluation aspects.
        - cased prediction and ground truth
        - uncased prediction and ground truth
     -->

<!-- - `30/01/2023` 
    - Reformat input dataset which includes three json files, namely train.json, dev.json and schema.json. 
    - Create a small dataset in `department_management` domain.
-  `31/01/2023`
    - Define text2cypher dataset builder :point_right: [data features](https://github.com/22842219/SemanticParser4Graph/blob/main/semantic_parser/seq2seq_construction/text2cypher_dataset_builder.py)
-  `01/02/2023`
    - DB content encoder :point_right: [picklist](https://github.com/22842219/SemanticParser4Graph/blob/main/semantic_parser/seq2seq_construction/bridge_content_encoder.py)
-  `02/02/2023`
    - Sequence2sequence constructor :point_right: [Seq2seq constructor](https://github.com/22842219/SemanticParser4Graph/blob/main/semantic_parser/seq2seq_construction/text2cypher_constructor.py)    
- `03/02/2023`
    - updata [schema](https://github.com/22842219/SemanticParser4Graph/tree/main/semantic_parser/data/text2cypher). 
    - [Input serialization](https://github.com/22842219/SemanticParser4Graph/tree/main/semantic_parser/seq2seq_construction) (done!) 
    - Test training/Evaluation [datasets object applied in a seqseq constructor](hhttps://github.com/22842219/SemanticParser4Graph/tree/main/semantic_parser/seq2seq_construction) (done!)
    - Test training/Evaluation [evaluation metrics](https://github.com/22842219/SemanticParser4Graph/blob/main/semantic_parser/metrics/text2cypher/evaluator.py) (done!)
- `08/02/2023`
    - :boom: The text2cypher model with prefix tuning is training now in the local ubuntu machine. Hopefully we could get a not bad result. Please refer to our [expriments log file](https://github.com/22842219/SemanticParser4Graph/blob/main/semantic_parser/exps-2023.md).
- `11/02/2023`
    - training the model using the whole set in kaya. (ongoing)
        - The sbatch slurm. (done!) 
        - :smiling_imp: The model stopped training due to the failure of graph connection which requires the installation of java in kaya. I've created a ticket asking for avice from uwa it service. (solved!)
            - module avail  # show available modules
            - module load java/11* # load java 11.*  to fit our neo4j-community-4.4.13 
            - solved the ``py2neo.errors.ConnectionUnavailable`` issue. Please refer to line 43-54 in [this page](https://github.com/22842219/SemanticParser4Graph/blob/main/semantic_parser/kaya_scripts/text2cypher-kaya-prefix-tuning.slurm).
- `13/02/2023`
    - Updating the paper
        - 1) to work out the loss function in a mathematical way together with input and output, (done!)
        - 2) to work out how the prefix-tuning process is interacting with the evaluation process. (done!)
- `14/02/2023` 
    - :boom: Priority task
        - Updating the paper
            - 3) related work (focusing on just neural semantic parsing part!)

        - training the model using **3,175** train, and **491** dev. 
            - Improving the code to achive the following targets.
                - The predictions always output lowercase tokens. I've looked up the T5 documentation and it seems like that's their settings. 
                    (confirmation required!!!)
            - Analyse the results with the focus below. 
                - :point_right: study the dataset distribution.
                    I observe the gained from evaluation seen examples benefits the unseen examples. 
                - :point_right: study the generation of the fowllowing items.
                    - **special tokens**, 
                    - **capitalized tokens**, 
                    - **alias**, 
                    - **graph patterns** including graph nodes and edges. 
                    - **repetitions of the same word sequences**, e.g., ``return return return``.
                - :point_right: tuning the following training arguments
                    - **num_train_epochs** : len(training data)/batch_size (to avoid overfitting)
                    - **generation_num_beams**: 4 is bettern than 2. 
                    - **generation_max_length**: 512 (as long as it does not exceed the transformers configuration threshold.)
                    - **larning_rate**: 1e-4 is kinda enough for the Adam optimization -->


### :point_right: Submission Plan
<!-- 
- KR 2023 (achieved)
    - Title and Abstract ddl: 3rd March, 2023
    - Paper ddl: 14th March, 2023 
- Experiments part

    ~~~- mile stone 1: 12nd Feb, 2023 ~~~
        ~~~- :vulcan_salute: Baseline Results and Analysis (kinda done! require more solid jobs)~~
        ~~~- Update baseline results and analysis to the overleaf (ongoing!)~~ -->

   <!-- - mile stone 2:
        - Most likey I will work on the model architecture improvement, e.g., fussion decoder?  -->
        
<!--         
- Paper Draft
    - first round review. 
    - investigate different decoding methods? to improve the model's performance

    - mile stone 2: 26th Feb, 2023
        - The first draft should be completed!
        - second round review. 
    - mile stone 3: 3rd March, 2023
        - submit title and abstract
    - mile stone 4: 5rd March

        - third round review
    - mile stone 5: 14th March, 2023
        - submit the paper.    -->
- Personal leave 2023: 12/05-16/05, 2023
- CIKM 2023
    - Title and Abstract dd: 26/05, 2023
    - Full paper ddl: 02/06, 2023
- Experiments part
    - milestone 1: 17/04-23/04, 2023
        - get output refinement done from the perspective of **exection-guided decoding**

- Paper part
    - milestone1: 30/04/2023
        - content 
        - **Schema-guided constrained decoding** part in section **Methodology**
        - **Evaluation part** (focusing on **False Negative** and **False Positive**) in **Evaluation** section
        - **Complexity Analysis** part in section **Result** 
        - Related work

### :point_right: TODO LIST
<!-- -`20/02/2023`
    - **edit distance or fuzzy matching** for the output so we can clearly see the impact of the modifications to the algorithm. 
    - evaluator post processing
    - add codeGPT?
    
        <!-- - :vulcan_salute: **Few/Zero shot learning.** -->
<!-- 
    - Update the implementation details in the paper. (done! but can be improved.)
    - Encoder-Decoder architecture using a running example.

    - Result Visualisation  -->
- 16/04/2023 (sort of done@, under testing)
    - cypher parser to get a normalised/parsed Cypher in order to evaluation models using exact match. 
- 19/04/2023 - 23/04.2023
    - get the overview diagram done using a proper running example. 
    - literature reviews. 
    - prioritized task: design advanced nn model on top of baselines using execution accuracy. 
    
    - get output refinement done from the perspective of **exection-guided decoding**
    - update paper **Schema-guided constrained decoding** part in section **Methodology**


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
        "db_id": "department_management",
        "tag_names_original": [
            "department",
            "head",
            "management"
        ],
        "tag_names": [
            ":`department_management.department`",
            ":`department_management.head`",
            ":`department_management.management`"
        ],
        "property_names": [
            [
                -1,
                "*"
            ],
            [
                0,
                "Name"
            ],
            [
                0,
                "Creation"
            ],
            [
                0,
                "Department_ID"
            ],
            [
                0,
                "Ranking"
            ],
            [
                0,
                "Budget_in_Billions"
            ],
            [
                0,
                "Num_Employees"
            ],
            [
                1,
                "name"
            ],
            [
                1,
                "born_state"
            ],
            [
                1,
                "age"
            ],
            [
                1,
                "head_ID"
            ],
            [
                2,
                "temporary_acting"
            ]
        ],
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
        "department": {
            "Name": [
                "Health and Human Services",
                "Defense",
                "State",
                "Justice",
                "Energy",
                "Commerce",
                "Homeland Security",
                "Treasury",
                "Housing and Urban Development",
                "Transportation",
                "Education",
                "Veterans Affairs",
                "Agriculture",
                "Interior",
                "Labor"
            ],
            "Creation": [
                "1965",
                "1903",
                "1789",
                "1977",
                "1849",
                "1913",
                "1889",
                "2002",
                "1870",
                "1989",
                "1953",
                "1947",
                "1979",
                "1966"
            ],
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
            ],
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
            ],
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
            ],
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
        },
        "head": {
            "name": [
                "Tiger Woods",
                "Sergio Garc\u00eda",
                "Dudley Hart",
                "Franklin Langham",
                "P\u00e1draig Harrington",
                "Jeff Maggert",
                "Nick Faldo",
                "K. J. Choi",
                "Stewart Cink",
                "Billy Mayfair"
            ],
            "born_state": [
                "Delaware",
                "Alabama",
                "Florida",
                "Connecticut",
                "California"
            ],
            "age": [
                67.0,
                68.0,
                69.0,
                43.0,
                50.0,
                52.0,
                53.0,
                56.0
            ],
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
        },
        "management": {
            "temporary_acting": [
                "Yes",
                "No"
            ]
        }
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
  "prefix_tuning.prefix_sequence_length": 10
  "prefix_tuning.mid_dim": 512, 
  "tokenizer": AutoTOkenizer.from_pretrained('t5-base),
  "pretrain_model": T5ForConditionalGeneration.from_pretrained('t5-base')
  "match_n_layer": 12
  "match_n_head", 12
  "n_embd", 768
  "match_n_embd":  64

  "batch size": 2

  "wte": [prefix_tuning.prefix_sequence_length, n_emdb]
  "wte_enc": [prefix_tuning.prefix_sequence_length, n_emdb]
  "control_trans": [mid_dim, match_n_layer*2*match_n_head*match_n_embd]
  "control_trans_enc": [mid_dim, match_n_layer*2*match_n_head*match_n_embd]

  "wte_dec": [prefix_tuning.prefix_sequence_length, n_emdb]
  "control_trans_dec": [mid_dim, match_n_layer*2*match_n_head*match_n_embd]
  "dropout": 0


} 
```

### Training Arguments
```
{

python -m torch.distributed.launch              --nproc_per_node 1               --master_port 1234 train.py               --seed 2               --cfg Salesforce/T5_base_prefix_text2cypher_with_cell_value.cfg               --run_name T5_base_prefix_text2cypher_with_cell_value              --logging_strategy steps               --logging_first_step true               --logging_steps 500               --evaluation_strategy steps               --eval_steps 500               --metric_for_best_model avr               --greater_is_better true               --save_strategy steps               --save_steps 500               --save_total_limit 1               --load_best_model_at_end               --gradient_accumulation_steps 8               --num_train_epochs 400               --adafactor true               --learning_rate 1e-4               --do_train               --do_eval               --do_predict               --predict_with_generate               --output_dir output/T5_base_prefix_text2cypher_with_cell_value           --overwrite_output_dir           --per_device_train_batch_size 2               --per_device_eval_batch_size 8               --generation_num_beams 4               --generation_max_length 64               --input_max_length 512               --ddp_find_unused_parameters true       
    
}
```



Note: [PICARD](https://arxiv.org/abs/2109.05093) paper has pointed out that beam size with 4 is the best, however due to the computation capacity, we have to set it as 2 at the moment. (could change to 4 once the mode is ready to upload to kaya.)
### FAQ


