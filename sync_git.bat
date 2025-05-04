@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: 设置颜色代码
set "yellow=[33m"
set "reset=[0m"

echo %yellow%正在从远程仓库拉取最新代码...%reset%

:: 执行git pull操作并捕获输出
git pull > git_pull_result.tmp

:: 读取git pull的输出
set "is_up_to_date=false"
for /f "tokens=*" %%a in (git_pull_result.tmp) do (
    echo %%a
    echo %%a | findstr /C:"Already up to date." /C:"已经是最新的" >nul && set "is_up_to_date=true"
)

:: 删除临时文件
del git_pull_result.tmp

:: 只有当本地代码已经是最新的情况下才执行提交操作
if "%is_up_to_date%"=="true" (
    echo %yellow%正在提交本地更改...%reset%
    git add .
    git commit -m "note"
    
    echo %yellow%正在推送更改到远程仓库...%reset%
    git push
    
    echo %yellow%上传完成！%reset%
) else (
    echo %yellow%请先解决冲突后再重新运行此脚本。%reset%
)

echo.
echo %yellow%按任意键退出...%reset%
pause >nul 