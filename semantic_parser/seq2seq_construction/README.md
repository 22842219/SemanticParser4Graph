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

### :point_right: [Property values (contents) picklist](https://github.com/22842219/SemanticParser4Graph/blob/main/semantic_parser/seq2seq_construction/bridge_content_encoder.py)

Note: [This](https://github.com/22842219/SemanticParser4Graph/blob/main/semantic_parser/general_testing.ipynb) shows an example of picklist regarding column **name** in table **department_management** in the **department_management.db**. 

Note: **[peteshaw](https://arxiv.org/abs/2010.12725)**