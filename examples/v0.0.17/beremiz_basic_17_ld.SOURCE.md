用途：记录真实 LD 工程的原始出处与验证边界。当前状态：V0.0.17 包内 Clean Build、真实 GUI 构建和保存工程仿真 PASS。

# Basic 17 LD 工程来源

原仓库 `ic-beremiz-motion`，提交 `0867ececc3224815e4f0aae07b76b9581f70cfe4`，原路径 `examples/beremiz_basic_17_ld/`。复制该提交的 6 个跟踪文件至同名教程目录，未复制 `build/`、缓存或 `test-results/`，保留原 `plc.xml/MAIN` 的 `<LD>` 正文。上游生成器路径 `tools/generate_basic17_ld_project.py`；本次只是原样复制，不把 XML 改写成图片。版权 `Copyright (c) 2026 Industrial Control Platform contributors`、`SPDX-License-Identifier: MIT`，许可全文见同级 `LICENSE.ic-beremiz-motion`。

V0.0.17 包内 CLI Clean Build：SO SHA-256 `0459f68979803641e453a5d30a2fdddfac5c04eb4c7b5f181ab8a82d00a4a7ec`，变量表 `9062acdcd8599bdbc73f6d039abf1f3cf3f55e9788d81e37f385fb1ec54edbe9`。包内保存工程测试夹具对教程 LD 副本执行两次 Clean Build、18 实例检查与固定虚轴扫描，PASS。未来版本应独立复制和复验；本目录仅对应 V0.0.17 软件验证。
