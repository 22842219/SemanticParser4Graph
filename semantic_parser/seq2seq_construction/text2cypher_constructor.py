import os
import torch
import random
import re
from copy import deepcopy
from typing import List, Dict

from datasets.dataset_dict import DatasetDict
from torch.utils.data import Dataset
from torch.utils.data.dataset import T_co

from bridge_content_encoder import get_database_matches

from tqdm import tqdm

"""

This part of seq2seq construction of text2cypher dataset was partly adapted from UnifiedSKG models.
https://github.com/HKUNLP/UnifiedSKG

And we followed their configuration of normalization and serialization.
their configuration is as followed:
{
    "source_prefix": "",
    "schema_serialization_type": "peteshaw",
    "schema_serialization_randomized": false,
    "schema_serialization_with_db_id": true,
    "schema_serialization_with_db_content": true,
    "normalize_query": true,
    "target_with_db_id": true,
}
"""


def text2cypher_get_input(
        question: str,
        serialized_schema: str,
        prefix: str,
) -> str:
    return prefix + question.strip() + " " + serialized_schema.strip()


def text2cypher_get_target(
        query: str,
        db_id: str,
        normalize_query: bool,
        target_with_db_id: bool,
) -> str:
    _normalize = normalize if normalize_query else (lambda x: x)
    return f"{db_id} | {_normalize(query)}" if target_with_db_id else _normalize(query)


def text2cypher_add_serialized_schema(ex: dict, args) -> dict:
    if getattr(args.seq2seq, "schema_serialization_with_nl"):
        serialized_schema = serialize_schema_natural_language(
            question=ex["question"],
            db_id=ex["db_id"],
            db_property_names=ex["db_property_names"],
            db_tag_names=ex["db_tag_names"],
            schema_path=ex["schema_path"],
            schema_serialization_with_db_content=args.seq2seq.schema_serialization_with_db_content,
            normalize_query=True,
        )
    else:
        serialized_schema = serialize_schema(
            question=ex["question"],
            db_id=ex["db_id"],
            db_property_names=ex["db_property_names"],
            db_tag_names=ex["db_tag_names"],
            schema_path=ex["schema_path"],
            schema_serialization_type="peteshaw",
            schema_serialization_randomized=False,
            schema_serialization_with_db_id=True,
            schema_serialization_with_db_content=args.seq2seq.schema_serialization_with_db_content,
            normalize_query=True,
        )
    print(f'serialized_schema: {serialize_schema}')
    return {"serialized_schema": serialized_schema}


def text2cypher_pre_process_function(batch: dict, args):
    prefix = ""

    inputs = [
        text2cypher_get_input(
            question=question, serialized_schema=serialized_schema, prefix=prefix
        )
        for question, serialized_schema in zip(
            batch["question"], batch["serialized_schema"]
        )
    ]

    targets = [
        text2cypher_get_target(
            query=query,
            db_id=db_id,
            normalize_query=True,
            target_with_db_id=args.seq2seq.target_with_db_id,
        )
        for db_id, query in zip(batch["db_id"], batch["query"])
    ]

    return zip(inputs, targets)


def text2cypher_pre_process_one_function(item: dict, args):
    prefix = ""

    seq_out = text2cypher_get_target(
        query=item["query"],
        db_id=item["db_id"],
        normalize_query=True,
        target_with_db_id=args.seq2seq.target_with_db_id,
    )

    return prefix + item["question"].strip(), seq_out


def normalize(query: str) -> str:
    def comma_fix(s):
        # Remove spaces in front of commas
        return s.replace(" , ", ", ")

    def newline_fix(s):
        # Remove newline in the query
        return s.replace("\n", " ")

    def white_space_fix(s):
        # Remove double and triple spaces
        return " ".join(s.split())

    def lower(s):
        # Convert everything except text between (single or double) quotation marks to lower case
        return re.sub(
            r"\b(?<!['\"])(\w+)(?!['\"])\b", lambda match: match.group(1).lower(), s
        )

    return newline_fix(comma_fix(white_space_fix(lower(query))))


def serialize_schema_natural_language(
        question: str,
        db_id: str,
        db_property_names: Dict[str, str],
        db_tag_names: List[str],
        schema_path: str,
        schema_serialization_with_db_content: bool = False,
        normalize_query: bool = True,
) -> str:
    overall_description = f'{db_id} contains tags (node labels/edge types) such as ' \
                          f'{", ".join([tag_name.lower() if normalize_query else tag_name for tag_name in db_tag_names])}.'
    property_description = lambda tag_name, property_names: \
        f'Tag {tag_name} has properties such as {", ".join(property_names)}.'
    value_description = lambda property_value_pairs: \
        f'{"".join(["The {} contains values such as {}.".format(property, value) for property, value in property_value_pairs])}'

    descriptions = [overall_description]
    db_tag_name_strs = []
    db_property_name_strs = []
    value_sep = ", "
    for tag_id, tag_name in enumerate(db_tag_names):
        tag_name_str = tag_name.lower() if normalize_query else tag_name
        db_tag_name_strs.append(tag_name_str)
        propertys = []
        property_value_pairs = []
        for property_id, (x, y) in enumerate(zip(db_property_names["tag_id"], db_property_names["property_name"])):
            if property_id == 0:
                continue
            property_str = y.lower() if normalize_query else y
            db_property_name_strs.append(property_str)
            if x == tag_id:
                propertys.append(property_str)
                if schema_serialization_with_db_content:
                    matches = get_database_matches(
                        db_id=db_id,
                        question=question,
                        tag_name=tag_name,
                        property_name=y,
                        schema_path = schema_path
                    )
                    if matches:
                        property_value_pairs.append((property_str, value_sep.join(matches)))

        tag_description_propertys_str = db_property_names(tag_name_str, propertys)
        descriptions.append(tag_description_propertys_str)
        if len(property_value_pairs) > 0:
            value_description_str = value_description(property_value_pairs)
            descriptions.append(value_description_str)

    return " ".join(descriptions)

def serialize_schema(
        question: str,
        db_id: str,
        db_property_names: Dict[str, str],
        db_tag_names: List[str],
        schema_path: str,
        schema_serialization_type: str = "peteshaw",
        schema_serialization_randomized: bool = False,
        schema_serialization_with_db_id: bool = True,
        schema_serialization_with_db_content: bool = False,
        normalize_query: bool = True,
) -> str:
    if schema_serialization_type == "verbose":
        db_id_str = "Domain: {db_id}. "
        tag_sep = ". "
        tag_str = "tag: {tag}. propertys: {propertys}"
        property_sep = ", "
        property_str_with_values = "{property} ({values})"
        property_str_without_values = "{property}"
        value_sep = ", "
    elif schema_serialization_type == "peteshaw":
        # see https://github.com/google-research/language/blob/master/language/nqg/tasks/text2cypher/append_schema.py#L42
        db_id_str = " | {db_id}"
        tag_sep = ""
        tag_str = " | {tag} : {propertys}"
        property_sep = " , "
        property_str_with_values = "{property} ( {values} )"
        property_str_without_values = "{property}"
        value_sep = " , "
    else:
        raise NotImplementedError

    def get_property_str(tag_name: str, property_name: str) -> str:
        property_name_str = property_name.lower() if normalize_query else property_name
        if schema_serialization_with_db_content:
            matches = get_database_matches(
                db_id=db_id,
                question=question,
                tag_name=tag_name,
                property_name=property_name,
                schema_path=schema_path,
            )
            if matches:
                return property_str_with_values.format(
                    property=property_name_str, values=value_sep.join(matches)
                )
            else:
                return property_str_without_values.format(property=property_name_str)
        else:
            return property_str_without_values.format(property=property_name_str)

    tags = [
        tag_str.format(
            tag=tag_name.lower() if normalize_query else tag_name,
            propertys=property_sep.join(
                map(
                    lambda y: get_property_str(tag_name=tag_name, property_name=y[1]),
                    filter(
                        lambda y: y[0] == tag_id,
                        zip(
                            db_property_names["tag_id"],
                            db_property_names["property_name"],
                        ),
                    ),
                )
            ),
        )
        for tag_id, tag_name in enumerate(db_tag_names)
    ]
    if schema_serialization_randomized:
        random.shuffle(tags)
    if schema_serialization_with_db_id:
        serialized_schema = db_id_str.format(db_id=db_id) + tag_sep.join(tags)
    else:
        serialized_schema = tag_sep.join(tags)
    return serialized_schema


def _get_schemas(examples: Dataset) -> Dict[str, dict]:
    schemas: Dict[str, dict] = dict()
    for ex in examples:
        if ex["db_id"] not in schemas:
            schemas[ex["db_id"]] = {
                "db_tag_names": ex["db_tag_names"],
                "db_property_names": ex["db_property_names"],
                "db_property_types": ex["db_property_types"],

            }
    return schemas


"""
    Wrap the raw dataset into the seq2seq one.
    And the raw dataset item is formatted as
    {
        "query": sample["query"],
        "question": sample["question"],
        "db_id": db_id,
        "db_tag_names": schema["tag_names_original"],
        "db_property_names": [
            {"tag_id": tag_id, "property_name": property_name}
            for tag_id, property_name in schema["property_names_original"]
        ],
        "db_property_types": schema["property_types"],

    }
    """


class Constructor(object):
    def __init__(self, args):
        self.args = args

    def to_seq2seq(self, raw_datasets: DatasetDict, cache_root: str):
        if not len(raw_datasets) == 2:
            raise AssertionError("Train, Dev sections of dataset expected.")
        if getattr(self.args.seq2seq, "few_shot_rate"):
            raw_train = random.sample(list(raw_datasets["train"]), int(self.args.seq2seq.few_shot_rate * len(raw_datasets["train"])))
            train_dataset = TrainDataset(self.args, raw_train, cache_root)
        else:
            train_dataset = TrainDataset(self.args, raw_datasets["train"], cache_root)
        dev_dataset = DevDataset(self.args, raw_datasets["validation"], cache_root)

        return train_dataset, dev_dataset


class TrainDataset(Dataset):
    def __init__(self, args, raw_datasets, cache_root):
        self.args = args
        self.raw_datasets = raw_datasets

        cache_path = os.path.join(cache_root, 'text2cypher_train.cache')
        if os.path.exists(cache_path) and args.dataset.use_cache:
            self.extended_data = torch.load(cache_path)
        else:
            self.extended_data = []
            for raw_data in tqdm(self.raw_datasets):
                extend_data = deepcopy(raw_data)
                extend_data.update(text2cypher_add_serialized_schema(extend_data, args))

                question, seq_out = text2cypher_pre_process_one_function(extend_data, args=self.args)
                extend_data.update({"struct_in": extend_data["serialized_schema"].strip(),
                                    "text_in": question,
                                    "seq_out": seq_out})
                self.extended_data.append(extend_data)
            if args.dataset.use_cache:
                torch.save(self.extended_data, cache_path)

    def __getitem__(self, index) -> T_co:
        return self.extended_data[index]

    def __len__(self):
        return len(self.extended_data)


class DevDataset(Dataset):
    def __init__(self, args, raw_datasets, cache_root):
        self.args = args
        self.raw_datasets = raw_datasets

        cache_path = os.path.join(cache_root, 'text2cypher_dev.cache')
        if os.path.exists(cache_path) and args.dataset.use_cache:
            self.extended_data = torch.load(cache_path)
        else:
            self.extended_data = []
            for raw_data in tqdm(self.raw_datasets):
                extend_data = deepcopy(raw_data)
                extend_data.update(text2cypher_add_serialized_schema(extend_data, args))

                question, seq_out = text2cypher_pre_process_one_function(extend_data, args=self.args)
                extend_data.update({"struct_in": extend_data["serialized_schema"].strip(),
                                    "text_in": question,
                                    "seq_out": seq_out})
                self.extended_data.append(extend_data)
            if args.dataset.use_cache:
                torch.save(self.extended_data, cache_path)

    def __getitem__(self, index) -> T_co:
        return self.extended_data[index]

    def __len__(self):
        return len(self.extended_data)
