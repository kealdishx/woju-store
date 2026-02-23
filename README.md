# Woju Store Source

Woju 提醒事项应用的 SideStore / AltStore 发布源。

## 目录结构

```
altstore-source/
├── apps.json                          # Source 配置文件
├── index.html                         # 安装引导页
├── build-ipa.sh                       # IPA 构建脚本
├── update-version.sh                  # 版本更新脚本
├── ExportOptions.plist                # Xcode 导出配置
├── .github/workflows/deploy.yml       # GitHub Pages 自动部署
├── icons/                             # 图标文件
│   ├── icon-1024.png
│   └── icon-512.png
├── ipa/                               # IPA 文件
│   └── woju-x.x.ipa
├── screenshots/                       # 应用截图
└── news/                              # 新闻配图
```

## 发布流程

### 1. 构建 IPA

```bash
cd altstore-source
./build-ipa.sh
```

### 2. 更新版本信息

```bash
./update-version.sh
```

脚本会自动更新 `apps.json` 中的版本号、文件大小和下载链接。

### 3. 推送发布

```bash
git add .
git commit -m "Release x.x"
git push
```

GitHub Actions 会自动部署到 GitHub Pages。

## Source URL

```
https://kealdishx.github.io/woju-store/apps.json
```

## 用户安装

### 一键添加

在 iPhone Safari 中打开引导页，点击对应按钮：

```
https://kealdishx.github.io/woju-store/
```

### 手动添加

在 SideStore / AltStore 中点击 Sources -> + -> 粘贴 Source URL。

## GitHub Pages 配置

仓库 Settings -> Pages -> Source 选择 **GitHub Actions**。
