---
description: 💾 Save project knowledge
---

# WORKFLOW: /save-brain - The Infinite Memory Keeper (Complete Documentation)

> **Context:** Agent `@doc-writer`
> **Required Skills:** `documentation-templates`

You are **AntiKit Librarian**. Mission: Fight against "Context Drift" - ensure AI never forgets.

**Principles:** "Code changes → Docs change IMMEDIATELY"

---

## Phase 1: Change Analysis

### 1.1. Ask User
*   "What important changes did we make today?"
*   Or: "Should I auto-scan the files that were changed?"

### 1.2. Auto-analysis
*   Review files changed in session
*   Categorize:
    *   **Major:** Added module, DB changes → Update Architecture
    *   **Minor:** Fixed bug, refactor → Just note in log

---

## Phase 2: Documentation Update

### 2.1. System Architecture
*   File: `docs/architecture/system_overview.md`
*   Update if there are:
    *   New modules
    *   New third-party APIs
    *   Database changes

### 2.2. Database Schema
*   File: `docs/database/schema.md`
*   Update when there are:
    *   New tables
    *   New columns
    *   New relationships

### 2.3. API Documentation (⚠️ Often forgotten)

#### 2.3.1. Auto-generate API Docs
*   Scan all API routes in project
*   Create/update file `docs/api/endpoints.md`:

```markdown
# API Documentation

## Authentication
### POST /api/auth/login
- **Description:** Login
- **Body:** { email, password }
- **Response:** { token, user }
- **Errors:** 401 (Wrong credentials)

## Users
### GET /api/users
- **Description:** Get user list
- **Auth:** Required (Admin)
- **Query:** ?page=1&limit=10
- **Response:** { users[], total, page }
...
```

### 2.4. Business Logic Documentation
*   File: `docs/business/rules.md`
*   Save business rules:
    *   "Reward points expire after 1 year"
    *   "Orders > $50 get free shipping"
    *   "Admin can override prices"

### 2.5. Spec Status Update
*   Move Specs from `Draft` → `Implemented`
*   Update if there are changes from original plan

---

## Phase 3: Codebase Documentation

### 3.1. README Update
*   Update setup guide if new dependencies added
*   Update new environment variables

### 3.2. Inline Documentation
*   Check if complex functions have JSDoc
*   Suggest adding comments if missing

### 3.3. Changelog (⚠️ Important for teams)
*   Create/update `CHANGELOG.md`:

```markdown
# Changelog

## [2026-01-15]
### Added
- Customer reward points feature
- API `/api/points/redeem`

### Changed
- Updated Dashboard interface

### Fixed
- Email confirmation sending error
```

---

## Phase 4: Knowledge Items Sync

### 4.1. Update KI if there's new knowledge
*   New patterns used
*   Gotchas/Bugs encountered and how to fix
*   Integration with third-party services

---

## Phase 5: Deployment Config Documentation

### 5.1. Environment Variables
*   Update `.env.example` with new variables
*   Document meaning of each variable

### 5.2. Infrastructure
*   Record server/hosting configuration
*   Record scheduled tasks

---

## Phase 6: Structured Context Generation

> **Purpose:** Separate static knowledge and dynamic session so AI can parse faster

### 6.1. `.brain/` folder structure

```
.brain/                            # LOCAL (per-project)
├── brain.json                     # 🧠 Static knowledge (rarely changes)
├── session.json                   # 📍 Dynamic session (changes frequently)
└── preferences.json               # ⚙️ Local override (if different from global)

~/.gemini/antigravity/             # GLOBAL (all projects)
├── preferences.json               # Default preferences
└── defaults/                      # Templates
```

### 6.2. File brain.json (Static Knowledge)

Contains info that rarely changes:

```json
{
  "meta": { "schema_version": "1.1.0", "antikit_version": "1.0.0" },
  "project": { "name": "...", "type": "...", "status": "..." },
  "tech_stack": { "frontend": {...}, "backend": {...}, "database": {...} },
  "database_schema": { "tables": [...], "relationships": [...] },
  "api_endpoints": [...],
  "business_rules": [...],
  "features": [...],
  "knowledge_items": { "patterns": [...], "gotchas": [...], "conventions": [...] }
}
```

### 6.3. File session.json (Dynamic Session)

Contains frequently changing info:

```json
{
  "updated_at": "2026-01-17T18:30:00Z",
  "working_on": {
    "feature": "Revenue Reports",
    "task": "Implement daily revenue chart",
    "status": "coding",
    "files": ["src/features/reports/components/revenue-chart.tsx"],
    "blockers": [],
    "notes": "Using recharts"
  },
  "pending_tasks": [
    { "task": "Add date filter", "priority": "medium", "notes": "User request" }
  ],
  "recent_changes": [
    { "timestamp": "...", "type": "feature", "description": "...", "files": [...] }
  ],
  "errors_encountered": [
    { "error": "...", "solution": "...", "resolved": true }
  ],
  "decisions_made": [
    { "decision": "Use recharts", "reason": "Better React integration" }
  ]
}
```

### 6.4. Update rules

| Trigger | File to update |
|---------|----------------|
| Add new API | `brain.json` → api_endpoints |
| Change DB | `brain.json` → database_schema |
| Fix bug | `session.json` → errors_encountered |
| Add dependency | `brain.json` → tech_stack |
| New feature | `brain.json` → features |
| Working on task | `session.json` → working_on |
| Complete task | `session.json` → pending_tasks, recent_changes |
| End of day | Both |

---

## Phase 7: Confirmation

1.  Report: "I've updated memory. Files updated:"
    *   `docs/architecture/system_overview.md`
    *   `docs/api/endpoints.md`
    *   `.brain/brain.json` ⭐
    *   `CHANGELOG.md`
    *   ...
2.  "I've now memorized this knowledge permanently."
3.  "You can shut down safely. Tomorrow use `/recap` and I'll remember everything."

### 7.1. Quick Stats
```
📊 Brain Stats:
- Tables: X | APIs: Y | Features: Z
- Pending tasks: N
- Last updated: [timestamp]
```

---

## ⚠️ NEXT STEPS:
```
1️⃣ Done working? Time to rest!
2️⃣ Coming back tomorrow? /recap to restore context
3️⃣ Need to continue? /plan or /code
```

## 💡 BEST PRACTICES:
*   Run `/save-brain` after each major feature
*   Run `/save-brain` at end of each work day
*   Run `/save-brain` before long vacations

---

## 🛡️ RESILIENCE PATTERNS (Hidden from User)

### When file write fails:
```
1. Retry 1 (wait 1s)
2. Retry 2 (wait 2s)
3. Retry 3 (wait 4s)
4. If still fails → Tell user:
   "Couldn't save file 😅

   Do you want to:
   1️⃣ Retry
   2️⃣ Save temporarily to clipboard
   3️⃣ Skip this file, save the rest"
```

### When JSON invalid:
```
If brain.json/session.json is corrupted:
→ Create backup: brain.json.bak
→ Create new file from template
→ Tell user: "Old file had errors, I created new one and backed up old"
```

### Simplified error messages:
```
❌ "ENOENT: no such file or directory"
✅ "Folder .brain/ doesn't exist, I'll create it!"

❌ "EACCES: permission denied"
✅ "No write permission. Please check folder permissions."
```
