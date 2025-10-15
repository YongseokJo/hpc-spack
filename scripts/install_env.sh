#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLUSTER="${1:-}"
bash "$ROOT/scripts/use.sh" "$CLUSTER"
spack concretize -f
spack install --fail-fast

