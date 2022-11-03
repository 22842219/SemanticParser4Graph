import collections
import json
import re
from git import List
from mo_future import string_types
from debugs import debug_wrapper
import utils as utils
from schema2graph import RelDBDataset




class SchemaGroundedTraverser(RelDBDataset):

    """
    SchemaGroundedTraverser takes a relational databse `schema` as inputs. 

    Attributes:
        schema (List):  the paths of relational database schema. 
        logger: 
        defined_fields (dict): A dictionary of defined structured fields. (a placeholder)
    """

    def __init__(self, schema: list, logger, defined_fields=None):

        self.schema = schema
        self.logger = logger
        self.defined_fields = defined_fields

        if not isinstance(self.schema, list):
            self.schema = [self.schema]
        self.dataset = RelDBDataset(self.schema, self.logger)

    def relationship(self, db):

        raise NotImplementedError


    
    def relationship_match(self):
        for i, db in enumerate(self.dataset.rel_dbs): 
            self.relationship(db)


  