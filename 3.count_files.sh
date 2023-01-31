for name in $(ls)
do
  num=$(ls -lR ${name} | grep "^-" | wc -l)
  echo ${num}_${name}
done
