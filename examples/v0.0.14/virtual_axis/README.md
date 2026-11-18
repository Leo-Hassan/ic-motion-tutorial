用途：保留上游虚轴、轴组与凸轮示例工程。当前状态：教程仓库已用 V0.0.14 发布包离线 Clean Build；原上游说明如下。

# 虚拟双轴、静态轴组与凸轮表示例

用途：演示 `Axis_1/Axis_2/Group_XY` 自动生成及 PLCopen 风格功能块；当前状态：已通过 XML、
MATIEC、等价运行时闭环和真实 IDE Clean/Build；节点使用原生 `IC_AXIS_VIRTUAL`，未做
EtherCAT、伺服或硬实时验收。

V11 在 MAIN 中增加默认启用的 `MC_ReadFollowingError` 和 `MC_AxisTrace`，总 Motion FB 实例数
为 20。Trace 固定 64 点、ReadIndex 0 为最新；示例只暴露诊断输出，不会触发运动。完整状态、
错误、位置/速度、跟随误差和覆盖自判定由 `tests/Test_Diagnostics.st` 执行。

V10 将单轴绝对运动扩展为 `MoveAbsA/B/C/D` 固定窗口示例：A 到 100，随后三个 0.5 单位短段
到 101.5；B/C/D 使用 `MC_BlendingHigh`。依次在 A 活动期间触发 B、C、D 后，内核会在活动段
加固定八项 FIFO 的窗口内反向传播制动约束、再正向传播加速约束，因而 A 的首个接点速度会受
最后短段停车条件约束。所有请求默认 FALSE，离线构建不会自动运动；自动 PASS/FAIL 由
`tests/Test_LookAhead.st` 执行。

V9 的两段 Blend 能力仍由 `tests/Test_Blend.st` 单独回归；V10 示例用四段
`MC_BlendingHigh` 展示多段 Look-ahead，而不改变 PLCopen 功能块接口。

V8 在 MAIN 中增加默认 FALSE 的 `StartSpline` 和 `MC_MoveSplineAbsolute`，以两个 XYZ 控制点
和终点演示三次 Bézier段。它复用 `Group_XY`，不会在打开或离线构建时自动运动；自动曲线
误差验收由 `tests/Test_Spline.st` 执行。当前组路径只支持 BufferMode=0；V9/V10
Blend/Look-ahead 仅用于单轴 `MC_MoveAbsolute`。

V7 在 MAIN 中增加默认 FALSE 的 `StartCircular` 和 `MC_MoveCircularAbsolute`，复用既有双轴
`Group_XY`，以圆心 (50,0)、起终点 (0,0) 演示 CCW 整圆。它不会自动执行，必须先 Power
并启用组；本示例离线构建验证不包含 Connect、Transfer、Run 或真实设备动作。

V6 在 MAIN 中增加默认不触发的 `MC_MoveLinearAbsolute`。组启用后可用 PositionX/Y/Z、速度、
加减速度和 Jerk 发起同步线段；当前只支持 BufferMode=0。自动运动验收由
`tests/Test_Linear.st` 执行，示例打开或离线构建不会自行运动。

V5 增加 `Cam_1`：handle 4，点为 `0:0;90:100;180:0;270:-100;360:0`。MAIN 中新增默认
不触发的 CamTableSelect/CamIn/CamOut；启用前应保持 Group/Gear 请求为 FALSE。当前示例只用于
离线构建，V5 自动运动验收由 `tests/Test_Cam.st` 执行。

V4 在 MAIN 中增加默认不触发的 `GearIn/GearOut`。将 `EnableGear` 置 TRUE 前应保持
`EnableGroup=FALSE`，随后 Axis_1 为 Master、Axis_2 为 Slave、比例 2:1；`DisableGear` 的
上升沿释放从轴。两个请求默认 FALSE，因此打开或离线构建工程不会产生运动。

用带扩展参数的大桥/Beremiz 打开本目录：

```sh
python3 beremiz/Beremiz.py \
  -e ic-beremiz-motion/beremiz_extension/ic_motion_extension.py \
  ic-beremiz-motion/examples/beremiz_virtual_axis
```

设备树包含 `IC Motion -> Axis_1/Axis_2 (VirtualAxis)、Group_XY (AxisGroup)、Cam_1
(CamTable)`。组节点使用
固定成员句柄 1、2，向 ST 导出 `AXIS_GROUP_REF`；`MC_GroupEnable` 仅取得组所有权，不替代
两个轴的 `MC_Power`。`MoveAbsA/B/C/D` 是绑定同一轴的四个独立 `MC_MoveAbsolute` 实例，
分别由 `StartMoveA/B/C/D` 触发。A 使用 MC_Aborting，B/C/D 使用 MC_BlendingHigh：A 活动
时依次触发后续实例，它们应 Busy=TRUE/Active=FALSE，并在非零、受 Look-ahead 约束的接点
速度下连续交接；把后续块改为 MC_Buffered 可验证停稳后提升，改为 MC_Aborting 可验证后调用
实例抢占及前序 CommandAborted。`StopRequest` 会清活动/
等待命令并持锁，Stop Done 后仍需释放 Execute 才能接收新运动。每个 Execute 新请求前先复位。

四个绝对运动均设置 `Jerk := 200.0`，用于在 IDE Clean/Build 中启用本地 Ruckig
S-Curve 规划器；将 `Jerk` 改为 `0.0` 可切换回梯形速度规划器。
