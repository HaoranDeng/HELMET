#!/bin/bash
set -e

# 检查是否提供了参数
if [ $# -ne 1 ]; then
    echo "用法: $0 <iter>"
    echo "例如: $0 25"
    exit 1
fi

# 检查环境变量是否设置
if [ -z "$model_name" ]; then
    echo "错误: 环境变量 model_name 未设置"
    echo "请先运行: export model_name=\"lcft_Meta-Llama-3-8B_ready_SP10B-raw_bsz64_steps5000_lr1e-5_warmup0.1\""
    exit 1
fi

mkdir -p /mnt/blob-pretraining-hptraining/haoran_result/LongFilter

# 从环境变量获取模型名称，从命令行参数获取迭代数
iter="$1"
checkpoint_name="checkpoint-${iter}"

# 构建模型路径
model_path="/mnt/blob-pretraining-hptraining/long_corpus/checkpoints/${model_name}/${checkpoint_name}"

echo "Starting evaluation for model ${model_name} at ${checkpoint_name}"

for task in recall_short rag_short icl_short cite_short; do
  python eval.py --config configs/${task}.yaml \
    --num_workers 20 \
    --model_name_or_path ${model_path} \
    --output_dir output/${task}/${model_name}_${checkpoint_name}/ \
    --use_chat_template False # only if you are using non-instruction-tuned models, otherwise use the default.
  # Create target directory if it doesn't exist
  mkdir -p /mnt/blob-pretraining-hptraining/haoran_result/LongFilter/${task}/${model_name}_${checkpoint_name}
  # Move the contents of the output directory to the target location
  mv output/${task}/${model_name}_${checkpoint_name}/* /mnt/blob-pretraining-hptraining/haoran_result/LongFilter/${task}/${model_name}_${checkpoint_name}/
  # Remove the empty local output directory
  rmdir output/${task}/${model_name}_${checkpoint_name}
  echo "Task ${task} results moved to /mnt/blob-pretraining-hptraining/haoran_result/LongFilter/${task}/${model_name}_${checkpoint_name}"
done

echo "All tasks completed! Model ${model_name}_${checkpoint_name} evaluation results saved to /mnt/blob-pretraining-hptraining/haoran_result/HELMET/ with task-specific subdirectories"