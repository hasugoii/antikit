# Phase 04: Mandatory Update Tiers

Trạng thái: ⬜ Chờ
Phụ thuộc: Phase 03 (Install)
Ước tính: 2 hours
Ưu tiên: P1-High (Security)

## Mục Tiêu

Implement 3-tier update system:
- CRITICAL: Auto-install, không thể skip
- RECOMMENDED: Prompt với default Yes
- OPTIONAL: User chọn

## Yêu Cầu

### Chức Năng
- [ ] Classify packages into tiers
- [ ] Force install critical updates
- [ ] Prompt for recommended updates
- [ ] Show optional updates separately
- [ ] Update /ak-update workflow

### Phi Chức Năng
- Critical updates bypass user confirmation
- Clear visual distinction between tiers
- Audit log for critical installs

## Các Bước Thực Hiện

| # | Task | Phụ thuộc | Ước tính | Trạng thái |
|---|------|-----------|----------|------------|
| 1 | Update registry with tier field | Registry | 20m | ⬜ |
| 2 | Modify /ak-update UI for tiers | Task 1 | 45m | ⬜ |
| 3 | Implement auto-install for CRITICAL | Task 2 | 30m | ⬜ |
| 4 | Add tier icons and messaging | Task 2 | 15m | ⬜ |
| 5 | Update all 4 language versions | Task 2-4 | 30m | ⬜ |

## Update UI Design

```
📦 ANTIKIT UPDATE CENTER

🔴 CRITICAL UPDATES (Auto-installing...)
├── ⚠️ Security Patch v1.3.2 - Fixing malicious pattern bypass
│   └── Installing... ✓
└── ⚠️ Urgent Fix v1.3.1 - Installer missing workflows
    └── Already installed ✓

🟡 RECOMMENDED UPDATES (Install? [Y/n])
├── [ ] workflow/debug 1.2.0 → 1.3.0 ⭐ New 5-Whys Analysis
├── [ ] workflow/code 1.2.1 → 1.3.0 ⭐ Breaking Change Detection
└── [ ] skill/react-patterns 2.0 → 2.1 📈 Performance improvements

🟢 OPTIONAL UPDATES (Install? [y/N])
├── [ ] skill/vue-patterns v1.0 (new)
├── [ ] agent/data-scientist v1.0 (new)
└── [ ] 15 more packages available...

> Enter: y, n, or package numbers
```

## Tier Classification Rules

```json
{
  "critical": {
    "triggers": [
      "Security vulnerability fix",
      "Malware removal",
      "Data corruption fix",
      "Breaking compatibility fix"
    ],
    "behavior": "auto-install",
    "notification": "⚠️ Critical update applied automatically"
  },
  "recommended": {
    "triggers": [
      "Core workflow improvements",
      "New major features",
      "Performance improvements",
      "Bug fixes"
    ],
    "behavior": "prompt-default-yes",
    "notification": "Install recommended updates? [Y/n]"
  },
  "optional": {
    "triggers": [
      "Community packages",
      "Experimental features",
      "Language-specific tools"
    ],
    "behavior": "prompt-default-no",
    "notification": "X optional packages available. Install? [y/N]"
  }
}
```

## Tiêu Chí Test
- [ ] Critical updates install without prompt
- [ ] Recommended updates prompt with default Y
- [ ] Optional updates prompt with default N
- [ ] User can skip recommended but not critical
- [ ] Audit log records all critical installs

---
Phase Tiếp Theo: [Phase 05 - Trust System](./phase-05-trust.md)
