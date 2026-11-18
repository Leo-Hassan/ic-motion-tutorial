(* SPDX-License-Identifier: MIT *)
PROGRAM MAIN
VAR
    Speed : DINT;
    ScanCount : UDINT;
END_VAR
Speed := 10;
Speed := 20;
ScanCount := ScanCount + 1;
END_PROGRAM

CONFIGURATION Config0
RESOURCE Res0 ON PLC
    TASK MainTask(INTERVAL := T#20ms, PRIORITY := 0);
    PROGRAM MainInstance WITH MainTask : MAIN;
END_RESOURCE
END_CONFIGURATION
