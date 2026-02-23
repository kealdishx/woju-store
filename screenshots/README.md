# 截图文件目录

将应用截图放在这里，用于在 AltStore 中展示应用功能。

## 截图要求

### 尺寸规格

根据设备类型选择合适的截图尺寸：

| 设备 | 分辨率 | 文件名示例 |
|------|--------|-----------|
| iPhone 14 Pro Max / 13 Pro Max | 1290x2796 | screen-1.png |
| iPhone 14 / 13 | 1170x2532 | screen-1.png |
| iPhone SE (3rd) | 750x1334 | screen-1.png |

**推荐**: 使用 iPhone 13/14 Pro Max 的分辨率 (1170x2532 或更高)

### 建议截图内容

准备 3-5 张截图，展示应用的核心功能：

1. **screen-1.png**: 主页面 - 提醒事项列表
   - 展示今天的提醒事项
   - 显示界面的整体布局

2. **screen-2.png**: 创建/编辑提醒
   - 展示创建新提醒的界面
   - 突出显示时间选择、重复选项等功能

3. **screen-3.png**: 计划列表
   - 展示已计划的提醒事项
   - 显示不同日期的提醒

4. **screen-4.png**: 提醒详情或完成列表
   - 展示提醒事项的详细信息
   - 或显示已完成的提醒

5. **screen-5.png** (可选): 通知效果
   - 展示推送通知的样式
   - 显示应用的核心价值

## 如何截图

### 方法 1: 使用模拟器

```bash
# 1. 启动模拟器
open -a Simulator

# 2. 选择设备 (推荐 iPhone 14 Pro Max)
# 3. 在模拟器中运行 Woju 应用
# 4. 截图快捷键: Cmd + S
# 5. 截图保存在桌面
# 6. 重命名并移动到此目录
```

### 方法 2: 使用真机

```bash
# 1. 在真机上运行应用
# 2. 截图: 同时按 音量+ 和 侧边按钮
# 3. 通过 AirDrop 或数据线传输到电脑
# 4. 移动到此目录并重命名
```

### 方法 3: Xcode 截图

```bash
# 1. 在 Xcode 中运行应用
# 2. 使用 Debug → View Debugging → Take Screenshot
# 3. 保存并移动到此目录
```

## 截图优化建议

### 1. 内容准备
- 填充有意义的示例数据（不要用 "测试" "111" 等）
- 使用真实的提醒事项内容
- 确保时间和日期看起来合理

### 2. 视觉效果
- 确保状态栏干净（满电、强信号）
- 使用 Xcode 的 Clean Status Bar 功能
- 避免显示个人敏感信息

### 3. 标注（可选）
- 可以使用图片编辑工具添加文字说明
- 突出显示关键功能
- 但不要过度设计

## 清理状态栏（Xcode）

在运行应用前，在 Xcode 中：
```
Window → Devices and Simulators → 选择设备 → Status Bar → Enable Clean Status Bar
```

或在 Scheme 中添加环境变量：
```
Edit Scheme → Run → Arguments → Environment Variables
IDEDebuggerStatusBarNotConnected = 1
```

## 当前状态

- [ ] screen-1.png - 主页面
- [ ] screen-2.png - 创建提醒
- [ ] screen-3.png - 计划列表
- [ ] screen-4.png - 详情/完成列表
- [ ] screen-5.png - 通知效果（可选）

## 文件大小优化

截图可能会比较大，建议优化：

```bash
# 使用 ImageOptim 压缩（推荐）
# 下载: https://imageoptim.com/

# 或使用命令行工具
pngquant screen-*.png --ext .png --force
```
