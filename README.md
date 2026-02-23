# Woju Store Source

这是 Woju 提醒事项应用的 AltStore 发布源配置。

## 📁 目录结构

```
store/
├── apps.json              # AltStore Source 配置文件
├── README.md              # 本文件
├── ipa/                   # 存放 IPA 文件
│   └── woju-1.0.ipa      # (需要生成)
├── icons/                 # 存放图标文件
│   ├── source-icon.png   # Source 图标 (需要准备)
│   ├── woju-icon.png     # 应用图标 (需要准备)
│   └── header.png        # Source 头图 (可选)
├── screenshots/           # 存放应用截图
│   ├── screen-1.png      # (需要准备)
│   ├── screen-2.png      # (需要准备)
│   ├── screen-3.png      # (需要准备)
│   └── screen-4.png      # (需要准备)
└── news/                  # 存放新闻图片 (可选)
    └── welcome.png        # (可选)
```

## 🚀 发布步骤

### 1. 生成 IPA 文件

```bash
# 在 Xcode 中：
# 1. Product → Archive
# 2. Distribute App → Ad Hoc / Development
# 3. 导出 IPA 文件
# 4. 将 IPA 文件重命名为 woju-1.0.ipa
# 5. 复制到 altstore-source/ipa/ 目录
```

### 2. 准备图标和截图

**应用图标** (`icons/woju-icon.png`):
- 从 `woju/Assets.xcassets/AppIcon.appiconset/` 导出
- 推荐尺寸: 1024x1024 PNG

**Source 图标** (`icons/source-icon.png`):
- 可以使用应用图标
- 推荐尺寸: 512x512 PNG

**应用截图** (`screenshots/screen-*.png`):
- 在模拟器或真机上截图
- iPhone 13 Pro Max: 1170x2532
- 建议准备 3-5 张展示主要功能的截图

### 3. 配置 GitHub Pages

#### 3.1 创建 GitHub 仓库

```bash
# 创建新仓库（在 GitHub 网站上操作）
# 仓库名建议: woju-altstore

# 推送 altstore-source 内容到仓库
cd altstore-source
git init
git add .
git commit -m "Initial AltStore source"
git branch -M main
git remote add origin https://github.com/your-username/woju-altstore.git
git push -u origin main
```

#### 3.2 启用 GitHub Pages

1. 进入仓库设置 (Settings)
2. 点击左侧 "Pages"
3. Source: 选择 `main` 分支
4. 点击 Save
5. 等待几分钟，获得你的 GitHub Pages URL

### 4. 更新 apps.json 中的 URL

将 `apps.json` 中所有的 `your-github-username` 替换为你的 GitHub 用户名：

```bash
# 使用命令批量替换
sed -i '' 's/your-github-username/YOUR_ACTUAL_USERNAME/g' apps.json
sed -i '' 's/your-email@example.com/YOUR_ACTUAL_EMAIL/g' apps.json
```

或者手动编辑 `apps.json`，替换以下内容：
- `your-github-username` → 你的 GitHub 用户名
- `your-email@example.com` → 你的邮箱（可选）

### 5. 验证配置

确保所有 URL 都可以访问：
- `https://your-username.github.io/woju-altstore/apps.json`
- `https://your-username.github.io/woju-altstore/ipa/woju-1.0.ipa`
- `https://your-username.github.io/woju-altstore/icons/woju-icon.png`
- 等等...

## 📱 用户安装指南

### 方式 1: 使用 AltStore

1. 在 iPhone 上打开 AltStore
2. 点击底部 "Sources" 标签
3. 点击右上角 "+" 按钮
4. 输入 Source URL：
   ```
   https://your-username.github.io/woju-altstore/apps.json
   ```
5. 点击 "Add"

### 方式 2: 使用 SideStore（推荐，支持自动续签）

1. 在 iPhone 上打开 SideStore
2. 点击底部 "Sources" 标签
3. 点击右上角 "+" 按钮
4. 输入 Source URL（与 AltStore 相同）：
   ```
   https://your-username.github.io/woju-altstore/apps.json
   ```
5. 点击 "Add"

> SideStore 与 AltStore 使用完全相同的 `apps.json` 格式，无需额外适配。

### 方式 3: 一键添加

在 iPhone Safari 中打开安装页面，点击对应按钮即可一键添加：

- **AltStore**: `altstore://source?url=https://your-username.github.io/woju-altstore/apps.json`
- **SideStore**: `sidestore://source?url=https://your-username.github.io/woju-altstore/apps.json`

### 安装应用

1. 在 Sources 中找到 "Woju Source"
2. 点击 "Woju" 应用
3. 点击 "INSTALL" / "FREE"
4. 等待安装完成

## 🔄 发布更新

当需要发布新版本时：

### 1. 导出新的 IPA

```bash
# 1. 在 Xcode 中更新版本号 (MARKETING_VERSION)
# 2. Archive 并导出新的 IPA
# 3. 重命名为 woju-1.1.ipa（版本号对应）
# 4. 复制到 altstore-source/ipa/
```

### 2. 更新 apps.json

在 `versions` 数组的**开头**添加新版本：

```json
{
  "version": "1.1",
  "date": "2026-02-15",
  "localizedDescription": "🆕 版本 1.1 更新\n\n• 新增功能 A\n• 修复 Bug B\n• 性能优化",
  "downloadURL": "https://your-username.github.io/woju-altstore/ipa/woju-1.1.ipa",
  "size": 5500000,
  "minOSVersion": "15.0",
  "maxOSVersion": "18.0"
}
```

### 3. 提交更新

```bash
git add .
git commit -m "Release version 1.1"
git push
```

等待几分钟后，用户在 AltStore 中会看到更新提示。

## 📊 文件大小参考

- **IPA 文件**: 通常 5-20 MB（取决于资源和代码）
- **应用图标**: ~100-500 KB
- **截图**: 每张 ~500 KB - 2 MB

## ⚠️ 注意事项

### 签名限制

- **免费 Apple ID**: 应用 7 天后会过期，需要重新签名
- **付费开发者账号**: 应用 1 年后过期
- AltStore 需要定期连接电脑来重新签名
- **SideStore 可在设备端自动续签，无需电脑**

### SideStore vs AltStore 对比

| 特性 | AltStore | SideStore |
|------|----------|-----------|
| 续签方式 | 需要电脑运行 AltServer | 设备端自动续签 |
| WiFi 同网要求 | 需要 | 不需要 |
| WireGuard VPN | 不需要 | 需要开启回环 VPN |
| 免费 ID 有效期 | 7 天（手动续签） | 7 天（自动续签） |
| Source 格式 | apps.json | apps.json（完全兼容） |
| 深链接 | `altstore://source?url=` | `sidestore://source?url=` |

### SideStore 自动续签配置

1. 安装 [SideStore](https://sidestore.io/) 到你的设备
2. 在 App Store 安装 **WireGuard** VPN 客户端
3. 打开 SideStore → 设置 → 按提示配置 WireGuard 回环 VPN
4. 启用 WireGuard VPN 后，SideStore 即可在设备端自动续签
5. 保持 VPN 开启，SideStore 会在到期前自动刷新签名

### Bundle ID

确保 `apps.json` 中的 `bundleIdentifier` 与 Xcode 项目中的一致：
```
当前配置: com.homie.woju
```

### HTTPS 要求

- 所有文件必须通过 HTTPS 访问
- GitHub Pages 默认支持 HTTPS
- 不要使用 HTTP URL

### 文件大小

- IPA 文件大小限制：建议不超过 150 MB
- 确保 `apps.json` 中的 `size` 字段准确（以字节为单位）

## 🛠️ 获取 IPA 文件大小

```bash
# 获取 IPA 文件大小（字节）
ls -l ipa/woju-1.0.ipa | awk '{print $5}'

# 或使用 stat 命令
stat -f%z ipa/woju-1.0.ipa
```

然后更新 `apps.json` 中对应版本的 `size` 字段。

## 📝 JSON 配置说明

### 必需字段

- `name`: Source 名称
- `identifier`: 唯一标识符（建议使用反向域名格式）
- `apps`: 应用数组

### 应用字段

- `name`: 应用名称
- `bundleIdentifier`: Bundle ID（必须与 IPA 一致）
- `developerName`: 开发者名称
- `versions`: 版本数组（最新版本放在最前面）

### 版本字段

- `version`: 版本号（必须与 IPA 的 CFBundleShortVersionString 一致）
- `date`: 发布日期（ISO 8601 格式）
- `downloadURL`: IPA 下载链接
- `size`: 文件大小（字节）
- `minOSVersion`: 最低 iOS 版本

## 🔗 有用的链接

- [AltStore 官方文档](https://faq.altstore.io/)
- [AltStore GitHub](https://github.com/altstoreio)
- [SideStore 官网](https://sidestore.io/)
- [SideStore GitHub](https://github.com/SideStore)
- [JSON 验证工具](https://jsonlint.com/)

## 📞 支持

如有问题，请在 [GitHub Issues](https://github.com/your-username/woju/issues) 中反馈。

---

**Happy Sideloading! 🎉**
