用途：汇集改版大桥 IDE 的章节入口。当前状态：V0.0.17 本地候选，案例 01、02、04 已完成真实 GUI 和相应离线验证；其余主题待逐章验收。

# V0.0.17 手册

本手册绑定 `ic-platform-V0.0.17-linux-amd64` 包及发布源码提交 `8f743aa19cc49012b5cfec38a49d15d95fb9facd`。这个包已通过本地软件和全新安装门禁，**尚未创建公开发布标签**。读者若没有该包，暂不能按本手册复现 GUI 步骤；不要用 V0.0.14 界面截图替代。

## 章节目录

| 阅读顺序 | 章节 | 验证状态 |
| --- | --- | --- |
| 1 | [版本与证据](versions.md) | 包身份、截图来源已核对 |
| 2 | [软件操作](operations.md) | 打开工程、编辑、构建、仿真已实测 |
| 3 | [01 虚轴首次运动](cases/01-first-virtual-axis.md) | Clean Build 与 GUI 离线仿真 PASS |
| 4 | [02 ST 功能块与命令交接](cases/02-st-command-handoff.md) | 示例 Clean Build PASS，配套 LookAhead 仿真 PASS |
| 5 | [04 LD 编辑与仿真](cases/04-ld-edit-simulate.md) | 原工程 Build/仿真 PASS；触点取反后 Build FAIL，见已知问题 |

后续章节会覆盖 ST 命令交接、断点和单步、LD、轴限位、设备映射与 CiA 402、IS620N 离线工程、电子齿轮与凸轮、二维路径、跟踪切、飞剪与旋切。尚未发布的章节不计通过。

所有页面中的“仿真”均指本机离线软件验证；当前 V0.0.17 无板端部署或实机运行证据。
