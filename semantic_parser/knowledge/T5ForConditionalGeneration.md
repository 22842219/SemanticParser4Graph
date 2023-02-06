### class transformers.T5ForConditionalGeneration

It is a T5 model with a **lanugage modeling head** on top. 

:point_right: T5 model
- [Exploring the Limits of Transfer Learning with a Unified Text-to-Text Transformer](https://arxiv.org/abs/1910.10683)
- It is an encoder decoder transformer pre-trained in a text-to-text denoising generative setting. 
- parameters:
    - T5-small with 60 million parameters.
    - T5-base with 220 million parameters.
    - T5-large with 770 million parameters.
    - T5-3B with 3 billion parameters.
    - T5-11B with 11 billion parameters.

- T5 expects a prefix before the input text to understand the task given by the user. For example, “summarize:” for the summarization, “cola sentence:” for the classification, “translate English to Spanish:” for the machine translation, etc., You can have a look at the below image to understand the above illustration.

- improved transformer architecture
- massive unsupervised training data
- better decoding methods, e.g.,  
    - greedy search
    - beam search
    - top-K sampling
    - top-p sampling
    - :point_down: check this blog for more idea. 
        - [How to generate text: using different decoding methods for language generation with Transformers](https://huggingface.co/blog/how-to-generate)


: point_right: Controllable generation
- [CTRL: A CONDITIONAL TRANSFORMER LANGUAGE MODEL FOR CONTROLLABLE GENERATION](https://arxiv.org/pdf/1909.05858.pdf)
    - train a model to condition on cotrol codes that govern style, content, and task-specific behavior. 
    - control codes were derived from structure that naturlally co-occurs with raw text. 
    - all control codes can be traced back to a particular subset of the training data. 
        - style by domain
    