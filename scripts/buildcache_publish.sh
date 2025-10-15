#!/usr/bin/env bash
# Usage: scripts/buildcache_publish.sh perlmutter s3://my-bucket/perlmutter
set -euo pipefail
CLUSTER="${1:-}"; MIRROR="${2:-}"
if [[ -z "$CLUSTER" || -z "$MIRROR" ]]; then echo "usage: $0 <cluster> <mirror-url>"; exit 1; fi
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
bash "$ROOT/scripts/use.sh" "$CLUSTER"
spack mirror add "$CLUSTER" "$MIRROR" || true
spack buildcache keys --install --trust || true
spack buildcache create -a -r -u -d "$MIRROR" $(spack find --format '{hash}')
echo "[buildcache] published to $MIRROR"

