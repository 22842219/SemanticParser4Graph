# SemanticParser4Graph

## Overview

This project implements

- A process to convert [relational databases to property graph databases](application).
- A process to translate [SQL queries to Cypher queries](application) by parsing, tokenizing SQL queries and converting SQL queries to Cypher queries, adapted from the [TabularSemanticParsing](https://github.com/salesforce/TabularSemanticParsing).
- Cy-Spider: Semantic Parsing Corpus and Baseline Models for a Property Graph.

<!-- The parser can be adapted to learn mappings from text to other structured query languages such as [SOQL](https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql.htm) by modifying the formal language pre-processing and post-processing modules. -->

## Quick Start

### Requirements

The main requirements are:

- Python 3.6+
- Neo4J Community Edition

### Install Dependencies

We recommend using virtual environments to run this code:

```shell
python -m virtualenv venv
source venv\bin\activate
```

Python packages can be installed via:

```shell
   git clone https://github.com/22842219/SemanticParser4Graph.git

   pip install torch torchvision

   python3 -m pip install -r requirements.txt
   or 
   pip install -r requirements.txt
```

### Download Pre-process Data

#### Text-to-Spider benchmarks, e.g., [Spider](https://yale-lily.github.io/spider), [KaggleDBQA](https://github.com/chiahsuan156/KaggleDBQA#Data-Format), and [BIRD](https://bird-bench.github.io/). We use the Spider benchmark to illustrate the process.

Download the [pre-processed data release](https://uniwa-my.sharepoint.com/:f:/r/personal/22842219_student_uwa_edu_au/Documents/preprocessed_spider?csf=1&web=1&e=Sh1Ep2), and unzip the folder.
put the data into `application/data/spider`.

Note: If you would like to preprocess Spider dataset by yourself, please refer to [salesforce TabularSemanticParsing](https://github.com/salesforce/TabularSemanticParsing)

### Set up Environment

1. Setting the `application/config.ini` file.

   - Create an `application/.env` file.

   ```shell
   GRAPH_PASSWORD=<your-neo4j-password>
   ```

   - The application that will be run, are determined in the `config.ini` file:

   ```shell
   

   [FILENAMES]
   root = <path-to->/SemanticParser4Graph
   benchmark = Spider

   neo4j_import_folder  = <path-to->/neo4j-community-4.4.11/import>
   neo4j_uri = http://localhost:7474/browser/
   neo4j_user = neo4j
   neo4j_password = <your-neo4j-password>
   ```

   - Meanwhile, please config Neo4j export path.

   ```shell
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
   password = <your-neo4j-password>

   ```
3. Running Neo4j

   ```shell
   cd <path-to-neo4j-bin>
   ./neo4j start
   ```
4. Constructing a property graph database from any arbitrary relational database schemas directly.

   ```shell
   cd application/rel_db2kg
   python schema2graph.py --<benchmark_dataset-name> --cased

   ```

   Translate SQL queries to Cypher queries.

   ```shell
   cd application/rel_db2kg
   python sql2cypher.py 

   ```
5. Running interface

   ```shell
   cd application
   python interface --web_ui
   ```

## Baseline

#### Spider

```shell
cd semantic_parser
bash experiment-text2cypher.sh 
```


## Model

TODO


## Citation

If you find the resource in this repository helpful, please cite

```
TODO
``` 

## Related Links

The web interface is adapted from UNSW SQL2Cypher: https://github.com/UNSW-database/SQL2Cypher.
