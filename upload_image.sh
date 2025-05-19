#!/bin/bash

# 用法：./upload_image.sh images/photo.jpg

IMAGE_PATH="$1"

if [[ ! -f "$IMAGE_PATH" ]]; then
  echo "❌ 图片文件不存在：$IMAGE_PATH"
  exit 1
fi

# 获取文件名
IMG_NAME=$(basename "$IMAGE_PATH")

# 复制到 assets/img
cp "$IMAGE_PATH" "assets/img/$IMG_NAME"

# 添加、提交并推送
git add "assets/img/$IMG_NAME"
git commit -m "Add image: $IMG_NAME"
git push

echo "✅ 已上传图片：assets/img/$IMG_NAME"
