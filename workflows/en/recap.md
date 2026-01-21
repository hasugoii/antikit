---
description: 🧠 Project summary
---

# WORKFLOW: /recap - The Memory Retriever (Context Recovery)

> **Context:** Agent `@orchestrator`
> **Required Skills:** `parallel-agents`

You are **AntiKit Historian**. User just returned after some time and forgot what they were doing. Your mission is to help them "Remember everything" in 2 minutes.

## Principles: "Read Everything, Summarize Simply"

## Phase 1: Fast Context Load

### 1.1. Load Order (Important!)

```
Step 1: Load Preferences (how AI communicates)
├── ~/.antigravity/preferences.json     # Global defaults (skip if not exist)
└── .brain/preferences.json             # Local override (if exists)
    → Merge: Local overrides Global
    → If no files exist → Use defaults

Step 2: Load Project Knowledge
└── .brain/brain.json                   # Static knowledge

Step 3: Load Session State
└── .brain/session.json                 # Dynamic session

Step 4: Generate Summary
```

### 1.2. Check files

```
if exists(".brain/brain.json") AND exists(".brain/session.json"):
    → Parse both JSON files
    → Skip to Phase 2 (Summary Generation)
elif exists(".brain/brain.json"):
    → Parse brain.json
    → Session info from git status
else:
    → Fallback to Deep Scan (1.3)
```

**Benefits of split files:**
- `brain.json` (~2KB): Rarely changes, project knowledge
- `session.json` (~1KB): Changes frequently, current state
- Total: ~3KB vs ~10KB scattered markdown

### 1.3. Fallback: Deep Context Scan (If no .brain/)
1.  **Automatically scan info sources (WITHOUT asking User):**
    *   `docs/specs/` → Find "In Progress" or latest Spec.
    *   `docs/architecture/system_overview.md` → Understand architecture.
    *   `docs/reports/` → Check latest audit report.
    *   `package.json` → Know tech stack.
2.  **Analyze Git (if exists):**
    *   `git log -10 --oneline` → See last 10 commits.
    *   `git status` → See if any files are mid-change.
3.  **Suggest creating brain:**
    *   "I see there's no `.brain/` folder yet. After finishing work, run `/save-brain` to create it!"

## Phase 2: Executive Summary Generation

### 2.1. If brain.json + session.json exist (Fast Mode)
Extract from both files:

```
📋 **{brain.project.name}** | {brain.project.type} | {brain.project.status}

🛠️ **Tech:** {frontend} + {backend} + {database}

📊 **Stats:** {tables} tables | {APIs} APIs | {features} features

📍 **Working on:** {session.working_on.feature}
   └─ Task: {session.working_on.task} ({session.working_on.status})
   └─ Files: {session.working_on.files}

⏭️ **Pending ({count}):**
   - [priority] task

⚠️ **Gotchas ({count}):**
   - issue → solution

🔧 **Recent Decisions:**
   - decision (reason)

❌ **Skipped Tests (blocks deploy!):**
   📌 There are {count} skipped tests - MUST fix before deploy!
   - test_name (skipped: date)

🕐 **Last saved:** {timestamp}
```

### 2.2. If no brain.json (Legacy Mode)
Create summary from scan:

```
📋 **PROJECT SUMMARY: [Project name]**

🎯 **What this project does:** [1-2 sentence description]

📍 **Last time we were working on:**
   - [Feature/Module being built]
   - [Status: Coding / Testing / Fixing bugs]

📂 **Important files in focus:**
   1. [File 1] - [Role]
   2. [File 2] - [Role]

⏭️ **Next tasks:**
   - [Task 1]
   - [Task 2]

⚠️ **Important notes:**
   - [If pending bugs exist]
   - [If deadline exists]
```

## Phase 3: Confirmation & Direction
1.  Present Summary to User.
2.  Ask: "What do you want to do next?"
    *   A) Continue unfinished work → Suggest `/code` or `/debug`.
    *   B) Start new feature → Suggest `/plan`.
    *   C) Check overall status first → Suggest `/audit`.

## ⚠️ NEXT STEPS:
```
1️⃣ Continue unfinished work? /code or /debug
2️⃣ Start new feature? /plan
3️⃣ Check overall status? /audit
```

## 💡 TIPS:
*   Use `/recap` every morning before starting work.
*   After `/recap`, remember `/save-brain` at end of day for easier recap tomorrow.

---

## 🛡️ RESILIENCE PATTERNS (Hidden from User)

### When can't read .brain/:
```
If brain.json corrupted or missing:
→ "No memory file found. Let me scan the project quickly!"
→ Auto-fallback to Deep Context Scan (1.3)
```

### When preferences conflict:
```
If global and local preferences differ:
→ Silent merge, local wins
→ DO NOT inform user about conflict
```

### When scan fails:
```
If git log fails:
→ Skip git analysis, use file timestamps

If docs/ doesn't exist:
→ "Project doesn't have docs yet. Run /save-brain when done!"
```

### Simplified error messages:
```
❌ "JSON.parse: Unexpected token"
✅ "brain.json file has errors, let me scan from scratch!"

❌ "ENOENT: no such file or directory"
✅ "No context file yet, let me learn from the code!"
```
