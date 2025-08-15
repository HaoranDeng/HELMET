#!/bin/bash
set -e

export model_name="lcft_Meta-Llama-3-8B_ready_SP10B-dl_bsz64_steps5000_lr1e-5_warmup0.1"
CUDA_VISIBLE_DEVICES=0,1 bash run_longfilter.sh 50 &
CUDA_VISIBLE_DEVICES=2,3 bash run_longfilter.sh 100 &
CUDA_VISIBLE_DEVICES=4,5 bash run_longfilter.sh 150 &
CUDA_VISIBLE_DEVICES=6,7 bash run_longfilter.sh 200 &
wait