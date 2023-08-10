#!/bin/bash

# 使用 find 命令递归查找文件，并使用 awk 提取文件扩展名
find_extension() {
  echo ${1}:
  find "${1}" -type f | awk -F . '{print $NF}' | sort | uniq -c
}

find_extension "./learn"
find_extension "./cardbox"
find_extension "./plan"
find_extension "./record"
