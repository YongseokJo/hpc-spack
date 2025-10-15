#!/bin/bash
#SBATCH -N 2
#SBATCH -n 64
#SBATCH -p gpu
#SBATCH --gpus-per-node=4
#SBATCH -t 02:00:00
#SBATCH -J mycode_native

. scripts/load_for_job.sh perlmutter
srun ./build/mycode

