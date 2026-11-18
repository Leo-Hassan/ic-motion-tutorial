用途：记录 ST 单步工程与维护调试输入的来源。当前状态：V0.0.17 包内 Clean Build 和主机回环调试 PASS，设备操作未执行。

# ST Current Value 工程来源

工程 `st_current_value/README.md`、`beremiz.xml`、`plc.xml` 原样来自 `beremiz` 提交 `06f5b1e0e45faecac96d790ab03e57be46d4fd2d` 的 `tests/projects/st_current_value/`。上游 Beremiz 的 GPL-2.0-or-later 许可全文见同级 `LICENSE.beremiz-ide`，工程版权与上游保持一致。未复制测试生成物、会话文件、凭据或二进制。

`st_current_value/maintenance_debug.st` 是根据上述 `plc.xml/MAIN` 三条语句另写的主机维护调试编译输入，附最小 `Config0/Res0/MainTask` 配置；文件头 SPDX 为 MIT，来源改写范围限于把 PLCopen XML 中的程序展开为 IEC ST。它不取代可在 IDE 中打开的工程。调试候选使用 `ic-matiec-adapter` 提交 `01e4b4897b6d7a002d26169314687e8154f29c5c` 的映射和审计工具生成，未把候选 SO 或调试 map 提交到教程。

未来 IDE 版本必须重新构建、验证身份绑定和截图；本站 V0.0.17 的回环证据不继承为生产设备调试验收。
