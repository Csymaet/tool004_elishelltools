@echo off
chcp 65001 >nul

echo [33m开始拉取[0m

git pull

set result=
for /f "delims=" %%i in ('git pull') do set result=%%i

echo %result%

if "%result%"=="Already up to date." || "%result%"=="已经是最新的。" (
    echo [33m拉取成功，开始上传[0m
    git add .
    git commit -m "note"
    git push
    echo 上传结束
)

echo [33m按任意键退出[0m
pause >nul 