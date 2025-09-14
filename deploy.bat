@echo off
chcp 65001 >nul
echo ========================================
echo    财务仪表盘 GitHub 部署助手
echo ========================================
echo.

echo 📋 部署前检查清单：
echo ✓ 确保您已创建 GitHub 仓库
echo ✓ 确保仓库是公开的（Public）
echo ✓ 确保您有仓库的写入权限
echo.

set /p repo_url="请输入您的 GitHub 仓库 URL (例如: https://github.com/username/repo-name.git): "

if "%repo_url%"=="" (
    echo ❌ 错误：仓库 URL 不能为空
    pause
    exit /b 1
)

echo.
echo 🚀 开始部署过程...
echo.

REM 检查 git 是否安装
git --version >nul 2>&1
if errorlevel 1 (
    echo ❌ 错误：未检测到 Git，请先安装 Git
    echo 下载地址：https://git-scm.com/download/win
    pause
    exit /b 1
)

REM 创建临时部署目录
set temp_dir=%TEMP%\github_deploy_%RANDOM%
mkdir "%temp_dir%"
cd /d "%temp_dir%"

echo 📥 克隆仓库...
git clone "%repo_url%" .
if errorlevel 1 (
    echo ❌ 错误：无法克隆仓库，请检查 URL 和权限
    pause
    exit /b 1
)

echo 📁 复制部署文件...
xcopy "%~dp0*" . /E /I /Y /EXCLUDE:"%~dp0deploy.bat"
if errorlevel 1 (
    echo ❌ 错误：文件复制失败
    pause
    exit /b 1
)

echo 📝 提交更改...
git add .
git commit -m "Deploy: Finance Dashboard - %date% %time%"
if errorlevel 1 (
    echo ⚠️  警告：没有新的更改需要提交
) else (
    echo ✅ 更改已提交
)

echo 🚀 推送到 GitHub...
git push origin main
if errorlevel 1 (
    echo 🔄 尝试推送到 master 分支...
    git push origin master
    if errorlevel 1 (
        echo ❌ 错误：推送失败，请检查网络连接和权限
        pause
        exit /b 1
    )
)

echo ✅ 推送成功！
echo.
echo 🌐 配置 GitHub Pages：
echo 1. 访问您的仓库页面
echo 2. 点击 Settings 标签
echo 3. 在左侧菜单找到 Pages
echo 4. Source 选择 "Deploy from a branch"
echo 5. Branch 选择 "main" (或 "master")
echo 6. Folder 选择 "/ (root)"
echo 7. 点击 Save
echo.
echo 🎉 部署完成！请等待 5-10 分钟让 GitHub Pages 生效
echo.

REM 清理临时目录
cd /d "%~dp0"
rmdir /s /q "%temp_dir%"

echo 按任意键退出...
pause >nul