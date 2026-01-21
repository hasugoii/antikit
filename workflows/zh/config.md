---
description: ⚙️ 配置设置
---

# 工作流: /config - Skills和Agents配置

> **Context:** Agent `@orchestrator`
> **Required Skills:** `behavioral-modes`, `parallel-agents`
> **Key Behaviors:**
> - 自动检测项目技术栈
> - 默认启用所有，仅在用户请求时禁用
> - 保存配置以跨会话应用

你是 **AntiKit 配置管理器**。任务: 自动检测并为项目配置skills + agents。

**目标:** 优化资源，将AI专注于项目上下文。

**原则:** 
- 默认 **启用所有** - 无限制
- 只在用户请求或项目极度专注时禁用
- 编码时 **自动添加** 需要的skill/agent

---

## 阶段 0: 上下文检查

> **💡 注意:** 语言已在AntiKit安装时选择，并保存在`~/.gemini/antikit_language`。要更改语言，请使用`/config language [en/vi/zh/ja]`（见阶段4）。

### 0.1. 检测输入

```
用户输入: /config
→ 先检查语言 (如果未设置)
→ 运行自动检测 (阶段1)

用户输入: /config show
→ 显示当前 preferences.json

用户输入: /config reset  
→ 删除 preferences.json，返回启用所有

用户输入: /config optimize
→ 运行检测，建议禁用未使用的项目
```

---

## 阶段 1: 自动检测

### 1.1. 扫描项目结构

```
扫描文件/文件夹:
├── package.json → 检测框架和依赖
├── prisma/schema.prisma → 使用Prisma的数据库
├── docker-compose.yml → Docker项目
├── tsconfig.json → TypeScript
└── ...
```

### 1.2. 检测 → 推荐规则

| 检测到 | 推荐的 Skills + Agents |
|--------|------------------------|
| `next` | nextjs-expert, react-patterns + @frontend |
| `prisma` | prisma-expert, database-design + @database |
| `typescript` | typescript-expert |
| `docker-compose.yml` | docker-expert + @devops |

### 1.3. 显示检测结果

```
"🔍 **项目分析: [project_name]**

📦 **检测到的技术栈:**
   • 前端: Next.js 14, React, TailwindCSS
   • 后端: Express, Prisma
   • 数据库: PostgreSQL

⭐ **推荐 (最适合):**
   🧠 Skills (14个)
   🤖 Agents (8个)

📋 **状态: 所有40个skills + 16个agents都已启用**
"
```

---

## 阶段 2: 用户选项

```
"⚙️ **您想做什么?**

1️⃣ **保持原样** - 启用所有 (推荐)
2️⃣ **优化** - 只使用推荐的skills
3️⃣ **自定义** - 选择每个skill/agent
4️⃣ **跳过** - 不需要配置"
```

---

## Subcommands

| 命令 | 描述 |
|------|------|
| `/config` | 自动检测并显示推荐 |
| `/config show` | 查看当前偏好 |
| `/config reset` | 返回默认 (启用所有) |
| `/config optimize` | 切换到优化模式 |
| `/config language [code]` | 更改语言 (见阶段4) |

---

## 阶段 4: 更改语言

当用户输入 `/config language [code]`:

### 4.1. 验证语言代码

```
有效代码: en, vi, zh, ja

如果代码无效:
→ 显示错误: "❌ 无效的语言代码。请使用: en, vi, zh, 或 ja"
→ 退出
```

### 4.2. 下载新语言的工作流

```
REPO_BASE = "https://raw.githubusercontent.com/hasugoii/antikit/main"
WORKFLOWS_DIR = ~/.gemini/antigravity/global_workflows/

WORKFLOW_FILES = [
    "README.md", "ak-update.md", "audit.md", "brainstorm.md", "cloudflare-tunnel.md",
    "code.md", "config.md", "customize.md", "debug.md", "deploy.md",
    "init.md", "next.md", "plan.md", "recap.md", "refactor.md",
    "rollback.md", "run.md", "save_brain.md", "test.md", "visualize.md"
]

对于 WORKFLOW_FILES 中的每个文件:
→ 从以下位置下载: $REPO_BASE/workflows/[lang]/[file]
→ 保存到: $WORKFLOWS_DIR/[file] (覆盖现有文件)

显示进度:
"⏳ 正在下载 [lang] 工作流...
   ✅ README.md
   ✅ ak-update.md
   ✅ audit.md
   ... (共20个文件)
   
✅ 已将20个工作流文件下载到 global_workflows/"
```

### 4.3. 保存新语言

```
保存到: ~/.gemini/antikit_language
内容: [new_lang_code]
```

### 4.3.5. 更新 GEMINI.md 中的 Command Mapping（重要）

```
GEMINI_MD = ~/.gemini/GEMINI.md

将 GEMINI.md 中的 "# AntiKit - Enhancement Kit for Antigravity" 部分
替换为语言特定的 Command Mapping。

按语言的 Command Mapping:

[en] English / [vi] Vietnamese / [ja] Japanese: 类似

[zh] 中文:
| 命令 | 描述 |
| `/brainstorm` | 💡 头脑风暴、市场研究 |
| `/plan` | 功能设计 |
| `/code` | 安全编写代码 |
... (共19个命令)

从以下位置下载完整模板:
$REPO_BASE/templates/gemini_[lang].md
→ 从 "# AntiKit" 部分开始替换 GEMINI.md 中的内容
```


### 4.4. 重启警告 (重要)

```
语言更改成功后，必须显示:

"✅ 语言已更改为 [language_name]!

⚠️ **重要: 您必须重启 Antigravity 才能使更改生效!**

新的工作流语言只有在重启后才会加载。
当前会话仍在使用缓存在内存中的旧语言文件。

🔄 请执行以下步骤:
1. 关闭此 Antigravity 会话
2. 重新打开 Antigravity
3. 使用 /recap 或任何工作流命令验证"
```

### 4.5. 语言名称映射

| 代码 | 显示名称 |
|------|----------|
| en | English |
| vi | Tiếng Việt |
| zh | 中文 |
| ja | 日本語 (日语) |

---

## ⚠️ 下一步:

```
1️⃣ 配置完成? /code 开始
2️⃣ 需要先计划? /plan
3️⃣ 开始新项目? /init
```
