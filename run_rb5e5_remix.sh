#!/bin/bash
set -e

bash scripts/download_data.sh
export model_name="OpenPAI-LongContext-17BA3B-32k-ds0714-rb5e5-remix"

CUDA_VISIBLE_DEVICES=0 bash run_sigma.sh 200 &
CUDA_VISIBLE_DEVICES=1 bash run_sigma.sh 400 &
CUDA_VISIBLE_DEVICES=2 bash run_sigma.sh 600 &
CUDA_VISIBLE_DEVICES=3 bash run_sigma.sh 800 &
CUDA_VISIBLE_DEVICES=4 bash run_sigma.sh 1000 &
CUDA_VISIBLE_DEVICES=5 bash run_sigma.sh 1200 &
CUDA_VISIBLE_DEVICES=6 bash run_sigma.sh 1400 &
CUDA_VISIBLE_DEVICES=7 bash run_sigma.sh 1600 &
wait