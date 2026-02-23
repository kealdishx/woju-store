# 图标文件目录

将应用图标和 Source 图标放在这里。

## 需要的图标文件

### 1. woju-icon.png（必需）
- **用途**: 应用图标，显示在 AltStore 应用列表中
- **尺寸**: 1024x1024 像素
- **格式**: PNG（带透明度）
- **来源**: 从 `../woju/Assets.xcassets/AppIcon.appiconset/` 导出

#### 如何导出应用图标：

```bash
# 方法 1: 从 Assets.xcassets 手动复制
# 找到最大的图标文件（通常是 1024x1024）
# 复制到此目录并重命名为 woju-icon.png

# 方法 2: 使用 sips 命令调整大小（如果需要）
sips -z 1024 1024 source.png --out woju-icon.png
```

### 2. source-icon.png（必需）
- **用途**: Source 图标，显示在 AltStore Sources 列表中
- **尺寸**: 512x512 像素（或使用 1024x1024）
- **格式**: PNG（带透明度）
- **建议**: 可以使用应用图标，或设计一个独特的 Source 图标

```bash
# 从应用图标创建 Source 图标
cp woju-icon.png source-icon.png
```

### 3. header.png（可选）
- **用途**: Source 详情页顶部的横幅图片
- **尺寸**: 1200x400 像素（宽高比约 3:1）
- **格式**: PNG 或 JPG
- **内容**: 可以是应用的特色功能展示或品牌形象

## 当前状态

- [ ] woju-icon.png (1024x1024)
- [ ] source-icon.png (512x512 或 1024x1024)
- [ ] header.png (可选, 1200x400)

## 设计建议

- 保持图标简洁清晰
- 使用与应用一致的配色方案
- 确保图标在小尺寸下也能清晰可辨
- 如果使用透明背景，确保在深色和浅色背景下都好看
