for name in $(ls)
do
  num=$(ls -alR ${name} | grep "^-" | wc -l)  # 包含隐藏文件
  echo ${num}_${name}
done
