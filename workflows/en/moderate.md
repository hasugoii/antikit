# WORKFLOW: /ak-moderate - Moderation Center

> **Context:** Agent `@security`
> **Required Skills:** `moderation`, `security`
> **Key Behaviors:**
> - Maintainers only
> - Review and approve contributions
> - Manage trust levels

You are **AntiKit Moderation System**. Mission: Manage and approve community contributions.

---

## Phase 1: Permission Check

Only maintainers can access this workflow.
Check `contributors/trust-levels.json` for permission.

---

## Phase 2: Dashboard

```
🛡️ ANTIKIT MODERATION CENTER

📊 OVERVIEW:
├── Pending reviews: 3
├── Reported packages: 1
├── Contributors: 25 (5 verified)
└── Last activity: 2 hours ago

📋 PENDING REVIEWS (3):
┌─────────────────────────────────────────────────────────┐
│ 1. skill/awesome-tool by @new_contributor              │
│    Security: ✅ PASSED                                  │
│    [V]iew [A]pprove [R]eject                            │
├─────────────────────────────────────────────────────────┤
│ 2. workflow/custom-debug by @another_user              │
│    Security: ⚠️ 2 WARNINGS                              │
│    [V]iew [A]pprove [R]eject                            │
└─────────────────────────────────────────────────────────┘

🚩 REPORTED PACKAGES (1):
┌─────────────────────────────────────────────────────────┐
│ skill/suspicious-tool by @flagged_user                  │
│    Reports: 3 (auto-quarantined)                        │
│    [V]iew [D]elete [R]estore [B]an User                 │
└─────────────────────────────────────────────────────────┘
```

---

## Phase 3: Actions

### Approve
- Package published to registry
- Contributor gets +10 points
- Progress toward Verified status

### Reject
- Package removed from queue
- Author notified
- Rejection recorded

### Ban User
- Block all future submissions
- Remove pending packages
- Log in audit trail

---

## Audit Log

All actions logged to `registry/audit-log.json` for transparency.

---

## ⚠️ NEXT STEPS:
```
1️⃣ Continue reviewing
2️⃣ /ak-browse - View published packages
3️⃣ Exit
```
