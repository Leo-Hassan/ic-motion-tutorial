#!/bin/sh
# SPDX-License-Identifier: MIT
# Cross-build the sanitized IS620N teaching copy without connecting a device.
set -eu

if [ "$#" -ne 4 ]; then
    echo "usage: $0 RELEASE_PACKAGE PROJECT_DIRECTORY IGH_AARCH64_SDK CROSS_COMPILER_DIRECTORY" >&2
    exit 2
fi
package=$(realpath "$1")
project=$(realpath "$2")
sdk=$(realpath "$3")
cross_bin=$(realpath "$4")
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
if [ "$(cat "$package/VERSION" 2>/dev/null)" != V0.0.17 ] ||
   [ ! -f "$project/beremiz.xml" ] ||
   [ ! -f "$sdk/include/ecrt.h" ] ||
   [ ! -f "$sdk/lib/libethercat.so" ] ||
   [ ! -x "$cross_bin/aarch64-buildroot-linux-gnu-gcc" ]; then
    echo "V0.0.17 package, offline project, IgH AArch64 SDK or cross-compiler missing" >&2
    exit 2
fi
export IC_TUTORIAL_IGH_SDK="$sdk"
host_python=$(command -v python3)
scratch=$(mktemp -d "${TMPDIR:-/tmp}/ic-cross-path.XXXXXX")
trap 'rm -rf "$scratch"' EXIT HUP INT TERM
ln -s "$host_python" "$scratch/python3"
cp -a "$project" "$scratch/project"
# Beremiz expands some C flags but preserves LDFLAGS literally. Resolve both
# paths only in the throwaway copy; keep the published project path-free.
python3 - "$scratch/project/IS620N_Dual_PDO@c_ext/confnode.xml" "$sdk" <<'PY'
from pathlib import Path
import sys
config = Path(sys.argv[1])
text = config.read_text()
marker = "${IC_TUTORIAL_IGH_SDK}"
if text.count(marker) != 2:
    raise SystemExit("unexpected IS620N SDK placeholder count")
config.write_text(text.replace(marker, sys.argv[2]))
PY
export PATH="$scratch:$cross_bin:$PATH"
echo "IGH_SDK=$sdk"
echo "CROSS_CC=$cross_bin/aarch64-buildroot-linux-gnu-gcc"
"$script_dir/clean_build.sh" "$package" "$scratch/project" V0.0.17
