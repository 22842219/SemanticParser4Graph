Relationship creation

1) curated based on foriengin keys of a table as the following rules
   1) StartID: type|EndID:type
2) populate a table as a relationship with the following charaters:
   1) compound keys
   2) table name starts with "HAS"

**Relationship query**

**databse: department_management**

**question: What are the distinct ages of the heads who are acting?**

**SELECT DISTINCT T1.creation FROM department AS T1 JOIN management AS T2 ON T1.department_id**  **=**  **T2.department_id JOIN head AS T3 ON T2.head_id**  **=**  **T3.head_id WHERE T3.born_state**  **=**  **'Alabama'**SELECT DISTINCT T1.age FROM management AS T2 JOIN head AS T1 ON T1.head_id**  **=**  **T2.head_id WHERE T2.temporary_acting**  **=**  **'Yes**

MATCH()-[T2:Management]->(T1:Head)

WHERE T2.temporary_acting ='Yes'

RETURNdistinct(T1.age

MATCH()-[T2:Management]->(T1:Department)

WHERE T2.temporary_acting ='Yes'

RETURN T1.name,T1.num_employees

****************cypher*****************

**MATCH ()-[T2:Management]->(T1:Department)**

()-[T2:Management]->(T3:Head)

**WHERE T3.born_state = 'Alabama'**

**RETURN distinct(T1.creation)**


**databse: department_management**

**question: What are the distinct creation years of the departments managed by a secretary born in state 'Alabama'?**

**sql_query: SELECT DISTINCT T1.creation FROM department AS T1 JOIN management AS T2 ON T1.department_id**  **=**  **T2.department_id JOIN head AS T3 ON T2.head_id**  **=**  **T3.head_id WHERE T3.born_state**  **=**  **'Alabama'**

**{'select': {'value': {'distinct': {'value': 'T1.creation'}}}, 'from': [{'value': 'department', 'name': 'T1'}, {'join': {'name': 'T2', 'value': 'management'}, 'on': {'eq': ['T1.department_id', 'T2.department_id']}}, {'join': {'name': 'T3', 'value': 'head'}, 'on': {'eq': ['T2.head_id', 'T3.head_id']}}], 'where': {'eq': ['T3.born_state', {'literal': 'Alabama'}]}}**

**{'department': ['Department_ID', 'Name', 'Creation', 'Ranking', 'Budget_in_Billions', 'Num_Employees'], 'head': ['head_ID', 'name', 'born_state', 'age'], 'rel_management': ['Department_ID', 'head_ID', 'temporary_acting']}**

****************important*****************

**559: [{'value': 'department', 'name': 'T1', 'is_table': True}, {'join': {'name': 'T2', 'value': 'management', 'is_table': True}, 'on': {'eq': ['T1.department_id', 'T2.department_id']}}, {'join': {'name': 'T3', 'value': 'head', 'is_table': True}, 'on': {'eq': ['T2.head_id', 'T3.head_id']}}]**

************operator*************

************operator*************

**parts: [{'T1': 'department'}, {'T2': 'management', 'on': ['T1.department_id = T2.department_id']}, {'T3': 'head', 'on': ['T2.head_id = T3.head_id']}]**

***********4***********

**pattern_info: ['T1.department_id ', ' T2.department_id']**

**pattern_info: ['T2.head_id ', ' T3.head_id']**

*********reformat_parts**********

**['()-[T2:Management]->(T1:Department)', '()-[T2:Management]->(T3:Head)']**

**()-[T2:Management]->(T1:Department)**

** **()-[T2:Management]->(T3:Head)
