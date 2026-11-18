用途：说明教程仓库对读者的稳定入口和离线脚本。当前状态：V0.0.17 案例 01～07、包内构建及临时离线入口已有验证；没有运行时 API。

# 阅读与工程入口

- 网站根目录为教程入口。
- `/v0.0.17/` 为改版 UI 本地候选手册入口，`/v0.0.17/cases/01-first-virtual-axis/` 为首个案例。
- `/v0.0.14/` 为 V0.0.14 手册入口。
- `/v0.0.14/versions/` 为版本与证据页面。

案例页列出工程路径和关键资源路径。本站没有运行时 API，不参与 PLC 或实时线程。

## 离线构建入口

`scripts/clean_build.sh RELEASE_PACKAGE PROJECT_DIRECTORY EXPECTED_VERSION` 只接受三个位置参数，只调用所选发布包的 `clean build`。脚本先核对版本、CLI、扩展和 MATIEC，再复制工程到临时目录；临时副本及产物由脚本持有，退出时删除。源工程归调用者所有，脚本不会写回。该命令运行在主机普通进程，不在实时路径中使用，不提供线程并发保证。参数或工具链不完整返回 2；Clean Build 失败时透传非零退出；成功时输出两个生成文件的 SHA-256。

`scripts/verify_basic17_ld.sh RELEASE_PACKAGE LD_PROJECT EXPECTED_VERSION` 先核对包版本和所需脚本，随后用包内工具在测试夹具自己的临时目录对指定 LD 工程及包内 ST 对照工程各执行两次 Clean Build 与主机虚轴扫描。输入工程归调用者，夹具持有并清理副本及产物；脚本不连接设备，不在实时线程运行，也不保证多进程并发。参数/包不完整返回 2；夹具失败透传非零退出；成功输出 ST/LD 哈希与 PASS。对修改后的 LD 图形，成功判据仅适用于实际传入的工程内容。

`scripts/open_mapping_offline.sh RELEASE_PACKAGE MAPPING_PROJECT EXPECTED_VERSION` 核对版本、项目和包内映射依赖，补齐 V0.0.17 启动器遗漏的设备目录 Python 路径及校验库路径，然后以 `IC_SKIP_ERPC_TUNNEL=1` 执行包内 `Beremiz.py`。输入工程归调用者，IDE 只在用户主动保存时写工程；脚本本身不复制或改写工程，不连接 Runtime，不在实时线程使用。参数、版本、DISPLAY 或依赖错误返回 2；正常启动后由 GUI 进程决定最终退出码。脚本是 V0.0.17 限定的离线映射页替代入口，不取代发布包的正式启动器门禁。

`scripts/verify_st_debug_loopback.sh RELEASE_PACKAGE PROJECT_DIRECTORY ADAPTER_SOURCE HOST_LIBRARY` 仅用于 V0.0.17。脚本核对包和输入，临时目录持有工具链链接、MATIEC 生成 C、调试 map、候选 SO 与审计清单，退出时清理。源工程、adapter 源码和主机库归调用者；脚本不写入它们。它调用包内真实 wx/eRPC 回环测试验证 ST 当前值 0→10→20、Continue 和 Detach，不连接设备、不开启生产 Runtime，也不在实时线程执行；不提供并发重入保证。缺参数、包、DISPLAY 或依赖返回 2；生成、编译、审计或测试失败返回非零，成功输出 PASS。

`scripts/verify_is620n_offline_config.py PROJECT_DIRECTORY` 只读校验教程双轴工程的版本无关静态配置：根 1 ms 周期、两个 CSP 通道、缩放、软件限位及无本机 IgH 路径。输入工程归调用者，脚本不生成文件、无线程和实时路径；缺参数返回 2，配置缺失或不符返回非零，成功打印 PASS。

`scripts/clean_build_is620n_offline.sh RELEASE_PACKAGE PROJECT_DIRECTORY IGH_AARCH64_SDK CROSS_COMPILER_DIRECTORY` 仅接受 V0.0.17 包，在调用者提供的 SDK/工具链下持有临时工程副本，在该副本解析路径后委托通用 `clean_build.sh`。源工程、SDK 和工具链归调用者；两层临时副本及产物由脚本退出时删除。它只进行主机离线交叉编译，不连接 Runtime，不在实时路径运行，也不保证并发调用隔离以外的系统资源。输入或依赖缺失返回 2，构建失败透传非零，成功输出 SO/变量表摘要。

`scripts/open_is620n_offline.sh` 使用同样四个参数，持有一份临时工程副本和 IDE Build 目录，调用包内 `Beremiz.py` 打开；仅在退出时清理脚本持有的副本。不会修改源工程或 SDK，不建立 eRPC 隧道，也不自动 Connect/Transfer/Run。参数、版本、DISPLAY 或依赖错误返回 2；GUI 进程退出码透传。它不是生产部署入口，也不适合实时线程。
