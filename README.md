# 🚀 Trae Finance Dashboard

现代化的个人财务管理系统，提供实时数据分析和美观的用户界面。

## ✨ 功能特性

- 📊 **实时数据分析** - 智能分析收支情况，提供详细财务报表
- 💳 **交易记录管理** - 自动分类记录，支持多种支付方式
- 🎯 **目标设定追踪** - 储蓄目标设定，进度追踪
- 📱 **响应式设计** - 完美适配桌面端和移动端
- 🌙 **深色模式** - 支持明暗主题切换
- 🔐 **安全认证** - JWT身份验证，数据安全保障

## 🛠️ 技术栈

### 前端
- **React 18** - 现代化前端框架
- **Redux** - 状态管理
- **Chart.js** - 数据可视化
- **CSS3** - 现代化样式设计

### 后端
- **Node.js** - 服务器运行环境
- **Express.js** - Web应用框架
- **MongoDB** - 数据库
- **JWT** - 身份认证
- **bcryptjs** - 密码加密

## 📦 项目结构

```
Trae Project/
├── client/                 # React前端应用
│   ├── src/
│   │   ├── components/     # React组件
│   │   ├── actions/        # Redux actions
│   │   ├── reducers/       # Redux reducers
│   │   └── utils/          # 工具函数
│   ├── public/             # 静态资源
│   └── build/              # 构建输出
├── routes/                 # API路由
├── models/                 # 数据模型
├── middleware/             # 中间件
├── config/                 # 配置文件
└── deploy/                 # 部署文件
```

## 🚀 快速开始

### 本地开发

1. **克隆项目**
   ```bash
   git clone <repository-url>
   cd trae-finance-dashboard
   ```

2. **安装依赖**
   ```bash
   # 安装后端依赖
   npm install
   
   # 安装前端依赖
   cd client
   npm install
   ```

3. **配置环境变量**
   ```bash
   # 在根目录创建 .env 文件
   MONGODB_URI=mongodb://localhost:27017/trae-finance
   JWT_SECRET=your-secret-key
   PORT=5000
   ```

4. **启动应用**
   ```bash
   # 启动后端服务器 (端口 5000)
   npm run server
   
   # 启动前端开发服务器 (端口 3002)
   cd client
   npm start
   ```

5. **访问应用**
   - 前端: http://localhost:3002
   - 后端API: http://localhost:5000

### 生产部署

1. **构建前端**
   ```bash
   cd client
   npm run build
   ```

2. **部署到服务器**
   - 将 `client/build` 文件夹内容部署到静态文件服务器
   - 将后端代码部署到 Node.js 服务器
   - 配置反向代理（如 Nginx）

## 🌐 在线演示

访问 [演示页面](./index.html) 查看应用界面预览。

## 📱 主要功能

### 仪表盘概览
- 财务统计卡片（收入、支出、净收益、总资产）
- 交易记录列表
- 数据可视化图表
- 实时数据更新

### 用户管理
- 用户注册和登录
- 个人资料管理
- 安全认证

### 财务管理
- 收支记录添加
- 交易分类管理
- 月度/年度报表
- 数据导出功能

## 🔧 API 接口

### 认证相关
- `POST /api/auth/register` - 用户注册
- `POST /api/auth/login` - 用户登录
- `GET /api/auth/user` - 获取用户信息

### 财务数据
- `GET /api/finance` - 获取财务数据
- `POST /api/finance` - 添加财务记录
- `PUT /api/finance/:id` - 更新财务记录
- `DELETE /api/finance/:id` - 删除财务记录

## 🎨 界面预览

### 桌面端
- 现代化卡片设计
- 渐变背景和毛玻璃效果
- 响应式网格布局

### 移动端
- 完全响应式设计
- 触摸友好的交互
- 优化的移动端体验

## 🤝 贡献指南

1. Fork 项目
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 创建 Pull Request

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 📞 联系方式

- 项目链接: [GitHub Repository](https://github.com/username/trae-finance-dashboard)
- 问题反馈: [Issues](https://github.com/username/trae-finance-dashboard/issues)

## 🙏 致谢

感谢所有为这个项目做出贡献的开发者和设计师！

---

**Made with ❤️ by Trae AI**