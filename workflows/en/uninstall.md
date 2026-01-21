---
description: 🗑️ Uninstall AntiKit
---

# WORKFLOW: /uninstall - Remove AntiKit

> **Context:** Agent `@devops`
> **Required Skills:** `server-management`, `powershell-windows`, `bash-linux`

You are the **AntiKit Uninstaller**. Mission: Safely remove AntiKit from the system.

**Goal:** Clean removal while preserving user data if requested.

---

## Phase 1: Confirmation

```
"⚠️ **UNINSTALL ANTIKIT**

You are about to remove AntiKit from your system. This will delete:

📂 **Files to be removed:**
- ~/.gemini/antigravity/global_workflows/ (20 workflow files)
- ~/.gemini/antigravity/agents/ (16 agent files)
- ~/.gemini/antigravity/skills/ (40 skill folders)
- ~/.gemini/antigravity/schemas/ (3 schema files)
- ~/.gemini/antigravity/templates/ (3 template files)
- ~/.gemini/antikit_version
- ~/.gemini/antikit_language
- AntiKit section in ~/.gemini/GEMINI.md

⚠️ **Note:** This will NOT delete:
- Your project files
- ~/.brain/ folders in your projects
- Other Antigravity settings

Are you sure you want to uninstall?
1️⃣ Yes - Remove AntiKit completely
2️⃣ No - Cancel uninstallation"
```

---

## Phase 2: Execute Uninstallation

If user confirms (Yes):

### 2.1. Remove AntiKit Directories

```
Remove the following directories:
rm -rf ~/.gemini/antigravity/global_workflows/
rm -rf ~/.gemini/antigravity/agents/
rm -rf ~/.gemini/antigravity/skills/
rm -rf ~/.gemini/antigravity/schemas/
rm -rf ~/.gemini/antigravity/templates/

Display progress:
"🗑️ Removing AntiKit files...
   ✅ Removed global_workflows/
   ✅ Removed agents/
   ✅ Removed skills/
   ✅ Removed schemas/
   ✅ Removed templates/"
```

### 2.2. Remove Config Files

```
Remove config files:
rm ~/.gemini/antikit_version
rm ~/.gemini/antikit_language

"✅ Removed config files"
```

### 2.3. Clean GEMINI.md

```
GEMINI_MD = ~/.gemini/GEMINI.md

Remove the "# AntiKit - Enhancement Kit for Antigravity" section 
and everything after it from GEMINI.md.

If GEMINI.md becomes empty after removal, delete the file.

"✅ Cleaned GEMINI.md"
```

### 2.4. Remove Empty Antigravity Directory

```
If ~/.gemini/antigravity/ is now empty:
rm -rf ~/.gemini/antigravity/

"✅ Removed empty antigravity directory"
```

---

## Phase 3: Completion

```
"✅ **ANTIKIT UNINSTALLED SUCCESSFULLY!**

All AntiKit files have been removed from your system.

⚠️ **IMPORTANT: You MUST restart Antigravity for changes to take effect!**

📝 **What was removed:**
- 20 workflow files
- 16 agents
- 40 skills
- 6 schema/template files
- AntiKit configuration

🔄 **To reinstall AntiKit later:**
Windows: irm https://raw.githubusercontent.com/hasugoii/antikit/main/install.ps1 | iex
Mac/Linux: curl -fsSL https://raw.githubusercontent.com/hasugoii/antikit/main/install.sh | bash

Thank you for using AntiKit! 👋"
```

---

## Phase 4: If User Cancels

```
"❌ Uninstallation cancelled.

AntiKit remains installed on your system.

👉 Continue using AntiKit:
- /recap - Restore context
- /plan - Start planning
- /code - Start coding"
```
