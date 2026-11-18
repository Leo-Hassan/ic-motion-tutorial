用途：记录跟踪切、飞剪和旋切共用工程的源码出处与验证边界。当前状态：21 个跟踪文件从锁定提交原样复制；V0.0.17 包内保存工程 Clean Build、仿真及真实 IDE 构建通过。

# 工艺切割工程来源

原仓库 `ic-beremiz-motion`，提交 `0867ececc3224815e4f0aae07b76b9581f70cfe4`，原路径 `examples/beremiz_process_cutting/`。本站复制全部 21 个 Git 跟踪文件，含 `project-manifest.json`、`library.lock`、`plc.xml`、模拟编码器主轴、三根虚拟从轴和四张 ProcessRecipe；工程文件没有修改。未复制构建物、测试结果和现场配置。上游版权为 2026 Industrial Control Platform contributors，SPDX MIT，完整许可证见同级 `LICENSE.ic-beremiz-motion`。

`plc.xml/MAIN` 同时调用 `IC_TrackingCut`、`IC_FlyingSaw`、`IC_RotaryKnife`，三篇案例共用这**一份**工程及同一次保存工程测试；不重复计为三个独立仿真。`UnreachableRecipe` 仅供错误路径验证。升级 IDE 版本须重新锁定组件提交、复制工程、复核清单、构建、仿真与真实截图。此工程仅在离线软件中验证，不含真实刀具、电机、光电标记或生产线安全验收。
