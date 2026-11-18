用途：记录教程网站采用的开源组件与结构参考。当前状态：站点选型完成，V0.0.17 虚轴、LD、设备映射与 CiA 402 示例均保留 MIT 来源。

# 第三方组件与参考

| 名称 | 用途 | 来源与边界 |
| --- | --- | --- |
| MkDocs 1.6.1 | 从 Markdown 构建静态站点 | [官方文档](https://www.mkdocs.org/)；按 pip 依赖使用，不复制源码 |
| Material for MkDocs 9.5.49 | 搜索、导航、代码块与响应式主题 | [官方文档](https://squidfunk.github.io/mkdocs-material/)；按 pip 依赖使用，不复制源码 |
| 野火教程网站 | “入口 → 手册 → 章节”阅读结构参考 | [野火产品资料入口](https://doc.embedfire.com/products/link/zh/latest/)及[章节示例](https://doc.embedfire.com/module/module_tutorial/zh/latest/)；未复制文字、图片或代码 |

后续若复制工作区示例源码，会逐工程记录原仓库、提交、路径、许可证和改动；不复制 `test-results`、`build`、密钥或内部配置。

阶段二已从 `ic-beremiz-motion` 提交 `29ca588ca3e1190acf751e9e3353a30d5222f44d` 复制 `examples/beremiz_virtual_axis/` 至 `examples/v0.0.14/virtual_axis/`。上游版权为 2026 Industrial Control Platform contributors，SPDX 为 MIT，完整许可证随示例保留。原路径、改动和未来替换边界见示例内 `SOURCE.md`；未复制上游 `build/`。

同一提交的 `beremiz_extension/ic_motion/preview_project.py` 经 V0.0.14 包内工具生成 `examples/v0.0.14/FirstVirtualAxis/`。工程 XML 和清单未手改，MIT 许可证与出处说明置于相邻文件，不破坏项目清单；参数与替换边界见 `FirstVirtualAxis.SOURCE.md`。

阶段三把该工程文件原样复制到 `examples/v0.0.17/FirstVirtualAxis/`，不复制生成物。上游路径仍为 `ic-beremiz-motion/beremiz_extension/ic_motion/preview_project.py`，原提交 `29ca588ca3e1190acf751e9e3353a30d5222f44d`，改版包的扩展提交 `0867ececc3224815e4f0aae07b76b9581f70cfe4`。复制修改只涉及版本目录和相邻来源说明；版权、SPDX MIT、未来版本重新验收边界见 `examples/v0.0.17/FirstVirtualAxis.SOURCE.md`。

阶段三乙从同一 V0.0.17 扩展提交 `0867ececc3224815e4f0aae07b76b9581f70cfe4` 原样复制 `examples/beremiz_virtual_axis/` 的 12 个跟踪文件和 `examples/beremiz_basic_17_ld/` 的 6 个跟踪文件到本站相应 V0.0.17 目录；未复制上游构建产物。两者均受 `ic-beremiz-motion` MIT 许可，版权、SPDX、原路径、修改说明和后续版本替换边界见相邻 `*.SOURCE.md`，完整许可见 `examples/v0.0.17/LICENSE.ic-beremiz-motion`。配套 LookAhead 与 LD 保存工程夹具通过包内/锁定源码调用，没有把测试源码、缓存或 `test-results` 纳入本站。

阶段三丁继续从相同提交复制 `examples/beremiz_device_mapping/` 的 7 个跟踪文件与 `examples/beremiz_cia402_axis/` 的 6 个跟踪文件；完整 MIT 许可继续由 `examples/v0.0.17/LICENSE.ic-beremiz-motion` 提供。CiA 402 工程仅在 README 去掉两个尾部空格，其工程 XML 和 ST 未改。两个相邻 `*.SOURCE.md` 记录路径、提交、修改和后续替换边界。模拟设备目录仅供离线映射验证，实轴配置 XML 为占位示例，不附真实设备身份、密钥或现场参数。
