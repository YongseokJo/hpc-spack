#!/bin/bash
#SBATCH -N 1
#SBATCH -n 8
#SBATCH -p gpu
#SBATCH --gpus-per-node=1
#SBATCH -t 02:00:00
#SBATCH -J ml_hybrid

. scripts/load_for_job.sh perlmutter
# micromamba bootstrap once, then reuse
source ~/.mambaforge/etc/profile.d/mamba.sh 2>/dev/null || true
if ! command -v mamba >/dev/null; then bash scripts/mamba_bootstrap.sh; fi
source ~/.mambaforge/etc/profile.d/conda.sh
mamba activate /scratch/$USER/envs/abyss || mamba create -y -p /scratch/$USER/envs/abyss python=3.11 pytorch=2.4.* cudatoolkit=12.1 -c pytorch -c nvidia && mamba activate /scratch/$USER/envs/abyss

srun python train.py

