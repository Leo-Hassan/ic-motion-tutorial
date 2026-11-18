用途：记录 V0.0.17 手册虚轴工程的来源与复制边界。当前状态：本地 V0.0.17 包内 Clean Build 和离线仿真通过。

# FirstVirtualAxis 工程来源

工程文件从本站 `examples/v0.0.14/FirstVirtualAxis/` 原样复制，不包含 `build/`；上游生成器为 `ic-beremiz-motion` 提交 `29ca588ca3e1190acf751e9e3353a30d5222f44d` 的 `beremiz_extension/ic_motion/preview_project.py`。工程的 `project-manifest.json` 仍记录初次生成身份；V0.0.17 只作兼容性重建与仿真，不伪称为新生成。V0.0.17 包的 IC Motion 扩展锁定 `0867ececc3224815e4f0aae07b76b9581f70cfe4`。

入口 `FirstVirtualAxis/beremiz.xml`，ST `plc.xml/MAIN`，可编辑 LD `plc.xml/BasicLD`，虚轴 `IC Motion@ic_motion/AxisX@VirtualAxis/confnode.xml`。版权为 `Copyright (c) 2026 Industrial Control Platform contributors`，许可证 `SPDX-License-Identifier: MIT`；完整文本见同级 `FirstVirtualAxis.LICENSE.upstream`。后续 IDE 版本若改变行为，须创建新的版本目录并重新验收；本目录保留 V0.0.17 对应身份。

V0.0.17 Clean Build：SO SHA-256 `e399feb39f2ef3c8e6d2f827b2a9fb095c14a60fc72f3a83dbdbb242dee91206`，变量表 `343dae36ad190944733dac699e2c6fb3bd977632ed49021a6967157c718a3544`。离线仿真 `cycles=3056`、`x=3`、`done=1`、`error=0`、`hardware_operations=0`；实机未验证。
