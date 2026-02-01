# Phase 03: Selective Install Workflow

Trạng thái: ⬜ Chờ
Phụ thuộc: Phase 01 (Registry)
Ước tính: 3 hours
Ưu tiên: P1-High (Core Feature)

## Mục Tiêu

Tạo workflow `/ak-install` cho phép user cài đặt individual packages thay vì download all.

## Yêu Cầu

### Chức Năng
- [ ] `/ak-install <type>/<name>` - Install single package
- [ ] `/ak-install --category=<cat>` - Install by category
- [ ] `/ak-uninstall <type>/<name>` - Remove package
- [ ] `/ak-list` - List installed packages
- [ ] Dependency resolution
- [ ] Update antikit_installed.json

### Phi Chức Năng
- Install single package < 10 seconds
- Clear success/failure feedback
- Works offline với cache

## Các Bước Thực Hiện

| # | Task | Phụ thuộc | Ước tính | Trạng thái |
|---|------|-----------|----------|------------|
| 1 | Create /ak-install workflow (4 langs) | Registry | 45m | ⬜ |
| 2 | Create /ak-uninstall workflow (4 langs) | Task 1 | 30m | ⬜ |
| 3 | Create /ak-list workflow (4 langs) | - | 20m | ⬜ |
| 4 | Add --package flag to install.ps1 | Task 1 | 30m | ⬜ |
| 5 | Add --package flag to install.sh | Task 1 | 30m | ⬜ |
| 6 | Implement dependency resolution | Task 4,5 | 30m | ⬜ |

## Workflow UI Design

### `/ak-install skill/react-patterns`

```
📦 ANTIKIT PACKAGE INSTALLER

Installing: skill/react-patterns v2.0.0

📋 Dependencies detected:
├── skill/typescript-expert (required)
└── skill/clean-code (optional)

Install dependencies too? [Y/n]

⬇️ Downloading...
├── react-patterns... ✓
├── typescript-expert... ✓
└── clean-code... ✓

✅ Installed 3 packages successfully!

📍 Locations:
├── ~/.gemini/antigravity/skills/react-patterns/
├── ~/.gemini/antigravity/skills/typescript-expert/
└── ~/.gemini/antigravity/skills/clean-code/

Test now? type `/recap` to try
```

### `/ak-install --category=security`

```
📦 ANTIKIT CATEGORY INSTALLER

Category: security

📋 Available packages (5):
├── [ ] skill/vulnerability-scanner v1.2
├── [ ] skill/red-team-tactics v1.0
├── [ ] agent/pentester v1.1
├── [ ] agent/security v1.0
└── [ ] workflow/audit v1.3

Select packages: (enter numbers, 'all', or 'cancel')
> 1,2,3

⬇️ Installing selected...
✅ Installed 3/3 packages!
```

## Tiêu Chí Test
- [ ] Single package installs correctly
- [ ] Dependencies prompt appears
- [ ] Category filter shows correct packages
- [ ] antikit_installed.json updates correctly
- [ ] Uninstall removes files

---
Phase Tiếp Theo: [Phase 04 - Mandatory Tiers](./phase-04-tiers.md)
