#!/bin/bash
# 1. 读取账单csv，并记入数据库
#   awk分类汇总，筛选年月
#   pgsql记入数据库
# 2. 修改个别字段
# 3. 显示数据？

set -euo pipefail

run(){
  local oper="a"
  local csvfile="./bills.csv"
  local month=0
  
  while getopts o:c:m: option
  do
    case ""${option}""
      in
      o) oper=${OPTARG};;
      c) csvfile=${OPTARG};;
      m) month=${OPTARG};;
      *);;
    esac
  done

  test ${csvfile}
}

test(){
  local sum=$(awk -F, 'BEGIN {sum=0} {if($4=="\"支出\"") {gsub("\"","",$5); sum+=$5}} END {print sum}' ./bills.csv)
  echo 总支出：${sum}
}

run "$@"
