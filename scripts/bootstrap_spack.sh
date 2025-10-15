#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [[ -z "${SPACK_ROOT:-}" ]]; then
	if [[ ! -d "$ROOT/.spack" ]]; then
		git clone --depth 1 https://github.com/spack/spack.git "$ROOT/.spack"
	fi
	export SPACK_ROOT="$ROOT/.spack"
fi
# shellcheck disable=SC1091
# source "$SPACK_ROOT/share/spack/setup-env.sh"
# echo "[spack] using $SPACK_ROOT"
#
