用途：说明中文教程仓库的构建、目录和交付进度。当前状态：阶段一站点骨架与 V0.0.14 身份已建立，未公开发布。

# 大桥 IDE / IC Motion 中文教程

独立 Markdown 教程仓库。阅读结构为“教程入口 → 版本手册 → 章节”，每个网站版本对应一个 IDE 发布版本。当前基线是 `V0.0.14`。

## 本地构建

```sh
python3 -m venv .venv
.venv/bin/python -m pip install -r requirements.txt
.venv/bin/mkdocs build --strict
.venv/bin/mkdocs serve
```

需要带 `venv` 和 `pip` 的 Python 3.8 或更新版本。打开本地预览地址。构建产物在忽略的 `site/`，不能作为工程源码提交。本工作站的系统 Python 缺少 `venv` 和 pip，阶段一改用本地忽略目录 `.deps/` 安装依赖后完成严格构建；详情见 `TEST_REPORT.md`。

## 目录

- `docs/index.md`：教程入口。
- `docs/v0.0.14/`：V0.0.14 手册；未来版本独立保留。
- `examples/v0.0.14/`：后续阶段加入经公开内容检查的工程副本。
- `TEST_REPORT.md`：逐阶段测试、失败和跳过记录。

本仓库不包含 EtherCAT 主站、密钥、板端配置、构建缓存或历史 `test-results`。教程不会触发板端 Stop、Transfer、Run、Force、SDO 写入或电机运动。
