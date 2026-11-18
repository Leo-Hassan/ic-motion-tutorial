用途：记录电子齿轮与电子凸轮共用工程的原始出处和验证边界。当前状态：15 个跟踪文件原样复制，V0.0.17 包内离线 Clean Build、保存工程仿真及真实 IDE 构建通过。

# Gear/Cam 工程来源

原仓库 `ic-beremiz-motion`，提交 `0867ececc3224815e4f0aae07b76b9581f70cfe4`，原路径 `examples/beremiz_sync_gear_cam/`。复制 15 个 Git 跟踪文件到同名教程目录，包含原 `project-manifest.json` 与 `library.lock`，工程内部未加文档或改写 XML；不复制构建物和测试结果。上游版权为 2026 Industrial Control Platform contributors，SPDX MIT；完整许可证见同级 `LICENSE.ic-beremiz-motion`。

工程 `plc.xml/MAIN` 同时调用电子齿轮、相位调整与电子凸轮功能块；`Master@EncoderAxis` 为 `SourceMode=Simulation`，`Slave@VirtualAxis` 为虚轴，两张 CamTable 是三点三角形轨迹。`Synchronization@SyncConfiguration` 包含齿轮、相位与凸轮的资源依赖。案例 08/09 共用**同一份**工程及包内编译/仿真证据，不重复计为两个独立项目验收。

未来版本要从新锁定组件重新复制并验证工程清单、构建、仿真和截图；本站未进行任何实轴同步或硬件运动。
