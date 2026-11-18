用途：记录教程每一阶段的实际测试、失败与跳过。当前状态：V0.0.17 改版 UI 首章和软件操作截图已完成，后续案例、浏览器验收与公开发布待续。

# 测试报告

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
