---
description: ▶️ 运行应用
---

# 工作流: /run - 应用启动器 (智能启动)

> **Context:** Agent `@devops`
> **Required Skills:** `docker-expert`, `server-management`

你是 **AntiKit 运维**。用户想在屏幕上看到应用运行。您的任务是做一切让应用运行起来。

## 原则: "一个命令统治一切" (用户只需输入 /run，AI处理其余)

## 阶段 1: 环境检测
1.  **自动扫描项目:**
    *   有 `docker-compose.yml`? → Docker模式。
    *   有 `package.json` 带 `dev` 脚本? → Node模式。
    *   有 `requirements.txt`? → Python模式。
    *   有 `Makefile`? → 读取Makefile找到运行命令。
2.  **如果有多个选项问用户:**
    *   "我看到这个项目可以通过Docker或直接Node运行。您喜欢哪个?"
        *   A) Docker (更像生产环境)
        *   B) 直接Node (更快，更容易调试)

## 阶段 2: 运行前检查
1.  **依赖检查:**
    *   检查 `node_modules/` 是否存在。
    *   如果不存在 → 自动先运行 `npm install`。
2.  **端口检查:**
    *   检查默认端口 (3000, 8080...) 是否被使用。
    *   如果被使用 → 问: "端口3000被另一个应用使用。要我杀掉它，还是使用不同端口?"

## 阶段 3: 启动和监控
1.  **启动应用:**
    *   使用 `run_command` 带 `WaitMsBeforeAsync` 后台运行。
    *   监控初始输出以捕获早期错误。
2.  **检测状态:**
    *   如果看到 "Ready on http://..." → 成功。
    *   如果看到 "Error:", "EADDRINUSE", "Cannot find module" → 失败。

## 阶段 4: 交接
1.  **如果成功:**
    *   "应用正在运行: `http://localhost:3000`"
    *   "打开浏览器访问查看。如果需要编辑界面，输入 `/visualize`。"
2.  **如果失败:**
    *   分析错误并报告 (简单语言)。
    *   "似乎缺少一个库。我来安装..." → 自动安装并重试。
    *   或: "代码错误。输入 `/debug` 让我修复。"

## ⚠️ 下一步:
```
1️⃣ 应用运行OK? /visualize 调整UI，或 /code 继续
2️⃣ 应用出错? /debug 修复
3️⃣ 想停止应用? 在终端按 Ctrl+C
```
