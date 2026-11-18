用途：记录二维路径示例工程的原始出处和可复核边界。当前状态：19 个工程跟踪文件从锁定提交原样复制，V0.0.17 包内保存工程 Clean Build、仿真与真实 IDE 构建通过。

# 二维路径工程来源

原仓库 `ic-beremiz-motion`，提交 `0867ececc3224815e4f0aae07b76b9581f70cfe4`，原路径 `examples/beremiz_coordinated_path/`。本站复制其 19 个 Git 跟踪文件，含 `project-manifest.json`、`library.lock`、`plc.xml`、两根虚轴、XY 轴组与四个 PathRecipe；无工程源码改动。未复制构建物和测试结果。上游版权为 2026 Industrial Control Platform contributors，SPDX MIT，完整许可证见同级 `LICENSE.ic-beremiz-motion`。

`plc.xml/MAIN` 调用 `IC_CoordinatedPath` 和 `MC_GroupStop`；`Group_XY@AxisGroup` 引用 AxisX/AxisY；`MixedPath@PathRecipe` 有 8 段直线、圆弧和样条。其它三个 PathRecipe 分别供限位、退化和非切线错误验证。版本升级须重新锁定源提交、复制并执行打开、Build、仿真和截图；本副本没有现场设备或实机路径验收。
