(* SPDX-License-Identifier: MIT
   离线示例：真实设备参数和安全门禁未确认，禁止直接用于上电运动。 *)
PROGRAM Cia402SingleAxis
VAR_EXTERNAL Axis_1 : AXIS_REF; END_VAR
VAR
    Power : MC_Power; Reset : MC_Reset; Home : MC_Home;
    MoveAbs : MC_MoveAbsolute; Stop : MC_Stop;
    Enable, ResetFault, EstablishReference, StartMove, StopRequest : BOOL;
END_VAR
Power(Axis := Axis_1, Enable := Enable);
Reset(Axis := Axis_1, Execute := ResetFault);
(* 通用适配器不伪造物理回零。仅设备专用回零可使用 Home；配置 SoftwareZero
   时，首个有效 PDO 的实际位置在初始化期建立逻辑零。 *)
Home(Axis := Axis_1, Execute := EstablishReference);
MoveAbs(Axis := Axis_1, Execute := StartMove, Position := 1.0,
        Velocity := 0.1, Acceleration := 0.2, Deceleration := 0.2);
Stop(Axis := Axis_1, Execute := StopRequest);
END_PROGRAM
