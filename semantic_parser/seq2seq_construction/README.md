## Data Structure Understanding Processes

### :point_right: Input data structure
- Below is an example of schema items referring **department_management**  in Spider.  
```
{"column_names":  [-1, *], [table_id, normalised_column_name]],
"column_names_original":  [ [-1, *], [table_id, original_column_name]], 
"column_types": List(str),
"db_id": str,   
"table_names": List(str),
"table_names_original": List(str),
"foreign_keys": [[from_column_id, to_column_id]],  
"primary_keys": [column_id] }.

e.g.,
  {
        "column_names": [
            [
                -1,
                "*"
            ],
            [
                0,
                "department id"
            ],
            [
                0,
                "name"
            ],
            [
                0,
                "creation"
            ],
            [
                0,
                "ranking"
            ],
            [
                0,
                "budget in billions"
            ],
            [
                0,
                "num employees"
            ],
            [
                1,
                "head id"
            ],
            [
                1,
                "name"
            ],
            [
                1,
                "born state"
            ],
            [
                1,
                "age"
            ],
            [
                2,
                "department id"
            ],
            [
                2,
                "head id"
            ],
            [
                2,
                "temporary acting"
            ]
        ],
        "column_names_original": [
            [
                -1,
                "*"
            ],
            [
                0,
                "Department_ID"
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
                "head_ID"
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
                2,
                "department_ID"
            ],
            [
                2,
                "head_ID"
            ],
            [
                2,
                "temporary_acting"
            ]
        ],
        "column_types": [
            "text",
            "number",
            "text",
            "text",
            "number",
            "number",
            "number",
            "number",
            "text",
            "text",
            "number",
            "number",
            "number",
            "text"
        ],
        "db_id": "department_management",
        "foreign_keys": [
            [
                1,
                11
            ],
            [
                7,
                12
            ]
        ],
        "primary_keys": [
            1,
            7,
            11
        ],
        "table_names": [
            "department",
            "head",
            "management"
        ],
        "table_names_original": [
            "department",
            "head",
            "management"
        ]
    },
```

### :point_right: Input normalization and serialization strategy

```
{
    "source_prefix": "",
    "schema_serialization_type": "peteshaw",
    "schema_serialization_randomized": false,
    "schema_serialization_with_db_id": true,
    "schema_serialization_with_db_content": true,
    "normalize_query": true,
    "target_with_db_id": true,
}
```
Note: **[peteshaw](https://arxiv.org/abs/2010.12725)**




### :point_right: [DB Content Encoding](https://github.com/22842219/SemanticParser4Graph/blob/main/semantic_parser/seq2seq_construction/bridge_content_encoder.py)

This point aims to understand how field values in the context of Text-to-SQL are cancatenated alongside column names and table names, especially for the case that one column contains thousands of field values. 

:grinning: Bacially the idea is straightforward and using the quetion tokens to filter out (or match) the most possible filed value(s) for the targeted field. It simply and trivally use **difflib.SequenceMatch** to get the maxmimum string matching. The idea is called **picklists** and described in **[TabularSemanticParsing](https://arxiv.org/abs/2012.12627)** paper. 


- [This](https://github.com/22842219/SemanticParser4Graph/blob/main/semantic_parser/general_testing.ipynb) shows an example of picklist regarding column **name** in table **department_management** in the **department_management.db**. 

```

A ruuning example: 
db_path = '/home/22842219/Desktop/projects_data/spider/database/department_management/department_management.sqlite'
table_name = 'head'
column_name = 'born_state'
question = 'What are the names of the heads who are born outside the California state?'

1. Get the whole field values of one column
    picklist = get_column_picklist(table_name, column_name, db_path) # R: List[str]

2. Split the question into a list of characters denoted as **n_grams**, as well as each field value denoted as **fv_tokens**. Then **difflib.SequenceMatcher** is employed to get the similary of **n_grams** and **fv_tokens**, and find the longest match start index, end index, and match size. These indices are used to specified the matched spans of the question and corresponding field value respectively. Finally, the matched entries are obtained by filtering out all stop words, the common db terms (i.e. **id**) and other common words (e.g., "no", "yes", "many"). One can even add a list of sensitive words involving data privacy, say personal id number. 

    get_matched_entries = get_matched_entries(question, picklist, match_threshold, s_theta) # R: Optional[List[Tuple[str, Tuple[str, str, float, float, int]]]]

    # w.r.t. running example
    # ['California', ]


    matches = get_database_matches(question, table_name, column_name, db_path)

3. Once got the matches, they are joined into a string and be a element of a tuple alongside the column name. The tuple then is appended to a list. 

    

```


