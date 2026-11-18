用途：把目标主题映射到可打开的工程和待执行的验证。当前状态：V0.0.17 首次虚轴运动章节、真实截图和离线仿真完成；其余主题待逐项验收。

# 案例覆盖计划

本表是编写清单，`待验证` 不能解读为案例通过。各案例页最终还须给出 IDE 发布版本、工程提交、步骤、带注释代码、真实截图、预期结果、常见错误和验证范围。截图必须来自与页面版本一致的发布包。

| 编号 | 主题 | 候选工程目录 | 关键 POU / 资源 | 当前状态 |
| --- | --- | --- | --- | --- |
| 01 | 虚轴首次运动 | 教程专用 `examples/v0.0.17/FirstVirtualAxis/`，沿用 V0.0.14 生成工程并用 V0.0.17 包复验 | `plc.xml/MAIN`；`AxisX@VirtualAxis/confnode.xml` | V0.0.17 Clean Build、真实 GUI 仿真、正文与截图 PASS；实机 SKIP |
| 02 | ST 功能块调用与命令交接 | `ic-beremiz-motion/examples/beremiz_virtual_axis/` | `plc.xml/MAIN` 中 `MoveAbsA/B/C/D` | 待验证 |
| 03 | ST 断点与单步 | `beremiz/tests/projects/st_current_value/` | `plc.xml/MAIN`；`Config0/Res0/MainTask` | 待验证 |
| 04 | 梯形图编辑与仿真 | `ic-beremiz-motion/examples/beremiz_basic_17_ld/` | `plc.xml/MAIN`，实际 `LD` POU | 待验证 |
| 05 | 轴配置与限位 | `ic-beremiz-motion/examples/beremiz_v12_basic/` | 虚轴配置节点与 `plc.xml/MAIN` | 待验证 |
| 06 | 设备映射与 CiA 402 | `ic-beremiz-motion/examples/beremiz_device_mapping/` 和 `beremiz_cia402_axis/` | `device-catalog.json`；`Axis_1@Cia402RealAxis/confnode.xml` | 待验证 |
| 07 | IS620N 实轴工程离线配置与构建 | `IGH_RK_1.6-master/beremiz_projects/is620n_cia402_dual_circle_online/` | `plc.xml/DualCirclePanel`；双轴配置与 C 扩展 | 只做离线，待敏感信息审查与 Clean Build |
| 08 | 电子齿轮 | `ic-beremiz-motion/examples/beremiz_sync_gear_cam/` | `plc.xml/MAIN`；`Synchronization@SyncConfiguration` | 待验证 |
| 09 | 电子凸轮 | 同上 | `Cam_A@CamTable`、`Cam_B@CamTable` | 待验证 |
| 10 | 二维路径 | `ic-beremiz-motion/examples/beremiz_coordinated_path/` | `plc.xml/MAIN`；`MixedPath@PathRecipe` | 待验证 |
| 11 | 跟踪切 | `ic-beremiz-motion/examples/beremiz_process_cutting/` | `TrackingRecipe@ProcessRecipe` | 待验证 |
| 12 | 飞剪与旋切 | 同上，分两套操作与预期结果 | `SawRecipe@ProcessRecipe`、`KnifeRecipe@ProcessRecipe` | 待验证 |

首例工程原生成器来自 `ic-beremiz-motion` V0.0.14 组件提交 `29ca588ca3e1190acf751e9e3353a30d5222f44d`；V0.0.17 包锁定扩展 `0867ececc3224815e4f0aae07b76b9581f70cfe4` 和改版 Beremiz `06f5b1e0e45faecac96d790ab03e57be46d4fd2d`，本地软件与全新安装门禁 PASS，但未创建公开发布标签。`IGH_RK_1.6-master` 锁定于 `e6308f19cafe6c591e2dea0c8ba92b0349b746be`。其余案例版本须以实际包复验结果为准。
