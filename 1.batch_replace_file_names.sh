#!/bin/bash

# 这是我写的第一个shell程序，也是用来解决真实问题的。
# 我的很多笔记文件名中有"|"这个符号，在linux上没什么问题，但是当我把笔记拉取到windows上就出问题了，windows不允许文件名出现称号"|"
# 所以这个程序就来批量替换一下文件名！

# 网络上的答案：
# find ./ -name "*_*" | while read f; do mv $f ${f/_/-}; done

# 我的答案！
filenames=$(find ./ -name "*|*")

for f in $filenames
do
  mv $f ${f/|/_}; 
done
