#!/bin/bash
set -e

bash scripts/download_data.sh
export model_name="OpenPAI-LongContext-17BA3B-32k-ds0714-rb1e5-remix"

CUDA_VISIBLE_DEVICES=0 bash run_hfhub.sh meta-llama/Meta-Llama-3-8B &
CUDA_VISIBLE_DEVICES=1 bash run_hfhub.sh meta-llama/Meta-Llama-3.1-8B &
CUDA_VISIBLE_DEVICES=2 bash run_hfhub.sh Qwen/Qwen3-4B &
CUDA_VISIBLE_DEVICES=3 bash run_hfhub.sh Qwen/Qwen3-8B &
wait