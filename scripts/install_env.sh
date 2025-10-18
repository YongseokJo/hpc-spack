# scripts/install_env.sh
#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLUSTER="${1:-}"
if [[ -z "$CLUSTER" ]]; then echo "usage: $0 <cluster>"; exit 1; fi

# Ensure Spack is available *in this shell*
source "$ROOT/scripts/activate_spack.sh"

ENV_DIR="$ROOT/envs/$CLUSTER"
BASE_DIR="$ROOT/envs/base"
ENV_REAL="$ENV_DIR/.env"

# Create env only if it doesn't exist
if [[ ! -d "$ENV_REAL" ]]; then
  spack env create -d "$ENV_REAL"
fi
spack env activate -d "$ENV_REAL"

# Seed/refresh files (don't clobber user's edits)
cp -f "$BASE_DIR/spack.yaml" "$ENV_REAL/spack.yaml"
[[ -f "$ENV_DIR/packages.yaml"  ]] && cp -f "$ENV_DIR/packages.yaml"  "$ENV_REAL/packages.yaml"
[[ -f "$ENV_DIR/compilers.yaml" ]] && cp -f "$ENV_DIR/compilers.yaml" "$ENV_REAL/compilers.yaml"

spack concretize -f
spack install --fail-fast
