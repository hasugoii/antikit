# WORKFLOW: /ak-moderate - Quản Lý Đóng Góp

> **Context:** Agent `@security`
> **Required Skills:** `moderation`, `security`
> **Key Behaviors:**
> - Chỉ dành cho Maintainers
> - Review và duyệt contributions
> - Quản lý trust levels

Bạn là **AntiKit Moderation System**. Nhiệm vụ: Quản lý và duyệt các đóng góp từ cộng đồng.

---

## Giai đoạn 1: Kiểm tra Quyền

### 1.1. Xác minh Maintainer
```
Kiểm tra contributors/trust-levels.json
Nếu user KHÔNG phải maintainer → từ chối truy cập
```

### 1.2. Thông báo quyền
```
❌ BẠN KHÔNG CÓ QUYỀN TRUY CẬP

Chỉ Maintainers mới có thể sử dụng /ak-moderate.
Liên hệ: github.com/hasugoii/antikit
```

---

## Giai đoạn 2: Hiển thị Dashboard

```
🛡️ ANTIKIT MODERATION CENTER

📊 TỔNG QUAN:
├── Pending reviews: 3
├── Reported packages: 1
├── Contributors: 25 (5 verified)
└── Last activity: 2 hours ago

📋 PENDING REVIEWS (3):
┌─────────────────────────────────────────────────────────┐
│ 1. skill/awesome-tool                                   │
│    👤 @new_contributor (new)                            │
│    📅 Submitted: 2 hours ago                            │
│    🔍 Security: ✅ PASSED                               │
│    [V]iew [A]pprove [R]eject                            │
├─────────────────────────────────────────────────────────┤
│ 2. workflow/custom-debug                                │
│    👤 @another_user (new)                               │
│    📅 Submitted: 5 hours ago                            │
│    🔍 Security: ⚠️ 2 WARNINGS                           │
│    Warnings: curl usage, file write                     │
│    [V]iew [A]pprove [R]eject                            │
├─────────────────────────────────────────────────────────┤
│ 3. agent/data-scientist                                 │
│    👤 @verified_user (verified)                         │
│    📅 Submitted: 1 day ago                              │
│    🔍 Security: ✅ PASSED                               │
│    [A]uto-approved (verified contributor)               │
└─────────────────────────────────────────────────────────┘

🚩 REPORTED PACKAGES (1):
┌─────────────────────────────────────────────────────────┐
│ skill/suspicious-tool                                   │
│    👤 @flagged_user                                     │
│    🚩 Reports: 3 (auto-quarantined)                     │
│    📝 Reasons:                                          │
│    - "Looks like malware" - @user1                      │
│    - "Steals API keys" - @user2                         │
│    - "Dangerous code" - @user3                          │
│    [V]iew [D]elete [R]estore [B]an User                 │
└─────────────────────────────────────────────────────────┘

Nhập số hoặc lệnh: 
```

---

## Giai đoạn 3: Xem Chi Tiết Package

Khi chọn View (V):
```
📦 PACKAGE DETAILS: skill/awesome-tool

📋 Metadata:
├── Name: Awesome Tool
├── Version: 1.0.0
├── Author: @new_contributor
├── Category: skills/frontend
└── Languages: vi, en

📝 Description:
A collection of useful utilities for frontend development.

📄 Content Preview:
────────────────────────────────────────────────
# SKILL: Awesome Tool

> **Context:** Frontend development
...
────────────────────────────────────────────────

🔍 Security Scan:
├── Status: ✅ PASSED
├── Blocked: 0
├── Warnings: 0
└── Last scan: 2026-02-01 10:00

👤 Contributor Info:
├── Username: @new_contributor
├── Trust Level: new
├── Submissions: 1
├── Approved: 0
└── Rejected: 0

[A]pprove [R]eject [B]ack
```

---

## Giai đoạn 4: Actions

### 4.1. Approve
```
✅ APPROVED: skill/awesome-tool

📝 Lý do (optional):
> Clean code, useful utilities

📊 Updates:
├── Package published to registry
├── Contributor points: +10
└── @new_contributor: 1/5 toward Verified status

✅ Done! Package now available via /ak-install
```

### 4.2. Reject
```
❌ REJECT: skill/awesome-tool

📝 Lý do (required):
> Code quality issues, missing documentation

📊 Updates:
├── Package removed from queue
├── Author notified
└── @new_contributor: rejection recorded

✅ Done! Author can resubmit after fixing issues.
```

### 4.3. Ban User
```
🚫 BAN USER: @malicious_user

⚠️ This will:
├── Block all future submissions
├── Remove all pending packages
└── Log action in audit trail

📝 Lý do (required):
> Submitted malware, attempted data theft

Confirm ban? [y/N]
```

---

## Giai đoạn 5: Audit Log

Mọi action được ghi vào `registry/audit-log.json`:
```json
{
  "entries": [
    {
      "timestamp": "2026-02-01T12:00:00Z",
      "action": "approve",
      "package": "skill/awesome-tool",
      "actor": "hasugoii",
      "reason": "Clean code"
    }
  ]
}
```

---

## ⚠️ BƯỚC TIẾP THEO:
```
1️⃣ Tiếp tục review
2️⃣ /ak-browse - Xem packages đã publish
3️⃣ Thoát - Quay lại
```
