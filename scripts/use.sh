#!/usr/bin/env bash
# Usage: scripts/use.sh perlmutter  (or stampede2/delta/…)
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLUSTER="${1:-}"
if [[ -z "$CLUSTER" ]]; then echo "usage: $0 <cluster>"; exit 1; fi

source "$ROOT/scripts/bootstrap_spack.sh"
ENV_DIR="$ROOT/envs/$CLUSTER"
BASE_DIR="$ROOT/envs/base"

spack env deactivate || true
spack env create -d "$ENV_DIR/.env" || true
spack env activate -d "$ENV_DIR/.env"

# Layer base + overlay: copy/merge on first use
cp -f "$BASE_DIR/spack.yaml" "$ENV_DIR/.env/spack.yaml"
[[ -f "$ENV_DIR/packages.yaml" ]]  && mkdir -p "$ENV_DIR/.env" && cp -f "$ENV_DIR/packages.yaml"  "$ENV_DIR/.env/packages.yaml"
[[ -f "$ENV_DIR/compilers.yaml" ]] && mkdir -p "$ENV_DIR/.env" && cp -f "$ENV_DIR/compilers.yaml" "$ENV_DIR/.env/compilers.yaml"

echo "[spack] active env: $CLUSTER"
