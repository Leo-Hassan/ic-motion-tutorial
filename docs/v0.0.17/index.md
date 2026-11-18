用途：汇集改版大桥 IDE 的章节入口。当前状态：V0.0.17 本地候选的案例 01～13 已在公开教程网站发布；工艺切割共用工程离线测试 PASS，IDE 安装包仍无公开发布标签。

# V0.0.17 手册

本手册绑定 `ic-platform-V0.0.17-linux-amd64` 包及发布源码提交 `8f743aa19cc49012b5cfec38a49d15d95fb9facd`。这个包已通过本地软件和全新安装门禁，**尚未创建公开发布标签**。读者若没有该包，暂不能按本手册复现 GUI 步骤；不要用 V0.0.14 界面截图替代。

## 章节目录

| 阅读顺序 | 章节 | 验证状态 |
| --- | --- | --- |
| 1 | [版本与证据](versions.md) | 包身份、截图来源已核对 |
| 2 | [软件操作](operations.md) | 打开工程、编辑、构建、仿真已实测 |
| 3 | [01 虚轴首次运动](cases/01-first-virtual-axis.md) | Clean Build 与 GUI 离线仿真 PASS |
| 4 | [02 ST 功能块与命令交接](cases/02-st-command-handoff.md) | 示例 Clean Build PASS，配套 LookAhead 仿真 PASS |
| 5 | [03 ST 断点与单步](cases/03-st-breakpoint-step.md) | 工程 Clean Build、主机回环和完整 IDE 断点/单步截图 PASS；生产监视 SKIP |
| 6 | [04 LD 编辑与仿真](cases/04-ld-edit-simulate.md) | 原工程及变量初值编辑副本 Build/仿真 PASS；触点取反后 Build FAIL，见已知问题 |
| 7 | [05 轴配置和限位](cases/05-axis-limits.md) | 与 01 共用工程；配置读取、范围内仿真 PASS，越界故障注入 SKIP |
| 8 | [06 设备映射与 CiA 402](cases/06-device-mapping-cia402.md) | 两工程离线 Build、映射模拟过程映像 PASS；实轴 SKIP，启动器映射页路径缺陷已记录 |
| 9 | [07 IS620N 双实轴离线构建](cases/07-is620n-offline-build.md) | 脱敏教学副本配置核对、AArch64 Clean Build 与真实 IDE Build PASS；仿真及实机 SKIP |
| 10 | [08 电子齿轮与相位调整](cases/08-electronic-gear.md) | 原样工程包内 Clean Build、保存工程仿真及真实 IDE Build PASS；实机 SKIP |
| 11 | [09 电子凸轮与表切换](cases/09-electronic-cam.md) | 与 08 共用同一工程和仿真证据；双表编辑页及 ST 真实截图 |
| 12 | [10 二维协调路径](cases/10-two-dimensional-path.md) | 八段 XY 路径资源、ST 与真实 IDE 构建；包内保存工程仿真结果见案例 |
| 13 | [11 跟踪切](cases/11-tracking-cut.md) | 模拟主轴/虚轴、工艺配方与 ST；保存工程测试 2/2 PASS，GUI Build PASS |
| 14 | [12 飞剪](cases/12-flying-saw.md) | 飞剪配方与 ST；与 11/13 共用同一次测试和工件 |
| 15 | [13 旋切](cases/13-rotary-knife.md) | 旋切配方与 ST；与 11/12 共用同一次测试和工件 |

三个工艺切割章节复用同一工程和一次保存工程仿真证据，不把单次运行重复计为三次独立验收。

所有页面中的“仿真”均指本机离线软件验证；当前 V0.0.17 无板端部署或实机运行证据。
