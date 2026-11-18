用途：记录教程网站采用的开源组件与结构参考。当前状态：V0.0.17 工程保留 MIT 或 GPL 原始来源；公开 GitHub Pages 工作流仅调用上游 Actions。

# 第三方组件与参考

| 名称 | 用途 | 来源与边界 |
| --- | --- | --- |
| MkDocs 1.6.1 | 从 Markdown 构建静态站点 | [官方文档](https://www.mkdocs.org/)；按 pip 依赖使用，不复制源码 |
| Material for MkDocs 9.5.49 | 搜索、导航、代码块与响应式主题 | [官方文档](https://squidfunk.github.io/mkdocs-material/)；按 pip 依赖使用，不复制源码 |
| GitHub Pages Actions | 自动构建后上传并部署静态产物 | [GitHub 官方工作流说明](https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages)；调用 `checkout`、`setup-python`、`upload-pages-artifact` 与 `deploy-pages` 的上游版本，不复制源码 |
| 野火教程网站 | “入口 → 手册 → 章节”阅读结构参考 | [野火产品资料入口](https://doc.embedfire.com/products/link/zh/latest/)及[章节示例](https://doc.embedfire.com/module/module_tutorial/zh/latest/)；未复制文字、图片或代码 |

每份工作区示例源码均在相邻来源文件记录原仓库、提交、路径、许可证和改动；不复制 `test-results`、`build`、密钥或内部配置。

阶段二已从 `ic-beremiz-motion` 提交 `29ca588ca3e1190acf751e9e3353a30d5222f44d` 复制 `examples/beremiz_virtual_axis/` 至 `examples/v0.0.14/virtual_axis/`。上游版权为 2026 Industrial Control Platform contributors，SPDX 为 MIT，完整许可证随示例保留。原路径、改动和未来替换边界见示例内 `SOURCE.md`；未复制上游 `build/`。

同一提交的 `beremiz_extension/ic_motion/preview_project.py` 经 V0.0.14 包内工具生成 `examples/v0.0.14/FirstVirtualAxis/`。工程 XML 和清单未手改，MIT 许可证与出处说明置于相邻文件，不破坏项目清单；参数与替换边界见 `FirstVirtualAxis.SOURCE.md`。

阶段三把该工程文件原样复制到 `examples/v0.0.17/FirstVirtualAxis/`，不复制生成物。上游路径仍为 `ic-beremiz-motion/beremiz_extension/ic_motion/preview_project.py`，原提交 `29ca588ca3e1190acf751e9e3353a30d5222f44d`，改版包的扩展提交 `0867ececc3224815e4f0aae07b76b9581f70cfe4`。复制修改只涉及版本目录和相邻来源说明；版权、SPDX MIT、未来版本重新验收边界见 `examples/v0.0.17/FirstVirtualAxis.SOURCE.md`。

阶段三乙从同一 V0.0.17 扩展提交 `0867ececc3224815e4f0aae07b76b9581f70cfe4` 原样复制 `examples/beremiz_virtual_axis/` 的 12 个跟踪文件和 `examples/beremiz_basic_17_ld/` 的 6 个跟踪文件到本站相应 V0.0.17 目录；未复制上游构建产物。两者均受 `ic-beremiz-motion` MIT 许可，版权、SPDX、原路径、修改说明和后续版本替换边界见相邻 `*.SOURCE.md`，完整许可见 `examples/v0.0.17/LICENSE.ic-beremiz-motion`。配套 LookAhead 与 LD 保存工程夹具通过包内/锁定源码调用，没有把测试源码、缓存或 `test-results` 纳入本站。

阶段三丁继续从相同提交复制 `examples/beremiz_device_mapping/` 的 6 个跟踪文件与 `examples/beremiz_cia402_axis/` 的 7 个跟踪文件；完整 MIT 许可继续由 `examples/v0.0.17/LICENSE.ic-beremiz-motion` 提供。CiA 402 工程仅在 README 去掉两个尾部空格，其工程 XML 和 ST 未改。两个相邻 `*.SOURCE.md` 记录路径、提交、修改和后续替换边界。模拟设备目录仅供离线映射验证，实轴配置 XML 为占位示例，不附真实设备身份、密钥或现场参数。

阶段三戊从 V0.0.17 锁定 `beremiz` 提交 `06f5b1e0e45faecac96d790ab03e57be46d4fd2d` 的 `tests/projects/st_current_value/` 原样复制 3 个工程文件，GPL-2.0-or-later 许可证全文见 `examples/v0.0.17/LICENSE.beremiz-ide`。同目录另写的 `maintenance_debug.st` 为对应三条通用 ST 赋值的最小编译输入，文件头 SPDX MIT；调试工具来自 `ic-matiec-adapter` 提交 `01e4b4897b6d7a002d26169314687e8154f29c5c`，仅调用其脚本与本机库，没有复制上游源码或候选二进制。原路径、修改范围及未来版本边界见相邻来源说明。

阶段三己从 `IGH_RK_1.6-master` 提交 `e6308f19cafe6c591e2dea0c8ba92b0349b746be` 的 `beremiz_projects/is620n_cia402_dual_circle_online/` 复制 11 个跟踪工程文件。`dual_circle_panel.st` 上游文件头为 SPDX MIT；其余 XML 无逐文件 SPDX 声明，本站不擅自给上游增加许可证。两个配置 XML 的本机路径被替换为教学参数，改动与未来替换边界见相邻 `is620n_dual_circle_offline.SOURCE.md`。IgH AArch64 SDK、交叉工具链和包内 EtherCAT 适配源码在调用者环境提供，未复制到教程；不发布主站实现、驱动库、现场凭据或历史硬件报告。

阶段三庚从 `ic-beremiz-motion` 提交 `0867ececc3224815e4f0aae07b76b9581f70cfe4` 的 `examples/beremiz_sync_gear_cam/` 原样复制 15 个跟踪工程文件至本站 `examples/v0.0.17/beremiz_sync_gear_cam/`，包括原清单；上游版权为 2026 Industrial Control Platform contributors，SPDX MIT，完整许可证沿用同级 `LICENSE.ic-beremiz-motion`。相邻 `beremiz_sync_gear_cam.SOURCE.md` 记录原路径、修改范围和未来版本需重新验证的边界。V0.0.17 包内测试源码只在本机调用，没有复制到本站。

阶段三辛从相同 `ic-beremiz-motion` 提交的 `examples/beremiz_coordinated_path/` 原样复制 19 个跟踪工程文件至本站 `examples/v0.0.17/beremiz_coordinated_path/`，包括原清单、XY 组和四个 PathRecipe；上游版权、SPDX MIT 与完整许可证仍见同级 `LICENSE.ic-beremiz-motion`。相邻 `beremiz_coordinated_path.SOURCE.md` 记录路径、修改和未来版本替换边界。包内测试与生成器源码只在本机调用，没有复制进教程。

阶段三壬从相同 `ic-beremiz-motion` 提交的 `examples/beremiz_process_cutting/` 原样复制 21 个跟踪工程文件至本站 `examples/v0.0.17/beremiz_process_cutting/`，包括原清单、模拟主轴、三根虚轴和四张 ProcessRecipe；上游版权、SPDX MIT 与完整许可证仍见同级 `LICENSE.ic-beremiz-motion`。相邻 `beremiz_process_cutting.SOURCE.md` 记录路径、修改和未来版本替换边界。包内测试与生成器源码仅在本机调用，没有复制进教程。
