#!/bin/bash

dst_names=(
    "all"
)


dst_types=(
    "merged"
)

score_funcs=(
    "mean"
    "last"
)

label_types=(
    "soft"
    # "hard"
)

c_metrics=(
    "rougel"
    "sentsim"
    "include"
)

log_path="/mnt/petrelfs/guoyiqiu/coding/slurm_log/%j-%x.out"
model_name="vicuna-7b-v1.1"
c_th=0.5
lr=1e-3
gradient_accumulation_steps=4
batch_size=16
epochs=20
max_train_data_size=20000
max_val_data_size=1000


for dst_name in "${dst_names[@]}"; do
    for dst_type in "${dst_types[@]}"; do
        train_dst_path=cached_results/"$model_name"/"$dst_type"/"$dst_name"_train
        val_dst_path=cached_results/"$model_name"/"$dst_type"/"$dst_name"_validation
        for score_func in "${score_funcs[@]}"; do
            for label_type in "${label_types[@]}"; do
                for c_metric in "${c_metrics[@]}"; do
                    job_name=train_"$dst_name"_"$dst_type"_"$score_func"_"$label_type"_"$c_metric"
                    srun --async -o $log_path -e $log_path -J $job_name -p medai --gres=gpu:1 --quotatype=spot python train_certainty_vector.py \
                        --model_name=$model_name \
                        --train_dst_path=$train_dst_path \
                        --val_dst_path=$val_dst_path \
                        --c_metric=$c_metric \
                        --c_th=$c_th \
                        --score_func=$score_func \
                        --lr=$lr \
                        --batch_size=$batch_size \
                        --gradient_accumulation_steps=$gradient_accumulation_steps \
                        --epochs=$epochs \
                        --max_train_data_size=$max_train_data_size \
                        --max_val_data_size=$max_val_data_size \
                        --label_type=$label_type
                    sleep 0.5
                done
            done
        done
    done
done

sleep 2
rm batchscript*