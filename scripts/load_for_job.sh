#!/usr/bin/env bash
# Source this in Slurm scripts:  . scripts/load_for_job.sh perlmutter
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLUSTER="${1:-}"
bash "$ROOT/scripts/use.sh" "$CLUSTER" >/dev/null
#spack load openmpi cuda hdf5 fftw cmake
