#!/bin/bash

# 更新版本信息脚本
# 用于在发布新版本时更新文件大小等信息

set -e

echo "======================================"
echo "  Woju 版本更新工具"
echo "======================================"
echo ""

# 检查 IPA 文件
IPA_DIR="ipa"
if [ ! -d "$IPA_DIR" ]; then
    echo "❌ ipa 目录不存在"
    exit 1
fi

# 列出所有 IPA 文件
echo "📦 找到以下 IPA 文件："
echo ""
ls -lh "$IPA_DIR"/*.ipa 2>/dev/null || {
    echo "❌ 没有找到 IPA 文件"
    echo "请先将 IPA 文件放到 ipa/ 目录"
    exit 1
}
echo ""

# 选择 IPA 文件
read -p "请输入 IPA 文件名 (例如: woju-1.0.ipa): " IPA_FILENAME
IPA_PATH="$IPA_DIR/$IPA_FILENAME"

if [ ! -f "$IPA_PATH" ]; then
    echo "❌ 文件不存在: $IPA_PATH"
    exit 1
fi

# 获取文件大小（字节）
FILE_SIZE=$(stat -f%z "$IPA_PATH" 2>/dev/null || stat -c%s "$IPA_PATH" 2>/dev/null)
FILE_SIZE_MB=$(echo "scale=2; $FILE_SIZE / 1024 / 1024" | bc)

echo ""
echo "📊 文件信息："
echo "  文件名: $IPA_FILENAME"
echo "  大小: $FILE_SIZE 字节 (${FILE_SIZE_MB} MB)"
echo ""
echo "请在 apps.json 中更新对应版本的 size 字段为: $FILE_SIZE"
echo ""

# 提取版本号（从文件名）
VERSION=$(echo "$IPA_FILENAME" | sed 's/woju-\(.*\)\.ipa/\1/')
echo "检测到版本号: $VERSION"
echo ""
echo "建议在 apps.json 的 versions 数组开头添加："
echo ""
cat << EOF
{
  "version": "$VERSION",
  "date": "$(date +%Y-%m-%d)",
  "localizedDescription": "🆕 版本 $VERSION 更新\\n\\n• 更新内容 1\\n• 更新内容 2\\n• 更新内容 3",
  "downloadURL": "https://your-username.github.io/woju-altstore/ipa/$IPA_FILENAME",
  "size": $FILE_SIZE,
  "minOSVersion": "15.0",
  "maxOSVersion": "18.0"
}
EOF
echo ""
