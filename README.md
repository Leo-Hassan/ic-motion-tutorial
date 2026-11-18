用途：说明中文教程仓库的构建、目录和交付进度。当前状态：改版 IDE V0.0.17 本地候选案例 01～13 已覆盖计划主题；LD 与映射页启动限制已记录，浏览器验收和公开发布待续。

# 大桥 IDE / IC Motion 中文教程

独立 Markdown 教程仓库。阅读结构为“教程入口 → 版本手册 → 章节”。当前编写基线是改版 UI 的 `V0.0.17` 本地候选，包源码提交 `8f743aa`，软件门禁已通过但尚无公开 IDE 发布标签；`V0.0.14` 旧版目录保留。

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
- `docs/v0.0.17/`：改版 UI 本地候选手册；`docs/v0.0.14/` 为保留的旧版目录。
- `docs/assets/images/v0.0.17/`：真实 IDE 截图与来源摘要。
- `examples/v0.0.17/FirstVirtualAxis/`：在 V0.0.17 包内重建和仿真的虚轴工程。
- `examples/v0.0.14/`：保留的 V0.0.14 虚轴工程底座；V0.0.17 的十三个案例工程位于独立版本目录。
- `scripts/clean_build.sh`：用选定发布包的包内 CLI 在临时副本离线 Clean Build。
- `scripts/verify_basic17_ld.sh`：用选定发布包对实际 LD 工程执行两次 Clean Build 与保存工程虚轴扫描；会同时运行包内 ST 对照工程。
- `scripts/verify_sync_gear_cam.sh`：用 V0.0.17 包内测试对同一齿轮/凸轮工程执行保存重开、两次 Clean Build 和本地主机仿真。
- `scripts/verify_coordinated_path.sh`：用 V0.0.17 包内测试对二维路径工程执行保存重开、两次 Clean Build 和八段路径/负向配方主机仿真。
- `scripts/verify_process_cutting.sh`：用 V0.0.17 包内测试对同一工艺切割工程执行保存重开、两次 Clean Build、三块批量切割和负向矩阵主机仿真。
- `scripts/verify_st_debug_loopback.sh`：用包内 MATIEC 和锁定 adapter 构建主机维护调试候选，运行真实 wx/eRPC 断点单步测试；不接设备。
- `scripts/verify_is620n_offline_config.py`：核对脱敏双实轴工程的 1 ms、CSP、通道和软件限位配置。
- `scripts/clean_build_is620n_offline.sh`、`open_is620n_offline.sh`：使用调用者提供的 AArch64 IgH SDK 和交叉工具链，在临时副本做离线构建或打开真实 IDE；不接设备。
- `scripts/open_mapping_offline.sh`：V0.0.17 映射页临时离线入口，核对包版本并补齐包内设备目录模块路径；不建立 Runtime 隧道。
- `TEST_REPORT.md`：逐阶段测试、失败和跳过记录。

本仓库不包含 EtherCAT 主站、密钥、板端配置、构建缓存或历史 `test-results`。教程不会触发板端 Stop、Transfer、Run、Force、SDO 写入或电机运动。
