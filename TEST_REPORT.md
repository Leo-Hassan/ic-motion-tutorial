用途：记录教程每一阶段的实际测试、失败与跳过。当前状态：阶段一版本与站点骨架验收完成，案例阶段尚未开始。

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
