# scripts/activate_spack.sh
#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SPACK_DIR="$ROOT/.spack"

# Bootstrap clone if missing (safe if already present)
if [[ ! -f "$SPACK_DIR/share/spack/setup-env.sh" ]]; then
  echo "[spack] installing into $SPACK_DIR"
  git clone --depth 2 https://github.com/spack/spack.git "$SPACK_DIR"
fi

export SPACK_ROOT="$SPACK_DIR"
# shellcheck disable=SC1091
source "$SPACK_ROOT/share/spack/setup-env.sh"

