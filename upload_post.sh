#!/bin/bash

# 使用方式：./upload_post.sh path/to/your-post.md

MD_PATH="$1"

if [ ! -f "$MD_PATH" ]; then
  echo "❌ Markdown 文件不存在：$MD_PATH"
  exit 1
fi

# 提取文件名（不含路径和扩展名）
BASENAME=$(basename "$MD_PATH" .md)

# 尝试从 Front Matter 提取日期
DATE=$(grep '^date:' "$MD_PATH" | head -n1 | awk '{print $2}')
if [ -z "$DATE" ]; then
  # 如果没有明确指定日期字段，则使用当前日期
  DATE=$(date '+%Y-%m-%d')
else
  # 截取 YYYY-MM-DD 格式
  DATE=$(echo "$DATE" | cut -d'T' -f1)
fi

# 构造新文件名
NEW_FILENAME="${DATE}-${BASENAME}.md"
POSTS_DIR="_posts"
mkdir -p "$POSTS_DIR"
mv "$MD_PATH" "$POSTS_DIR/$NEW_FILENAME"

# Git 操作
git add "$POSTS_DIR/$NEW_FILENAME"
git commit -m "Add blog post: $NEW_FILENAME"
git push

echo "✅ 已上传博客文章：$POSTS_DIR/$NEW_FILENAME"
