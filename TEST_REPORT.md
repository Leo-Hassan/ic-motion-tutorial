用途：记录教程每一阶段的实际测试、失败与跳过。当前状态：V0.0.17 案例 01～13、软件操作与全站本地验收已有证据；LD 触点取反失败，公开发布待续。

# 测试报告

## 阶段四：全站本地验收与发布准备（2026-11-19）

| 项目 | 实际结果 |
| --- | --- |
| V0.0.17 IDE | 本轮再次从包内 `Beremiz.py` 打开真实 `beremiz_basic_17_ld`，进程路径指向 V0.0.17 候选包；窗口标题显示大桥、工程名及 `Online:OFFLINE`，无生产 Runtime 连接 |
| 严格构建 | `PYTHONPATH=.deps python3 -m mkdocs build --strict` 返回 0；`python3 scripts/verify_site.py` 返回 0，生成 21 个 HTML 页、88 条搜索记录，13 个案例及两个版本入口齐全 |
| 链接、图片与代码 | 核对 1103 条生成站点内页面、资源链接及锚点缺失 0；44 张 V0.0.17 PNG 与来源表 SHA-256 全部相同；旋切页 ST 块含真实 Pygments 注释着色 span |
| Firefox 桌面 | 本机真实 Firefox 访问 `127.0.0.1:8765`：教程入口 → V0.0.17 手册 → 案例 01 点击成功；搜索 `rotary` 返回旋切页并可进入；案例 13 中真实 IDE 图、ST 代码和结果表可见。案例 13 底部前一篇链接进入案例 12；后续篇链接在页面与生成 HTML 中存在 |
| Firefox 手机 | 390×844 浏览器视口打开案例 13，顶部菜单、标题、版本/工程表格按窄屏换行；1366×900 桌面视口打开案例 11，章节导航与正文并排，无首屏横向溢出 |
| 公开内容 | 发布文件清单无 `build/`、`Testing/`、`test-results/`、`psk/`、`.deps/`、`site/`、SO、PEM 或 KEY；文字扫描只命中报告中的检查模式、校验脚本和工作流 `id-token` 字段，无实际凭据、本机路径或私有 IP。旧设备部署目录的 rpath 字面值已从来源说明移除 |
| 发布工作流 | `.github/workflows/pages.yml` 已准备 `main` 推送后 MkDocs 严格构建、站点核对和 GitHub Pages 部署；本阶段还未创建公开仓库，远端运行结果待发布阶段记录 |

浏览器预览服务曾随交互会话终止并显示本机连接失败；改以独立后台服务启动后返回 HTTP 200，正文检查继续通过。这是本地预览进程退出，不计为站点链接缺陷。Firefox 搜索初次输入受到本机中文输入法影响，切换英文输入后 `rotary` 搜索成功；未改动搜索索引。案例 04 的 V0.0.17 触点取反后 `RecursionError` 仍为 FAIL，原始 LD 工程构建和软件仿真 PASS 不覆盖该编辑路径。板端 Stop/Transfer/Run、Force、SDO 写入、电机运动和当前版实机验收均 SKIP。

## 阶段三壬：跟踪切、飞剪和旋切（2026-11-18）

三篇案例共用从 `ic-beremiz-motion` 提交 `0867ececc3224815e4f0aae07b76b9581f70cfe4` 原样复制的 `examples/beremiz_process_cutting/`，21 个跟踪工程文件包括 manifest、模拟编码器 Master、三根 VirtualAxis 和四张 ProcessRecipe。当前包版本 V0.0.17，工程内部 `productVersion=15.2.0` 是示例工程自身版本，不是 IDE 发布版本；测试文件名的 `v15` 同样不代表本次运行了 V0.0.15 IDE。三篇共用同一组构建/仿真证据，不重复计为三次独立运行。

| 项目 | 实际结果 |
| --- | --- |
| 首次包内保存工程测试 | `scripts/verify_process_cutting.sh` 初次 2 项中工作流项 PASS，构建项 **FAIL**：`matiec installation is not found`，返回 1；包内旧测试把 `IC_MATIEC_DIR` 同时当作 `MATIEC_PATH` 和 `lib/C` 根目录，首版包装脚本误设为 `matiec/bin` |
| 修正后保存工程测试 | 包装脚本将 `IC_MATIEC_DIR` 设为包内 `matiec` 根目录，另把 `matiec/bin` 加到 PATH；复跑返回 0、2/2 PASS，耗时 136.844 秒。控制器生成/保存/重开/另存/备份/恢复 PASS；同一保存工程两次 Clean Build 的七项摘要一致 |
| 保存工程 C 仿真 | `TrackingCut/FlyingSaw/RotaryKnife batch=5/5/5 permits=5/5/5` PASS，软件检查同步、返回、连续旋切，以及坏配方、漏标、重复切割请求、禁止许可、跳产品、反向、资源占用、不可达条件下的 FaultStopping、停止和执行器释放。三种块共用本次夹具运行 |
| 独立 CLI Clean Build | `scripts/clean_build.sh` 返回 0，SO SHA-256 `3400dd3d527864775cc3d3ba43317092ce62df2eb1d05f66f9171a8b29dce01b`，变量表 `45b9977c762f47c47df15e738c0964401b1cbd33d84ee05ba512a6866bb331b3`；与前项两次 Build 相同，工程身份 `g2 ad7b2f3cbfcb` |
| 真实 IDE GUI Build | V0.0.17 包内 `Beremiz.py` 打开未编辑临时副本，工具栏 Build 后 Console `Successfully built.`；SO 与变量表完整 SHA-256 与 CLI 逐字节一致。真实 IDE 底栏 `Online:OFFLINE` |
| 真实截图 | Master 离线状态、三张 ProcessRecipe Config、`MAIN` ST 和 GUI Build 成功六图；全部为真实 V0.0.17 包内 wx 窗口实拍，只裁剪窗口区域，SHA-256 见 `PROVENANCE.md` |
| 板端与实机 | SKIP：无生产 Runtime 连接、PDO/DC、传感器/刀具/机械安全验收；未执行板端 Stop/Transfer/Run、Force、SDO 写入或电机运动 |

包内 Python 测试仍输出两条 `ResourceWarning: unclosed file`，没有使复跑失败。工程 `ProcessTask=T#1ms` 为软件配置，不代表硬实时周期。21 个工程文件与锁定来源逐字节相同；`sh -n` 和 `git diff --check` PASS。站点 `mkdocs build --strict` 返回 0，生成 21 个 HTML 页面、88 条搜索索引；扫描 739 条站内页面/资源链接缺失 0，44 张 V0.0.17 PNG 与来源表摘要全部匹配。新工程/章节/脚本的本机绝对路径、私钥头、口令赋值及私有网段模式扫描命中 0。全站真实浏览器和 GitHub Pages 验收后续执行。

## 阶段三辛：二维协调路径（2026-11-18）

工程从 `ic-beremiz-motion` 提交 `0867ececc3224815e4f0aae07b76b9581f70cfe4` 的 `examples/beremiz_coordinated_path/` 复制 19 个跟踪文件，包含原始 manifest、两根虚轴、XY 组和四个 PathRecipe。目标只在主机离线运行，`PathTask=T#1ms` 是软件配置值，不等于硬实时周期实测。

| 项目 | 实际结果 |
| --- | --- |
| V0.0.17 包内保存工程测试 | 首次会话在第一项测试后以退出码 143 中断，没有完整判定；独立复跑 `scripts/verify_coordinated_path.sh` 返回 0，2/2 PASS，耗时 108.285 秒。工程生成/保存/重开/另存/备份/恢复 PASS；两次 Clean Build 八项摘要一致 |
| 保存工程 C 仿真 | 从本工程生成的共享库运行包内 C 夹具，八段绝对/相对直线、CCW/CW 圆弧、整圆、跨零、样条、混合过渡、固定前瞻/轮廓、QueueExhausted、GroupStop，以及限位/退化/非切线/无效配方与反馈无效均 PASS；终点 `(0,0)`，最大轮廓误差 `<0.01` 是夹具断言，不是硬件测量 |
| 独立 CLI Clean Build | `scripts/clean_build.sh` 返回 0；SO SHA-256 `c414e528b6a9f3305ae861acd3263ccbfb1a8ee6576dc5be425f930729ad75df`，变量表 `46388008c6236388a031412a22325b39f28be58626cac4562313043359509f07`；与保存工程测试两次结果一致，工程身份 `g2 d010d5409c7c` |
| 真实 IDE GUI Build | 全新 V0.0.17 包内 `Beremiz.py` 打开未编辑临时副本，点击 Build，Console `Successfully built.`；SO/变量表完整哈希与 CLI 逐字节一致。底栏 `Online:OFFLINE`，无生产 Runtime 连接 |
| 真实截图 | Group_XY、MixedPath 八段预览、`MAIN` 起始 ST 和 Build 成功 ST/Console 四图；全部由外部 `gnome-screenshot` 实拍 V0.0.17 包内 wx 窗口并裁剪，摘要见 `PROVENANCE.md` |
| 板端与实机 | SKIP：未执行板端 Stop/Transfer/Run、Force、SDO 写入或电机运动；没有 PDO/DC、机械轨迹或安全验收 |

首次测试会话的 143 中断没有留下完整 traceback 或可靠原因，不能归因为工程缺陷或算通过；只将完整复跑计入 PASS。包内 Python 测试输出两条 `ResourceWarning: unclosed file`，未改变测试判定。19 个工程文件与锁定来源逐字节相同；`sh -n` 和 `git diff --check` PASS。站点 `mkdocs build --strict` 返回 0，生成 18 个 HTML 页面、73 条搜索索引；扫描 572 条站内页面/资源链接缺失 0，38 张 V0.0.17 PNG 与来源表摘要全部匹配。新工程/章节/脚本的本机绝对路径、私钥头、口令赋值及私有网段模式扫描命中 0。真实浏览器桌面/手机验收及公开发布仍待后续阶段。

## 阶段三庚：电子齿轮、相位与电子凸轮（2026-11-18）

同一工程来自 `ic-beremiz-motion` 提交 `0867ececc3224815e4f0aae07b76b9581f70cfe4` 的 `examples/beremiz_sync_gear_cam/`，15 个跟踪文件原样复制到教程 `examples/v0.0.17/beremiz_sync_gear_cam/`。案例 08/09 共用它和同一组构建、仿真证据；没有重复计数。源码包含模拟 EncoderAxis 主轴、VirtualAxis 从轴、两张三点 CamTable 和同步配置，未导入 `build/`、`test-results/`、密钥或现场配置。

| 项目 | 实际结果 |
| --- | --- |
| V0.0.17 包内保存工程测试 | `scripts/verify_sync_gear_cam.sh` 返回 0，2/2 PASS，耗时 130.460 秒；控制器生成/保存/重开/另存/备份/恢复 PASS；两次 Clean Build 摘要完全一致，保存工程 C 仿真输出 `GearIn/Out GearInPos Phasing absolute/relative CamSwitch/CamOut PASS` |
| 独立 CLI Clean Build | `scripts/clean_build.sh` 对教程工程临时副本返回 0；SO SHA-256 `e416dbd9aee8aae7f9568970f697301c89d96cbe74eedcbeca1afb4619f5b9bd`，变量表 `adfebaf2a5ee9129c777d96d7875594e37f957b867d291aced09f4f8f591b97c`；与前项两次 Build 相同，工程身份 `g2 7632eb6860ab` |
| 真实 IDE GUI Build | V0.0.17 包内 `Beremiz.py` 在全新进程打开未编辑临时副本，等待加载后点击 Build，Console `Successfully built.`；SO/变量表完整 SHA-256 与 CLI **逐字节一致**。GUI 截图同屏显示工程树、`MAIN` 与 Console，状态 `Online:OFFLINE` |
| 首次 GUI 异常 | 首个 GUI 进程在打开 `MAIN` 后约 0.2 秒按 F11，真实报 `wxYield called recursively`，调用链 `BeremizIDE.py OnMethod → ProjectController._Build → LogPseudoFile._should_write → app.Yield()`。该次 GUI Build **FAIL**；关闭对话框后同进程再按 F11/点工具栏未得到新结果。重启后不先打开编辑器、等待工程加载，GUI Build PASS。缺陷没有修改包源码、没有移动版本标签 |
| 真实截图 | 新增 Gear ST、同步资源、Cam_A、Cam_B、Cam ST 与 GUI 成功控制台六图，均来自真实 V0.0.17 包内 wx 窗口，SHA-256 见 `PROVENANCE.md`；首次异常截图只留在本地临时测试目录，不纳入教程公开页面 |
| 仿真与硬件 | C 夹具从本工程生成的共享库进行本机离线软件仿真；没有生产 Runtime 连接、PDO、板端 Stop/Transfer/Run、Force、SDO 写入或电机运动。实轴同步和机械安全验收 SKIP |

`test_v15_beremiz_sync_project.py` 名称中的 `v15` 指该测试最初开发阶段；本阶段实际从 V0.0.17 包运行并核对包版本，不能把脚本名写成 IDE V0.0.15 验收。测试日志还出现两条上游 Python `ResourceWarning: unclosed file`，没有使测试失败。15 个工程文件与锁定源提交逐字节相同；`sh -n scripts/verify_sync_gear_cam.sh` 与 `git diff --check` 均 PASS。`PYTHONPATH=.deps python3 -m mkdocs build --strict` 返回 0，站点 17 个 HTML 页、搜索索引 68 条，扫描 522 条站内页面/资源链接缺失 0；34 张 V0.0.17 PNG 与来源表 SHA-256 全部匹配。新增工程/案例/脚本扫描未发现本机绝对路径、私钥头、口令赋值或私有网段地址。全站真实浏览器桌面/手机验收及公开发布仍待后续阶段。

## 阶段三己：IS620N 双实轴离线工程（2026-11-18）

从 `IGH_RK_1.6-master` 提交 `e6308f19cafe6c591e2dea0c8ba92b0349b746be` 的 `beremiz_projects/is620n_cia402_dual_circle_online/` 复制 11 个工程跟踪文件；没有复制 README 中的历史实机报告、`TEST_REPORT.md`、未跟踪 `psk/`、`build/`、`Testing/` 或 `test-results/`。`beremiz.xml` 的绝对交叉编译器改为工具名；C extension 的 IgH include/lib 改为教学占位符且移除旧板端 rpath，只有临时副本在构建/打开时解析本地路径。静态扫描本目录的 `/home/`、`/root/`、`psk`、`secret`、`private`、`password` 命中 0。

| 项目 | 实际结果 |
| --- | --- |
| 静态配置核对 | `verify_is620n_offline_config.py` PASS：根 1 ms、`MotionTask=T#1ms`、双轴 CSP、通道 1/2、每轴 ±0.95 转、1,048,576 counts/转，IgH 路径占位符 2 处 |
| V0.0.17 包内 CLI Clean Build | 真实 IgH AArch64 SDK 和交叉工具链在本机提供，临时教学副本 Clean Build PASS；SO SHA-256 `e85cd37c6620d23b92e26022ba5bce5d4bc58daa959a983ce96c8d7f97f25ded`，变量表 `843cd871ebd5ab5e58075bb7293d061cbda2f608db5859aa5b08247af1298fa7`；`Build identity unavailable`，没有部署 |
| 真实 IDE 构建 | 相同包内 `Beremiz.py` 打开临时副本，`F11` Console `Successfully built.`；SO 与变量表 SHA-256 和 CLI **逐字节一致**；`file` 确认 SO 为 AArch64 ELF 共享对象，`readelf -Ws` 未见 `CPU_ZERO`/`CPU_SET`/`CPU_ISSET`/`__atomic` 未定义符号 |
| 真实 IDE 配置/截图 | `DualCirclePanel`、Axis_1 Commissioning OFFLINE、Config CSP/±0.95、Console 构建成功四图；摘要见 `PROVENANCE.md`；`open_is620n_offline.sh` 实际启动该包 IDE，关闭后返回 0 且临时工程已删除 |
| 离线仿真与板端 | SKIP：此双实轴工程无独立 PDO/DC 过程映像仿真；没有 Connect、Stop、Transfer、Run、Force、SDO 写入或电机运动，历史实机报告未计入当前版本 |

首次运行教学构建脚本把交叉工具链目录置于 PATH 首位，调用了工具链自带的不兼容 Python，`beremiz_cli_compat.py` 报 `No module named 'click'`；增加主机 Python shim 后通过编译。第二次编译到链接阶段报 `cannot find -lethercat`：本版 Beremiz 把 `${IC_TUTORIAL_IGH_SDK}` 在 LDFLAGS 中原样传给链接器；脚本改为仅在临时工程副本将两个占位符替换为 SDK 路径，重建 PASS。原始两次失败保留，不把初次尝试记作成功。GUI 点击 Config 后窗口显示 `~project~`，构建提示 `Build identity unavailable: unsaved project changes`；无论原因，教学副本不具备部署身份。

本阶段 `PYTHONPATH=.deps python3 -m mkdocs build --strict` 返回 0，生成 14 个 HTML 页面、58 条搜索索引记录。静态扫描 425 条站内页面/资源链接，缺失 0；28 张 V0.0.17 PNG 的 SHA-256 与来源表逐项匹配。两个 shell 脚本 `sh -n`、静态配置核对与 `git diff --check` 均通过。公开 IDE V0.0.17 发布、全站浏览器验收和 GitHub Pages 仍待后续阶段。

## 阶段三戊：ST 断点与单步（2026-11-18）

`st_current_value` 的三个工程文件从 V0.0.17 锁定 `beremiz` 提交 `06f5b1e0e45faecac96d790ab03e57be46d4fd2d` 原样复制。另写的 `maintenance_debug.st` 与工程 `MAIN` 的三条赋值一致，仅为候选编译输入。`ic-matiec-adapter` 源码提交 `01e4b4897b6d7a002d26169314687e8154f29c5c`，主机库由相同源码构建；不随教程提交。调试服务仅在主机 `127.0.0.1`，物理输出隔离。

| 项目 | 实际结果 |
| --- | --- |
| V0.0.17 包内 Clean Build | 两次 PASS；`VARIABLES.csv` SHA-256 均为 `7cee8bc84447ebe4ee558eb50916ee08be26d39305ff08ace65cfb724e2ad4df`；两次临时路径的 SO 分别为 `0857c153d1a0ce847842924906a38843ebe3c06dd75b5b417fe4de81dbb7bd25` 和 `9ed2b41d6ca49b113976e8f35632cce42429fa497bf8e4a0af3b73bc53077636`，故不声明产物逐字节一致 |
| 可复现主机回环 | `scripts/verify_st_debug_loopback.sh` 使用包内 MATIEC、锁定 adapter 映射/审计工具和包内 `test_maintenance_debug_erpc_gui.py --current-value`，返回 `real MATIEC + eRPC + wx inline Speed 0 -> 10 -> 20; Continue and Detach PASS`；脚本返回 0 |
| 完整 IDE 本地回环 | 直接加载 V0.0.17 包内 `BeremizIDE` 的真实 wx 框架，打开从该工程迁移且 Clean Build 的临时副本；本地主机测试夹具给已停止 Runtime 注入匹配的工程身份并用 eRPC 执行 Attach、两次 Step over、Continue 和 Detach。面板读数依次 `Speed=0/10/20`，继续后 `ScanCount=1`；离开为 `Detached` |
| 真实截图 | 外部 `gnome-screenshot` 在各 GUI 事件返回后截取 6 个实际窗口状态；断点、暂停行、内联值和退出状态可见；6 张 SHA-256 各不相同且与 `PROVENANCE.md` 一致 |
| 生产监视与板端 | SKIP：未连接生产 Runtime，未作在线只读监视；没有 Connect、Stop、Transfer、Run、Force、SDO 写入或电机运动 |

完整 IDE 回环初次尝试用候选 map generation 7 匹配工程 generation 1，被 Runtime 正确拒绝为 `MAINTENANCE_DEBUG_MAP_MISMATCH`；将本地测试候选的 map、manifest 与实际工程构建身份绑定后通过。第二次测试脚本缺少 `if __name__ == "__main__"` 保护，隔离调试子进程 spawn 重入，出现 `MAINTENANCE_DEBUG_COMMAND_TIMEOUT`；修正入口后通过。自动截图初次在同一 GUI 事件回调中抓取，得到未刷新的旧画面；改为独立桌面截图进程在事件返回后截取并逐图检查，旧图未进入仓库。这些是测试夹具准备和采集失败，不计作最终调试 PASS。包内真实 GUI 的正式生产调试流程未验证。

本站阶段三戊 `PYTHONPATH=.deps python3 -m mkdocs build --strict` 返回 0，生成 13 个 HTML 章节页，53 条搜索索引记录。静态扫描 381 条站内页面/资源链接，缺失 0；24 张 V0.0.17 PNG 的 SHA-256 与来源表逐项匹配，6 张 ST 调试图彼此不同。`sh -n scripts/verify_st_debug_loopback.sh` 和 `git diff --check` 返回 0。浏览器桌面/手机及公开发布尚未执行。

## 阶段三丁：设备映射与 CiA 402（2026-11-18）

两工程均从 V0.0.17 锁定的 `ic-beremiz-motion` 提交 `0867ececc3224815e4f0aae07b76b9581f70cfe4` 只复制 Git 跟踪文件。模拟设备目录含 1 台 `Simulated-IO` 与 4 个预置通道；CiA 402 工程的 CSP、缩放和行程为上游离线占位值。没有设备扫描、板端连接或参数写入。

| 项目 | 实际结果 |
| --- | --- |
| 映射工程包内 Clean Build | PASS；SO SHA-256 `e43ec09b46158754af6f3158ad99a87ff8546587b9d024a9d1bf13ee2d380603`，变量表 `3b7fcd0f6c7f64522261d3326c0263b3f6bc0520c3ae72e72ac2c59f9e61e237`；真实 IDE `F11` Build PASS |
| CiA 402 工程包内 Clean Build | PASS；SO SHA-256 `fcd539f319107916186b9e6fc267a76a10b688291099b959f4c829a52be7cec5`，变量表 `dbf04d33b449df0b82230966a644b0bd4f6290b53a32b0add1655b16ad8d9900`；真实 IDE `F11` Build PASS，GUI 临时副本提示 unsaved project changes |
| 映射离线夹具 | 源码仓库 `MAP_P01C_GENERATED_CYCLE`、`MAP_P01D_WORKFLOW`、`MAP_P01D_BEREMIZ_CLEAN_BUILD` 3/3 PASS；后者完成保存工程模拟过程映像验证。该夹具使用同提交上游工程，教程副本另做包内 Clean Build |
| 映射 GUI 正式入口 | **FAIL**：V0.0.17 正式启动器的 Python 路径缺 `ic-device-library/python`，打开 Mapping 编辑页真实报 `No module named ic_device_catalog`；已有包内软件门禁不覆盖该路径 |
| 教程临时离线入口 | `scripts/open_mapping_offline.sh` 对期望 V0.0.18 返回 2 并说明不匹配；对 V0.0.17 打开教程工程，真实 Mapping 页显示 4 行及 `Offline editing`，进程路径仍指向 V0.0.17 包内 `Beremiz.py`，无 Runtime 隧道 |
| CiA 402 仿真与板端 | SKIP：虚轴仿真入口不支持 `Cia402RealAxis`；无当轮实机授权，硬件操作 0 |

第一次在工作区源码 CTest 的现有缓存上运行映射测试时，共 3 项中生成周期 1 PASS、工作流与保存工程测试 2 FAIL，原因是缓存引用的 `build/ic-device-library/libic_mapping_validator.so` 尚未构建。先在相同源码树构建 `ic_mapping_validator`，再复跑 3/3 PASS；原始失败保留，不能称第一次全通过。另一次从源码根执行旧版 CTest 的 `--test-dir build` 输出 `No tests were found`；改在实际 `build/` 工作目录执行。正式启动器映射页路径缺陷仍未修复，不以临时入口 PASS 覆盖。

CiA 402 工程复制后仅清理上游 README 首行两个 Markdown 尾部空格；对最终教程副本再做包内 Clean Build，SO 与变量表 SHA-256 均与上表初次结果一致。工程 XML、ST 和实轴占位参数没有改动。

本阶段新增 6 张真实 V0.0.17 包内 IDE 截图，工程树、编辑位置、离线状态及构建结果与正文对应，SHA-256 见图片来源表。网站、浏览器和公开发布的整体验收在后续阶段进行。

本站 `mkdocs build --strict` 返回 0，13 个 HTML 页面、335 条站内页面或资源链接缺失 0，搜索索引 48 条且含 CiA 402 正文。首轮截图摘要对照发现 `cia402-build-result.png` 的来源表录入多出两个十六进制字符，图片本体未改；修正表项后复核。真实浏览器桌面与手机验收仍待执行。

本阶段暂存 33 个文件的文字敏感模式扫描命中 0，18 张 V0.0.17 PNG 的 SHA-256 均在来源表中逐项匹配；`git diff --cached --check` 无空白错误。生成的 `site/`、本地测试日志和包内构建目录未纳入提交。

提交后按 `git ls-files` 复核发现来源说明把映射与 CiA 402 的文件数写反；实际分别为 6 和 7 个跟踪文件，已修正来源表述，不涉及工程内容或构建结果。

## 阶段三丙：轴配置和限位（2026-11-18）

案例 05 复用案例 01 的完全相同 `FirstVirtualAxis` 源码与 V0.0.17 包内实测，不创建第二份工程或把同一次运行计为新增独立验证。配置文件核对值为位置 -100..100、速度/加减速度上限 100、周期 0.001 s；`plc.xml` 中 `config/resource1/MotionTask` 为 `T#1ms`，`MAIN` 的目标 3、速度 1 均在所示配置范围内。阶段三甲已记录该工程 Clean Build 的 SO 与变量表哈希及真实 GUI 仿真的 3056 周期、X=3、ErrorID=0、硬件操作 0。本章没有执行越界故障注入或实机限位测试，均记 SKIP。

站点 `mkdocs build --strict` 本阶段复跑返回 0；12 个生成 HTML 页、291 条站内页面或资源链接缺失 0。页面复用阶段三甲直接截取的两张真实 V0.0.17 IDE 图片，未生成界面。浏览器桌面、手机和公开站点验收仍待后续阶段。

## 阶段三乙：ST 命令交接与真实 LD 工程（2026-11-18）

本阶段使用同一个 V0.0.17 本地候选包，版本回查与包源码身份见阶段三甲。两个复制工程均来自 `ic-beremiz-motion` 提交 `0867ececc3224815e4f0aae07b76b9581f70cfe4`；只复制跟踪的源码和配置，`build/` 与历史测试物没有进入教程。包内 IDE 以 `IC_SKIP_ERPC_TUNNEL=1` 在真实桌面打开临时副本，窗口显示 `Online:OFFLINE`。

| 项目 | 实际结果 |
| --- | --- |
| ST 工程 Clean Build | `beremiz_virtual_axis` 使用 V0.0.17 包内 CLI 成功；SO SHA-256 `8d0b2419f4bacbfaadf5c7f5e2eee59316f5836d367d9e1cc690e0af07348328`，变量表 `4c0baaeb12a959a0a65b1a9c54d9cd82f013396d6d6d27d9f9e4984a24df1f13`；真实 IDE `F11` Build 成功 |
| ST 交接夹具 | 同提交 `Test_LookAhead.st` 的 `V10_ST_LookAhead` CTest 1/1 PASS：2753 周期、排队 3、交接 3、终点 5.06；与案例工程的 100..101.5 目标不同，案例自身自动 GUI 仿真 SKIP |
| 原始 LD 工程 Clean Build | `beremiz_basic_17_ld` 使用 V0.0.17 包内 CLI 成功；SO SHA-256 `0459f68979803641e453a5d30a2fdddfac5c04eb4c7b5f181ab8a82d00a4a7ec`，变量表 `9062acdcd8599bdbc73f6d039abf1f3cf3f55e9788d81e37f385fb1ec54edbe9`；真实 IDE `F11` Build 成功 |
| 保存工程 LD 仿真 | 公开 `scripts/verify_basic17_ld.sh` 调包内 `test_beremiz_basic17_build.py`，对教程 LD 和包内 ST 对照工程各两次 Clean Build，哈希相等，确认 17 类块/18 实例并执行主机虚轴扫描；复跑 1/1 PASS，202.530 秒；LD 的 SO/变量表哈希与上行一致 |
| LD 编辑缺陷 | 在独立临时副本中真实双击 `Enable` 触点，Normal 改 Negated 并保存，`F11` 触发 `RecursionError`，**FAIL**。保存的 `plc.xml` 中触点 97 错误反向引用线圈 98，形成回环；原始工程 PASS 不能覆盖这一失败 |
| 真实截图 | 本阶段新增 ST 2 张、LD 6 张，包括取反编辑和实际错误对话框；V0.0.17 包内进程、步骤和 SHA-256 见 `PROVENANCE.md`；没有绘制或生成 IDE UI |
| MkDocs 严格构建与静态链接 | `PYTHONPATH=.deps python3 -m mkdocs build --strict` 返回 0；11 个生成 HTML 页、254 条本地页面或资源链接缺失 0；搜索索引 39 条，含 ST 和 LD 正文。真实浏览器验收仍待后续阶段 |
| 板端与实机 | SKIP：无当轮单独授权，硬件操作 0 |

第一次直接调用保存工程测试缺少包内 MatIEC `bin` 的 `PATH`，运行失败；补齐包内路径后 1/1 PASS。源码仓库现有 CMake 缓存最初没有 MatIEC，`V10_ST_LookAhead` 报 SKIP；重新配置 `IC_MATIEC_EXECUTABLE` 后 1/1 PASS。V0.0.17 包裁掉 CTest 原始夹具源码，不能在包目录直接重新配置此项，实际 PASS 使用锁定提交的工作区 `ic-beremiz-motion` 源码和包内 MatIEC。随后在 CMake 当前目录误用 `-S .` 返回配置错误，改为源码根路径后才成功。这些初次失败和 SKIP 不计为通过。

LD 编辑缺陷已在 V0.0.17 发布源码仓库 README、CHANGELOG 与 TEST_REPORT 追记；尚未修复、没有移动标签或重打归档。**案例 04 的“LD 编辑后可构建”要求仍未满足。**

本阶段暂存 42 个文件的文字敏感模式扫描命中 0，图片摘要与来源表逐项一致。新增约 2651 行中，原样复制的 PLCopen LD `plc.xml` 占 2090 行；超过通常的 2000 行阶段原则是为保留可打开、可构建的真实 LD 工程，未扩展产品源码功能。

## 阶段三甲：V0.0.17 改版 UI 与案例 01（2026-11-18）

V0.0.17 本地候选主包版本回查为 `Industrial Control Platform V0.0.17`；
发布源码提交 `8f743aa19cc49012b5cfec38a49d15d95fb9facd`，主包归档 SHA-256
`5606204f00e3bc1d21fbdf1690f57b964f75d1889e5f17c3c0efa69e162216e5`。
发布仓库的本地包内门禁和归档解压后的全新安装复验均 PASS，硬件操作 0；
这些属于软件/GUI 验证。文档追记提交 `53daa23` 不改变归档身份。

| 项目 | 实际结果 |
| --- | --- |
| 包内真实 GUI | 从 V0.0.17 包启动，`ps` 指向包内 `Beremiz.py`；红色标题栏、活动栏、工程树可见，底部 `Disconnected`、`Online:OFFLINE` |
| V0.0.17 工程副本 Clean Build | `scripts/clean_build.sh` 返回 0；SO SHA-256 `e399feb39f2ef3c8e6d2f827b2a9fb095c14a60fc72f3a83dbdbb242dee91206`；变量表 `343dae36ad190944733dac699e2c6fb3bd977632ed49021a6967157c718a3544` |
| 包内控制器离线仿真 | 从教程工程临时副本重开，`LoadProject=(None,False)`；`cycles=3056`、`x=3`、`done=1`、`error=0`、`hardware_operations=0` |
| 真实 GUI 离线仿真 | 在包内 IDE 打开同工程临时副本，XTEST 输入 `Ctrl+Alt+M`，结果框显示 3056 周期、X=3.000000、ErrorID=0；生成结果 JSON 与控制器仿真一致 |
| 截图来源 | wx `ScreenDC` 从真实窗口直接截取 4 张 PNG；版本/进程/摘要见 `docs/assets/images/v0.0.17/PROVENANCE.md` |
| MkDocs 严格构建 | `PYTHONPATH=.deps python3 -m mkdocs build --strict` 返回 0；章节页、图像、代码高亮与 `lang=zh` 搜索索引生成；浏览器桌面和手机验收仍待执行 |
| 静态链接检查 | 扫描生成的 123 条站内图片/页面链接，按 GitHub Pages `/ic-motion-tutorial/` 前缀解析后缺失 0；搜索索引 29 条，首例和 `MC_MoveAbsolute` 正文均在索引/HTML 中 |
| 板端与实机 | SKIP：无本轮单独授权，未连接、部署、运行或写设备 |

一次手工直接调用包内 `Beremiz.py` 时误将包内 `python/` 加入 Python 3.8 的
`PYTHONPATH`，其 `lxml` 与系统解释器不兼容，真实 GUI 弹出 ImportError 并退出；
按正式启动器环境只使用 `compat-python` 和 `beremiz` 后，工程窗口正常打开，
编辑、构建及仿真通过。此错误启动不计 IDE 验收 PASS。
首次手工写错构建入口 `.deps/bin/mkdocs`，命令返回 127；实际依赖通过
`PYTHONPATH=.deps python3 -m mkdocs` 使用，纠正后严格构建返回 0。
首次静态链接脚本未识别站点的 `/ic-motion-tutorial/` 部署前缀，误报 10 条缺失；
按 `site_url` 前缀解析后复核 123 条链接，缺失 0。该首轮误报不计真实断链。

本阶段尚未完成约 12 案例、每例截图、全站浏览器验收、GitHub Pages 与公开发布；
不能将首例或发布包离线门禁外推到这些未完成项。V0.0.17 仍为本地候选，
没有公开 IDE 发布标签或下载地址。

## 阶段一：版本与站点骨架（2026-11-18）

| 项目 | 实际结果 |
| --- | --- |
| 发布包 `VERSION` | `V0.0.14` |
| `bin/ic-platform --version` | `Industrial Control Platform V0.0.14`，退出 0 |
| 发布目录 `RELEASE_COMMIT` | `00127cb5792af7279719942260329b47b7b3a09f`，与发布仓库 HEAD 一致 |
| `bin/ic-platform --self-test` | 退出 0；Linux amd64 依赖、PyNaCl/eRPC 与 PLC Runtime 自检通过 |
| MkDocs 严格构建 | `PYTHONPATH=.deps python3 -m mkdocs build --strict`，退出 0，0 warning；产物在忽略的 `site/` |
| 产物结构 | 首页、手册、版本页、搜索索引与样式文件均存在；搜索索引包含版本页，共 12 条章节索引记录 |
| 忽略规则 | `.deps/`、`.venv/`、`site/` 均被 Git 忽略 |
| 浏览器与案例验收 | 后续阶段，当前未执行 |
| 板端操作 | SKIP：本任务无当轮授权 |

初次 `git init -b main` 因本机 Git 不支持 `-b` 返回 129；随后用 `git init` 与 `symbolic-ref` 建立独立 `main` 分支。未改动其他仓库。

本机 Python 3.8 无 `ensurepip`，`python3 -m venv .venv` 返回 1；系统 Python 无 pip，直接 `python3 -m pip` 返回 1。默认代理访问 PyPI 超时。随后从官方 PyPI 直连，将 pip 和站点依赖安装到忽略的 `.deps/`，严格构建成功。`.deps/` 只是本机依赖缓存，不进入 Git。

首次提交因本机缺少 Git 作者身份返回 128；随后仅在本教程仓库设置当前 GitHub 账号的公开 noreply 身份，再重试提交。

## 阶段二：虚轴样例与 UI 版本核对（进行中）

| 项目 | 实际结果 |
| --- | --- |
| 示例来源 | `ic-beremiz-motion` 提交 `29ca588ca3e1190acf751e9e3353a30d5222f44d`，与 V0.0.14 组件锁一致 |
| 包内 CLI 初次尝试 | 直接调用 `Beremiz_cli.py` 返回 1：本机 Click 7 缺少 `result_callback`；改用发布包自带 `beremiz_cli_compat.py` |
| V0.0.14 包内 Clean Build | `scripts/clean_build.sh <V0.0.14发布目录> examples/v0.0.14/virtual_axis V0.0.14` 返回 0；`project.so` SHA-256 `8d0b2419f4bacbfaadf5c7f5e2eee59316f5836d367d9e1cc690e0af07348328`；`VARIABLES.csv` SHA-256 `4c0baaeb12a959a0a65b1a9c54d9cd82f013396d6d6d27d9f9e4984a24df1f13` |
| 构建警告 | 旧示例无 `project-manifest.json`，CLI 提示 `Build identity unavailable`；离线构建仍成功，未进行 Transfer |
| 版本不匹配门禁 | 给 V0.0.14 包传入期望 `V0.0.15`，脚本返回 2 并说明版本不一致 |
| 改版 IDE 打开 | 工作区 `beremiz` 提交/标签 `06f5b1e0` / `ui-baseline-2026-11-18`；真实桌面 `DISPLAY=:0` 打开虚轴工程，窗口显示改版红色 UI；进程路径已核对为工作区源码，不是 V0.0.14 发布包 |
| 改版 UI 截图 | 真实窗口截图 SHA-256 `54978bb87754c30caa6711d7c056fa049a678e5adc43fa015d5f01f5efe4a27f`，仅保存在忽略的 `test-results/`；不作为 V0.0.14 教程截图 |
| 仿真与板端 | 原复杂虚轴工程的独立仿真尚未执行；首次运动专用工程见下节；板端操作 SKIP，无当轮授权 |

独立发布版本尚未包含改版 UI。当前正在确认教程后续基线；截图、案例操作步骤和浏览器验收未完成，本阶段不计完成。

### 首次虚轴运动教程专用工程

从 V0.0.14 包内 `ic_motion.preview_project.create_project` 使用模板 0、行程 3.0、速度 1.0 生成 `FirstVirtualAxis`。原生成目录 `simulate` 返回 0：3056 扫描、`x=3`、`max_x=3`、`done=1`、`error=0`、`hardware_operations=0`。

初次把 `SOURCE.md` 与许可证放入带 `project-manifest.json` 的工程内部，临时副本 `LoadProject` 返回 `PROJECT_CONTENT_MISMATCH`，不能算通过。将两文件移到工程目录同级后，从教程副本再复制到全新临时目录，`LoadProject` 返回 `(None, False)`，随后 `simulate` 返回 0，同样在 3056 扫描到达 3.0，错误 0、硬件操作 0。用 `scripts/clean_build.sh` 对教程副本另做包内 Clean Build 返回 0；SO SHA-256 `e399feb39f2ef3c8e6d2f827b2a9fb095c14a60fc72f3a83dbdbb242dee91206`，变量表 SHA-256 `343dae36ad190944733dac699e2c6fb3bd977632ed49021a6967157c718a3544`。工程构建身份存在；所有生成 `build/` 留在临时或忽略目录，未提交。

阶段二当前仍缺与最终发布 UI 版本对应的案例步骤截图、ST/LD 页面与浏览器验收；本站 `mkdocs build --strict` 复跑返回 0。`test-results/` 只保留本地日志和候选截图，未纳入发布内容。
