python -m torch.distributed.launch              --nproc_per_node 1               --master_port 1234 train.py               --seed 2               --cfg Salesforce/T5_base_prefix_text2cypher_with_cell_value.cfg               --run_name T5_base_prefix_text2cypher_with_cell_value              --logging_strategy steps               --logging_first_step true               --logging_steps 500               --evaluation_strategy steps               --eval_steps 400               --metric_for_best_model avr               --greater_is_better true               --save_strategy steps               --save_steps 400               --save_total_limit 1               --load_best_model_at_end               --gradient_accumulation_steps 8               --num_train_epochs 100               --adafactor true               --learning_rate 1e-4               --do_train               --do_eval               --do_predict               --predict_with_generate               --output_dir output/T5_base_prefix_text2cypher_with_cell_value           --overwrite_output_dir           --per_device_train_batch_size 4               --per_device_eval_batch_size 8               --generation_num_beams 4               --generation_max_length 512               --input_max_length 512               --ddp_find_unused_parameters true 