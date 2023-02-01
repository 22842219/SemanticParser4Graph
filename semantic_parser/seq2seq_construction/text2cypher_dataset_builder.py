# coding=utf-8
# Copyright 2021 The HuggingFace Datasets Authors and the current dataset script contributor.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.




import json
import datasets
from preprocess.process_cypher import get_schema_from_json

logger = datasets.logging.get_logger(__name__)


_REFERENCES = """\
@article{yu2018spider,
  title={Spider: A large-scale human-labeled dataset for complex and cross-domain semantic parsing and text-to-sql task},
  author={Yu, Tao and Zhang, Rui and Yang, Kai and Yasunaga, Michihiro and Wang, Dongxu and Li, Zifan and Ma, James and Li, Irene and Yao, Qingning and Roman, Shanelle and others},
  journal={arXiv preprint arXiv:1809.08887},
  year={2018}
}

@article{raffel2020exploring,
  title={Exploring the limits of transfer learning with a unified text-to-text transformer},
  author={Raffel, Colin and Shazeer, Noam and Roberts, Adam and Lee, Katherine and Narang, Sharan and Matena, Michael and Zhou, Yanqi and Li, Wei and Liu, Peter J},
  journal={The Journal of Machine Learning Research},
  volume={21},
  number={1},
  pages={5485--5551},
  year={2020},
  publisher={JMLRORG}
}
"""

_DESCRIPTION = """\
Spider is a large-scale complex and cross-domain semantic parsing and text-toSQL dataset annotated by 11 college students.
We use a dataset transformed from a subset of Spider to train our Text-to-Cypher semantic parsing.
"""

_HOMEPAGE = ""

_LICENSE = "CC BY-SA 4.0"

_URL = "/home/22842219/Desktop/phd/SemanticParser4Graph/semantic_parser/data/text2cypher"


class Text2Cypher(datasets.GeneratorBasedBuilder):
    VERSION = datasets.Version("1.0.0")

    BUILDER_CONFIGS = [
        datasets.BuilderConfig(
            name="text2cypher",
            version=VERSION,
            description="Weakly Supervised Text-to-Cypher Semantic Parsing Oriented for Property Graph atabase",
        ),
    ]

    def __init__(self, *args, writer_batch_size=None, **kwargs):
        super().__init__(*args, writer_batch_size=writer_batch_size, **kwargs)
        self.schema_cache = dict()

    def _info(self):
        features = datasets.Features(
            {
                "query": datasets.Value("string"), 
                "question": datasets.Value("string"),
                "answers": datasets.features.Sequence(datasets.Value("string")),
                "db_id": datasets.Value("string"),
                "db_tag_names": datasets.features.Sequence(datasets.Value("string")),
                "db_property_names": datasets.features.Sequence(
                    {
                        "tag_id": datasets.Value("int32"),
                        "property_name": datasets.Value("string")
                    }),
                "db_property_types": datasets.features.Sequence(datasets.Value("string")),
 
            }
        )
        return datasets.DatasetInfo(
            description=_DESCRIPTION,
            features=features,
            supervised_keys=None,
            homepage=_HOMEPAGE,
            license=_LICENSE,
            citation=_REFERENCES,
        )

    def _split_generators(self, dl_manager):
        # downloaded_filepath = dl_manager.download_and_extract(_URL)
        downloaded_filepath = _URL

        return [
            datasets.SplitGenerator(
                name=datasets.Split.TRAIN,
                gen_kwargs={
                    "data_filepath": downloaded_filepath + "/train.json",
                },
            ),
            datasets.SplitGenerator(
                name=datasets.Split.VALIDATION,
                gen_kwargs={
                    "data_filepath": downloaded_filepath + "/dev.json",

                },
            ),
        ]

    def _generate_examples(self, data_filepath, schema_path):
        """This function returns the examples in the raw (text) form."""
        logger.info("generating examples from = %s", data_filepath)

        schema_data = get_schema_from_json(schema_path)
        with open(data_filepath, 'r', encoding="utf-8") as f:
            data = json.load(f)
            print(len(data))
            for idx, sample in enumerate(data):
                db_id = sample["db_id"]
                if db_id not in self.schema_cache:
                    self.schema_cache[db_id] = schema_data[db_id]
                every_schema = self.schema_cache[db_id]
                print(db_id)
                print(every_schema)
                print(sample)
                tags = list(every_schema.keys())[1:]
                for tag_id, tag in enumerate(tags):
                    property_name_value_pairs = every_schema[tag]
                    for pair in property_name_value_pairs:
                        for property_name, field_values in pair.items():      
                            yield idx, {
                                "db_id": db_id,
                                "query": sample["query"],
                                "question": sample["question"],
                                "answers": sample["answers"],
                                "db_tag_names": tags, 
                                "db_property_names": 
                                    [
                                        {
                                            "tag_id": tag_id, 
                                            "property_name": property_name
                                        }
                                    ],
                                "db_property_types": every_schema['property_types']
                                }

