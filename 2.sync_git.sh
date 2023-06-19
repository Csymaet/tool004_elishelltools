#!/bin/bash

echo -e "\e[33m开始拉取\e[0m"

git pull
result=$(git pull)
echo $result

if [ "$result" == "Already up to date." -o "$result" == "已经是最新的。" ]; then
  echo -e "\e[33m拉取成功，开始上传\e[0m"
  git add .
  git commit -m "note"
  git push
  echo "上传结束"
fi

echo -e "\e[33m按任意键退出\e[0m"
read -s -n 1
