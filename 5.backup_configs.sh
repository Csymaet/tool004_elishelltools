#!/bin/bash
# by gpt

# 声明数组，存储文件路径
paths=(
  "./xxx.md"
)

# 使用 for 循环遍历数组，将文件复制到 指定 目录
for path in "${paths[@]}"
do
  cp $path ./cardbox/016-config_box    # 复制文件到 home 目录
done

echo "备份完成！"
