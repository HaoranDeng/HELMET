#!/bin/bash
set -e

# Check if arguments are provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <model_name_or_path>"
    echo "Example: $0 meta-llama/Meta-Llama-3-8B"
    exit 1
fi

model_name_or_path="$1"
# Extract model name from model path for output directory
model_name=$(basename "$model_name_or_path")


for task in recall_short rag_short icl_short cite_short summ_short longqa_short; do
  python eval.py --config configs/${task}.yaml \
    --model_name_or_path ${model_name_or_path} \
    --output_dir output/${task}/${model_name}/ \
    --use_chat_template False # only if you are using non-instruction-tuned models, otherwise use the default.
  # Create target directory if it doesn't exist
  mkdir -p /mnt/blob-pretraining-hptrainingwestcentralus/haoran_result/HELMET/${task}/${model_name}
  # Copy the contents of the output directory to the target location
  cp -r output/${task}/${model_name}/* /mnt/blob-pretraining-hptrainingwestcentralus/haoran_result/HELMET/${task}/${model_name}/
  echo "Task ${task} results copied to /mnt/blob-pretraining-hptrainingwestcentralus/haoran_result/HELMET/${task}/${model_name}"
done

echo "All tasks completed! Model ${model_name} evaluation results saved to /mnt/blob-pretraining-hptrainingwestcentralus/haoran_result/HELMET/ with task-specific subdirectories"

