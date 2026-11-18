用途：说明教程仓库对读者的稳定入口和离线构建脚本。当前状态：V0.0.17 首页、首章和包内 Clean Build 脚本已验证；没有运行时 API。

# 阅读与工程入口

- 网站根目录为教程入口。
- `/v0.0.17/` 为改版 UI 本地候选手册入口，`/v0.0.17/cases/01-first-virtual-axis/` 为首个案例。
- `/v0.0.14/` 为 V0.0.14 手册入口。
- `/v0.0.14/versions/` 为版本与证据页面。

案例页列出工程路径和关键资源路径。本站没有运行时 API，不参与 PLC 或实时线程。

## 离线构建入口

`scripts/clean_build.sh RELEASE_PACKAGE PROJECT_DIRECTORY EXPECTED_VERSION` 只接受三个位置参数，只调用所选发布包的 `clean build`。脚本先核对版本、CLI、扩展和 MATIEC，再复制工程到临时目录；临时副本及产物由脚本持有，退出时删除。源工程归调用者所有，脚本不会写回。该命令运行在主机普通进程，不在实时路径中使用，不提供线程并发保证。参数或工具链不完整返回 2；Clean Build 失败时透传非零退出；成功时输出两个生成文件的 SHA-256。

`scripts/verify_basic17_ld.sh RELEASE_PACKAGE LD_PROJECT EXPECTED_VERSION` 先核对包版本和所需脚本，随后用包内工具在测试夹具自己的临时目录对指定 LD 工程及包内 ST 对照工程各执行两次 Clean Build 与主机虚轴扫描。输入工程归调用者，夹具持有并清理副本及产物；脚本不连接设备，不在实时线程运行，也不保证多进程并发。参数/包不完整返回 2；夹具失败透传非零退出；成功输出 ST/LD 哈希与 PASS。对修改后的 LD 图形，成功判据仅适用于实际传入的工程内容。
