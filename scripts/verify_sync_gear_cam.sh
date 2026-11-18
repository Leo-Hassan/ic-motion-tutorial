#!/bin/sh
# SPDX-License-Identifier: MIT
# Exercise the saved Gear/Cam project with the exact V0.0.17 package tools.
set -eu

if [ "$#" -ne 2 ]; then
    echo "usage: $0 RELEASE_PACKAGE SYNC_PROJECT_DIRECTORY" >&2
    exit 2
fi
package=$(realpath "$1")
project=$(realpath "$2")
ide="$package/payload/ide/opt/brigth-plc"
motion="$ide/modules/ic-beremiz-motion"
extension="$motion/beremiz_extension/ic_motion_extension.py"
if [ "$(cat "$package/VERSION" 2>/dev/null)" != V0.0.17 ] ||
   [ ! -f "$project/project-manifest.json" ] ||
   [ ! -f "$motion/tests/test_v15_beremiz_sync_project.py" ] ||
   [ ! -f "$motion/tests/test_sync_gear_cam_project_generated.c" ] ||
   [ ! -f "$motion/tools/generate_sync_gear_cam_project.py" ] ||
   [ ! -f "$ide/beremiz/beremiz_cli_compat.py" ] ||
   [ ! -f "$extension" ] || [ ! -x "$ide/matiec/bin/iec2c" ]; then
    echo "V0.0.17 package or saved Gear/Cam project incomplete" >&2
    exit 2
fi
pythonpath="$ide/compat-python:$ide/beremiz:$motion/beremiz_extension:$motion/tests"
if python3 -c 'import sys; raise SystemExit(sys.version_info < (3, 12))'; then
    pythonpath="$ide/compat-python:$ide/python:$ide/beremiz:$motion/beremiz_extension:$motion/tests"
fi
export PYTHONPATH="$pythonpath"
export PYTHONDONTWRITEBYTECODE=1
export IC_MODULE_ROOT="$ide/modules"
export IC_C_COMPILER=cc
export IC_MATIEC_DIR="$ide/matiec/bin"
export IC_MATIEC_ROOT="$ide/matiec"
export IC_BEREMIZ_CLI="$ide/beremiz/Beremiz_cli.py"
export IC_BEREMIZ_CLI_COMPAT="$ide/beremiz/beremiz_cli_compat.py"
export IC_BEREMIZ_ROOT="$ide/beremiz"
export IC_SYNC_PROJECT="$project"
export IC_SYNC_PROJECT_GENERATOR="$motion/tools/generate_sync_gear_cam_project.py"
export IC_SYNC_PROJECT_HARNESS="$motion/tests/test_sync_gear_cam_project_generated.c"
export IC_MOTION_EXTENSION="$extension"
echo "IDE_VERSION=V0.0.17"
echo "PROJECT=$project"
python3 -B "$motion/tests/test_v15_beremiz_sync_project.py"
