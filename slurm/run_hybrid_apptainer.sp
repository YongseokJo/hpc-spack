#!/bin/bash
#SBATCH -N 1
#SBATCH -n 8
#SBATCH -p gpu
#SBATCH --gpus-per-node=1
#SBATCH -t 02:00:00
#SBATCH -J ml_container

. scripts/load_for_job.sh perlmutter
module load apptainer 2>/dev/null || true
srun apptainer exec --nv containers/ml.sif python train.py

