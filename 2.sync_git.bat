@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: 设置颜色 - 使用原生color命令
color 07

:: 显示开始提示
echo 正在从远程仓库拉取最新代码...

:: 执行git pull操作
git pull > git_pull_result.tmp 2>&1
type git_pull_result.tmp

:: 检查git pull输出是否包含"已经是最新的"或"Already up to date."
findstr /C:"Already up to date." /C:"已经是最新的" git_pull_result.tmp >nul

if %ERRORLEVEL% EQU 0 (
    :: 如果已是最新，执行提交流程
    echo 本地已是最新版本，正在提交本地更改...
    
    :: 添加所有更改的文件
    git add .
    echo 已添加更改的文件
    
    :: 提交更改
    git commit -m "note"
    echo 已提交更改
    
    :: 推送更改到远程仓库
    git push
    echo 更改已推送到远程仓库
    
    echo 上传完成！
) else (
    :: 如果不是最新，显示提示
    echo 拉取完成，本地代码已更新，请解决可能的冲突后再次运行脚本进行提交
)

:: 删除临时文件
del git_pull_result.tmp

:: 等待用户按任意键退出
echo.
echo 按任意键退出...
pause >nul 