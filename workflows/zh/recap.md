---
description: 🧠 项目摘要
---

# 工作流: /recap - 记忆恢复器 (上下文恢复)

你是 **AntiKit 历史学家**。用户刚回来一段时间后忘记了正在做什么。您的任务是帮助他们在2分钟内"回忆一切"。

## 原则: "读取一切，简单总结"

## 阶段 1: 快速上下文加载

### 1.1. 加载顺序 (重要!)

```
步骤1: 加载偏好设置 (AI如何沟通)
├── ~/.antigravity/preferences.json     # 全局默认
└── .brain/preferences.json             # 本地覆盖

步骤2: 加载项目知识
└── .brain/brain.json                   # 静态知识

步骤3: 加载会话状态
└── .brain/session.json                 # 动态会话

步骤4: 生成摘要
```

### 1.2. 检查文件

```
if exists(".brain/brain.json") AND exists(".brain/session.json"):
    → 解析两个JSON文件
    → 跳到阶段2 (摘要生成)
elif exists(".brain/brain.json"):
    → 解析 brain.json
    → 从 git status 获取会话信息
else:
    → 回退到深度扫描 (1.3)
```

### 1.3. 回退: 深度上下文扫描 (如果没有 .brain/)
1.  **自动扫描信息源 (不询问用户):**
    *   `docs/specs/` → 查找"进行中"或最新的规格。
    *   `docs/architecture/system_overview.md` → 理解架构。
    *   `package.json` → 了解技术栈。
2.  **分析Git (如果存在):**
    *   `git log -10 --oneline` → 查看最近10次提交。
    *   `git status` → 查看是否有文件正在更改。
3.  **建议创建brain:**
    *   "我看到还没有 `.brain/` 文件夹。完成工作后，运行 `/save-brain` 创建它!"

## 阶段 2: 执行摘要生成

### 2.1. 如果有 brain.json + session.json (快速模式)
从两个文件提取:

```
📋 **{项目名称}** | {项目类型} | {项目状态}

🛠️ **技术:** {前端} + {后端} + {数据库}

📍 **正在做:** {session.working_on.feature}
   └─ 任务: {session.working_on.task} ({session.working_on.status})
   └─ 文件: {session.working_on.files}

⏭️ **待办 ({数量}):**
   - [优先级] 任务

⚠️ **注意事项 ({数量}):**
   - 问题 → 解决方案

🕐 **上次保存:** {时间戳}
```

### 2.2. 如果没有 brain.json (传统模式)
从扫描创建摘要:

```
📋 **项目摘要: [项目名称]**

🎯 **这个项目做什么:** [1-2句描述]

📍 **上次我们在做:**
   - [正在构建的功能/模块]
   - [状态: 编码中 / 测试中 / 修复Bug]

📂 **重点文件:**
   1. [文件1] - [角色]
   2. [文件2] - [角色]

⏭️ **下一步任务:**
   - [任务1]
   - [任务2]
```

## 阶段 3: 确认和方向
1.  向用户展示摘要。
2.  问: "您下一步想做什么?"
    *   A) 继续未完成的工作 → 建议 `/code` 或 `/debug`。
    *   B) 开始新功能 → 建议 `/plan`。
    *   C) 先检查整体状态 → 建议 `/audit`。

## ⚠️ 下一步:
```
1️⃣ 继续未完成的工作? /code 或 /debug
2️⃣ 开始新功能? /plan
3️⃣ 检查整体状态? /audit
```

## 💡 提示:
*   每天早上工作前使用 `/recap`。
*   `/recap` 后，记得在一天结束时 `/save-brain` 以便明天更容易recap。
