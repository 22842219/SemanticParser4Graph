# SemanticParser4Graph

## Overview

This project implements

- A process to convert [relational databases to property graph databases](application).
- A process to translate [SQL queries to Cypher queries](application) by parsing, tokenizing SQL queries and converting SQL queries to Cypher queries, adapted from the [TabularSemanticParsing](https://github.com/salesforce/TabularSemanticParsing).
- A strong sequence-to-sequence based cross-domain text-to-SQL semantic parser that achieved state-of-the-art performance on the widely used benchmark dataset: [Spider](https://yale-lily.github.io/spider).

<!-- The parser can be adapted to learn mappings from text to other structured query languages such as [SOQL](https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql.htm) by modifying the formal langauge pre-processing and post-processing modules. -->

## Model

TODO

## Quick Start

### Requirements

The main requirements are:

- Python 3.6+
- Neo4J Community Edition

### Install Dependencies

We recommend using virtual environments to run this code:
```
    python -m virtualenv venv
    venv\Scripts\activate
```  
Python packages can be installed via:

```
    git clone https://github.com/22842219/SemanticParser4Graph.git

    pip install torch torchvision

    python3 -m pip install -r requirements.txt
    or 
    pip install -r requirements.txt
```

### Download Pre-process Data

#### Spider

Download the [pre-processed data release](https://uniwa-my.sharepoint.com/:f:/r/personal/22842219_student_uwa_edu_au/Documents/preprocessed_spider?csf=1&web=1&e=Sh1Ep2), and unzip the folder. 
put the data into `application/data/spider`.

Note: If you would like to preprocess Spider dataset by yourself, please refer to [salesforce TabularSemanticParsing](https://github.com/salesforce/TabularSemanticParsing)


### Set up Environment

1. Setting the config.ini file
```
cd application

```
2. Running Neo4j
```
cd <path-to-neo4j-bin>
./neo4j start
```
3. Constructing a property graph database from relational database
```
cd application/rel_db2kg/data_processor
python data_processor_spider.py --dbProcessing

cd application/rel_db2kg
python triple_generation.py

```

4. Running interface

```
cd application
python interface --web_ui
```


### Baseline

### Train

TODO

#### Spider

```
./experiment-text2cypher.sh configs/spider.sh --train 0
```

### Inference

TODO 

#### Spider

```
./experiment-text2cypher.sh configs/spider.sh --inference 0
```

<!-- 
## Citation

If you find the resource in this repository helpful, please cite

```
TODO
``` -->

## Related Links

The web interface is adapted from UNSW SQL2Cypher: https://github.com/UNSW-database/SQL2Cypher.
