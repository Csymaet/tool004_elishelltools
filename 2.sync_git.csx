#!/usr/bin/env dotnet-script

using System;
using System.Diagnostics;
using System.Linq;

// 检查是否传入了--no-pause参数
bool shouldPause = !Args.Any(arg => arg == "--no-pause");

Console.ForegroundColor = ConsoleColor.Yellow;
Console.WriteLine("开始拉取");
Console.ResetColor();

string result = ExecuteGitCommand("pull");
Console.WriteLine(result);

if (result.Contains("Already up to date.") || result.Contains("已经是最新的。"))
{
    Console.ForegroundColor = ConsoleColor.Yellow;
    Console.WriteLine("拉取成功，开始上传");
    Console.ResetColor();
    
    ExecuteGitCommand("add .");
    ExecuteGitCommand("commit -m \"note\"");
    ExecuteGitCommand("push");
    
    Console.WriteLine("上传结束");
}

// 只在Windows环境下或未指定--no-pause时等待按键
if (shouldPause)
{
    Console.ForegroundColor = ConsoleColor.Yellow;
    Console.WriteLine("按任意键退出");
    Console.ResetColor();
    Console.ReadKey(true);
}

string ExecuteGitCommand(string arguments)
{
    var processInfo = new ProcessStartInfo
    {
        FileName = "git",
        Arguments = arguments,
        RedirectStandardOutput = true,
        RedirectStandardError = true,
        UseShellExecute = false,
        CreateNoWindow = true
    };

    using var process = Process.Start(processInfo);
    string output = process.StandardOutput.ReadToEnd();
    process.WaitForExit();
    
    return output.Trim();
}