#!/bin/sh
# SPDX-License-Identifier: MIT
# Verify the saved LD project through the selected package's offline harness.
set -eu

if [ "$#" -ne 3 ]; then
    echo "usage: $0 RELEASE_PACKAGE LD_PROJECT EXPECTED_VERSION" >&2
    exit 2
fi
package=$(realpath "$1")
project=$(realpath "$2")
expected=$3
if [ ! -f "$package/VERSION" ] || [ ! -f "$project/plc.xml" ]; then
    echo "release package or LD project is incomplete" >&2
    exit 2
fi
actual=$(tr -d '\n' < "$package/VERSION")
if [ "$actual" != "$expected" ]; then
    echo "release version mismatch: expected $expected, got $actual" >&2
    exit 2
fi

ide="$package/payload/ide/opt/brigth-plc"
module="$ide/modules/ic-beremiz-motion"
for required in "$ide/matiec/bin/iec2c" "$module/tests/test_beremiz_basic17_build.py" \
                "$module/tests/test_basic17_project_generated.c" \
                "$module/examples/beremiz_basic_17/plc.xml" \
                "$ide/beremiz/beremiz_cli_compat.py"; do
    if [ ! -f "$required" ]; then
        echo "package is missing offline verification input: $required" >&2
        exit 2
    fi
done

pythonpath="$ide/compat-python:$ide/beremiz:$module/beremiz_extension:$module/tests"
if python3 -c 'import sys; raise SystemExit(sys.version_info < (3, 12))'; then
    pythonpath="$ide/compat-python:$ide/python:$ide/beremiz:$module/beremiz_extension:$module/tests"
fi
export PYTHONPATH="$pythonpath"
export PYTHONDONTWRITEBYTECODE=1
export IC_MODULE_ROOT="$ide/modules"
export IC_C_COMPILER="$(command -v gcc)"
export IC_MATIEC_DIR="$ide/matiec"
export IC_BEREMIZ_CLI="$ide/beremiz/Beremiz_cli.py"
export IC_BEREMIZ_CLI_COMPAT="$ide/beremiz/beremiz_cli_compat.py"
export IC_BASIC17_ST_EXAMPLE="$module/examples/beremiz_basic_17"
export IC_BASIC17_LD_EXAMPLE="$project"
export IC_BASIC17_PROJECT_HARNESS="$module/tests/test_basic17_project_generated.c"
export IC_MOTION_EXTENSION="$module/beremiz_extension/ic_motion_extension.py"
export PATH="$ide/matiec/bin:$PATH"

echo "IDE_VERSION=$actual"
echo "LD_PROJECT=$project"
python3 -B "$module/tests/test_beremiz_basic17_build.py"
