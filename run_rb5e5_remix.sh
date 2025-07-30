#!/bin/bash
set -e

bash scripts/download_data.sh
export model_name="OpenPAI-LongContext-17BA3B-32k-ds0714-rb5e5-remix"
CUDA_VISIBLE_DEVICES=0,1 bash run_sigma.sh 1800 &
CUDA_VISIBLE_DEVICES=2,3 bash run_sigma.sh 2000 &

export model_name="OpenPAI-LongContext-17BA3B-32k-ds0714-rb2e5-remix"
CUDA_VISIBLE_DEVICES=4,5 bash run_sigma.sh 1800 &
CUDA_VISIBLE_DEVICES=6,7 bash run_sigma.sh 2000 &
wait