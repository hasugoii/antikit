# BRIEF: AntiKit v1.4.0 - Selective Updates & Security System

## 🎯 Mục Tiêu
1. **Selective Updates** - User chọn packages theo nhu cầu, không bắt buộc download all
2. **Mandatory Core** - Security patches và critical fixes tự động install
3. **Content Moderation** - Ngăn chặn community contributions độc hại

---

## 📦 Feature 1: Selective Update System

### Commands Mới
| Command | Mô tả |
|---------|-------|
| `/ak-install <type>/<name>` | Install single package |
| `/ak-install --category=<cat>` | Install theo category |
| `/ak-install --preset=<name>` | Install preset bundle |
| `/ak-uninstall <type>/<name>` | Gỡ package |

### Categories
- `workflows/` - Workflow files
- `skills/` - SKILL.md files  
- `agents/` - Agent personas
- `rules/` - Custom rules

### Update Tiers
| Tier | Loại | Behavior |
|------|------|----------|
| CRITICAL | Security patches, malware fixes | **Auto-install**, không thể skip |
| RECOMMENDED | Core improvements | Prompt với default Y |
| OPTIONAL | Community packages | User chọn |

---

## 🛡️ Feature 2: Security System

### Layer 1: Automated Scanning

**Blocked Patterns (reject ngay):**
```
# External execution
❌ curl | wget + pipe to bash/sh
❌ Invoke-WebRequest + Invoke-Expression
❌ eval(), exec() với user input
❌ subprocess.run() với shell=True

# File system dangers
❌ Access $HOME, /etc, C:\Windows, C:\Users
❌ rm -rf, del /s /q, Remove-Item -Recurse -Force
❌ Format-Volume, diskpart

# Data exfiltration
❌ curl/wget POST với file content
❌ Base64 encoded commands
❌ Obfuscated variable names
```

**Warning Patterns (flag nhưng cho qua với review):**
```
⚠️ curl/wget GET (download resources)
⚠️ Network requests có logging
⚠️ File read/write trong project dir
```

### Layer 2: Contributor Trust System

| Level | Requirements | Permissions |
|-------|--------------|-------------|
| 🆕 **New** | First submit | Queue → Manual review |
| ⭐ **Verified** | 5 approved + 0 rejected | Auto-approve nếu scan pass |
| 👑 **Maintainer** | Core team member | Instant publish + approve others |

### Layer 3: Community Moderation

- **Report Button**: `/ak-report <package>` với lý do
- **Auto-quarantine**: 3+ reports → disable package, notify maintainer
- **Blocklist**: Banned contributors cannot submit
- **Audit Log**: `registry/audit-log.json` - public transparency

---

## 🏗️ Implementation Plan

### Phase 1: Selective Install (Priority: HIGH)
**Files:**
- [ ] `workflows/*/browse.md` - Add install single package
- [ ] `registry/index.json` - Add categories, dependencies
- [ ] `install.ps1/sh` - Add `--package` flag
- [ ] NEW: `/ak-install` workflow

### Phase 2: Security Scanning (Priority: CRITICAL)
**Files:**
- [ ] `schemas/security-patterns.json` - Blocked patterns
- [ ] `scripts/security-scan.ps1` - Windows scanner
- [ ] `scripts/security-scan.sh` - Unix scanner
- [ ] `.github/workflows/security-check.yml` - CI check

### Phase 3: Trust System (Priority: MEDIUM)
**Files:**
- [ ] `contributors/trust-levels.json` - Trust data
- [ ] `registry/approval-queue.json` - Pending reviews
- [ ] NEW: `/ak-moderate` workflow - Admin moderation
- [ ] UPDATE: `/ak-contribute` - Add scan before submit

---

## 📊 Defaults Đã Chọn

| Question | Default |
|----------|---------|
| Selective scope | Individual package level |
| Dependencies | Auto-install with confirmation |
| External URLs | Block by default, whitelist GitHub raw |
| curl/wget | Block with pipe, warn without |
| Trust threshold | 5 successful contributions |
| Verified auto-publish | Yes, if scan passes |
| Core maintainers | hasugoii only (expandable) |
| Community moderators | Not yet, future feature |

---

## ⚠️ Bước Tiếp Theo

```
1️⃣ /plan - Thiết kế chi tiết implementation
2️⃣ Điều chỉnh - Sửa BRIEF trước khi plan
3️⃣ Tạm hoãn - Lưu ý tưởng, làm sau
```
