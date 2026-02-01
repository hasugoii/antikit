# Phase 06: Testing & Documentation

Trạng thái: ⬜ Chờ
Phụ thuộc: Phase 01-05 (All)
Ước tính: 2 hours
Ưu tiên: P1-High (Quality)

## Mục Tiêu

Comprehensive testing và documentation cho v1.4.0 features.

## Yêu Cầu

### Chức Năng
- [ ] Security scanner test suite
- [ ] Workflow integration tests
- [ ] Update README với new commands
- [ ] Update CHANGELOG
- [ ] Bump version to 1.4.0

### Phi Chức Năng
- 100% coverage cho security patterns
- Clear user documentation
- Migration guide từ v1.3.x

## Các Bước Thực Hiện

| # | Task | Phụ thuộc | Ước tính | Trạng thái |
|---|------|-----------|----------|------------|
| 1 | Create security scanner tests | Phase 2 | 30m | ⬜ |
| 2 | Create malicious test files | Task 1 | 15m | ⬜ |
| 3 | Test all new workflows manually | Phase 3-5 | 30m | ⬜ |
| 4 | Update README files (4 langs) | All | 20m | ⬜ |
| 5 | Update CHANGELOG.md | All | 10m | ⬜ |
| 6 | Bump VERSION to 1.4.0 | Task 5 | 5m | ⬜ |

## Test Files

### Security Scanner Tests

```
tests/security/
├── should-block/
│   ├── curl-pipe-bash.md        # curl | bash
│   ├── wget-pipe-sh.md          # wget | sh
│   ├── rm-rf-home.md            # rm -rf ~
│   ├── del-system32.md          # del C:\Windows
│   ├── base64-decode.md         # base64 -d
│   └── powershell-iex.md        # iwr | iex
├── should-warn/
│   ├── curl-download.md         # curl without pipe
│   ├── file-write.md            # fs.writeFile
│   └── network-fetch.md         # fetch()
└── should-pass/
    ├── clean-workflow.md        # Normal workflow
    ├── github-curl.md           # curl github.com/hasugoii/antikit
    └── internal-scripts.md      # Script references
```

### Test Commands

```powershell
# Windows - Run security scanner tests
.\scripts\security-scan.ps1 -TestMode

# Expected output:
# Testing should-block files... 6/6 BLOCKED ✓
# Testing should-warn files... 3/3 WARNED ✓
# Testing should-pass files... 3/3 PASSED ✓
# All tests passed!
```

```bash
# macOS/Linux - Run security scanner tests
./scripts/security-scan.sh --test

# Expected output same as above
```

## Manual Testing Checklist

### Selective Install
- [ ] `/ak-install skill/react-patterns` installs single package
- [ ] Dependencies prompt appears
- [ ] `/ak-uninstall skill/react-patterns` removes package
- [ ] `/ak-list` shows installed packages

### Update Tiers
- [ ] Critical updates auto-install
- [ ] Recommended updates prompt [Y/n]
- [ ] Optional updates prompt [y/N]

### Trust System
- [ ] New contributor goes to review queue
- [ ] `/ak-report` submits report
- [ ] `/ak-moderate` shows pending reviews (maintainer only)

## Documentation Updates

### README.md additions

```markdown
## New in v1.4.0

### Selective Package Installation
```bash
# Install specific package
/ak-install skill/react-patterns

# Install by category
/ak-install --category=security

# Remove package
/ak-uninstall skill/react-patterns
```

### Security & Trust System
- All community contributions automatically scanned
- Trust levels: New → Verified → Maintainer
- Report suspicious packages: `/ak-report <package>`
```

### CHANGELOG.md entry

```markdown
## [1.4.0] - 2026-02-XX

### 📦 Selective Update System
- `/ak-install` - Install individual packages
- `/ak-uninstall` - Remove packages
- `/ak-list` - List installed packages
- Category and tag filtering

### 🛡️ Security System
- Automated security scanning for all contributions
- Blocked patterns: curl pipe, rm -rf, base64 decode, etc.
- Warning patterns: network requests, file writes

### 👥 Trust System
- Contributor trust levels: New → Verified → Maintainer
- Auto-approve for verified contributors
- Community reporting and moderation
- Audit log for transparency

### ⚡ Mandatory Update Tiers
- CRITICAL: Auto-install security patches
- RECOMMENDED: Prompt with default Yes
- OPTIONAL: User choice
```

## Tiêu Chí Hoàn Thành
- [ ] All security scanner tests pass
- [ ] Manual workflow tests pass
- [ ] All 4 language READMEs updated
- [ ] CHANGELOG updated
- [ ] VERSION bumped to 1.4.0
- [ ] Git commit with proper message

---
🎉 **Plan Complete!**
