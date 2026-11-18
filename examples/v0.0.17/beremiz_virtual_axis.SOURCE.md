用途：记录 ST 命令交接工程的原始出处。当前状态：V0.0.17 包内 Clean Build 与 IDE Build PASS；工程自身无自动仿真入口。

# ST 命令交接工程来源

原仓库 `ic-beremiz-motion`，提交 `0867ececc3224815e4f0aae07b76b9581f70cfe4`，原路径 `examples/beremiz_virtual_axis/`。复制该提交的 12 个跟踪文件至同名教程目录，未复制上游 `build/` 或 `test-results/`，没有修改 ST、XML 或资源参数。版权 `Copyright (c) 2026 Industrial Control Platform contributors`、`SPDX-License-Identifier: MIT`，许可全文见同级 `LICENSE.ic-beremiz-motion`。

本目录使用 V0.0.17 包内 Beremiz/MATIEC/IC Motion Clean Build，SO SHA-256 `8d0b2419f4bacbfaadf5c7f5e2eee59316f5836d367d9e1cc690e0af07348328`。同提交 `tests/Test_LookAhead.st` 是配套固定扫描夹具；它的短行程结果不冒充本工程 GUI 运行。后续版本更换包或源码时，新建版本目录并重验。
