@echo off
chcp 65001 >nul
echo.
echo ========================================
echo    修复版 GitHub Pages 部署脚本
echo    专门部署 app 文件夹中的修复内容
echo ========================================
echo.

REM 检查必要文件
if not exist "app\index.html" (
    echo ❌ 错误：找不到 app\index.html 文件
    echo 请确保在 deploy 文件夹中运行此脚本
    pause
    exit /b 1
)

if not exist "app\static" (
    echo ❌ 错误：找不到 app\static 文件夹
    pause
    exit /b 1
)

echo ✅ 检测到修复后的应用文件
echo.

REM 获取仓库信息
set /p REPO_URL="请输入您的GitHub仓库URL（如：https://github.com/username/repo.git）: "

if "%REPO_URL%"=="" (
    echo ❌ 错误：仓库URL不能为空
    pause
    exit /b 1
)

echo.
echo 🚀 开始部署过程...
echo.

REM 检查Git是否安装
git --version >nul 2>&1
if errorlevel 1 (
    echo ❌ 错误：未检测到Git，请先安装Git
    echo 下载地址：https://git-scm.com/download/win
    pause
    exit /b 1
)

REM 创建临时目录
if exist "temp_deploy_fixed" (
    echo 🧹 清理旧的临时文件...
    rmdir /s /q "temp_deploy_fixed"
)

mkdir "temp_deploy_fixed"
cd "temp_deploy_fixed"

echo 📥 克隆仓库...
git clone "%REPO_URL%" . 2>nul
if errorlevel 1 (
    echo ❌ 克隆失败，请检查仓库URL是否正确
    cd ..
    rmdir /s /q "temp_deploy_fixed"
    pause
    exit /b 1
)

echo 📁 复制修复后的应用文件...

REM 复制主要文件
copy "..\app\index.html" "index.html" >nul
if errorlevel 1 (
    echo ❌ 复制 index.html 失败
    cd ..
    rmdir /s /q "temp_deploy_fixed"
    pause
    exit /b 1
)

copy "..\app\asset-manifest.json" "asset-manifest.json" >nul 2>&1

REM 复制static文件夹
if exist "static" rmdir /s /q "static"
xcopy "..\app\static" "static" /E /I /Y >nul
if errorlevel 1 (
    echo ❌ 复制 static 文件夹失败
    cd ..
    rmdir /s /q "temp_deploy_fixed"
    pause
    exit /b 1
)

echo ✅ 文件复制完成
echo.

echo 📤 提交更改到GitHub...
git add . >nul 2>&1
git commit -m "Deploy fixed Trae Finance Dashboard with relative paths" >nul 2>&1

echo 🚀 推送到GitHub...
git push origin main >nul 2>&1
if errorlevel 1 (
    git push origin master >nul 2>&1
    if errorlevel 1 (
        echo ❌ 推送失败，请检查权限或网络连接
        cd ..
        rmdir /s /q "temp_deploy_fixed"
        pause
        exit /b 1
    )
)

echo ✅ 推送成功！
echo.

REM 清理临时文件
cd ..
rmdir /s /q "temp_deploy_fixed"

echo ========================================
echo           🎉 部署完成！
echo ========================================
echo.
echo 📋 接下来的步骤：
echo 1. 访问您的GitHub仓库
echo 2. 进入 Settings ^> Pages
echo 3. Source 选择 "Deploy from a branch"
echo 4. Branch 选择 "main" 或 "master"
echo 5. Folder 选择 "/ (root)"
echo 6. 点击 Save
echo.
echo 🌐 您的网站将在以下地址可用：
echo https://YOUR_USERNAME.github.io/REPO_NAME/
echo.
echo ⚠️  注意：GitHub Pages 可能需要几分钟时间生效
echo.
echo 如果页面仍显示异常，请检查：
echo - 仓库是否设为公开（Public）
echo - Pages 功能是否已启用
echo - 等待几分钟后重新访问
echo.
pause