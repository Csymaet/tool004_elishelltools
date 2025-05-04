#!/bin/bash

# 判断操作系统类型
if [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "darwin"* ]]; then
    # Linux或macOS环境
    PRIMARY_FILE=~/myfile/project/tool/tool004_elishelltools/2.sync_git.csx
    echo "检测到Linux/macOS系统"
    # 在Linux环境下传递参数，指示不使用ReadKey
    SCRIPT_ARGS="--no-pause"
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" || "$OSTYPE" == "cygwin" ]]; then
    # Windows环境 (Git Bash, MinGW, Cygwin)
    PRIMARY_FILE=~/Desktop/002-project/tool/tool004_elishelltools/2.sync_git.csx
    echo "检测到Windows系统"
    # Windows环境下可以使用ReadKey
    SCRIPT_ARGS=""
else
    # 其他操作系统
    echo "未知操作系统类型: $OSTYPE"
    exit 1
fi

# 检查文件是否存在并执行
if [ -f "$PRIMARY_FILE" ]; then
    echo "执行文件: $PRIMARY_FILE"
    dotnet script "$PRIMARY_FILE" $SCRIPT_ARGS
    
    # 如果在Linux环境下，提供替代的"按回车键退出"
    if [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "darwin"* ]]; then
        echo "按回车键退出..."
        read
    fi
else
    echo "错误: 找不到文件 $PRIMARY_FILE"
    exit 1
fi