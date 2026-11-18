用途：标注虚轴示例复制来源、版权和修改边界。当前状态：V0.0.14 发布源码中的工程已复制，离线 Clean Build 已通过。

# 源码来源

| 项目 | 值 |
| --- | --- |
| 上游仓库 | 工作区 `ic-beremiz-motion` |
| 上游提交 | `29ca588ca3e1190acf751e9e3353a30d5222f44d`，与 V0.0.14 `COMPONENTS.lock` 一致 |
| 上游路径 | `examples/beremiz_virtual_axis/` |
| 版权 | Copyright (c) 2026 Industrial Control Platform contributors |
| 许可证 | `SPDX-License-Identifier: MIT`；完整文本见 `LICENSE.upstream` |
| 工程文件改动 | `git archive` 从上游提交复制；11 个 XML 文件未改；仅给原 `README.md` 前置中文用途/状态说明，另增本说明与许可证副本 |
| 未来替换边界 | 仅当新版 IDE 的接口、配置格式或案例步骤变化时，在新版目录另存副本；本目录保持 V0.0.14 复现身份 |

工程在 `examples/v0.0.14/virtual_axis/`，入口为 `beremiz.xml`；主 POU 为 `plc.xml` 中的 `MAIN`，任务为 `Config0/Resource0/MotionTask`。本工程包含虚轴、轴组、齿轮与凸轮演示，默认请求变量为 `FALSE`；仅用于离线学习和软件仿真。
