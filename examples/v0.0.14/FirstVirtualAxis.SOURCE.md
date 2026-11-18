用途：说明首次虚轴运动工程的生成来源、版权和复现参数。当前状态：V0.0.14 包内工具已生成完整工程，教程副本重开、Clean Build 与离线仿真均通过。

# 首次虚轴运动工程

| 项目 | 值 |
| --- | --- |
| 上游仓库与提交 | `ic-beremiz-motion`，`29ca588ca3e1190acf751e9e3353a30d5222f44d` |
| 上游生成器路径 | `beremiz_extension/ic_motion/preview_project.py` 的 `create_project` |
| IDE 发布基线 | V0.0.14 包内 Beremiz、MATIEC 与 IC Motion 扩展 |
| 生成参数 | 名称 `FirstVirtualAxis`；模板 `单轴定位`（编号 0）；行程 `3.0`、速度 `1.0`、齿轮比参数 `2.0`、凸轮幅值参数 `0.5` |
| 版权 | Copyright (c) 2026 Industrial Control Platform contributors |
| 许可证 | `SPDX-License-Identifier: MIT`；完整文本见同级 `FirstVirtualAxis.LICENSE.upstream` |
| 修改说明 | 生成的 `beremiz.xml`、`plc.xml`、资源 XML、`library.lock`、`project-manifest.json` 原样复制；本说明和许可证置于工程目录外侧；未复制 `build/` |
| 未来替换边界 | 新 IDE 版本若改变生成器、项目清单或 PLC 行为，应在新版本目录重新生成与验收；此目录保留 V0.0.14 身份 |

工程入口是同级 `FirstVirtualAxis/beremiz.xml`。主 ST POU 为 `plc.xml/MAIN`，可编辑 LD POU 为 `plc.xml/BasicLD`；虚轴参数位于 `IC Motion@ic_motion/AxisX@VirtualAxis/confnode.xml`。生成器设置 `LOCAL://`、单个 1 ms 周期任务、位置 3.0 的自动状态机；不需要 Force 或连接设备。项目清单会拒绝未列入清单的文件，因而出处和许可证必须放在工程目录外侧。

用 V0.0.14 发布包对该目录运行 `scripts/clean_build.sh` 得到 SO SHA-256 `e399feb39f2ef3c8e6d2f827b2a9fb095c14a60fc72f3a83dbdbb242dee91206`，`VARIABLES.csv` SHA-256 `343dae36ad190944733dac699e2c6fb3bd977632ed49021a6967157c718a3544`。包内 `preview_simulation.simulate` 对公开副本的临时拷贝执行 3056 个固定扫描后报告 `x=3.0`、`max_x=3.0`、`done=1`、`error=0`、`hardware_operations=0`；未进行实轴或硬实时验收。
