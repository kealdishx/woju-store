#!/bin/bash

# Woju AltStore Source 配置脚本
# 用于快速更新 apps.json 中的 URL

set -e

echo "======================================"
echo "  Woju AltStore Source 配置工具"
echo "======================================"
echo ""

# 获取 GitHub 用户名
read -p "请输入你的 GitHub 用户名: " GITHUB_USERNAME

if [ -z "$GITHUB_USERNAME" ]; then
    echo "❌ GitHub 用户名不能为空"
    exit 1
fi

# 获取仓库名（默认 woju-altstore）
read -p "请输入仓库名 (默认: woju-altstore): " REPO_NAME
REPO_NAME=${REPO_NAME:-woju-altstore}

# 获取邮箱（可选）
read -p "请输入你的邮箱 (可选，直接回车跳过): " EMAIL
EMAIL=${EMAIL:-your-email@example.com}

echo ""
echo "配置信息："
echo "  GitHub 用户名: $GITHUB_USERNAME"
echo "  仓库名: $REPO_NAME"
echo "  邮箱: $EMAIL"
echo ""
read -p "确认以上信息正确？(y/n) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ 已取消"
    exit 1
fi

# 备份原文件
echo "📦 备份原始 apps.json..."
cp apps.json apps.json.backup

# 替换 URL
echo "🔧 更新 apps.json 中的 URL..."
sed -i '' "s|your-github-username|$GITHUB_USERNAME|g" apps.json
sed -i '' "s|woju-altstore|$REPO_NAME|g" apps.json
sed -i '' "s|your-email@example.com|$EMAIL|g" apps.json

echo "✅ 配置完成！"
echo ""
echo "下一步："
echo "1. 准备 IPA 文件并放到 ipa/ 目录"
echo "2. 准备图标和截图并放到对应目录"
echo "3. 初始化 Git 仓库并推送到 GitHub："
echo ""
echo "   git init"
echo "   git add ."
echo "   git commit -m \"Initial AltStore source\""
echo "   git branch -M main"
echo "   git remote add origin https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"
echo "   git push -u origin main"
echo ""
echo "4. 在 GitHub 仓库设置中启用 GitHub Pages"
echo "5. 你的 AltStore Source URL 将是："
echo "   https://$GITHUB_USERNAME.github.io/$REPO_NAME/apps.json"
echo ""
