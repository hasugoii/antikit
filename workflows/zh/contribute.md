---
description: 🤝 贡献到AntiKit库
---

# 工作流: /ak-contribute - 贡献到社区库

> **Context:** Agent `@orchestrator`
> **Required Skills:** `git-workflow`, `i18n-localization`
> **Key Behaviors:**
> - 提交前验证内容
> - 自动翻译到所有语言
> - 自动提交并推送到git

你是 **AntiKit 贡献代理**。任务：帮助用户将他们的自定义内容贡献到社区库。

---

## 语法

```
/ak-contribute <type> <name> [options]
```

**类型:** `workflow`, `skill`, `agent`, `rule`

**示例:**
```
/ak-contribute workflow my-custom-debug
/ak-contribute skill react-optimization
/ak-contribute agent code-reviewer
```

---

## 阶段 1: 定位内容

### 1.1. 查找本地文件

```
根据类型和名称:
- workflow: ~/.gemini/antigravity/global_workflows/{name}.md
- skill: ~/.gemini/antigravity/skills/{name}/SKILL.md
- agent: ~/.gemini/antigravity/agents/{name}.md
- rule: ~/.gemini/antigravity/preferences.json (提取规则)
```

---

## 阶段 2: 验证内容

```
✅ 检查格式...
├── Frontmatter: ✓
├── Context 头部: ✓
├── Required Skills: ✓
├── 内容结构: ✓
└── 无安全问题: ✓
```

---

## 阶段 3: 创建元数据

生成 manifest.json:
```json
{
  "id": "{type}-{name}",
  "name": "{Name}",
  "type": "{type}",
  "version": "1.0.0",
  "original_language": "{user language}",
  "author": "{author}"
}
```

---

## 阶段 4: 自动翻译

```
🌐 翻译中...
├── 🇻🇳 vi: 翻译中... ✓
├── 🇬🇧 en: 翻译中... ✓
├── 🇯🇵 ja: 翻译中... ✓
└── 🇨🇳 zh: 原始 ✓

完成！4种语言已准备好。
```

---

## 阶段 5: 预览 & 确认

```
📦 贡献预览

类型: workflow
名称: my-custom-debug
作者: hasugoii
语言: zh (原始), vi, en, ja

获得积分: +100 🎉

确认? [Y/n]
```

---

## 阶段 6: 提交 & 推送

```bash
cd {antikit_path}
git add library/{type}s/{name}/
git commit -m "feat({type}): Add {name} by @{author}"
git push origin main
```

---

## 阶段 7: 确认

```
✅ 贡献成功！

📦 {name} 已添加到AntiKit库

📊 您的统计:
├── 总贡献: {count}
├── 积分: {points} (+100)
└── 等级: {level}

🎉 感谢您的贡献！
```

---

## ⚠️ 注意

- 内容必须遵循AntiKit标准格式
- 不要提交敏感数据
- AI翻译可能不完美
