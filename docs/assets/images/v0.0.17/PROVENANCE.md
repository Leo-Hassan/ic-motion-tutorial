用途：记录教程截图的真实来源和版本身份。当前状态：44 张图片来自 V0.0.17 包内真实 wx 窗口，未绘制或生成界面。

# V0.0.17 截图来源

2026-11-18 在本机 `DISPLAY=:0` 启动 `ic-platform-V0.0.17-linux-amd64`；启动前包内 `bin/ic-platform --version` 返回 `Industrial Control Platform V0.0.17`。`ps` 回查启动器和 `Beremiz.py` 路径均指向该包。`IC_SKIP_ERPC_TUNNEL=1`，常规操作窗口状态栏始终为离线。项目编辑截图从同一包内 `Beremiz.py` 打开教程工程的临时副本；通过真实 XTEST 鼠标和键盘输入展开树、打开编辑页并触发 `Ctrl+Alt+M`。映射页因 V0.0.17 启动器缺模块路径，使用本仓库 `open_mapping_offline.sh` 等价的包内路径补全环境打开真实 IDE；未使用模拟界面。前 18 张以 wx `ScreenDC` 读取真实窗口区域；`ld-build-recursion-error.png` 仅从同次全屏截图裁剪窗口区域。

ST 调试六图另由测试程序直接导入**同一 V0.0.17 包内** `BeremizIDE` 创建完整大桥 IDE 窗口，打开教程 ST 工程的临时副本。测试程序在 `127.0.0.1` 启动包内真实 eRPC Runtime，使用本机隔离调试候选，并为无已安装 BootApplication 的回环测试注入与该临时副本 Clean Build 匹配的部署身份。依次调用真实面板的断点、Attach、Step over、Continue、Detach；外部 `gnome-screenshot` 在各 GUI 事件完成后拍全屏并裁剪实际窗口区域。截图中底部 `Disconnected/Online:OFFLINE` 反映没有生产 Runtime 连接；右侧调试状态来自回环服务。临时 SO、map、会话描述和测试日志未加入仓库。

IS620N 四图从同包 `Beremiz.py` 真实窗口打开仅含工程源码的临时教学副本；为本地离线交叉构建，在**临时** `confnode.xml` 将 IgH SDK 占位符换为本机 SDK 路径，教程仓库文件仍不含绝对路径。GUI 无 Runtime 连接，未导入原工程的 `psk/`、`build/`、`TEST_REPORT.md` 或历史测试物。外部 `gnome-screenshot` 全屏实拍后只裁剪 IDE 窗口区域。

同步工程六图从同包 `Beremiz.py` 打开 `beremiz_sync_gear_cam` 的临时副本。真实鼠标打开 `MAIN`、Synchronization、Cam_A 和 Cam_B；原始保存工程的 V0.0.17 GUI Build 显示 `Successfully built.`。首次在打开编辑器后立即 F11 遇到 `wxYield called recursively`，重启真实 IDE，等工程加载完成再从未编辑副本执行 Build 成功；该失败列入测试报告。六图均为外部 `gnome-screenshot` 实拍，只裁剪窗口区域；本次截图没有包含首次报错对话框，因为案例使用后续可复现的成功步骤。

二维路径四图从同包 `Beremiz.py` 打开 `beremiz_coordinated_path` 的未编辑临时副本；先完成 GUI Build，再用真实鼠标打开 `Group_XY`、`MixedPath` 和 `MAIN`。外部 `gnome-screenshot` 拍全屏，只裁剪真实 IDE 窗口区域；图 4 保留同屏的 Build 成功 Console。

工艺切割六图从同包 `Beremiz.py` 打开 `beremiz_process_cutting` 的临时副本；先 GUI Build 成功，再真实点击 Master Commissioning、TrackingRecipe/SawRecipe/KnifeRecipe Config 和 `MAIN`。三张配方页只读取已保存工程值，没有改写或 Apply。外部 `gnome-screenshot` 拍全屏并只裁剪 IDE 窗口；原工程无 Runtime 连接，底栏始终 `Online:OFFLINE`。所有 44 张均未绘制、合成或 AI 生成 UI。

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
| `mapping-editor.png` | 打开模拟 Mapping 节点，显示四通道、来源、变量及 OFFLINE 状态 | `0104428d5c218174053976d8d01494e667bd6c1bde5ee0e6404be0623eb4079e` |
| `mapping-build-result.png` | 同映射工程按 F11，Console 显示 Build 成功 | `034d1276f5b5257dcd885c328bd723266dea8eb5336edff90f57d792ae1b8a43` |
| `cia402-commissioning.png` | 打开离线 Cia402RealAxis 节点，显示 OFFLINE 质量和示例范围 | `7450b1f4f1e9bb2e0e5afc1d5381477935e7598b264bd0991e2d0525576aeb3b` |
| `cia402-config.png` | 同一轴 Config 页的 CSP、CountsPerUnit 和位置/速度字段 | `609d9f2decc6e3cdf1311ec7952a9fed263a30af02fddebca2fd9b9d3af48e7d` |
| `cia402-st-editor.png` | 打开实轴示例 ST MAIN，显示五个功能块调用和工程树 | `a78f7d498e216fe6aea2d53f9a54df30a5e58116d4fcbcfe77db241fd53d9b36` |
| `cia402-build-result.png` | 同实轴工程按 F11，Console 显示 Build 成功和未保存提示 | `16dde471a4e4c91aaebe75c242a05822540b34b4dbd6f87f12d25dd2e710d053` |
| `st-debug-pending.png` | `MAIN` 第一行断点待绑定、右侧 ST Debug Details | `efcd561d4819d164b41f4b6b89c33bbbb9a61e0690ea482fb4e3c8e9e09aebdd` |
| `st-debug-breakpoint.png` | 本地主机回环 Attach，停在第一条语句前，`Speed=0` | `225355779f4a3be616ab706f4b1cc176d6df88bea1dca4373d14e1a3ec79023d` |
| `st-debug-speed10.png` | 第一次 Step over，`Speed=10` | `e6307eb4be6875ad11186bbd9394e132f93f0d2447806311d78c27644132e238` |
| `st-debug-speed20.png` | 第二次 Step over，`Speed=20`、`ScanCount=0` | `4dd5449d15bcee87e56f93b771394a035ec974218289eaef734c2c5dcc14ac13` |
| `st-debug-continued.png` | Continue 后在下一扫描的第一条断点停住，`ScanCount=1` | `c3ecd1ae505aab1306a46c48c70002bccaef185ba54400fbf5f90e7c14de3988` |
| `st-debug-exit.png` | Detach 后 Detached 且 ST 内联值移除 | `ecf90dd943e03aed13606e77d06c57274862c42745b0d277ea37665268e076c7` |
| `is620n-st-editor.png` | 教学副本 `DualCirclePanel` ST、双轴工程树、离线状态 | `190c08d89e54d063d9b4687ee53ba9ef590670bc4fe5a9495ed55707e9ee217a` |
| `is620n-axis-offline.png` | `Axis_1` Commissioning 页显示 OFFLINE 与 ±0.95 转 | `33a08dd0f0587f546b87d0bc7f18b5aa937ed92992be367d607b45707a2e528e` |
| `is620n-axis-config.png` | `Axis_1` Config 页显示 CSP、counts/转和软件限位 | `4cbc3e0e862cf7069c3ca95466d1b4a9c8abd56d3eb61db45fa948caa5f55f05` |
| `is620n-build-result.png` | 同副本真实 IDE `F11` 后 Console 显示 `Successfully built.` 和未保存身份提示 | `afa3fad23be283b4bebf7a20a5a1f06de7f98ebc00990e49e92428bd8fd0d324` |
| `sync-gear-st.png` | 双击同步工程 `MAIN`，查看 GearIn、GearInPos、两个 Phasing、GearOut 和资源树 | `9902d654a00ca06dcd9328d8105bbcbaa98324309556e62a7eea6083ce1e13eb` |
| `sync-resource.png` | 双击 Synchronization，显示离线预检和资源页 | `bda6a118a857b9bfc8e640dce8d12c16b0437f5be15fb99f8fadc78b090d314a` |
| `sync-cam-a.png` | 双击 Cam_A，查看三点正三角形表与预览 | `81e498161e301a81306296b7390c76aff41ec033ca61cfcfc3101c7e10e829f7` |
| `sync-cam-b.png` | 双击 Cam_B，查看三点负三角形表与预览 | `a64bac257df01fe6592850935de4cc1d86b15686669d81fff9512e5f5ff96821` |
| `sync-cam-st.png` | 回到 `MAIN`，查看 CamTableSelect、ActiveCamTable、CamIn 和 CamOut | `5be50f3e5590e1bccfc7c98099f71f30463c1ebb72ea7ce5dcad21ec99d0971c` |
| `sync-gui-build-result.png` | 全新 IDE 进程中，未编辑工程 GUI Build 成功；Console、工程树和 `MAIN` 同屏 | `e81ee92de98d372f912728ac18963ea2112a7c1ce42e1e2d9acc83ef246bd06d` |
| `path-axis-group.png` | 双击 Group_XY，显示 AxisX/AxisY 成员和资源树 | `dff109d39d9a86286b85096cf03ba4106d45769f2cc58ae7714a0d1957aa64e1` |
| `path-mixed-recipe.png` | 双击 MixedPath，显示八段二维路径表和预览 | `2529038700474944e6c1919d250e2221448ae5e24ce80f3bf698dc818688a83d` |
| `path-st-editor.png` | 打开 `MAIN`，显示上电、轴组使能和配方选择起始代码 | `baf4b977fadc879041e6db75aab361cf0ecd3265c19d203acbddc55f81f93d9d` |
| `path-build-result.png` | `MAIN` 中查看 CoordinatedPath/GroupStop，Console 显示 `Successfully built.` | `d9373ea9cff510e4e0620306da4432992416044b4cf731b03bd7395283328282` |
| `process-master-offline.png` | 双击 Master，Commissioning 显示离线编码器轴状态 | `dec1d5a77dffa02c8f9d372689c00df4ad6cbeee4380ee41b49221d0e0ea42b9` |
| `process-tracking-recipe.png` | 双击 TrackingRecipe/Config，读取产品长度、同步窗口、切点、比例与容差 | `fdff6a1a30ca600655741ce85bfaabbd99ee3627045fb9df2dce7273fd4d1caf` |
| `process-saw-recipe.png` | 双击 SawRecipe/Config，读取飞剪对应的工艺配方 | `f1a014d9ac6b7c31b50922c2568911c6c68a7d27103318d721c7e937c41dc8d0` |
| `process-knife-recipe.png` | 双击 KnifeRecipe/Config，读取旋切配方与比例 360 | `326d4061f723bde929d1c104f32119df7984e1ba55390dc7ad3215a81e36e597` |
| `process-st-editor.png` | 打开 `MAIN`，查看三轴上电、跟踪切及飞剪调用起始行 | `d02a3bac6d7a59e4688f84f7bd8381a6a95871deb1212c4569381d68c39c702b` |
| `process-build-result.png` | `MAIN` 中查看三种工艺块完整调用和 Console `Successfully built.` | `739bcf48a1d3c3fd7975f5b006de956cc2b513a673a718a244e141687049e0bd` |

包内结果 JSON 对应 `cycles=3056`、`x=3`、`done=1`、`error=0`、`hardware_operations=0`。生成物和本机临时路径不进入教程仓库。
