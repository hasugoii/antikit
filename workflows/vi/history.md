---
description: 📜 Lịch sử cập nhật AntiKit
---

# WORKFLOW: /ak-history - Lịch Sử Update

> **Context:** Agent `@orchestrator`
> **Required Skills:** `documentation-templates`
> **Key Behaviors:**
> - Hiển thị lịch sử update
> - Cho phép rollback
> - Track contributions

Bạn là **AntiKit History Tracker**. Nhiệm vụ: Hiển thị và quản lý lịch sử cập nhật packages.

---

## Cú Pháp

```
/ak-history [options]
```

**Options:**
- `--days=<n>` - Hiển thị n ngày gần nhất
- `--type=<update|install|contribute>` - Filter theo loại
- `--package=<name>` - Xem history của package cụ thể

---

## Giai đoạn 1: Đọc History File

```bash
cat ~/.gemini/antikit_installed.json
```

---

## Giai đoạn 2: Hiển Thị Timeline

```
📜 ANTIKIT UPDATE HISTORY

┌─────────────────────────────────────────────────────────┐
│ 📅 2026-02-01 16:05                                     │
│ ├── ⬆️ UPDATE: workflow/debug 1.0.0 → 1.2.0            │
│ ├── ⬆️ UPDATE: workflow/code 1.1.0 → 1.2.1             │
│ ├── 📦 INSTALL: skill/react-patterns v2.0 (new)        │
│ └── 📦 INSTALL: skill/nextjs-expert v1.5 (new)         │
├─────────────────────────────────────────────────────────┤
│ 📅 2026-01-28 09:30                                     │
│ ├── 📦 INSTALL: agent/pentester v1.0 (new)             │
│ └── 📦 INSTALL: skill/vulnerability-scanner v1.0       │
├─────────────────────────────────────────────────────────┤
│ 📅 2026-01-25 14:00                                     │
│ ├── 🎉 CONTRIBUTE: workflow/my-custom-debug            │
│ │   └── Points earned: +100                             │
│ └── ⬆️ CORE UPDATE: v1.1.0 → v1.2.0                    │
└─────────────────────────────────────────────────────────┘

📊 Thống kê:
├── Tổng updates: 15
├── Packages installed: 45
├── Contributions: 3
└── Points earned: 350
```

---

## Giai đoạn 3: Xem Chi Tiết Entry

Khi user chọn một entry:

```
📋 CHI TIẾT UPDATE

┌─────────────────────────────────────────────────────────┐
│ workflow/debug 1.0.0 → 1.2.0                            │
├─────────────────────────────────────────────────────────┤
│ Date: 2026-02-01 16:05                                  │
│ Type: Update                                            │
│ Source: https://github.com/hasugoii/antikit             │
│                                                          │
│ 📝 Changes:                                              │
│ - Added 5 Whys Root Cause Analysis                       │
│ - Added Bug Severity Classification                      │
│ - Enhanced session.json logging                          │
│                                                          │
│ 📄 Files changed:                                        │
│ ~/.gemini/antigravity/global_workflows/debug.md          │
└─────────────────────────────────────────────────────────┘

1️⃣ Rollback to previous version (1.0.0)
2️⃣ View current file
3️⃣ Back to history
```

---

## Giai đoạn 4: Rollback (nếu chọn)

```
⚠️ ROLLBACK CONFIRMATION

Bạn muốn rollback:
- Package: workflow/debug
- From: 1.2.0
- To: 1.0.0

⚠️ Lưu ý: Rollback sẽ mất các tính năng mới.

Tiếp tục? [y/N]
```

Nếu confirm:
```
⏪ ROLLING BACK...

Downloading: workflow/debug v1.0.0... ✓
Replacing current version... ✓
Updating history... ✓

✅ Rollback complete!

Package workflow/debug is now at v1.0.0
```

---

## Giai đoạn 5: Next Steps

```
⚠️ BƯỚC TIẾP THEO:

1️⃣ Cập nhật packages? /ak-update
2️⃣ Duyệt library? /ak-browse
3️⃣ Xem profile? /ak-profile
```
