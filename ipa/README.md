# IPA 文件目录

将导出的 IPA 文件放在这里。

## 如何导出 IPA 文件

### 方法 1: Xcode Archive（推荐）

1. 在 Xcode 中打开项目
2. 选择真机设备或 "Any iOS Device"
3. 菜单: **Product** → **Archive**
4. 等待编译完成
5. 在 Organizer 窗口中，选择刚才的 Archive
6. 点击 **Distribute App**
7. 选择 **Ad Hoc** 或 **Development**
8. 选择签名选项（Automatically manage signing）
9. 点击 **Export**
10. 保存导出的 IPA 文件
11. 将文件重命名为 `woju-版本号.ipa`（例如 `woju-1.0.ipa`）
12. 复制到此目录

### 方法 2: 命令行导出

```bash
# 1. Archive
xcodebuild archive \
  -project ../woju.xcodeproj \
  -scheme woju \
  -archivePath ./build/woju.xcarchive

# 2. Export IPA
xcodebuild -exportArchive \
  -archivePath ./build/woju.xcarchive \
  -exportPath ./build \
  -exportOptionsPlist ExportOptions.plist
```

### 注意事项

- 确保 Bundle ID 与 apps.json 中的一致: `com.homie.woju`
- 确保版本号正确设置
- 导出后运行 `../update-version.sh` 来获取文件大小信息
- IPA 文件可能较大（5-20 MB），考虑使用 Git LFS

## 当前需要的版本

- [ ] woju-1.0.ipa (首次发布)
