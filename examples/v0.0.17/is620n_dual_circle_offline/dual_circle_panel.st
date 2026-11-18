(* SPDX-License-Identifier: MIT
   PLC Run-only acceptance program: after 3 s of continuous PDO safety readiness,
   power both axes, execute exactly two full circles, then stop and disable. *)
PROGRAM DualCirclePanel
VAR_EXTERNAL
    Axis_1 : AXIS_REF;
    Axis_2 : AXIS_REF;
    PDO_SafetyReady : BOOL;
    PDO_EnableReady : BOOL;
    PDO_ResetReady : BOOL;
    PDO_GuardError : UINT;
    PDO_Statusword0 : WORD;
    PDO_Statusword1 : WORD;
    PDO_DriveError0 : WORD;
    PDO_DriveError1 : WORD;
    PDO_ActualPosition0 : DINT;
    PDO_ActualPosition1 : DINT;
    PDO_ActualVelocity0 : DINT;
    PDO_ActualVelocity1 : DINT;
    PDO_ModeDisplay0 : SINT;
    PDO_ModeDisplay1 : SINT;
    PDO_Operational0 : BOOL;
    PDO_Operational1 : BOOL;
    PDO_WorkingCounter : UDINT;
    PDO_StableCycles : UDINT;
    PDO_Cycle : ULINT;
    HMI_CommandKey : UDINT;
    HMI_ArmSeq : UDINT;
    HMI_DisarmSeq : UDINT;
    HMI_ResetSeq : UDINT;
    HMI_StartSeq : UDINT;
    HMI_StopSeq : UDINT;
    HMI_Enable : BOOL;
    HMI_Radius : LREAL;
    HMI_Velocity : LREAL;
    HMI_Acceleration : LREAL;
    HMI_Deceleration : LREAL;
    HMI_PathChoice : SINT;
    HMI_ArmAck : UDINT;
    HMI_DisarmAck : UDINT;
    HMI_ResetAck : UDINT;
    HMI_StartAck : UDINT;
    HMI_StopAck : UDINT;
    HMI_Armed : BOOL;
    HMI_Error : BOOL;
    HMI_State : UINT;
    HMI_ErrorID : UDINT;
    HMI_PowerStatus0 : BOOL;
    HMI_PowerStatus1 : BOOL;
    HMI_CircleBusy : BOOL;
    HMI_CircleDone : BOOL;
    HMI_CircleCount : UINT;
    HMI_StopBusy : BOOL;
    HMI_StopDone : BOOL;
    HMI_ResetBusy : BOOL;
    HMI_ResetDone : BOOL;
END_VAR
VAR
    PowerX, PowerY : MC_Power;
    Circle : MC_MoveCircular;
    StopX, StopY : MC_Stop;
    AutoState : UINT;
    AutoDelayCycles, AutoStageCycles, AutoReadyCycles, GapCycles : UDINT;
    AutoEnable, CircleExecute, StopLatch : BOOL;
    SafetyOK, DriveReady, PowerEnable : BOOL;
END_VAR

(* These globals remain visible in the IDE, but are status only.  Motion uses
   the fixed literals below and never depends on an IDE Force operation. *)
HMI_CommandKey := 0;
HMI_ArmSeq := 0;
HMI_DisarmSeq := 0;
HMI_ResetSeq := 0;
HMI_StartSeq := 0;
HMI_StopSeq := 0;
HMI_ArmAck := 0;
HMI_DisarmAck := 0;
HMI_ResetAck := 0;
HMI_StartAck := 0;
HMI_StopAck := 0;
HMI_Radius := 0.45;
HMI_Velocity := 0.10;
HMI_Acceleration := 0.05;
HMI_Deceleration := 0.05;
HMI_PathChoice := 1;
HMI_ResetBusy := FALSE;
HMI_ResetDone := FALSE;

SafetyOK := PDO_SafetyReady AND (NOT PDO_ResetReady) AND
            (PDO_GuardError = 0) AND
            (PDO_DriveError0 = 0) AND (PDO_DriveError1 = 0) AND
            PDO_Operational0 AND PDO_Operational1 AND
            (PDO_WorkingCounter = 6) AND
            (PDO_StableCycles >= 400) AND
            (PDO_ModeDisplay0 = 8) AND (PDO_ModeDisplay1 = 8);
DriveReady := ((PDO_Statusword0 AND 16#006F) = 16#0027) AND
              ((PDO_Statusword1 AND 16#006F) = 16#0027);

(* A safety loss during power or motion is latched as a one-shot fault. *)
IF ((AutoState >= 3) AND (AutoState <= 5) AND (NOT SafetyOK)) OR
   ((AutoState = 4) AND ((NOT DriveReady) OR (NOT PDO_EnableReady))) THEN
    AutoState := 7;
    AutoStageCycles := 0;
    AutoEnable := FALSE;
    CircleExecute := FALSE;
    GapCycles := 0;
    StopLatch := HMI_PowerStatus0 OR HMI_PowerStatus1 OR HMI_CircleBusy;
    HMI_Error := TRUE;
    HMI_ErrorID := 20738;
END_IF;

CASE AutoState OF
0:
    AutoEnable := FALSE;
    CircleExecute := FALSE;
    StopLatch := FALSE;
    AutoDelayCycles := 0;
    GapCycles := 0;
    HMI_CircleCount := 0;
    HMI_CircleDone := FALSE;
    HMI_StopDone := FALSE;
    HMI_Error := FALSE;
    HMI_ErrorID := 0;
    IF SafetyOK THEN AutoState := 1; END_IF;
1:
    AutoEnable := FALSE;
    HMI_Error := FALSE;
    HMI_ErrorID := 0;
    IF SafetyOK THEN
        IF AutoDelayCycles < 3000 THEN
            AutoDelayCycles := AutoDelayCycles + 1;
        END_IF;
        IF AutoDelayCycles >= 3000 THEN
            AutoStageCycles := 0;
            AutoReadyCycles := 0;
            AutoState := 2;
        END_IF;
    ELSE
        AutoDelayCycles := 0;
    END_IF;
2:
    AutoEnable := FALSE;
    AutoStageCycles := AutoStageCycles + 1;
    IF (NOT PowerX.Error) AND (NOT PowerY.Error) AND
       (NOT Circle.Error) AND (NOT StopX.Error) AND (NOT StopY.Error) THEN
        IF AutoReadyCycles < 100 THEN
            AutoReadyCycles := AutoReadyCycles + 1;
        END_IF;
    ELSE
        AutoReadyCycles := 0;
    END_IF;
    IF AutoReadyCycles >= 100 THEN
        AutoEnable := TRUE;
        AutoStageCycles := 0;
        AutoState := 3;
    ELSIF AutoStageCycles >= 1000 THEN
        AutoState := 7;
        HMI_Error := TRUE;
        IF PowerX.Error THEN HMI_ErrorID := PowerX.ErrorID;
        ELSIF PowerY.Error THEN HMI_ErrorID := PowerY.ErrorID;
        ELSIF Circle.Error THEN HMI_ErrorID := Circle.ErrorID;
        ELSIF StopX.Error THEN HMI_ErrorID := StopX.ErrorID;
        ELSIF StopY.Error THEN HMI_ErrorID := StopY.ErrorID;
        ELSE HMI_ErrorID := 20743;
        END_IF;
    END_IF;
3:
    AutoEnable := TRUE;
    AutoStageCycles := AutoStageCycles + 1;
    IF DriveReady AND PDO_EnableReady THEN
        HMI_CircleCount := 0;
        HMI_CircleDone := FALSE;
        HMI_StopDone := FALSE;
        CircleExecute := TRUE;
        GapCycles := 0;
        AutoState := 4;
    ELSIF AutoStageCycles >= 5000 THEN
        AutoState := 7;
        AutoEnable := FALSE;
        HMI_Error := TRUE;
        HMI_ErrorID := 20744;
    END_IF;
4:
    AutoEnable := TRUE;
5:
    AutoEnable := FALSE;
    CircleExecute := FALSE;
    IF AutoStageCycles < 5000 THEN
        AutoStageCycles := AutoStageCycles + 1;
    END_IF;
6:
    AutoEnable := FALSE;
    CircleExecute := FALSE;
7:
    AutoEnable := FALSE;
    CircleExecute := FALSE;
    IF StopLatch AND (AutoStageCycles < 5000) THEN
        AutoStageCycles := AutoStageCycles + 1;
    END_IF;
ELSE
    AutoState := 7;
    AutoEnable := FALSE;
    CircleExecute := FALSE;
    HMI_Error := TRUE;
    HMI_ErrorID := 20742;
END_CASE;

PowerEnable := SafetyOK AND (AutoEnable OR StopLatch);
PowerX(Axis := Axis_1, Enable := PowerEnable);
PowerY(Axis := Axis_2, Enable := PowerEnable);

Circle(AxisX := Axis_1, AxisY := Axis_2, Execute := CircleExecute,
       CenterX := -0.45, CenterY := 0.0,
       EndPositionX := 0.0, EndPositionY := 0.0,
       PathChoice := 1, Velocity := 0.10,
       Acceleration := 0.05, Deceleration := 0.05);

IF (AutoState = 4) AND Circle.Done THEN
    HMI_CircleCount := HMI_CircleCount + 1;
    CircleExecute := FALSE;
    IF HMI_CircleCount < 2 THEN
        GapCycles := 1;
    ELSE
        HMI_CircleDone := TRUE;
        AutoEnable := FALSE;
        StopLatch := TRUE;
        AutoStageCycles := 0;
        AutoState := 5;
    END_IF;
END_IF;
IF (AutoState = 4) AND (GapCycles > 0) AND (NOT Circle.Done) THEN
    GapCycles := GapCycles - 1;
    IF GapCycles = 0 THEN CircleExecute := TRUE; END_IF;
END_IF;

IF (AutoState >= 3) AND (AutoState <= 5) AND
   (PowerX.Error OR PowerY.Error OR Circle.Error) THEN
    HMI_Error := TRUE;
    AutoState := 7;
    AutoStageCycles := 0;
    AutoEnable := FALSE;
    CircleExecute := FALSE;
    GapCycles := 0;
    StopLatch := HMI_PowerStatus0 OR HMI_PowerStatus1 OR Circle.Busy;
    IF PowerX.Error THEN HMI_ErrorID := PowerX.ErrorID;
    ELSIF PowerY.Error THEN HMI_ErrorID := PowerY.ErrorID;
    ELSE HMI_ErrorID := Circle.ErrorID;
    END_IF;
END_IF;

StopX(Axis := Axis_1, Execute := StopLatch);
StopY(Axis := Axis_2, Execute := StopLatch);
IF StopX.Done AND StopY.Done THEN
    HMI_StopDone := TRUE;
    StopLatch := FALSE;
    IF AutoState = 5 THEN AutoState := 6; END_IF;
END_IF;
IF ((AutoState = 5) OR (AutoState = 7)) AND StopLatch AND
   (AutoStageCycles >= 5000) THEN
    StopLatch := FALSE;
    AutoState := 7;
    HMI_Error := TRUE;
    HMI_ErrorID := 20745;
END_IF;
IF (AutoState >= 3) AND (AutoState <= 5) AND
   (StopX.Error OR StopY.Error) THEN
    HMI_Error := TRUE;
    AutoState := 7;
    AutoEnable := FALSE;
    StopLatch := FALSE;
    IF StopX.Error THEN HMI_ErrorID := StopX.ErrorID;
    ELSE HMI_ErrorID := StopY.ErrorID;
    END_IF;
END_IF;

HMI_PowerStatus0 := (PDO_Statusword0 AND 16#006F) = 16#0027;
HMI_PowerStatus1 := (PDO_Statusword1 AND 16#006F) = 16#0027;
HMI_CircleBusy := Circle.Busy;
HMI_StopBusy := StopX.Busy OR StopY.Busy;
HMI_Enable := AutoEnable;
HMI_Armed := (AutoState = 3) OR (AutoState = 4);
IF AutoState = 7 THEN HMI_State := 7;
ELSIF AutoState = 6 THEN HMI_State := 6;
ELSIF NOT SafetyOK THEN HMI_State := 0;
ELSIF (AutoState = 5) OR StopLatch OR HMI_StopBusy THEN HMI_State := 5;
ELSIF Circle.Busy THEN HMI_State := 4;
ELSIF PowerX.Status AND PowerY.Status THEN HMI_State := 3;
ELSIF HMI_Armed THEN HMI_State := 2;
ELSE HMI_State := 1;
END_IF;
END_PROGRAM

CONFIGURATION Config0
VAR_GLOBAL
    Axis_1 : AXIS_REF := 65537;
    Axis_2 : AXIS_REF := 65538;
    PDO_SafetyReady : BOOL := FALSE;
    PDO_EnableReady : BOOL := FALSE;
    PDO_ResetReady : BOOL := FALSE;
    PDO_GuardError : UINT := 1;
    PDO_Statusword0, PDO_Statusword1 : WORD := 0;
    PDO_DriveError0, PDO_DriveError1 : WORD := 0;
    PDO_ActualPosition0, PDO_ActualPosition1 : DINT := 0;
    PDO_ActualVelocity0, PDO_ActualVelocity1 : DINT := 0;
    PDO_ModeDisplay0, PDO_ModeDisplay1 : SINT := 0;
    PDO_Operational0, PDO_Operational1 : BOOL := FALSE;
    PDO_WorkingCounter, PDO_StableCycles : UDINT := 0;
    PDO_Cycle : ULINT := 0;
    HMI_CommandKey : UDINT := 0;
    HMI_ArmSeq, HMI_DisarmSeq, HMI_ResetSeq : UDINT := 0;
    HMI_StartSeq, HMI_StopSeq : UDINT := 0;
    HMI_Enable : BOOL := FALSE;
    HMI_Radius : LREAL := 0.45;
    HMI_Velocity : LREAL := 0.10;
    HMI_Acceleration : LREAL := 0.05;
    HMI_Deceleration : LREAL := 0.05;
    HMI_PathChoice : SINT := 1;
    HMI_ArmAck, HMI_DisarmAck, HMI_ResetAck : UDINT := 0;
    HMI_StartAck, HMI_StopAck : UDINT := 0;
    HMI_Armed, HMI_Error : BOOL := FALSE;
    HMI_State : UINT := 0;
    HMI_ErrorID : UDINT := 0;
    HMI_PowerStatus0, HMI_PowerStatus1 : BOOL := FALSE;
    HMI_CircleBusy, HMI_CircleDone : BOOL := FALSE;
    HMI_CircleCount : UINT := 0;
    HMI_StopBusy, HMI_StopDone : BOOL := FALSE;
    HMI_ResetBusy, HMI_ResetDone : BOOL := FALSE;
END_VAR
RESOURCE Resource0 ON PLC
TASK MotionTask(INTERVAL := T#1ms, PRIORITY := 0);
PROGRAM MAIN0 WITH MotionTask : DualCirclePanel;
END_RESOURCE
END_CONFIGURATION
