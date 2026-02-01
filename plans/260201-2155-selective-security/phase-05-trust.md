# Phase 05: Trust System & Moderation

Trạng thái: ⬜ Chờ
Phụ thuộc: Phase 02 (Security)
Ước tính: 2 hours
Ưu tiên: P2-Medium (Community)

## Mục Tiêu

Implement contributor trust levels và community moderation system.

## Trust Levels

| Level | Requirements | Permissions |
|-------|--------------|-------------|
| 🆕 **New** | First submit | Queue → Manual review |
| ⭐ **Verified** | 5 approved + 0 rejected in last 10 | Auto-approve if scan passes |
| 👑 **Maintainer** | Core team | Instant publish + approve/reject |

## Yêu Cầu

### Chức Năng
- [ ] contributors/trust-levels.json schema
- [ ] Trust level calculation logic
- [ ] /ak-moderate workflow for maintainers
- [ ] /ak-report workflow for users
- [ ] Auto-quarantine on 3+ reports
- [ ] Audit log for all actions

### Phi Chức Năng
- Trust recalculated on each action
- Transparent audit log
- Appeal process for blocked users

## Các Bước Thực Hiện

| # | Task | Phụ thuộc | Ước tính | Trạng thái |
|---|------|-----------|----------|------------|
| 1 | Create trust-levels.json schema | - | 15m | ⬜ |
| 2 | Create /ak-moderate workflow (4 langs) | Task 1 | 30m | ⬜ |
| 3 | Create /ak-report workflow (4 langs) | - | 20m | ⬜ |
| 4 | Implement auto-quarantine logic | Task 3 | 20m | ⬜ |
| 5 | Create registry/audit-log.json | Task 1-4 | 15m | ⬜ |
| 6 | Update /ak-contribute with trust check | Task 1 | 20m | ⬜ |

## Trust Levels Schema

```json
{
  "version": "1.0.0",
  "contributors": {
    "hasugoii": {
      "level": "maintainer",
      "approved": 50,
      "rejected": 0,
      "reports_received": 0,
      "joined": "2026-01-20",
      "last_contribution": "2026-02-01",
      "badges": ["founder", "top-contributor"]
    },
    "new_user": {
      "level": "new",
      "approved": 0,
      "rejected": 0,
      "reports_received": 0,
      "joined": "2026-02-01",
      "pending_reviews": 1
    }
  },
  "blocked": {
    "malicious_user": {
      "reason": "Submitted malware",
      "blocked_date": "2026-01-25",
      "blocked_by": "hasugoii"
    }
  }
}
```

## Moderation Workflow UI

### `/ak-moderate` (Maintainer only)

```
🛡️ ANTIKIT MODERATION CENTER

📋 PENDING REVIEWS (3):
┌─────────────────────────────────────────────────────────┐
│ 1. skill/awesome-tool by @new_contributor              │
│    Submitted: 2 hours ago                               │
│    Security Scan: ✅ PASSED                             │
│    [View] [Approve] [Reject]                            │
├─────────────────────────────────────────────────────────┤
│ 2. workflow/custom-debug by @another_user              │
│    Submitted: 5 hours ago                               │
│    Security Scan: ⚠️ 2 WARNINGS                         │
│    Warnings: curl usage, file write                     │
│    [View] [Approve] [Reject]                            │
└─────────────────────────────────────────────────────────┘

🚩 REPORTED PACKAGES (1):
┌─────────────────────────────────────────────────────────┐
│ skill/suspicious-tool by @flagged_user                  │
│    Reports: 3 (auto-quarantined)                        │
│    Reasons: "Looks like malware", "Steals data"         │
│    [Review] [Restore] [Delete] [Ban User]               │
└─────────────────────────────────────────────────────────┘
```

### `/ak-report <package>`

```
🚩 REPORT PACKAGE

Package: skill/suspicious-tool
Author: @unknown_user

Why are you reporting this package?
1. Security concern (malware, data theft)
2. Inappropriate content
3. Low quality / doesn't work
4. Other

> 1

Please describe the issue:
> This skill seems to send my API keys to external server

✅ Report submitted. Maintainers will review.

If 3 or more users report this package, it will be
automatically quarantined pending review.
```

## Audit Log Schema

```json
{
  "entries": [
    {
      "timestamp": "2026-02-01T12:00:00Z",
      "action": "approve",
      "package": "skill/awesome-tool",
      "actor": "hasugoii",
      "reason": "Clean scan, useful content"
    },
    {
      "timestamp": "2026-02-01T11:00:00Z",
      "action": "quarantine",
      "package": "skill/suspicious-tool",
      "actor": "system",
      "reason": "3 community reports"
    }
  ]
}
```

## Tiêu Chí Test
- [ ] New contributor packages go to review queue
- [ ] Verified contributor packages auto-approve if scan passes
- [ ] 3 reports trigger auto-quarantine
- [ ] Maintainer can approve/reject/ban
- [ ] Audit log records all actions

---
Phase Tiếp Theo: [Phase 06 - Testing & Documentation](./phase-06-testing.md)
