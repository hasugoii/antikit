# Plan: AntiKit v1.4.0 - Selective Updates & Security System

Tạo: 2026-02-01 21:55
Trạng thái: 🟡 Đang Lập Kế Hoạch

## Tổng Quan

Xây dựng hệ thống update linh hoạt và an toàn cho AntiKit:
1. **Selective Updates** - User chọn packages theo nhu cầu
2. **Mandatory Core** - Security patches tự động install
3. **Content Moderation** - Ngăn chặn community contributions độc hại

## Tech Stack
- Scripts: PowerShell (Windows), Bash (macOS/Linux)
- Registry: JSON files
- CI/CD: GitHub Actions
- Validation: JSON Schema

## Các Phase

| Phase | Tên | Trạng thái | Tiến độ | Ước tính |
|-------|-----|------------|---------|----------|
| 01 | Registry Schema Enhancement | ⬜ Chờ | 0% | 2h |
| 02 | Security Scanning System | ⬜ Chờ | 0% | 3h |
| 03 | Selective Install Workflow | ⬜ Chờ | 0% | 3h |
| 04 | Mandatory Update Tiers | ⬜ Chờ | 0% | 2h |
| 05 | Trust System & Moderation | ⬜ Chờ | 0% | 2h |
| 06 | Testing & Documentation | ⬜ Chờ | 0% | 2h |

**Tổng ước tính:** 14 hours (~2-3 sessions)

## Dependencies Map

```
Phase 1 (Registry) ─┬─► Phase 2 (Security) ─► Phase 5 (Trust)
                    │
                    └─► Phase 3 (Install) ─► Phase 4 (Tiers)
                                                    │
                                                    └─► Phase 6 (Test)
```

## Lệnh Nhanh
- Bắt đầu Phase 1: `/code phase-01`
- Kiểm tra tiến độ: `/next`
- Lưu context: `/save-brain`

## Files Tổng Quan

### Mới tạo
- `schemas/security-patterns.json` - Blocked/warning patterns
- `registry/packages/` - Individual package metadata
- `contributors/trust-levels.json` - Trust system
- `workflows/*/install.md` - New `/ak-install` workflow
- `workflows/*/moderate.md` - New `/ak-moderate` workflow
- `.github/workflows/security-scan.yml` - CI check

### Sửa đổi
- `registry/index.json` - Add categories, tiers
- `install.ps1` / `install.sh` - Add --package flag
- `workflows/*/ak-update.md` - Add tier selection
- `workflows/*/contribute.md` - Add security scan before submit
