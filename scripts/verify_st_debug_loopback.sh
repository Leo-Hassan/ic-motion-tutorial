#!/bin/sh
# SPDX-License-Identifier: MIT
# Compile a bounded host-only ST debug candidate and exercise real wx/eRPC steps.
set -eu

if [ "$#" -ne 4 ]; then
    echo "usage: $0 RELEASE_PACKAGE PROJECT_DIRECTORY ADAPTER_SOURCE HOST_LIBRARY" >&2
    exit 2
fi
package=$(realpath "$1")
project=$(realpath "$2")
adapter=$(realpath "$3")
host=$(realpath "$4")
ide="$package/payload/ide/opt/brigth-plc"
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
source_file="$project/maintenance_debug.st"
if [ "$(cat "$package/VERSION" 2>/dev/null)" != V0.0.17 ] ||
   [ ! -f "$project/plc.xml" ] || [ ! -f "$source_file" ] ||
   [ ! -f "$adapter/tools/matiec_debug_map.py" ] ||
   [ ! -f "$adapter/tools/matiec_maintenance_artifact.py" ] ||
   [ ! -f "$adapter/tests/verify_maintenance_debug_executor.cmake" ] ||
   [ ! -f "$host" ] || [ ! -x "$ide/matiec/bin/iec2c" ] ||
   [ ! -f "$ide/beremiz/tests/test_maintenance_debug_erpc_gui.py" ]; then
    echo "V0.0.17 package, source, adapter or host library missing" >&2
    exit 2
fi
if [ -z "${DISPLAY:-}" ]; then
    echo "DISPLAY is required for the real wx loopback test" >&2
    exit 2
fi

scratch=$(mktemp -d "${TMPDIR:-/tmp}/ic-st-debug.XXXXXX")
trap 'rm -rf "$scratch"' EXIT HUP INT TERM
mkdir "$scratch/toolchain"
ln -s "$ide/matiec/bin/iec2c" "$scratch/toolchain/iec2c"
ln -s "$ide/matiec/lib" "$scratch/toolchain/lib"
pythonpath="$ide/compat-python:$ide/beremiz:$ide/modules/ic-beremiz-motion/beremiz_extension"
if python3 -c 'import sys; raise SystemExit(sys.version_info < (3, 12))'; then
    pythonpath="$ide/compat-python:$ide/python:$ide/beremiz:$ide/modules/ic-beremiz-motion/beremiz_extension"
fi
export IC_TUTORIAL_IDE_ROOT="$ide"
export PYTHONDONTWRITEBYTECODE=1
echo "IDE_VERSION=V0.0.17"
echo "ADAPTER_COMMIT=$(git -C "$adapter" rev-parse HEAD 2>/dev/null || echo unavailable)"
echo "SOURCE_SHA256=$(sha256sum "$source_file" | cut -d ' ' -f 1)"
cmake \
    -DIEC2C="$scratch/toolchain/iec2c" \
    -DSOURCE="$source_file" \
    -DOUTPUT_DIR="$scratch/generated" \
    -DPYTHON=python3 \
    -DMAP_TOOL="$adapter/tools/matiec_debug_map.py" \
    -DARTIFACT_TOOL="$adapter/tools/matiec_maintenance_artifact.py" \
    -DC_COMPILER=cc \
    -DADAPTER_INCLUDE="$adapter/include" \
    -DREADELF=readelf \
    -DTEST_SCRIPT="$script_dir/st_current_value_test_wrapper.py" \
    -DHOST_LIBRARY="$host" \
    -DTEST_PYTHONPATH="$pythonpath" \
    -P "$adapter/tests/verify_maintenance_debug_executor.cmake"
