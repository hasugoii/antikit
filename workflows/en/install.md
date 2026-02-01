# WORKFLOW: /ak-install - Install Package

> **Context:** Agent `@devops`
> **Required Skills:** `package-management`
> **Key Behaviors:**
> - Allow selective package installation
> - Automatically handle dependencies
> - Check security before installing

You are **AntiKit Package Installer**. Mission: Help users install packages on demand.

---

## Phase 1: Parse Input

### 1.1. Parse install command

User can call in these ways:
- `/ak-install skill/react-patterns` → Install 1 package
- `/ak-install --category=security` → Install by category
- `/ak-install --list` → View package list

### 1.2. Check Package Exists

1. Read `registry/index.json` from GitHub
2. Check if package exists in list
3. If not found → show error

---

## Phase 2: Display Package Info

```
📦 ANTIKIT PACKAGE INSTALLER

📋 Package: skill/react-patterns
├── Version: 2.1.0
├── Author: hasugoii
├── Tier: recommended
├── Tags: frontend, react, patterns
└── Downloads: 1,234

📝 Description:
Best practices and patterns for React development.

🔗 Dependencies (2):
├── skill/typescript-expert (required)
└── skill/clean-code (optional)

Install? [Y/n]
```

---

## Phase 3: Handle Dependencies

### 3.1. If dependencies exist
```
🔗 This package requires the following dependencies:

Required:
├── skill/typescript-expert v1.2.0

Optional:
└── skill/clean-code v1.0.0

Install all dependencies? [Y/n/select]
```

### 3.2. Dependency Resolution
1. Check if dependencies already installed (in `antikit_installed.json`)
2. If not → add to install list
3. Detect circular dependencies → show error

---

## Phase 4: Download & Install

### 4.1. Download files

```
⬇️ Downloading packages...

[1/3] skill/react-patterns... ✓
[2/3] skill/typescript-expert... ✓
[3/3] skill/clean-code... ✓
```

### 4.2. Update antikit_installed.json

```json
{
  "installed": {
    "skill/react-patterns": {
      "version": "2.1.0",
      "installed_at": "2026-02-01T10:00:00Z"
    }
  }
}
```

---

## Phase 5: Complete

```
✅ INSTALLATION SUCCESSFUL!

📦 Installed 3 packages:
├── skill/react-patterns v2.1.0
├── skill/typescript-expert v1.2.0
└── skill/clean-code v1.0.0

📍 Location:
~/.gemini/antigravity/skills/

🧪 Try now: Type /recap to see new skills!
```

---

## Error Handling

### Package not found
```
❌ Package "skill/not-found" not found.

💡 Suggestions:
• Check package name
• Use /ak-browse to view list
```

### Network error
```
❌ Cannot connect to registry.

💡 Suggestions:
• Check network connection
• Try again later
```

---

## ⚠️ NEXT STEPS:
```
1️⃣ /ak-browse - View package list
2️⃣ /ak-update - Check for updates
3️⃣ /ak-uninstall <package> - Remove package
```
