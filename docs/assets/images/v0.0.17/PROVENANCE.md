用途：记录教程截图的真实来源和版本身份。当前状态：12 张图片均从 V0.0.17 包内真实 wx 窗口直接截取，未绘制或生成界面。

# V0.0.17 截图来源

2026-11-18 在本机 `DISPLAY=:0` 启动 `ic-platform-V0.0.17-linux-amd64`；启动前包内 `bin/ic-platform --version` 返回 `Industrial Control Platform V0.0.17`。`ps` 回查启动器和 `Beremiz.py` 路径均指向该包。`IC_SKIP_ERPC_TUNNEL=1`，窗口状态栏始终为离线。项目编辑截图从同一包内 `Beremiz.py` 打开教程工程的临时副本；通过真实 XTEST 鼠标和键盘输入展开树、打开编辑页并触发 `Ctrl+Alt+M`。用 wx `ScreenDC` 直接读取屏幕上 IDE 窗口区域为 PNG，未后期绘制、合成或 AI 生成 UI。

| 文件 | 对应实际步骤 | SHA-256 |
| --- | --- | --- |
| `ide-overview.png` | V0.0.17 包打开 IS620N 工程，离线窗口总览 | `bc9a7f0e9e7607fb2f3f4f6cfc04649dcebd3baae5401d89e702ec51eaad76d7` |
| `first-virtual-editor.png` | 打开 `FirstVirtualAxis` 的 ST `MAIN`，显示工程树 | `25facc3beb5a8c00c482b019464d9e8dc430c213d0f369974996dfa435a914b9` |
| `axis-config.png` | 打开 `AxisX` 参数页，显示虚轴限位和周期 | `a8f180297a6f620fda54621e5d1ed44066eb4ecaf896057ab58c96a4be88e927` |
| `first-virtual-result.png` | `Ctrl+Alt+M` 后的离线仿真结果框和 IDE Console | `9b46633798132418b47d31da1a7bd7c8660688d0dafb224d12fb024986a57594` |
| `st-command-editor.png` | 双击 `beremiz_virtual_axis` 的 ST `MAIN`，查看 A/B 命令和工程树 | `58a8a8006ce51e67ceabcf9646f408563630fcd376fd9db1dfb3f0016313ea02` |
| `st-command-build.png` | 同工程按 `F11` 后 Console 显示 Build 成功 | `7dfc97ce77091b11bb333fe655fc34e0a49138a149d4dfb0df71f1b63bb7db4f` |
| `ld-function-block.png` | 双击 `beremiz_basic_17_ld` 的 `MAIN`，真实 LD 编辑器显示功能块 | `d47f695112b463eb49b9b97966f4563d72aeed99cad3b2b27286dcc79f1e081a` |
| `ld-contact-coil.png` | 在同一 LD 编辑器滚至底部，显示触点、线圈和电源轨 | `fed333eeec1ee6cb4da71b832be4479718010eab3d9d5038b63838ff23bbefbb` |
| `ld-build-result.png` | 原始 LD 工程在真实 IDE 按 `F11`，Console 显示成功 | `20767218974522f57e171623e0f40a3a80a78b120fd25a2a8baa8fe993546ebd` |
| `ld-edit-contact.png` | 双击触点 97，打开真实 Edit Contact Values 对话框 | `73a48102dd4e7a10d04d665f221caf19ff268c3c794cd12e3456aa1af8b9e565` |
| `ld-edited-negated-contact.png` | 在独立临时副本中将触点改为 Negated 并保存；该副本 Build FAIL | `2fe084a0cf1753a1763299065c7c29b27400197238ed8bf659483bf6e61dcc62` |
| `ld-build-recursion-error.png` | 同一副本按 F11 后真实 wx 错误对话框，显示 RecursionError；从全屏实拍中裁剪 | `8f9cf1783c00299143f9abf7b6d8e9ed1fcaafb6c74bfde36ecfb9eb4723094d` |

包内结果 JSON 对应 `cycles=3056`、`x=3`、`done=1`、`error=0`、`hardware_operations=0`。生成物和本机临时路径不进入教程仓库。
