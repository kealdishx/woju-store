#!/bin/bash

# 更新版本信息脚本
# 用于在发布新版本时自动更新 apps.json

set -e

echo "======================================"
echo "  Woju 版本更新工具"
echo "======================================"
echo ""

# 检查 jq 是否安装
if ! command -v jq &> /dev/null; then
    echo "需要安装 jq，正在通过 Homebrew 安装..."
    brew install jq
fi

# 检查 IPA 文件
IPA_DIR="ipa"
if [ ! -d "$IPA_DIR" ]; then
    echo "ipa 目录不存在"
    exit 1
fi

# 列出所有 IPA 文件
echo "找到以下 IPA 文件："
echo ""
ls -lh "$IPA_DIR"/*.ipa 2>/dev/null || {
    echo "没有找到 IPA 文件"
    echo "请先将 IPA 文件放到 ipa/ 目录"
    exit 1
}
echo ""

# 选择 IPA 文件
read -p "请输入 IPA 文件名 (例如: woju-1.1.ipa): " IPA_FILENAME
IPA_PATH="$IPA_DIR/$IPA_FILENAME"

if [ ! -f "$IPA_PATH" ]; then
    echo "文件不存在: $IPA_PATH"
    exit 1
fi

# 获取文件大小（字节）
FILE_SIZE=$(stat -f%z "$IPA_PATH" 2>/dev/null || stat -c%s "$IPA_PATH" 2>/dev/null)
FILE_SIZE_MB=$(echo "scale=2; $FILE_SIZE / 1024 / 1024" | bc)

# 提取版本号（从文件名）
VERSION=$(echo "$IPA_FILENAME" | sed 's/woju-\(.*\)\.ipa/\1/')

echo ""
echo "文件信息："
echo "  文件名: $IPA_FILENAME"
echo "  大小: $FILE_SIZE 字节 (${FILE_SIZE_MB} MB)"
echo "  版本号: $VERSION"
echo ""

# 获取更新说明
read -p "请输入版本更新说明 (直接回车使用默认): " CHANGELOG
CHANGELOG=${CHANGELOG:-"版本 $VERSION 更新"}

TODAY=$(date +%Y-%m-%d)
BASE_URL="https://kealdishx.github.io/woju-store"

# 构建新版本 JSON
NEW_VERSION=$(jq -n \
    --arg ver "$VERSION" \
    --arg date "$TODAY" \
    --arg desc "$CHANGELOG" \
    --arg url "$BASE_URL/ipa/$IPA_FILENAME" \
    --argjson size "$FILE_SIZE" \
    '{
        version: $ver,
        date: $date,
        localizedDescription: $desc,
        downloadURL: $url,
        size: $size,
        minOSVersion: "18.0"
    }')

# 将新版本插入 apps.json 的 versions 数组开头
jq --argjson newver "$NEW_VERSION" \
   '.apps[0].versions = [$newver] + .apps[0].versions' \
   apps.json > apps.json.tmp && mv apps.json.tmp apps.json

# 添加新闻条目
NEWS_ID="woju-release-${VERSION}"
NEW_NEWS=$(jq -n \
    --arg title "Woju $VERSION 发布" \
    --arg id "$NEWS_ID" \
    --arg caption "$CHANGELOG" \
    --arg date "$TODAY" \
    '{
        title: $title,
        identifier: $id,
        caption: $caption,
        date: $date,
        tintColor: "#007AFF",
        notify: true,
        appID: "com.homie.woju"
    }')

jq --argjson news "$NEW_NEWS" \
   '.news = [$news] + .news' \
   apps.json > apps.json.tmp && mv apps.json.tmp apps.json

echo "apps.json 已更新"
echo ""
echo "下一步："
echo "  git add ipa/$IPA_FILENAME apps.json"
echo "  git commit -m \"Release $VERSION\""
echo "  git push"
echo ""
