#!/bin/sh
# SPDX-License-Identifier: MIT
# Open a throwaway, path-resolved IS620N project in the exact V0.0.17 IDE.
set -eu

if [ "$#" -ne 4 ]; then
    echo "usage: $0 RELEASE_PACKAGE PROJECT_DIRECTORY IGH_AARCH64_SDK CROSS_COMPILER_DIRECTORY" >&2
    exit 2
fi
package=$(realpath "$1")
project=$(realpath "$2")
sdk=$(realpath "$3")
cross_bin=$(realpath "$4")
ide="$package/payload/ide/opt/brigth-plc"
extension="$ide/modules/ic-beremiz-motion/beremiz_extension/ic_motion_extension.py"
if [ "$(cat "$package/VERSION" 2>/dev/null)" != V0.0.17 ] ||
   [ ! -f "$project/beremiz.xml" ] || [ ! -f "$extension" ] ||
   [ ! -f "$sdk/include/ecrt.h" ] || [ ! -f "$sdk/lib/libethercat.so" ] ||
   [ ! -x "$cross_bin/aarch64-buildroot-linux-gnu-gcc" ] ||
   [ -z "${DISPLAY:-}" ]; then
    echo "V0.0.17 package, project, SDK, cross-compiler or DISPLAY missing" >&2
    exit 2
fi
host_python=$(command -v python3)
scratch=$(mktemp -d "${TMPDIR:-/tmp}/ic-is620n-gui.XXXXXX")
trap 'rm -rf "$scratch"' EXIT HUP INT TERM
cp -a "$project" "$scratch/project"
ln -s "$host_python" "$scratch/python3"
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
pythonpath="$ide/compat-python:$ide/beremiz:$ide/modules/ic-beremiz-motion/beremiz_extension"
if "$host_python" -c 'import sys; raise SystemExit(sys.version_info < (3, 12))'; then
    pythonpath="$ide/compat-python:$ide/python:$ide/beremiz:$ide/modules/ic-beremiz-motion/beremiz_extension"
fi
export PYTHONPATH="$pythonpath"
export IC_MODULE_ROOT="$ide/modules"
export IC_TUTORIAL_IGH_SDK="$sdk"
export MATIEC_PATH="$ide/matiec"
export PATH="$scratch:$cross_bin:$MATIEC_PATH/bin:$PATH"
export IC_SKIP_ERPC_TUNNEL=1
export PYTHONDONTWRITEBYTECODE=1
echo "IDE_VERSION=V0.0.17"
echo "PROJECT_COPY=$scratch/project"
"$host_python" -B "$ide/beremiz/Beremiz.py" --extend "$extension" \
    "$scratch/project" "$scratch/build"
