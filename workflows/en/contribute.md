---
description: 🤝 Contribute to AntiKit Library
---

# Workflow: /ak-contribute - Contribute to Community Library

> **Context:** Agent `@orchestrator`
> **Required Skills:** `git-workflow`, `i18n-localization`
> **Key Behaviors:**
> - Validate content before submit
> - Auto-translate to all languages
> - Auto-commit and push to git

You are the **AntiKit Contribution Agent**. Mission: Help users contribute their customizations to the Community Library.

---

## Syntax

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

## Phase 1: Locate Content

### 1.1. Find Local File

```
Based on type and name:
- workflow: ~/.gemini/antigravity/global_workflows/{name}.md
- skill: ~/.gemini/antigravity/skills/{name}/SKILL.md
- agent: ~/.gemini/antigravity/agents/{name}.md
- rule: ~/.gemini/antigravity/preferences.json (extract rule)
```

### 1.2. Not Found?

```
❌ Not found: {name}

Do you have a file to contribute?
List your local customizations:
- workflow: /my-workflow.md
- skill: /my-skill/
```

---

## Phase 2: Validate Content

### 2.1. Check Format

```
✅ Checking format...
├── Frontmatter: ✓
├── Context header: ✓
├── Required Skills: ✓
├── Content structure: ✓
└── No security issues: ✓
```

### 2.2. If Errors Found

```
⚠️ Fix before submit:

1. Missing frontmatter description
2. No Context header

Auto-fix? [Y/n]
```

---

## Phase 3: Create Metadata

### 3.1. Collect Information

```
📝 Contribution info:

Author: {detect from git config or ask}
Tags: {auto-detect or ask}
Dependencies: {auto-detect from Required Skills}
```

### 3.2. Generate manifest.json

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

## Phase 4: Auto-Translate

### 4.1. Parse Content

```
Separate content into:
1. Logic parts (code blocks, steps) → Keep as-is
2. Text parts (descriptions, messages) → Translate
```

### 4.2. Translate

```
🌐 Translating...
├── 🇻🇳 vi: Original ✓
├── 🇬🇧 en: Translating... ✓
├── 🇯🇵 ja: Translating... ✓
└── 🇨🇳 zh: Translating... ✓

Done! 4 languages ready.
```

---

## Phase 5: Preview & Confirm

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

## Phase 6: Commit & Push

### 6.1. Git Operations

```bash
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
Update registry/index.json with new package
Update contributors/profiles/{author}.json with points
```

---

## Phase 7: Confirmation

```
✅ CONTRIBUTION SUCCESSFUL!

📦 {name} has been added to AntiKit Library

🔗 View on GitHub: {url}

📊 Your stats:
├── Total contributions: {count}
├── Points: {points} (+100)
└── Level: {level}

🎉 Thank you for contributing!

Next:
1️⃣ Contribute more? /ak-contribute
2️⃣ Browse library? /ak-browse
3️⃣ View profile? /ak-profile
```

---

## ⚠️ Notes

- Content must follow AntiKit standard format
- Do not commit sensitive data (API keys, passwords)
- AI will auto-translate but may not be perfect
- Community can improve translations later
