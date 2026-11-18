用途：记录教程每一阶段的实际测试、失败与跳过。当前状态：阶段一完成，阶段二甲虚轴工程离线验证完成，案例页面尚未完成。

# 测试报告

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
