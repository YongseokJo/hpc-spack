#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SPACK_DIR="$ROOT/.spack"

if [[ -z "${SPACK_ROOT:-}" ]]; then
	if [[ ! -d "$ROOT/.spack" ]]; then
		git clone --depth 2 https://github.com/spack/spack.git "$ROOT/.spack"
	fi
	export SPACK_ROOT=$ROOT/.spack
fi



# Add to bashrc if not already there
BASHRC="$HOME/.bash_profile"
SPACK_LINE="export SPACK_ROOT=\"$SPACK_DIR\"; [ -f \"\$SPACK_ROOT/share/spack/setup-env.sh\" ] && . \"\$SPACK_ROOT/share/spack/setup-env.sh\""

# Load it into current shell
export SPACK_ROOT="$SPACK_DIR"
# shellcheck disable=SC1091
source "$SPACK_ROOT/share/spack/setup-env.sh"

if ! grep -q "SPACK_ROOT=.*$SPACK_DIR" "$BASHRC" 2>/dev/null; then
  {
    echo ""
    echo "# >>> Spack setup >>>"
    echo "export SPACK_ROOT=\"$SPACK_DIR\""
    echo "#[ -f \"\$SPACK_ROOT/share/spack/setup-env.sh\" ] && . \"\$SPACK_ROOT/share/spack/setup-env.sh\""
    echo "export PATH=\"$SPACK_DIR\"/bin:$PATH"
    echo "# <<< Spack setup <<<"
  } >> "$BASHRC"
  echo "[spack] Added Spack initialization to ~/.bashrc"
else
  echo "[spack] ~/.bashrc already contains Spack setup"
fi



echo "[spack] Ready → $(spack --version)"
