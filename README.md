# hpc-stack

Reproducible HPC stack with Spack overlays per cluster, plus optional Mamba/Apptainer for ML.

## Quick start (on any cluster)

```bash
git clone https://github.com/<you>/hpc-stack.git
cd hpc-stack
make install CL=perlmutter   # or stampede2/delta

