用途：把目标主题映射到可打开的工程和验证证据。当前状态：V0.0.17 案例 01～13 已发布；LD 原工程通过，触点取反编辑后构建失败，其余适用的离线测试已执行。

# 案例覆盖计划

本表是覆盖清单。各案例页给出 IDE 版本、工程提交、步骤、带注释代码、真实截图、预期结果、常见错误和验证范围；PASS 只对应所列离线软件范围。截图来自与页面版本一致的包内真实 IDE。

| 编号 | 主题 | 候选工程目录 | 关键 POU / 资源 | 当前状态 |
| --- | --- | --- | --- | --- |
| 01 | 虚轴首次运动 | 教程专用 `examples/v0.0.17/FirstVirtualAxis/`，沿用 V0.0.14 生成工程并用 V0.0.17 包复验 | `plc.xml/MAIN`；`AxisX@VirtualAxis/confnode.xml` | V0.0.17 Clean Build、真实 GUI 仿真、正文与截图 PASS；实机 SKIP |
| 02 | ST 功能块调用与命令交接 | `examples/v0.0.17/beremiz_virtual_axis/` | `plc.xml/MAIN` 中 `MoveAbsA/B/C/D` | 包内 Clean Build 与 IDE Build PASS；同源码 LookAhead 仿真 PASS；本例自动 GUI 仿真 SKIP |
| 03 | ST 断点与单步 | 教程复制 `examples/v0.0.17/st_current_value/`，原路径 `beremiz/tests/projects/st_current_value/` | `plc.xml/MAIN`；`Config0/Res0/MainTask` | 包内 Clean Build、真实 MATIEC/wx/eRPC 主机回环及完整 IDE 窗口演示 PASS；生产监视 SKIP |
| 04 | 梯形图编辑与仿真 | `examples/v0.0.17/beremiz_basic_17_ld/` | `plc.xml/MAIN`，实际 `LD` POU | 原工程 Clean Build、真实 IDE Build、保存工程仿真 PASS；触点取反后 Build FAIL（V0.0.17 已知问题） |
| 05 | 轴配置与限位 | 与 01 共用 `examples/v0.0.17/FirstVirtualAxis/` | `AxisX@VirtualAxis/confnode.xml` 与 `plc.xml/MAIN` | 配置读取、同工程 Clean Build 和范围内虚轴仿真 PASS；越界故障注入 SKIP |
| 06 | 设备映射与 CiA 402 | `examples/v0.0.17/beremiz_device_mapping/` 与 `beremiz_cia402_axis/` | `device-catalog.json`；`Axis_1@Cia402RealAxis/confnode.xml` | 两工程 Clean Build/GUI Build PASS，模拟映射夹具 3/3 PASS；实轴仿真和实机 SKIP；映射页须补启动环境 |
| 07 | IS620N 实轴工程离线配置与构建 | 教程脱敏 `examples/v0.0.17/is620n_dual_circle_offline/`，原路径 `IGH_RK_1.6-master/beremiz_projects/is620n_cia402_dual_circle_online/` | `plc.xml/DualCirclePanel`；双轴配置与 C 扩展 | 静态配置、包内 AArch64 Clean Build、真实 IDE Build PASS；两产物哈希一致，仿真及实机 SKIP |
| 08 | 电子齿轮 | `examples/v0.0.17/beremiz_sync_gear_cam/` | `plc.xml/MAIN`；`Synchronization@SyncConfiguration` | 保存工程测试 2/2、Clean Build、GUI Build PASS；与 09 共用证据，实机 SKIP |
| 09 | 电子凸轮 | 同上 | `Cam_A@CamTable`、`Cam_B@CamTable` | 同一保存工程测试 PASS；双表真实 IDE 截图，实机 SKIP |
| 10 | 二维路径 | `examples/v0.0.17/beremiz_coordinated_path/` | `plc.xml/MAIN`；`MixedPath@PathRecipe` | 保存工程测试 2/2、Clean Build、GUI Build PASS；实机 SKIP |
| 11 | 跟踪切 | `examples/v0.0.17/beremiz_process_cutting/` | `TrackingRecipe@ProcessRecipe` | 保存工程测试 2/2、Clean Build、GUI Build PASS；与 12/13 共用证据，实机 SKIP |
| 12 | 飞剪 | 同上 | `SawRecipe@ProcessRecipe` | 同一保存工程测试 PASS；配方和 ST 真实 IDE 截图，实机 SKIP |
| 13 | 旋切 | 同上 | `KnifeRecipe@ProcessRecipe` | 同一保存工程测试 PASS；配方和 ST 真实 IDE 截图，实机 SKIP |

首例工程原生成器来自 `ic-beremiz-motion` V0.0.14 组件提交 `29ca588ca3e1190acf751e9e3353a30d5222f44d`；V0.0.17 包锁定扩展 `0867ececc3224815e4f0aae07b76b9581f70cfe4` 和改版 Beremiz `06f5b1e0e45faecac96d790ab03e57be46d4fd2d`，本地软件与全新安装门禁 PASS，但 IDE 包未创建公开发布标签。`IGH_RK_1.6-master` 锁定于 `e6308f19cafe6c591e2dea0c8ba92b0349b746be`。教程网站公开不等于 IDE 安装包已发布。
