# SemanticParser4Graph

## Overview

This project implements

- A process to convert [relational databases to property graph databases](application).
- A process to translate [SQL queries to Cypher queries](application) by parsing, tokenizing SQL queries and converting SQL queries to Cypher queries, adapted from the [TabularSemanticParsing](https://github.com/salesforce/TabularSemanticParsing).
- A strong sequence-to-sequence based cross-domain text-to-SQL semantic parser that achieved state-of-the-art performance on the widely used benchmark dataset: [Spider](https://yale-lily.github.io/spider).

<!-- The parser can be adapted to learn mappings from text to other structured query languages such as [SOQL](https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql.htm) by modifying the formal langauge pre-processing and post-processing modules. -->

## Quick Start

### Requirements

The main requirements are:

- Python 3.6+
- Neo4J Community Edition

### Install Dependencies

We recommend using virtual environments to run this code:

```shell script
python -m virtualenv venv
venv\Scripts\activate
```

Python packages can be installed via:

```shell script
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

1. Setting the `application/config.ini` file

   The application that will be run, are determined in the `config.ini` file:

   ```shell script
   [OPTIONS]
   run_triple_generation=True

   [FILENAMES]
   raw_folder = <path-to->/SemanticParser4Graph/application/data/

   sp_folder = <path-to->/SemanticParser4Graph/semantic_parser/data

   spider_parsed_json = <path-to->/SemanticParser4Graph/application/data/spider/spider.parsed.json

   neo4j_import_folder  = <path-to->/neo4j-community-4.4.11/import>
   neo4j_uri = http://localhost:7474/browser/
   neo4j_user = neo4j
   neo4j_password = <your-password>

   env_file = <path-to->/SemanticParser4Graph/application/.env
   ```

   Meanwhile, please config Neo4j export path.

   ``` shell script
   cd application/ConverDB.py

   ```

   Set `_neo4j_export_path = '<path-to->/neo4j-community-4.4.11/import'` in `Class ConvertDB`.
2. Configure `application/conf/db.ini` file

   ```[sqlite3]
   spider_path = <path-to->/SemanticParser4Graph/application/data/spider/database
   database = musical

   [neo4j]
   port = 7687
   host = localhost
   username = neo4j
   password = <your-password>

   ```
3. Running Neo4j

   ```shell script
   cd <path-to-neo4j-bin>
   ./neo4j start
   ```
4. Constructing a property graph database from relational database

   ```shell script
   cd application/rel_db2kg/data_processor
   python data_processor_spider.py --dbProcessing

   cd application/rel_db2kg
   python triple_generation.py

   ```
5. Running interface

   ```shell script
   cd application
   python interface --web_ui
   ```

## Baseline

#### Spider

```shell script
./experiment-text2cypher.sh configs/spider.sh --train 0
```

### Inference

TODO

#### Spider

```shell script
./experiment-text2cypher.sh configs/spider.sh --inference 0
```

## Model

TODO

<!-- ### Train

### Inference -->

<!-- 
## Citation

If you find the resource in this repository helpful, please cite

```
TODO
``` -->

## Related Links

The web interface is adapted from UNSW SQL2Cypher: https://github.com/UNSW-database/SQL2Cypher.
