"""在发布包自带的 wx/eRPC 回环测试中选择当前值单步场景。"""

import os
from pathlib import Path
import sys


ide = Path(os.environ["IC_TUTORIAL_IDE_ROOT"])
test = ide / "beremiz" / "tests" / "test_maintenance_debug_erpc_gui.py"
if not test.is_file():
    raise SystemExit("V0.0.17 package lacks ST debug loopback test")
os.execv(sys.executable, [sys.executable, "-B", str(test), *sys.argv[1:],
                          "--current-value"])
