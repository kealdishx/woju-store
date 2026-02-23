#!/bin/bash

# Woju IPA 构建脚本
# 用于从命令行自动构建和导出 IPA 文件

set -e

echo "======================================"
echo "  Woju IPA 构建工具"
echo "======================================"
echo ""

# 配置
PROJECT_PATH="../woju.xcodeproj"
SCHEME="woju"
ARCHIVE_PATH="./build/woju.xcarchive"
EXPORT_PATH="./ipa"
EXPORT_OPTIONS="./ExportOptions.plist"

# 检查项目是否存在
if [ ! -d "$PROJECT_PATH" ]; then
    echo "找不到项目文件: $PROJECT_PATH"
    exit 1
fi

# 清理旧的构建
echo "清理旧的构建文件..."
rm -rf ./build
mkdir -p ./build
mkdir -p "$EXPORT_PATH"

# 获取版本信息
echo "获取项目信息..."
VERSION=$(xcodebuild -showBuildSettings -project "$PROJECT_PATH" -scheme "$SCHEME" 2>/dev/null | grep MARKETING_VERSION | awk '{print $3}' | head -1)
BUILD=$(xcodebuild -showBuildSettings -project "$PROJECT_PATH" -scheme "$SCHEME" 2>/dev/null | grep CURRENT_PROJECT_VERSION | awk '{print $3}' | head -1)
BUNDLE_ID=$(xcodebuild -showBuildSettings -project "$PROJECT_PATH" -scheme "$SCHEME" 2>/dev/null | grep PRODUCT_BUNDLE_IDENTIFIER | awk '{print $3}' | head -1)

echo "  版本号: $VERSION"
echo "  Build: $BUILD"
echo "  Bundle ID: $BUNDLE_ID"
echo ""

# 确认
read -p "是否继续构建？(y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "已取消"
    exit 1
fi

# Archive
echo "开始 Archive..."
xcodebuild archive \
    -project "$PROJECT_PATH" \
    -scheme "$SCHEME" \
    -archivePath "$ARCHIVE_PATH" \
    -configuration Release \
    -destination "generic/platform=iOS" \
    | xcpretty || xcodebuild archive \
    -project "$PROJECT_PATH" \
    -scheme "$SCHEME" \
    -archivePath "$ARCHIVE_PATH" \
    -configuration Release \
    -destination "generic/platform=iOS"

if [ ! -d "$ARCHIVE_PATH" ]; then
    echo "Archive 失败"
    exit 1
fi

echo "Archive 完成"
echo ""

# Export IPA
echo "导出 IPA..."
xcodebuild -exportArchive \
    -archivePath "$ARCHIVE_PATH" \
    -exportPath "$EXPORT_PATH" \
    -exportOptionsPlist "$EXPORT_OPTIONS" \
    | xcpretty || xcodebuild -exportArchive \
    -archivePath "$ARCHIVE_PATH" \
    -exportPath "$EXPORT_PATH" \
    -exportOptionsPlist "$EXPORT_OPTIONS"

# 查找导出的 IPA 文件
IPA_FILE=$(find "$EXPORT_PATH" -name "*.ipa" -type f | head -1)

if [ -z "$IPA_FILE" ]; then
    echo "导出 IPA 失败"
    exit 1
fi

# 重命名 IPA 文件
NEW_IPA_NAME="woju-${VERSION}.ipa"
mv "$IPA_FILE" "$EXPORT_PATH/$NEW_IPA_NAME"

echo "IPA 导出完成"
echo ""

# 获取文件信息
FILE_SIZE=$(stat -f%z "$EXPORT_PATH/$NEW_IPA_NAME" 2>/dev/null || stat -c%s "$EXPORT_PATH/$NEW_IPA_NAME" 2>/dev/null)
FILE_SIZE_MB=$(echo "scale=2; $FILE_SIZE / 1024 / 1024" | bc)

echo "======================================"
echo "  构建成功！"
echo "======================================"
echo ""
echo "IPA 文件: $EXPORT_PATH/$NEW_IPA_NAME"
echo "文件大小: $FILE_SIZE_MB MB ($FILE_SIZE 字节)"
echo ""
echo "下一步："
echo "  ./update-version.sh"
echo ""
