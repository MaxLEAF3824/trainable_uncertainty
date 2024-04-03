#!/bin/bash
#SBATCH --job-name=train_vc
#SBATCH --partition=medai
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --quotatype=spot
#SBATCH --output=/mnt/petrelfs/guoyiqiu/coding/slurm_log/%x-%j.out
#SBATCH --error=/mnt/petrelfs/guoyiqiu/coding/slurm_log/%x-%j.out

# dst_name="sciq_s"
# train_dst_path="/mnt/petrelfs/guoyiqiu/coding/trainable_uncertainty/cached_results/short/allenai_sciq_train_2000_vicuna-7b-v1.1"
# val_dst_path="/mnt/petrelfs/guoyiqiu/coding/trainable_uncertainty/cached_results/short/allenai_sciq_validation_1000_vicuna-7b-v1.1"

# dst_name="medqa_s"
# train_dst_path="/mnt/petrelfs/guoyiqiu/coding/trainable_uncertainty/cached_results/short/GBaker_MedQA-USMLE-4-options_train_10178_vicuna-7b-v1.1"
# val_dst_path="/mnt/petrelfs/guoyiqiu/coding/trainable_uncertainty/cached_results/short/GBaker_MedQA-USMLE-4-options_test_1273_vicuna-7b-v1.1"

# dst_name="triviaqa_s"
# train_dst_path="/mnt/petrelfs/guoyiqiu/coding/trainable_uncertainty/cached_results/short/lucadiliello_triviaqa_train_10000_vicuna-7b-v1.1"
# val_dst_path="/mnt/petrelfs/guoyiqiu/coding/trainable_uncertainty/cached_results/short/lucadiliello_triviaqa_validation_7785_vicuna-7b-v1.1"

# dst_name="medmcqa_s"
# train_dst_path="/mnt/petrelfs/guoyiqiu/coding/trainable_uncertainty/cached_results/short/openlifescienceai_medmcqa_train_182822_vicuna-7b-v1.1"
# val_dst_path="/mnt/petrelfs/guoyiqiu/coding/trainable_uncertainty/cached_results/short/openlifescienceai_medmcqa_validation_4183_vicuna-7b-v1.1"

# dst_name="coqa_s"
# train_dst_path="/mnt/petrelfs/guoyiqiu/coding/trainable_uncertainty/cached_results/short/stanfordnlp_coqa_train_2000_vicuna-7b-v1.1"
# val_dst_path="/mnt/petrelfs/guoyiqiu/coding/trainable_uncertainty/cached_results/short/stanfordnlp_coqa_validation_500_vicuna-7b-v1.1"

# dst_name="sciq_l"
# train_dst_path="/mnt/petrelfs/guoyiqiu/coding/trainable_uncertainty/cached_results/long/allenai_sciq_train_11679_vicuna-7b-v1.1_long"
# val_dst_path="/mnt/petrelfs/guoyiqiu/coding/trainable_uncertainty/cached_results/long/allenai_sciq_validation_1000_vicuna-7b-v1.1_long"

# dst_name="medqa_l"
# train_dst_path="/mnt/petrelfs/guoyiqiu/coding/trainable_uncertainty/cached_results/long/GBaker_MedQA-USMLE-4-options_train_10000_vicuna-7b-v1.1_long"
# val_dst_path="/mnt/petrelfs/guoyiqiu/coding/trainable_uncertainty/cached_results/long/GBaker_MedQA-USMLE-4-options_test_1000_vicuna-7b-v1.1_long"

# dst_name="triviaqa_l"
# train_dst_path="/mnt/petrelfs/guoyiqiu/coding/trainable_uncertainty/cached_results/long/lucadiliello_triviaqa_train_10000_vicuna-7b-v1.1_long"
# val_dst_path="/mnt/petrelfs/guoyiqiu/coding/trainable_uncertainty/cached_results/long/lucadiliello_triviaqa_validation_1000_vicuna-7b-v1.1_long"

# dst_name="medmcqa_l"
# train_dst_path="/mnt/petrelfs/guoyiqiu/coding/trainable_uncertainty/cached_results/long/openlifescienceai_medmcqa_train_10000_vicuna-7b-v1.1_long"
# val_dst_path="/mnt/petrelfs/guoyiqiu/coding/trainable_uncertainty/cached_results/long/openlifescienceai_medmcqa_validation_1000_vicuna-7b-v1.1_long"

# dst_name="coqa_l"
# train_dst_path="/mnt/petrelfs/guoyiqiu/coding/trainable_uncertainty/cached_results/long/stanfordnlp_coqa_train_7199_vicuna-7b-v1.1_long"
# val_dst_path="/mnt/petrelfs/guoyiqiu/coding/trainable_uncertainty/cached_results/long/stanfordnlp_coqa_validation_500_vicuna-7b-v1.1_long"


model_name="vicuna-7b-v1.1"
c_metric="rougel"
c_th=0.5
lr=1e-3
batch_size=16
epochs=5
label_type='soft'
max_train_data_size=2000
max_val_data_size=1000

python train_certainty_vector.py \
    --model_name=$model_name \
    --train_dst_path=$train_dst_path \
    --val_dst_path=$val_dst_path \
    --c_metric=$c_metric \
    --c_th=$c_th \
    --score_func="last" \
    --lr=$lr \
    --batch_size=$batch_size \
    --epochs=$epochs \
    --max_train_data_size=$max_train_data_size \
    --max_val_data_size=$max_val_data_size \
    --label_type=$label_type

python train_certainty_vector.py \
    --model_name=$model_name \
    --train_dst_path=$train_dst_path \
    --val_dst_path=$val_dst_path \
    --c_metric=$c_metric \
    --c_th=$c_th \
    --score_func="mean" \
    --lr=$lr \
    --batch_size=$batch_size \
    --epochs=$epochs \
    --max_train_data_size=$max_train_data_size \
    --max_val_data_size=$max_val_data_size \
    --label_type=$label_type