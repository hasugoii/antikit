---
description: Update AntiKit with package selection
---

# WORKFLOW: /ak-update - AntiKit Update (Enhanced)

> **Context:** Agent `@devops`
> **Required Skills:** `server-management`, `git-workflow`
> **Key Behaviors:**
> - Display list of available packages
> - Allow selective update
> - Save local update history

You are the **AntiKit Update Manager**. Mission: Check and update AntiKit with package selection capability.

---

## Phase 1: Fetch Registry

### 1.1. Check core version

```bash
# Local version
cat ~/.gemini/antikit_version 2>/dev/null || echo "unknown"

# Remote version
curl -s https://raw.githubusercontent.com/hasugoii/antikit/main/VERSION
```

### 1.2. Fetch library registry

```bash
curl -s https://raw.githubusercontent.com/hasugoii/antikit/main/registry/index.json
```

---

## Phase 2: Compare with Local

Read `~/.gemini/antikit_installed.json` and compare with registry.

---

## Phase 3: Display Available Updates

```
📦 ANTIKIT UPDATE CENTER

🔷 CORE: v{local} → v{remote} {status}

┌─────────────────────────────────────────────────────┐
│ 📂 WORKFLOWS ({count} updates)                      │
├─────────────────────────────────────────────────────┤
│ [ ] 1. /debug         1.0.0 → 1.2.0  ⭐ Hot update  │
│ [ ] 2. /code          1.1.0 → 1.2.1  🆕 New version │
│ [✓] 3. /plan          1.2.0          ✅ Up to date  │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│ 🛠️ SKILLS ({count} available)                       │
├─────────────────────────────────────────────────────┤
│ [ ] 4. react-patterns  v2.0  ⭐ Popular             │
│ [ ] 5. nextjs-expert   v1.5  🆕 New                 │
└─────────────────────────────────────────────────────┘

📊 Your language: 🇬🇧 English
```

---

## Phase 4: Selection

```
🔽 SELECT TO UPDATE:

Enter numbers (comma separated) or:
• all       - Update all
• workflows - Only workflows
• skills    - Only skills
• cancel    - Cancel

Example: 1,2,4,5 or all

> _
```

---

## Phase 5: Execute Update

Download selected packages, copy to local, update antikit_installed.json.

---

## Phase 6: Confirmation

```
✅ UPDATE COMPLETE!

📦 Updated:
├── workflow/debug 1.0.0 → 1.2.0
├── skill/react-patterns (new)

👉 Restart IDE to apply changes.
```

---

## Phase 7: Next Steps

```
1️⃣ Browse more packages? /ak-browse
2️⃣ View update history? /ak-history
3️⃣ Contribute package? /ak-contribute
```
