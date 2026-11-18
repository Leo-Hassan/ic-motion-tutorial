#!/bin/sh
# SPDX-License-Identifier: MIT
# Build a tutorial project with the selected release package, entirely offline.
set -eu

if [ "$#" -ne 3 ]; then
    echo "usage: $0 RELEASE_PACKAGE PROJECT_DIRECTORY EXPECTED_VERSION" >&2
    exit 2
fi

package=$(realpath "$1")
project=$(realpath "$2")
expected=$3

if [ ! -f "$package/VERSION" ] || [ ! -f "$project/beremiz.xml" ]; then
    echo "missing release VERSION or project beremiz.xml" >&2
    exit 2
fi
actual=$(tr -d '\n' < "$package/VERSION")
if [ "$actual" != "$expected" ]; then
    echo "release version mismatch: expected $expected, got $actual" >&2
    exit 2
fi

ide="$package/payload/ide/opt/brigth-plc"
cli="$ide/beremiz/beremiz_cli_compat.py"
extension="$ide/modules/ic-beremiz-motion/beremiz_extension/ic_motion_extension.py"
if [ ! -f "$cli" ] || [ ! -f "$extension" ] || [ ! -x "$ide/matiec/bin/iec2c" ]; then
    echo "incomplete release toolchain" >&2
    exit 2
fi

scratch=$(mktemp -d "${TMPDIR:-/tmp}/ic-tutorial-build.XXXXXX")
trap 'rm -rf "$scratch"' EXIT HUP INT TERM
cp -a "$project" "$scratch/project"

pythonpath="$ide/compat-python:$ide/beremiz:$ide/modules/ic-beremiz-motion/beremiz_extension"
if python3 -c 'import sys; raise SystemExit(sys.version_info < (3, 12))'; then
    pythonpath="$ide/compat-python:$ide/python:$ide/beremiz:$ide/modules/ic-beremiz-motion/beremiz_extension"
fi
export PYTHONPATH="$pythonpath"
export IC_MODULE_ROOT="$ide/modules"
export MATIEC_PATH="$ide/matiec"
export PATH="$MATIEC_PATH/bin:$PATH"
export PYTHONDONTWRITEBYTECODE=1

echo "IDE_VERSION=$actual"
echo "PROJECT=$project"
python3 -B "$cli" --project-home "$scratch/project" \
    --buildpath "$scratch/build" --extend "$extension" clean build
sha256sum "$scratch/build/project.so" "$scratch/build/VARIABLES.csv"
