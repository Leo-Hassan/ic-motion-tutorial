# Basic 17 梯形图虚拟轴例程

用途与状态：这是可由 Beremiz 打开、编辑、保存和 Clean Build 的真实 LD 工程。`MAIN`
用梯形图块调用 Basic 清单的 17 种 IEC 功能块；`MC_MoveAbsolute` 有 A/B 两个独立实例，
因此工程精确生成 18 条实例注册。末尾的 `Enable` 触点和 `LDLanguageWitness` 线圈用于明确
保留可编辑的梯形图梯级，不参与运动仲裁。

本目录的 `plc.xml` 由 `tools/generate_basic17_ld_project.py` 调用 Beremiz
`ProjectController` 图形编辑接口生成和保存，不是手工拼写或修改的 PLCopen XML。对应 ST
工程为相邻的 `beremiz_basic_17`；两者参加相同的保存/重开、Save As、备份恢复、真实
MATIEC 和连续两次 Clean Build 哈希门禁。

仿真时先置 `Enable`，再对 `HomeRequest` 等命令变量施加上升沿。`MoveARequest` 使用
Aborting，`MoveBRequest` 使用 Buffered；`StopRequest` 保持到 Done 后应先撤销运动请求和
Stop，再以新上升沿重启。七个 Read 块持续启用。当前 Basic 子集只接受
`BufferMode=0/1`、`Jerk=0`，transport-neutral Stop 的 `Deceleration` 只接受 0。

工程只用于离线构建、虚拟轴仿真和接口学习，不创建 EtherCAT 主站，不需要 Connect、
Transfer、Run、Force 或写 SDO，也不能替代实轴、硬实时或功能安全验收。
