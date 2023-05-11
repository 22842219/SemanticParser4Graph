
'''
Author: Ziyu Zhao
Affiliation: UWA NLT-TLP GROUP
'''

from schema2graph import DBengine
import os, re, math
from typing import Set

import matplotlib.pyplot as plt
import pandas as pd
from fire import Fire
import numpy as np


def data_complexity(spider_dbs):

    db_atts = {} # the number of attributes in all the tabls of each domain schema. 
    stat_db_atts = []
    for_plot = {}
    total_natt = 0
    total_fks = 0
    total_cos = 0
    for i, db_path in enumerate(spider_dbs):
        db_name = db_path.split(os.sep)[-1].split('.')[0] 
        print(db_name)
        engine = DBengine(db_path)
        tab_names = [tab_info[0] for tab_info in engine.get_table_names()]
        unique_atts = []
        each={}
        each['db_name'] = db_name
        num_of_fks = 0
        num_of_no_fks_tbs=0
        num_of_with_fks_tbs = 0
        cos=0
        for tb_name in tab_names:
            tb_records = engine.get_table_values(tb_name)
            tb_headers = [desc[0] for desc in tb_records.description]  
            df = pd.DataFrame(tb_records.fetchall(), columns = tb_headers)
            rows = data = [d for d in df.transpose().to_dict().values()  if any(d.values())]
            tb_constraints = engine.get_outbound_foreign_keys(tb_name)
            unique_atts.extend(tb_headers)    
            if tb_constraints:
                num_of_fks+=len(tb_constraints)
                num_of_with_fks_tbs+=1
            else:
                num_of_no_fks_tbs+=1
        db_atts[db_name]=set(unique_atts)
        each['natt']=len(set(unique_atts))
        each['nfk']=num_of_fks
        for i in range(1, num_of_no_fks_tbs+1):
            cos+=num_of_with_fks_tbs**2
        each['cos']=cos
        stat_db_atts.append(each)
        total_natt+= len(set(unique_atts))
        total_cos += cos
        total_fks+=num_of_fks

        for_plot[db_name] = [len(set(unique_atts)), num_of_fks, cos]


    for db, values in for_plot.items():
        [i, j, k] = values
        values = [i*100/total_natt, j*100/total_fks, k*100/total_cos]
        for_plot[db]=values



    csv_file = "rel_data_complexity.csv"
    import csv
    try:
        with open(csv_file, 'w') as csvfile:
            writer = csv.DictWriter(csvfile, fieldnames=['db_name', 'natt', 'nfk', 'cos'])
            writer.writeheader()
            for data in stat_db_atts:
                writer.writerow(data)
    except IOError:
        print("I/O error")
    
    return for_plot


import sqlite3

def calculate_metrics(db_path):
    conn = sqlite3.connect(db_path)
    c = conn.cursor()

    # Number of attributes (natt)
    c.execute("SELECT SUM(COUNT(*)) FROM pragma_table_info('table_name')")
    natt = c.fetchone()[0]
    print(f'natt: {natt}')
    # Depth referential tree (drt)
    c.execute("""
        WITH RECURSIVE drt(parent, child, depth) AS (
          SELECT parent, child, 1 FROM pragma_foreign_key_list('all')
          UNION ALL
          SELECT drt.parent, f.child, drt.depth + 1 FROM drt
          JOIN pragma_foreign_key_list(drt.child, drt.parent) AS f ON 1=1
        )
        SELECT MAX(depth) FROM drt
    """)
    drt = c.fetchone()[0]

    # Number of foreign keys (nfk)
    c.execute("SELECT COUNT(*) FROM pragma_foreign_key_list('all')")
    nfk = c.fetchone()[0]

    # Cohesion of the schema (cos)
    c.execute("""
        WITH subgraphs AS (
          SELECT name, group_concat(tbl_name, ',') AS tbl_names
          FROM sqlite_master WHERE type = 'table' GROUP BY name
        ),
        tbl_graph AS (
          SELECT tbl_name, fkey_table AS fkey_tbl
          FROM pragma_foreign_key_list('all')
        ),
        tbl_subgraph AS (
          SELECT tbl_name, name
          FROM tbl_graph JOIN subgraphs ON tbl_graph.fkey_tbl = subgraphs.tbl_names
        ),
        subgraph_sizes AS (
          SELECT name, COUNT(*) AS size
          FROM tbl_subgraph GROUP BY name
        ),
        subgraph_cos AS (
          SELECT SUM(size * size) AS cos
          FROM subgraph_sizes
        )
        SELECT cos FROM subgraph_cos
    """)
    cos = c.fetchone()[0]

    # Schema size (ss)
    c.execute("SELECT SUM(page_count * page_size) FROM pragma_page_count('main')")
    ss = c.fetchone()[0]

    conn.close()

    return {'natt': natt, 'drt': drt, 'nfk': nfk, 'cos': cos, 'ss': ss}





def plot(for_plot):
    data=[]
    for k, v in for_plot.items():
        each = []
        each.append(k)
        each.extend(v)
        data.append(each)
    data = sorted(data, key=lambda x: x[0])

    # Create data frame
    data = pd.DataFrame(data, columns=['db_name', 'natt', 'nfk', 'cos'])

    # Create subplots
    fig, axs = plt.subplots(nrows=2, ncols=1, figsize=(15, 10))

    # Plot histograms of the three metrics against 166 domains
    axs[0].hist(data[['natt', 'nfk', 'cos']].values, bins=20, label=['Number of Attributes', 'Number of Foreign Keys', 'Cohension of the Schema'])
    axs[0].legend()
    axs[0].set_xlabel('Normalized Complexity')
    axs[0].set_ylabel('Frequency')
    axs[0].set_title('Histogram of Normalized Complexity')

    # Plot scatter diagram of the three evaluation metrics w.r.t each relational database
    # Only plot every 10th database name to avoid overlap
    tick_labels = data['db_name'][::10]
    axs[1].scatter(np.arange(len(data))[::10], data['natt'][::10], color='b', label = 'Number of Attributes')
    axs[1].scatter(np.arange(len(data))[::10], data['nfk'][::10], color='r', label = 'Number of Foreign Keys')
    axs[1].scatter(np.arange(len(data))[::10], data['cos'][::10], color='g', label = 'Cohesion of the Schema')
    axs[1].set_xlabel('Relational Database Name')
    axs[1].set_xticks(np.arange(len(data))[::10])
    axs[1].set_xticklabels(tick_labels, rotation=90)
    axs[1].set_ylabel('Normalized Complexity')
    axs[1].set_title('Scatter Diagram of Normalized Complexity')
    axs[1].legend()

    fig.tight_layout()
    fig.show()

    # Save the figure
    fig.savefig('my_plot.png', dpi=300)
def main():

    import glob, argparse
    import configparser
    config = configparser.ConfigParser()
    config.read('../config.ini')
    filenames = config["FILENAMES"]

    raw_folder = filenames['raw_folder']
    raw_spider_folder = os.path.join(raw_folder, 'spider')
    db_folder = os.path.join(raw_spider_folder,  'database')
    spider_dbs = glob.glob(db_folder + '/**/*.sqlite', recursive = True)

    # for_plot = data_complexity(spider_dbs)
    # plot(for_plot)

    for i, db_path in enumerate(spider_dbs):
        metric = calculate_metrics(db_path)
        print(metric)


if __name__ == "__main__":
    Fire(main)