import logging
import os
import time
from collections import OrderedDict
import torch
# import datasets
import transformers
from transformers import (
    HfArgumentParser,
    set_seed,
    EarlyStoppingCallback,
)
from transformers.trainer_utils import get_last_checkpoint



# import utils.tool
# from utils.configue import Configure
# from utils.dataset import TokenizedDataset
# from trainer import EvaluateFriendlySeq2SeqTrainer
from utils.training_arguments import WrappedSeq2SeqTrainingArguments
# Huggingface realized the "Seq2seqTrainingArguments" which is the same with "WrappedSeq2SeqTrainingArguments"
# in transformers==4.10.1 during our work.

from filelock import FileLock
import nltk
with FileLock(".lock") as lock:
    nltk.download("punkt", quiet=True)
    nltk.download("stopwords", quiet=True)
logger = logging.getLogger(__name__)
torch.use_deterministic_algorithms(True)
# Initialize the logger
logging.basicConfig(level=logging.INFO)

def main() -> None:


    # Get args
    parser = HfArgumentParser((WrappedSeq2SeqTrainingArguments,))
    training_args, = parser.parse_args_into_dataclasses()
    print(training_args)




if __name__ == "__main__":
    main()