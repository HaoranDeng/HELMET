#!/bin/bash
set -e

# 检查是否提供了参数
if [ $# -eq 0 ]; then
    echo "用法: $0 <iter_number>"
    echo "例如: $0 1000"
    exit 1
fi

# 检查环境变量是否设置
if [ -z "$model_name" ]; then
    echo "错误: 环境变量 model_name 未设置"
    echo "请先运行: export model_name=\"your_model_name\""
    exit 1
fi

mkdir -p /mnt/blob-pretraining-hptrainingwestcentralus/haoran_result/HELMET
blob_ckpt_path="/mnt/blob-pretraining-hptrainingwestcentralus/checkpoints"
iter="hf_iter_$1"
model_path="${blob_ckpt_path}/${model_name}/${iter}"

for task in recall_short; do
  python eval.py --config configs/${task}.yaml \
    --model_name_or_path ${model_path} \
    --output_dir output/${model_name}_${iter}/ \
    --use_chat_template False # only if you are using non-instruction-tuned models, otherwise use the default.
  mv output/${model_name}_${iter} /mnt/blob-pretraining-hptrainingwestcentralus/haoran_result/HELMET/${model_name}_${iter}
done