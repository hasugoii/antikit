---
description: 🗑️ 卸载 AntiKit
---

# 工作流: /uninstall - 删除 AntiKit

你是 **AntiKit 卸载器**。任务: 安全地从系统中删除 AntiKit。

**目标:** 干净地删除，同时根据需要保留用户数据。

---

## 阶段 1: 确认

```
"⚠️ **卸载 ANTIKIT**

您即将从系统中删除 AntiKit。以下文件将被删除:

📂 **将被删除的文件:**
- ~/.gemini/antigravity/global_workflows/ (20个工作流文件)
- ~/.gemini/antigravity/agents/ (16个代理文件)
- ~/.gemini/antigravity/skills/ (40个技能文件夹)
- ~/.gemini/antigravity/schemas/ (3个模式文件)
- ~/.gemini/antigravity/templates/ (3个模板文件)
- ~/.gemini/antikit_version
- ~/.gemini/antikit_language
- ~/.gemini/GEMINI.md 中的 AntiKit 部分

⚠️ **注意:** 以下内容不会被删除:
- 您的项目文件
- 项目中的 ~/.brain/ 文件夹
- 其他 Antigravity 设置

您确定要卸载吗?
1️⃣ 是 - 完全删除 AntiKit
2️⃣ 否 - 取消卸载"
```

---

## 阶段 2: 执行卸载

如果用户确认（是）:

### 2.1. 删除 AntiKit 目录

```
删除以下目录:
rm -rf ~/.gemini/antigravity/global_workflows/
rm -rf ~/.gemini/antigravity/agents/
rm -rf ~/.gemini/antigravity/skills/
rm -rf ~/.gemini/antigravity/schemas/
rm -rf ~/.gemini/antigravity/templates/

显示进度:
"🗑️ 正在删除 AntiKit 文件...
   ✅ 已删除 global_workflows/
   ✅ 已删除 agents/
   ✅ 已删除 skills/
   ✅ 已删除 schemas/
   ✅ 已删除 templates/"
```

### 2.2. 删除配置文件

```
删除配置文件:
rm ~/.gemini/antikit_version
rm ~/.gemini/antikit_language

"✅ 已删除配置文件"
```

### 2.3. 清理 GEMINI.md

```
GEMINI_MD = ~/.gemini/GEMINI.md

从 GEMINI.md 中删除 "# AntiKit - Enhancement Kit for Antigravity" 部分
及其后的所有内容。

如果删除后 GEMINI.md 为空，则删除该文件。

"✅ 已清理 GEMINI.md"
```

### 2.4. 删除空的 Antigravity 目录

```
如果 ~/.gemini/antigravity/ 现在为空:
rm -rf ~/.gemini/antigravity/

"✅ 已删除空的 antigravity 目录"
```

---

## 阶段 3: 完成

```
"✅ **ANTIKIT 卸载成功！**

所有 AntiKit 文件已从系统中删除。

⚠️ **重要: 您必须重启 Antigravity 才能使更改生效！**

📝 **已删除:**
- 20个工作流文件
- 16个代理
- 40个技能
- 6个模式/模板文件
- AntiKit 配置

🔄 **以后重新安装 AntiKit:**
Windows: irm https://raw.githubusercontent.com/hasugoii/antikit/main/install.ps1 | iex
Mac/Linux: curl -fsSL https://raw.githubusercontent.com/hasugoii/antikit/main/install.sh | bash

感谢您使用 AntiKit！ 👋"
```

---

## 阶段 4: 如果用户取消

```
"❌ 卸载已取消。

AntiKit 仍安装在您的系统上。

👉 继续使用 AntiKit:
- /recap - 恢复上下文
- /plan - 开始规划
- /code - 开始编码"
```
