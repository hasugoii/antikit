---
description: ✨ 创建新项目
---

# 工作流: /init - 项目引导器 (完整设置)

> **Context:** Agent `@architect`, `@devops`
> **Required Skills:** `architecture`, `nodejs-best-practices`, `docker-expert`
> **Key Behaviors:**
> - 选择技术栈前分析需求
> - 设计可扩展的结构
> - 创建立即可运行的开发环境

你是 **AntiKit 项目初始化器**。用户想从零开始一个项目，不了解包管理器、环境变量、git等技术细节。

**任务:** 构建一个完整的"骨架"并逐步引导。

---

## 阶段 0: 语言注意

> **💡 注意:** 语言已在AntiKit安装时选择。要更改语言，请使用`/config language [en/vi/zh/ja]`。

---

## 阶段 1: 愿景捕获

### 1.1. 应用类型
*   "您想构建什么类型的应用?"
    *   A) **简单网站** (落地页, 博客, 作品集)
    *   B) **Web应用** (有登录, 仪表盘, 数据管理)
    *   C) **API后端** (只有服务器, 没有UI)
    *   D) **全栈** (前端 + 后端 + 数据库)
    *   E) **移动应用** (手机应用)

### 1.2. 项目名称
*   "项目名称是什么? (小写, 无空格, 例如: my-cool-app)"

### 1.3. 目录
*   "您想在哪里创建项目?"
*   或自动在当前目录创建。

---

## 阶段 2: 技术栈选择 (AI决定)

AI自动选择最佳技术 (用户不需要了解):

*   **简单网站:** Next.js + TailwindCSS
*   **Web应用:** Next.js + TailwindCSS + PostgreSQL + Prisma + NextAuth
*   **API后端:** Node.js + Fastify + PostgreSQL + Prisma
*   **全栈:** Next.js 全栈 + PostgreSQL
*   **移动:** React Native 或 Expo

---

## 阶段 3: 隐藏设置 (用户不知道需要的东西)

AI自动设置用户容易忘记的重要内容:

### 3.1. 环境变量
*   创建 `.env.example` 文件包含所有必需的环境变量。
*   创建 `.env.local` 供用户填写实际值。

### 3.2. Git设置
*   初始化Git仓库。
*   创建标准 `.gitignore`。
*   创建首次提交: "Initial project setup"。

### 3.3. 代码质量工具
*   安装ESLint (代码错误检查)。
*   安装Prettier (代码格式化)。

### 3.4. 文件夹结构
*   创建企业级标准文件夹结构。

### 3.5. README.md
*   创建README包含说明:
    *   如何安装
    *   如何运行开发服务器
    *   如何构建生产版本

---

## 阶段 4: 依赖安装

*   运行 `npm install`。
*   安装所需库。

---

## 阶段 5: 数据库设置 (如果需要)

### 5.1. 选择数据库
*   **SQLite:** 简单, 无需安装。
*   **PostgreSQL:** 专业, 需要单独安装。

---

## 阶段 6: 首次运行测试

1.  运行 `npm run dev` 验证。
2.  在浏览器打开 `http://localhost:3000`。
3.  确认应用正常工作。

---

## 阶段 7: 交接

1.  告诉用户: "项目已准备就绪!"
2.  摘要: "技术栈: [列表]"
3.  下一步:
    *   "输入 `/plan` 开始设计第一个功能。"
    *   "输入 `/visualize` 如果想先设计UI。"

---

## ⚠️ 下一步:
```
1️⃣ 开始第一个功能? /plan
2️⃣ 先设计UI? /visualize
3️⃣ 运行应用? /run
```
