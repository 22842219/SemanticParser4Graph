## Data Structure Understanding Processes

### Input data structure
- Below is an example of schema items referring **department_management**  in Spider.  
```
{"column_names": [ [-1, *], [table_id, normalised_column_name]],
"column_names_original":  [ [-1, *], [table_id, original_column_name]], 
"column_types": list,
"db_id": str,   
"table_names": list,
"table_names_original": list,
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

