#!/bin/bash
set -e

mkdir -p /mnt/blob-pretraining-hptrainingwestcentralus/haoran_result/HELMET

bash scripts/download_data.sh

for task in recall_short rag_short icl_short cite_short summ_short longqa_short; do
  python eval.py --config configs/${task}.yaml \
    --model_name_or_path Qwen3/Qwen3-8B \
    --use_chat_template False # only if you are using non-instruction-tuned models, otherwise use the default.
done
mv output/* /mnt/blob-pretraining-hptrainingwestcentralus/haoran_result/HELMET/.

for task in recall_short rag_short icl_short cite_short summ_short longqa_short; do
  python eval.py --config configs/${task}.yaml \
    --model_name_or_path meta-llama/Meta-Llama-3-8B \
    --use_chat_template False # only if you are using non-instruction-tuned models, otherwise use the default.
done
mv output/* /mnt/blob-pretraining-hptrainingwestcentralus/haoran_result/HELMET/.

