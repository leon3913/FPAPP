# 🚀 Trae Finance Dashboard 部署指南

本指南将帮助您将 Trae Finance Dashboard 部署到各种平台。

## 📋 部署选项

### 1. GitHub Pages (推荐)

#### 自动部署
1. 将项目推送到 GitHub 仓库
2. 启用 GitHub Pages
3. GitHub Actions 将自动构建和部署

#### 手动部署
```bash
# 1. 构建项目
cd client
npm run build

# 2. 安装 gh-pages
npm install -g gh-pages

# 3. 部署到 GitHub Pages
gh-pages -d build
```

### 2. Netlify

1. 连接 GitHub 仓库到 Netlify
2. 设置构建命令:
   - Build command: `cd client && npm run build`
   - Publish directory: `client/build`
3. 部署设置:
   - Node version: 18
   - 环境变量: 根据需要设置

### 3. Vercel

```bash
# 1. 安装 Vercel CLI
npm install -g vercel

# 2. 在项目根目录运行
vercel

# 3. 按照提示配置
# - Framework: React
# - Root Directory: client
# - Build Command: npm run build
# - Output Directory: build
```

### 4. 传统服务器部署

#### 前端部署
```bash
# 1. 构建前端
cd client
npm run build

# 2. 将 build 文件夹内容上传到 web 服务器
# 例如: /var/www/html/
```

#### 后端部署
```bash
# 1. 安装 PM2
npm install -g pm2

# 2. 启动后端服务
pm2 start server.js --name "trae-finance-api"

# 3. 配置 Nginx 反向代理
# /etc/nginx/sites-available/trae-finance
```

## 🔧 环境配置

### 环境变量

创建 `.env` 文件:
```env
# 数据库配置
MONGODB_URI=mongodb://localhost:27017/trae-finance
# 或使用 MongoDB Atlas
# MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/trae-finance

# JWT 密钥
JWT_SECRET=your-super-secret-jwt-key-here

# 服务器端口
PORT=5000

# 前端 URL (生产环境)
CLIENT_URL=https://yourdomain.com

# API 基础 URL
REACT_APP_API_URL=https://api.yourdomain.com
```

### 数据库设置

#### MongoDB Atlas (推荐)
1. 创建 MongoDB Atlas 账户
2. 创建集群
3. 获取连接字符串
4. 更新 `MONGODB_URI` 环境变量

#### 本地 MongoDB
```bash
# Ubuntu/Debian
sudo apt-get install mongodb
sudo systemctl start mongodb

# macOS
brew install mongodb-community
brew services start mongodb-community

# Windows
# 下载并安装 MongoDB Community Server
```

## 🌐 域名和 SSL

### 域名配置
1. 购买域名
2. 配置 DNS 记录指向服务器 IP
3. 等待 DNS 传播 (通常 24-48 小时)

### SSL 证书 (Let's Encrypt)
```bash
# 安装 Certbot
sudo apt-get install certbot python3-certbot-nginx

# 获取 SSL 证书
sudo certbot --nginx -d yourdomain.com -d www.yourdomain.com

# 自动续期
sudo crontab -e
# 添加: 0 12 * * * /usr/bin/certbot renew --quiet
```

## 📊 监控和日志

### PM2 监控
```bash
# 查看进程状态
pm2 status

# 查看日志
pm2 logs

# 重启应用
pm2 restart trae-finance-api

# 监控面板
pm2 monit
```

### Nginx 配置示例
```nginx
server {
    listen 80;
    server_name yourdomain.com www.yourdomain.com;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    server_name yourdomain.com www.yourdomain.com;
    
    ssl_certificate /etc/letsencrypt/live/yourdomain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/yourdomain.com/privkey.pem;
    
    # 前端静态文件
    location / {
        root /var/www/html/trae-finance;
        index index.html;
        try_files $uri $uri/ /index.html;
    }
    
    # API 代理
    location /api {
        proxy_pass http://localhost:5000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }
}
```

## 🔒 安全配置

### 防火墙设置
```bash
# Ubuntu UFW
sudo ufw allow ssh
sudo ufw allow 'Nginx Full'
sudo ufw enable

# CentOS/RHEL Firewalld
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload
```

### 应用安全
- 使用强 JWT 密钥
- 启用 CORS 保护
- 实施速率限制
- 定期更新依赖
- 使用 HTTPS

## 📈 性能优化

### 前端优化
- 启用 Gzip 压缩
- 配置缓存头
- 使用 CDN
- 图片优化

### 后端优化
- 数据库索引
- 连接池配置
- 缓存策略
- 负载均衡

## 🚨 故障排除

### 常见问题

1. **构建失败**
   ```bash
   # 清除缓存
   npm cache clean --force
   rm -rf node_modules package-lock.json
   npm install
   ```

2. **API 连接失败**
   - 检查环境变量
   - 验证 CORS 配置
   - 确认服务器状态

3. **数据库连接问题**
   - 验证连接字符串
   - 检查网络连接
   - 确认数据库服务状态

### 日志查看
```bash
# PM2 日志
pm2 logs trae-finance-api

# Nginx 日志
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log

# 系统日志
sudo journalctl -u nginx -f
```

## 📞 支持

如果遇到部署问题，请:
1. 检查本指南的故障排除部分
2. 查看项目 Issues
3. 创建新的 Issue 并提供详细信息

---

**祝您部署顺利！🎉**