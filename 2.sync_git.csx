#!/usr/bin/env dotnet-script

using System;
using System.Diagnostics;

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

Console.ForegroundColor = ConsoleColor.Yellow;
Console.WriteLine("按回车键退出");
Console.ResetColor();
Console.ReadLine();

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