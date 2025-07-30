#!/bin/bash
set -e

# bash scripts/download_data.sh
export model_name="OpenPAI-LongContext-17BA3B-32k-ds0714-rb5e5-remix"

CUDA_VISIBLE_DEVICES=0 bash run_sigma.sh 200