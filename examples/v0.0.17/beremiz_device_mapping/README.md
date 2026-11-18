# 离线设备映射示例

用途：演示在 Beremiz 的 `IC Motion -> Mapping` 页面查看 P01b 设备目录、绑定
PLC 全局变量并离线 Clean Build。当前状态：仅离线和模拟过程映像验证；没有连接、扫描、
Transfer、Run、SDO 或实机运动验收。

打开工程时，映射表应显示 `Simulated-IO` 的四个通道及方向、类型、位宽、对象字典来源、
变量、所有者和状态。在线值固定显示 `unavailable`；这不影响离线编辑。现有变量可从下拉框
绑定，也可用 `CONFIG0.NAME` 显式创建。创建动作先暂存，只有 `Save mapping` 同时保存
`plc.xml` 和 `device-catalog.json`；创建失败会撤销本次新变量及绑定。`Cancel edits`、
Undo/Redo 和关闭页面时的未保存提示不会触发在线动作。

输出通道只能有一个写所有者；输入可扇出到多个不同 PLC 输入变量。类型、方向、输出所有者
或位区间冲突会定位到表格行并拒绝保存。未知类型保持 `unknown`，不会推测。轴映射只能选择
工程中已有的 `AxisConfig` 及其声明角色；Controlword、模式和目标值输出会被轴所有者保留，
必需角色不完整时拒绝生成可运行配置。

`Compare offline snapshot…` 只读取用户选择的 JSON 文件。身份或 PDO 布局变化必须人工确认，
原绑定随后保持 `confirmation required`，需逐项重建；设备顺序不参与映射，也没有隐藏扫描。
确认真实 ESI/PDO、接线、缩放、STO、急停、限位和机械安全之前，不得把本示例用于上电。
