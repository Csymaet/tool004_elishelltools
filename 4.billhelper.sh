#!/bin/bash
# 1. 读取账单csv
# 2. awk筛选年月，汇总数据
# 3. 记入数据库

set -euo pipefail

run(){
  local csvfile=""
  local date_prefix=""
  local comment=""
  
  while getopts f:d:c: option
  do
    case ""${option}"" in
      f) csvfile=${OPTARG};;
      d) date_prefix=${OPTARG};;
      c) comment=${OPTARG};;
      *);;
    esac
  done

  if [ -z "$csvfile" ]; then
    echo "Error: 请通过-f参数填写csv文件路径"
    exit 1
  fi

  if [ -z "$date_prefix" ]; then
    echo "Error: 请通过-d参数填写日期前缀"
    exit 1
  fi

  local result1=$(sum ${csvfile} ${date_prefix} "运动")
  local result2=$(sum ${csvfile} ${date_prefix} "三餐")
  echo $result1 $result2

  psql << EOF
    select * from money.bill where id < 3;
EOF

  echo $comment
}

sum(){
  echo $(awk -F, -v d=\"$2 -v t=\"$3\" 'BEGIN {sum=0} {if($4=="\"支出\"" && $2 ~ "^" d && $3==t) {gsub("\"","",$5); sum+=$5}} END {print sum}' $1)
}

run "$@"
