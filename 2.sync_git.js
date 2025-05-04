#!/usr/bin/env node

const { execSync } = require('child_process');
const readline = require('readline');

// 显示彩色文本
function colorText(text, colorCode) {
  return `\x1b[${colorCode}m${text}\x1b[0m`;
}

console.log(colorText('开始拉取', 33));

try {
  // 先执行一次git pull
  execSync('git pull', { stdio: 'inherit' });
  
  // 再执行一次并获取结果
  const result = execSync('git pull', { encoding: 'utf8' }).trim();
  console.log(result);

  if (result === 'Already up to date.' || result === '已经是最新的。') {
    console.log(colorText('拉取成功，开始上传', 33));
    
    execSync('git add .', { stdio: 'inherit' });
    execSync('git commit -m "note"', { stdio: 'inherit' });
    execSync('git push', { stdio: 'inherit' });
    
    console.log('上传结束');
  }
} catch (error) {
  console.error(colorText('发生错误:', 31), error.message);
}

console.log(colorText('按任意键退出', 33));

// 等待用户按键后退出
readline.emitKeypressEvents(process.stdin);
if (process.stdin.isTTY) {
  process.stdin.setRawMode(true);
}

process.stdin.on('keypress', () => {
  process.exit();
}); 