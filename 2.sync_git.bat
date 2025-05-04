@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: 设置颜色
set "yellow=[33m"
set "reset=[0m"

:: 显示开始提示
echo %yellow%正在从远程仓库拉取最新代码...%reset%

:: 执行git pull操作
git pull > git_pull_result.tmp 2>&1
type git_pull_result.tmp

:: 检查git pull输出是否包含"已经是最新的"或"Already up to date."
findstr /C:"Already up to date." /C:"已经是最新的" git_pull_result.tmp >nul

if %ERRORLEVEL% EQU 0 (
    :: 如果已是最新，执行提交流程
    echo %yellow%本地已是最新版本，正在提交本地更改...%reset%
    
    :: 添加所有更改的文件
    git add .
    echo %yellow%已添加更改的文件%reset%
    
    :: 提交更改
    git commit -m "note"
    echo %yellow%已提交更改%reset%
    
    :: 推送更改到远程仓库
    git push
    echo %yellow%更改已推送到远程仓库%reset%
    
    echo %yellow%上传完成！%reset%
) else (
    :: 如果不是最新，显示提示
    echo %yellow%拉取完成，本地代码已更新，请解决可能的冲突后再次运行脚本进行提交%reset%
)

:: 删除临时文件
del git_pull_result.tmp

:: 等待用户按任意键退出
echo.
echo %yellow%按任意键退出...%reset%
pause >nul 