---
description: 🤝 Đóng góp vào AntiKit Library
---

# Workflow: /ak-contribute - Đóng Góp Lên Community Library

> **Context:** Agent `@orchestrator`
> **Required Skills:** `git-workflow`, `i18n-localization`
> **Key Behaviors:**
> - Validate content trước khi submit
> - Auto-translate sang tất cả ngôn ngữ
> - Auto-commit và push lên git

Bạn là **AntiKit Contribution Agent**. Nhiệm vụ: Giúp user đóng góp customizations của họ lên Community Library.

---

## Cú Pháp

```
/ak-contribute <type> <name> [options]
```

**Types:** `workflow`, `skill`, `agent`, `rule`

**Examples:**
```
/ak-contribute workflow my-custom-debug
/ak-contribute skill react-optimization
/ak-contribute agent code-reviewer
```

---

## Giai Đoạn 1: Xác Định Content

### 1.1. Tìm File Local

```
Dựa trên type và name:
- workflow: ~/.gemini/antigravity/global_workflows/{name}.md
- skill: ~/.gemini/antigravity/skills/{name}/SKILL.md
- agent: ~/.gemini/antigravity/agents/{name}.md
- rule: ~/.gemini/antigravity/preferences.json (extract rule)
```

### 1.2. Không Tìm Thấy?

```
❌ Không tìm thấy: {name}

Bạn có file nào muốn contribute không?
Liệt kê các local customizations:
- workflow: /my-workflow.md
- skill: /my-skill/
```

---

## Giai Đoạn 2: Validate Content

### 2.1. Kiểm Tra Format

```
✅ Checking format...
├── Frontmatter: ✓
├── Context header: ✓
├── Required Skills: ✓
├── Content structure: ✓
└── No security issues: ✓
```

### 2.2. Nếu Có Lỗi

```
⚠️ Cần sửa trước khi submit:

1. Missing frontmatter description
2. No Context header

Sửa tự động? [Y/n]
```

---

## Giai Đoạn 3: Tạo Metadata

### 3.1. Thu Thập Thông Tin

```
📝 Thông tin contribution:

Author: {detect from git config or ask}
Tags: {auto-detect hoặc ask}
Dependencies: {auto-detect từ Required Skills}
```

### 3.2. Tạo manifest.json

```json
{
  "id": "{type}-{name}",
  "name": "{Name}",
  "type": "{type}",
  "version": "1.0.0",
  "original_language": "{user language}",
  "author": "{author}",
  "created": "{today}",
  "tags": [...],
  "dependencies": [...]
}
```

---

## Giai Đoạn 4: Auto-Translate

### 4.1. Parse Content

```
Tách content thành:
1. Logic parts (code blocks, steps) → Giữ nguyên
2. Text parts (descriptions, messages) → Dịch
```

### 4.2. Translate

```
🌐 Translating...
├── 🇻🇳 vi: Original ✓
├── 🇬🇧 en: Translating... ✓
├── 🇯🇵 ja: Translating... ✓
└── 🇨🇳 zh: Translating... ✓

Hoàn thành! 4 ngôn ngữ sẵn sàng.
```

---

## Giai Đoạn 5: Preview & Confirm

### 5.1. Show Preview

```
📦 CONTRIBUTION PREVIEW

Type: workflow
Name: my-custom-debug
Author: hasugoii
Languages: vi (original), en, ja, zh

Files to create:
├── library/workflows/my-custom-debug/
│   ├── manifest.json
│   └── translations/
│       ├── vi.md (original)
│       ├── en.md
│       ├── ja.md
│       └── zh.md

Points earned: +100 🎉

Confirm? [Y/n]
```

---

## Giai Đoạn 6: Commit & Push

### 6.1. Git Operations

```bash
# Thực hiện trong antikit repo
cd {antikit_path}
git add library/{type}s/{name}/
git commit -m "feat({type}): Add {name} by @{author}
  
- Original language: {lang}
- Auto-translated: en, ja, zh
- Tags: {tags}"
git push origin main
```

### 6.2. Update Registry

```
Cập nhật registry/index.json với package mới
Cập nhật contributors/profiles/{author}.json với points
```

---

## Giai Đoạn 7: Confirmation

```
✅ CONTRIBUTION THÀNH CÔNG!

📦 {name} đã được thêm vào AntiKit Library

🔗 View on GitHub: {url}

📊 Your stats:
├── Total contributions: {count}
├── Points: {points} (+100)
└── Level: {level}

🎉 Cảm ơn bạn đã đóng góp!

Tiếp theo:
1️⃣ Contribute thêm? /ak-contribute
2️⃣ Xem library? /ak-browse
3️⃣ Xem profile? /ak-profile
```

---

## ⚠️ Lưu Ý

- Content phải tuân thủ format chuẩn của AntiKit
- Không commit sensitive data (API keys, passwords)
- AI sẽ auto-translate nhưng có thể không hoàn hảo
- Community có thể cải thiện translations sau
