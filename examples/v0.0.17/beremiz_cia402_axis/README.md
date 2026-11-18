# CiA 402 单轴 Beremiz 示例

用途：展示五个 PLCopen 功能块与实轴节点的最小 ST 接口。
当前状态：仅离线示例，未完成设备、主站或功能安全验收。

在 `IC Motion` 下添加 `CiA 402 Real Axis`，全局名设为 `Axis_1`，优先选择 CSP。所有缩放、
限位、周期和通道必须由实际 ESI、PDO 与主站配置确认。`SoftwareZero` 只建立逻辑零点；它不
移动电机，也不是物理回零。

上电前必须确认 STO、急停、限位、制动器、使能回路、机械脱开或有限安全行程，并完成零速
预检。软件 Quick Stop 不替代任何安全功能。PDO invalid、非 OP、模式不符或周期停滞时应
看到输出 invalid 且 Controlword=0；此时停止试验，保留日志和配置，不扩大行程排错。
