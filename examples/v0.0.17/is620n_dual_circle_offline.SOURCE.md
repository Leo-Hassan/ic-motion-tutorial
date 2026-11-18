用途：记录 IS620N 双实轴工程离线教学副本的来源与改动。当前状态：只含工程源码，V0.0.17 包内 CLI 与真实 GUI AArch64 离线构建 PASS；禁止当作可部署工程。

# IS620N 双实轴离线工程来源

原仓库 `IGH_RK_1.6-master`，提交 `e6308f19cafe6c591e2dea0c8ba92b0349b746be`，原路径 `beremiz_projects/is620n_cia402_dual_circle_online/`。本目录只复制 11 个 Git 跟踪的工程 XML、ST 和 C extension 配置文件；不复制原 `README.md`、`TEST_REPORT.md`、`psk/`、`build/`、`Testing/` 或 `test-results/`。代码包含由项目维护者编写的 IS620N/IgH 接口；源文件和原仓库版权、SPDX、上游路径均保留。若需替换，必须从锁定提交重新取源并重新验收，不复用此教学副本作为现场配置。

为避免发布本机绝对路径，`beremiz.xml` 的 Compiler/Linker 改为 `aarch64-buildroot-linux-gnu-gcc`，由构建脚本从调用者提供的交叉工具链目录解析；`IS620N_Dual_PDO@c_ext/confnode.xml` 的 IgH include/lib 改为 `${IC_TUTORIAL_IGH_SDK}`，构建时只在临时工程副本替换为调用者 SDK 路径，并去掉仅适合旧设备部署目录的 rpath。其他工程文件未改。此修改会改变链接参数，因此生成 SO 仅用于离线教学验证，不得 Transfer。

本工程可能包含实际轴配置、限位和程序逻辑，但本站不提供现场主站、设备身份、密钥或参数，也不验证运行环境。任何当前版本实机结论必须另行获准并独立验收。

本机 V0.0.17 包内 CLI 和真实 IDE 的临时副本构建返回相同 `project.so` SHA-256 `e85cd37c6620d23b92e26022ba5bce5d4bc58daa959a983ce96c8d7f97f25ded`、`VARIABLES.csv` SHA-256 `843cd871ebd5ab5e58075bb7293d061cbda2f608db5859aa5b08247af1298fa7`。这只是当前教学副本与指定 SDK/工具链的离线证据，未建立可部署身份。
