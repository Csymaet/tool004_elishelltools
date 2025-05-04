#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import subprocess
import sys
import os

# 如果是Windows系统，确保正确显示彩色文本
if os.name == 'nt':
    os.system('color')

def color_text(text, color_code):
    return f"\033[{color_code}m{text}\033[0m"

def run_git_command(command):
    try:
        result = subprocess.run(f"git {command}", shell=True, check=True, 
                              stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                              universal_newlines=True)
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        print(f"命令执行失败: {e}")
        print(f"错误输出: {e.stderr}")
        return None

print(color_text("开始拉取", 33))

# 先执行一次git pull并显示输出
subprocess.run("git pull", shell=True)

# 再次执行并获取结果
pull_result = run_git_command("pull")
if pull_result is not None:
    print(pull_result)

    if pull_result in ["Already up to date.", "已经是最新的。"]:
        print(color_text("拉取成功，开始上传", 33))
        
        run_git_command("add .")
        run_git_command("commit -m \"note\"")
        run_git_command("push")
        
        print("上传结束")
else:
    print(color_text("Git拉取失败，无法继续同步", 31))

print(color_text("按任意键退出", 33))

# 等待用户按键
if os.name == 'nt':  # Windows
    os.system('pause >nul')
else:  # Unix/Linux
    try:
        import termios
        import tty
        def getch():
            fd = sys.stdin.fileno()
            old_settings = termios.tcgetattr(fd)
            try:
                tty.setraw(sys.stdin.fileno())
                ch = sys.stdin.read(1)
            finally:
                termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
            return ch
        getch()
    except ImportError:
        input() 