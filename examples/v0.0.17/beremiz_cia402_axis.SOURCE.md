用途：说明 CiA 402 单轴离线示例的来源与限制。当前状态：从锁定源码复制并只整理 README 换行，V0.0.17 Clean Build 已通过，实机未验证。

# 来源

`ic-beremiz-motion` 提交 `0867ececc3224815e4f0aae07b76b9581f70cfe4` 的 `examples/beremiz_cia402_axis/`；只复制 7 个 Git 跟踪文件，唯一修改是 README 首行去掉 Markdown 硬换行的两个尾部空格，工程 XML 和 ST 未改。`confnode.xml` 是离线占位参数，不代表 IS620N 或其他真实驱动器设定。许可证见同级 `LICENSE.ic-beremiz-motion`，未复制 `build/`、`test-results/` 或设备凭据。
