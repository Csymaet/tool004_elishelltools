#!/bin/bash
# 1. 读取账单csv
# 2. awk筛选年月，汇总数据
# 3. 记入数据库

set -euo pipefail

run(){
  local csvfile=""
  local date_prefix=""
  local comment=""
  
  # 参数
  while getopts f:d:c: option
  do
    case ""${option}"" in
      f) csvfile=${OPTARG};;
      d) date_prefix=${OPTARG};;
      c) comment=${OPTARG};;
      *);;
    esac
  done

  # 检查参数
  if [ -z "$csvfile" ]; then
    echo "Error: 请通过-f参数填写csv文件路径"
    exit 1
  fi

  if [ -z "$date_prefix" ]; then
    echo "Error: 请通过-d参数填写日期前缀"
    exit 1
  fi

  # 汇总数据
  local result2=$date_prefix"-01"
  local result3=$(sum ${csvfile} ${date_prefix} "支出" "学习")
  local result4=$(sum ${csvfile} ${date_prefix} "支出" "房租")
  local result5=$(sum ${csvfile} ${date_prefix} "支出" "水电")
  local result6=$(sum ${csvfile} ${date_prefix} "支出" "三餐")

  local result7=$(sum ${csvfile} ${date_prefix} "支出" "果坚奶")
  local result8=$(sum ${csvfile} ${date_prefix} "支出" "零食")
  local result9=$(sum ${csvfile} ${date_prefix} "支出" "长途交通")
  local result10=$(sum ${csvfile} ${date_prefix} "支出" "短途交通")
  local result11=$(sum ${csvfile} ${date_prefix} "支出" "运动")

  local result12=$(sum ${csvfile} ${date_prefix} "支出" "娱乐")
  local result13=$(sum ${csvfile} ${date_prefix} "支出" "医疗")
  local result14=$(sum ${csvfile} ${date_prefix} "支出" "社交")
  local result15=$(sum ${csvfile} ${date_prefix} "支出" "旅行")
  local result16=$(sum ${csvfile} ${date_prefix} "支出" "生活")

  local result17=$(sum ${csvfile} ${date_prefix} "支出" "通讯")
  local result18=$(sum ${csvfile} ${date_prefix} "支出" "家人")
  local result19=$(sum ${csvfile} ${date_prefix} "支出" "树")
  local result20=$(sum ${csvfile} ${date_prefix} "支出" "利息")
  local result21=$(sum ${csvfile} ${date_prefix} "支出" "公益")

  local result22=$(sum ${csvfile} ${date_prefix} "收入" "主业")
  local result23=$(sum ${csvfile} ${date_prefix} "收入" "奖金")
  local result24=$(sum ${csvfile} ${date_prefix} "收入" "副业")
  local result25=$(sum ${csvfile} ${date_prefix} "收入" "其它")

  local result26=$(sum ${csvfile} ${date_prefix} "收入" "场内收益")
  local result27=$(sum ${csvfile} ${date_prefix} "收入" "且慢收益")
  local result28=$(sum ${csvfile} ${date_prefix} "收入" "无风险收益")

  local result29=$comment

  # 插入数据
  psql << EOF
    INSERT INTO money.bill(
	    "时间", "学习", "房租", "水电", "三餐", "果坚奶", "零食", "长途交通", "短途交通", "运动", "娱乐", "医疗", "社交", "旅行", "生活", "通讯", "家人", "树", "利息", "公益", "主业", "奖金", "副业", "其它", "场内收益", "且慢收益", "无风险收益", "描述")
	    VALUES ('$result2', $result3, $result4, $result5, $result6, $result7, $result8, $result9, $result10, $result11, $result12, $result13, $result14, $result15, $result16, $result17, $result18, $result19, $result20, $result21, $result22, $result23, $result24, $result25, $result26, $result27, $result28, '$result29');
EOF

  echo $comment
}

sum(){
  echo $(awk -F, -v d=\"$2 -v t1=\"$3\" -v t2=\"$4\" 'BEGIN {sum=0} {if($2 ~ "^" d && $3==t2 && $4==t1) {gsub("\"","",$5); sum+=$5}} END {print sum}' $1)
}

run "$@"
