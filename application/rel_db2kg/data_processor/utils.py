import re, os, jsonlines
from difflib import SequenceMatcher
import os
import logging


table_pattern = re.compile('[A-Za-z_]\w+|t')
alias_pattern = re.compile('([A-Z_]+alias\d)|'
                           '(T\d)|'
                           '(t\d)')
alias_id_pattern = re.compile('\d+')
alias_id_revtok_pattern = re.compile('\d+ ')
field_pattern = re.compile('([A-Z_]{1,100}alias\d+\.[A-Za-z_]\w+)|'
                           '([A-Za-z_]{1,100}\d+\.[A-Za-z_]\w+)|'
                           '([A-Za-z_]\w+\.[A-Za-z_]\w+)|'
                           '(T\d\.[A-Za-z_]\w+)|'
                           '(t\d\.[A-Za-z_]\w+)')
number_pattern = re.compile('\d+((\.\d+)|(,\d+))?')
time_pattern = re.compile('(\d{2}:\d{2}:\d{2})|(\d{2}:\d{2})')
datetime_pattern = re.compile('(\d{4})-(\d{2})-(\d{2})( (\d{2}):(\d{2}):(\d{2}))?')


DERIVED_TABLE_PREFIX = 'DERIVED_TABLE'
DERIVED_FIELD_PREFIX = 'DERIVED_FIELD'


def is_derived_table(s):
    return s.startswith(DERIVED_TABLE_PREFIX)


def is_derived_field(s):
    return s.startswith(DERIVED_FIELD_PREFIX)


def is_derived(s):
    return is_derived_table(s) or is_derived_field(s)


def is_subquery(json):
    if not isinstance(json, dict):
        return False
    return 'from' in json or \
           'query' in json or \
           'union' in json or \
           'intersect' in json or \
           'except' in json 


def save2json(json_file, output_filename):
    if not os.path.exists(os.path.dirname(output_filename)):
        try:
            os.makedirs(os.path.dirname(output_filename))
            print("make zzy?")
        except OSError as exc:
            if exc.errno != errno.EEXITST:
                raise
            
    with jsonlines.open(output_filename, 'a') as writer:
        for row in json_file:
            writer.write(row)



def read(filename):
    data = []
    with open(filename, 'r') as f:
        for line in f:
            data.append(line.strip('\n'))
    return data

def similar(a, b):
    return SequenceMatcher(None, a, b).ratio()




class Logger:
    _log_directory = os.getcwd() + '/log'

    def __init__(self):
        # ensure the correct log directory
        if not os.path.isdir(self._log_directory):
            os.mkdir(self._log_directory)

        self.logger = logging
        # self.logger = logging.getLogger(__name__)
        # f_handler = logging.FileHandler(self._log_directory + '/sql2cypher.log')
        # f_format = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        # f_handler.setFormatter(f_format)
        #
        # self.logger.addHandler(f_handler)
        self.logger.basicConfig(filename=self._log_directory + '/sql2cypher.log',
                                format='%(asctime)s - %(name)s: %(levelname)s %(message)s')

    def error(self, msg):
        self.logger.error(msg)

    def warning(self, msg):
        self.logger.warning(msg)