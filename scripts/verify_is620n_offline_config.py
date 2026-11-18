"""核对 IS620N 教学工程的双轴、周期和公开路径；不连接设备。"""

from pathlib import Path
import sys
import xml.etree.ElementTree as ET


def main() -> int:
    if len(sys.argv) != 2:
        print("usage: verify_is620n_offline_config.py PROJECT_DIRECTORY", file=sys.stderr)
        return 2
    project = Path(sys.argv[1]).resolve()
    root = ET.parse(project / "beremiz.xml").getroot()
    assert root.attrib["EtherCATMasterTaskPeriod"] == "1ms"
    assert root.find("./TargetType/Linux").attrib["Compiler"] == "aarch64-buildroot-linux-gnu-gcc"
    plc = ET.parse(project / "plc.xml").getroot()
    tasks = [node for node in plc.iter() if node.tag.endswith("task")]
    assert len(tasks) == 1 and tasks[0].attrib["name"] == "MotionTask"
    assert tasks[0].attrib["interval"] == "T#1ms"
    for number in (1, 2):
        path = project / "IC_Motion@ic_motion" / f"Axis_{number}@Cia402RealAxis" / "confnode.xml"
        axis = ET.parse(path).getroot().attrib
        assert axis["Mode"] == "CSP"
        assert axis["TransportChannel"] == str(number)
        assert axis["MinimumPosition"] == "-0.95"
        assert axis["MaximumPosition"] == "0.95"
        assert axis["CountsPerUnit"] == "1048576.0"
        assert axis["PLCPeriodSeconds"] == axis["BusPeriodSeconds"] == "0.001"
    extension = (project / "IS620N_Dual_PDO@c_ext" / "confnode.xml").read_text()
    assert "-D_GNU_SOURCE -pthread" in extension
    assert extension.count("${IC_TUTORIAL_IGH_SDK}") == 2
    assert "/home/" not in extension and "/root/" not in extension
    print("IS620N offline config PASS: 1 ms CSP, two channels, ±0.95 turn, path-free SDK")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
