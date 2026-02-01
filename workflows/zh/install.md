# WORKFLOW: /ak-install - 安装软件包

> **Context:** Agent `@devops`
> **Required Skills:** `package-management`
> **Key Behaviors:**
> - 允许选择性安装软件包
> - 自动处理依赖关系
> - 安装前进行安全检查

你是 **AntiKit Package Installer**。任务：帮助用户按需安装软件包。

---

## 阶段1：解析输入

### 1.1. 解析安装命令

用户可以通过以下方式调用：
- `/ak-install skill/react-patterns` → 安装单个软件包
- `/ak-install --category=security` → 按类别安装
- `/ak-install --list` → 查看软件包列表

### 1.2. 检查软件包是否存在

1. 从 GitHub 读取 `registry/index.json`
2. 检查软件包是否在列表中
3. 如果未找到 → 显示错误

---

## 阶段2：显示软件包信息

```
📦 ANTIKIT 软件包安装器

📋 软件包: skill/react-patterns
├── 版本: 2.1.0
├── 作者: hasugoii
├── 层级: recommended
├── 标签: frontend, react, patterns
└── 下载量: 1,234

📝 描述：
React 开发的最佳实践和模式。

🔗 依赖项 (2):
├── skill/typescript-expert (必需)
└── skill/clean-code (可选)

安装吗？ [Y/n]
```

---

## 阶段3：处理依赖关系

### 3.1. 如果存在依赖项
```
🔗 此软件包需要以下依赖项：

必需：
├── skill/typescript-expert v1.2.0

可选：
└── skill/clean-code v1.0.0

安装所有依赖项？ [Y/n/select]
```

---

## 阶段4：下载和安装

```
⬇️ 正在下载软件包...

[1/3] skill/react-patterns... ✓
[2/3] skill/typescript-expert... ✓
[3/3] skill/clean-code... ✓
```

---

## 阶段5：完成

```
✅ 安装成功！

📦 已安装 3 个软件包：
├── skill/react-patterns v2.1.0
├── skill/typescript-expert v1.2.0
└── skill/clean-code v1.0.0

📍 位置：
~/.gemini/antigravity/skills/

🧪 现在试试：输入 /recap 查看新技能！
```

---

## ⚠️ 下一步：
```
1️⃣ /ak-browse - 查看软件包列表
2️⃣ /ak-update - 检查更新
3️⃣ /ak-uninstall <package> - 删除软件包
```
