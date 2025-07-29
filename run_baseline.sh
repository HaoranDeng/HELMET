#!/bin/bash
set -e

bash scripts/download_data.sh
export model_name="OpenPAI-LongContext-17BA3B-32k-ds0714-rb1e5-remix"

CUDA_VISIBLE_DEVICES=0,1 bash run_hfhub.sh meta-llama/Meta-Llama-3-8B &
CUDA_VISIBLE_DEVICES=2,3 bash run_hfhub.sh meta-llama/Meta-Llama-3.1-8B &
CUDA_VISIBLE_DEVICES=4,5 bash run_hfhub.sh Qwen/Qwen-4B &
CUDA_VISIBLE_DEVICES=6,7 bash run_hfhub.sh Qwen/Qwen-8B &
wait