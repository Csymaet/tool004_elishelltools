#!/bin/bash

# 使用 find 命令递归查找文件，并使用 awk 提取文件扩展名
find_extension() {
  echo ${1}:
  find "${1}" -type f | awk -F . '{print $NF}' | sort | uniq -c
}

filenames=$(ls)

OLDIFS="$IFS"  #备份旧的IFS变量
IFS=$'\n'   #修改分隔符为换行符
for f in $filenames
do
  if [ -d "$f" ]
  then
    find_extension $f
  fi
done
IFS=$OLDIFS
