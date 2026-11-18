#!/bin/sh
# SPDX-License-Identifier: MIT
# Open the package IDE on a local mapping example without a Runtime tunnel.
set -eu

if [ "$#" -ne 3 ]; then
    echo "usage: $0 RELEASE_PACKAGE MAPPING_PROJECT EXPECTED_VERSION" >&2
    exit 2
fi
package=$(realpath "$1")
project=$(realpath "$2")
expected=$3
if [ ! -f "$package/VERSION" ] || [ ! -f "$project/device-catalog.json" ]; then
    echo "release package or mapping project is incomplete" >&2
    exit 2
fi
actual=$(tr -d '\n' < "$package/VERSION")
if [ "$actual" != "$expected" ]; then
    echo "release version mismatch: expected $expected, got $actual" >&2
    exit 2
fi
ide="$package/payload/ide/opt/brigth-plc"
module="$ide/modules"
validator="$module/ic-device-library/lib/libic_mapping_validator.so"
extension="$module/ic-beremiz-motion/beremiz_extension/ic_motion_extension.py"
if [ ! -f "$validator" ] || [ ! -f "$module/ic-device-library/python/ic_device_catalog.py" ] || [ ! -f "$extension" ]; then
    echo "package is missing the offline mapping editor dependencies" >&2
    exit 2
fi
if [ -z "${DISPLAY:-}" ]; then
    echo "DISPLAY is required for the desktop IDE" >&2
    exit 2
fi
pythonpath="$ide/compat-python:$ide/beremiz:$module/ic-device-library/python:$module/ic-beremiz-motion/beremiz_extension"
if python3 -c 'import sys; raise SystemExit(sys.version_info < (3, 12))'; then
    pythonpath="$ide/compat-python:$ide/python:$ide/beremiz:$module/ic-device-library/python:$module/ic-beremiz-motion/beremiz_extension"
fi
export PYTHONPATH="$pythonpath"
export PYTHONDONTWRITEBYTECODE=1
export IC_MODULE_ROOT="$module"
export IC_MAPPING_VALIDATOR_LIBRARY="$validator"
export MATIEC_PATH="$ide/matiec"
export PATH="$ide/matiec/bin:$PATH"
export IC_SKIP_ERPC_TUNNEL=1
echo "IDE_VERSION=$actual"
echo "OFFLINE_PROJECT=$project"
exec python3 -B "$ide/beremiz/Beremiz.py" -e "$extension" "$project"
