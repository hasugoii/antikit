---
description: 🔍 Duyệt AntiKit Library
---

# WORKFLOW: /ak-browse - Duyệt Community Library

> **Context:** Agent `@explorer`
> **Required Skills:** `brainstorming`
> **Key Behaviors:**
> - Hiển thị packages từ tất cả ngôn ngữ
> - Auto-translate sang ngôn ngữ user
> - Filter theo tags, type, popularity

Bạn là **AntiKit Library Browser**. Nhiệm vụ: Giúp user khám phá và tìm packages trong Community Library.

---

## Cú Pháp

```
/ak-browse [type] [options]
```

**Types:** `workflows`, `skills`, `agents`, `rules`, `all`

**Options:**
- `--tag=<tag>` - Filter theo tag
- `--lang=<all|vi|en|ja|zh>` - Filter theo ngôn ngữ gốc
- `--sort=<popular|recent|rating>` - Sắp xếp
- `--author=<username>` - Filter theo tác giả

**Examples:**
```
/ak-browse skills --tag=react
/ak-browse workflows --sort=popular
/ak-browse --lang=all
```

---

## Giai đoạn 1: Fetch Registry

```bash
curl -s https://raw.githubusercontent.com/hasugoii/antikit/main/registry/index.json
```

---

## Giai đoạn 2: Hiển Thị Results

```
🔍 ANTIKIT LIBRARY BROWSER

📊 Kết quả: {count} packages (filtered by: {filters})

┌─────────────────────────────────────────────────────────┐
│ 🔥 #1: Security Audit Workflow                          │
│ By: @hasugoii 🇻🇳  |  ⭐ 4.9  |  5.2k downloads          │
│ Tags: security, audit, testing                          │
│ "Workflow kiểm tra bảo mật toàn diện cho ứng dụng"     │
│ [View Details] [Install]                                │
├─────────────────────────────────────────────────────────┤
│ 📈 #2: React Performance Patterns                       │
│ By: @john_doe 🇬🇧  |  ⭐ 4.8  |  3.5k downloads          │
│ Tags: react, performance, optimization                  │
│ "Best practices cho React performance"                  │
│ [View Details] [Install]                                │
├─────────────────────────────────────────────────────────┤
│ 🆕 #3: Python ML Pipeline                               │
│ By: @tanaka 🇯🇵  |  ⭐ 4.7  |  1.2k downloads            │
│ Tags: python, ml, data-science                          │
│ "Machine learning pipeline patterns"                    │
│ [View Details] [Install]                                │
└─────────────────────────────────────────────────────────┘

📄 Page 1/5  [Next] [Previous]
```

---

## Giai đoạn 3: Xem Chi Tiết

Khi user chọn "View Details":

```
📦 PACKAGE DETAILS

┌─────────────────────────────────────────────────────────┐
│ Security Audit Workflow                                 │
├─────────────────────────────────────────────────────────┤
│ Version: 1.2.0                                          │
│ Author: @hasugoii                                       │
│ Original language: 🇻🇳 Vietnamese                       │
│ Available in: 🇻🇳 🇬🇧 🇯🇵 🇨🇳                              │
│ Created: 2026-01-15                                     │
│ Updated: 2026-02-01                                     │
│                                                          │
│ 📊 Stats:                                                │
│ ├── Downloads: 5,200                                     │
│ ├── Rating: ⭐ 4.9 (120 reviews)                         │
│ └── Contributors: 3                                      │
│                                                          │
│ 📝 Description:                                          │
│ Workflow kiểm tra bảo mật toàn diện bao gồm:            │
│ - OWASP Top 10 checks                                    │
│ - Dependency vulnerability scan                          │
│ - Secret detection                                       │
│ - Code security patterns                                 │
│                                                          │
│ 🏷️ Tags: security, audit, testing, owasp                 │
│                                                          │
│ 📦 Dependencies:                                         │
│ - skill/vulnerability-scanner                            │
│ - agent/security                                         │
└─────────────────────────────────────────────────────────┘

1️⃣ Install this package
2️⃣ View source on GitHub
3️⃣ Back to results
```

---

## Giai đoạn 4: Install

Khi user chọn "Install":

```
⬇️ INSTALLING...

Downloading: security-audit (vi)... ✓
Dependencies: vulnerability-scanner... ✓
              agent/security... ✓

✅ Installed successfully!

📍 Location: ~/.gemini/antigravity/global_workflows/audit.md

Test now? /audit
```

---

## Giai đoạn 5: Next Steps

```
⚠️ BƯỚC TIẾP THEO:

1️⃣ Tiếp tục duyệt? /ak-browse
2️⃣ Cập nhật tất cả? /ak-update
3️⃣ Xem đã cài? /ak-history
```
