# Phase 02: Security Scanning System

Trạng thái: ⬜ Chờ
Phụ thuộc: Phase 01 (Registry)
Ước tính: 3 hours
Ưu tiên: P0-Critical (Security)

## Mục Tiêu

Xây dựng hệ thống scanning tự động để phát hiện và chặn community contributions độc hại.

## Yêu Cầu

### Chức Năng
- [ ] Define blocked patterns (reject ngay)
- [ ] Define warning patterns (flag for review)
- [ ] Create PowerShell scanner script
- [ ] Create Bash scanner script
- [ ] Create GitHub Actions workflow
- [ ] Integrate into /ak-contribute workflow

### Phi Chức Năng
- Scan time < 5 seconds per file
- Zero false negatives cho critical patterns
- < 10% false positives cho warnings

## Các Bước Thực Hiện

| # | Task | Phụ thuộc | Ước tính | Trạng thái |
|---|------|-----------|----------|------------|
| 1 | Define security patterns JSON | - | 30m | ⬜ |
| 2 | Create PowerShell scanner | Task 1 | 45m | ⬜ |
| 3 | Create Bash scanner | Task 1 | 45m | ⬜ |
| 4 | Create GitHub Actions workflow | Task 2,3 | 30m | ⬜ |
| 5 | Update /ak-contribute workflow | Task 2,3 | 30m | ⬜ |

## Files Cần Tạo/Sửa

### Tạo mới
- `schemas/security-patterns.json` - Pattern definitions
- `scripts/security-scan.ps1` - Windows scanner
- `scripts/security-scan.sh` - Unix scanner
- `.github/workflows/security-scan.yml` - CI check

### Sửa đổi
- `workflows/*/contribute.md` - Add scan step

## Security Patterns Design

```json
{
  "version": "1.0.0",
  "blocked": {
    "external_execution": [
      "curl.*\\|.*bash",
      "wget.*\\|.*sh",
      "Invoke-WebRequest.*Invoke-Expression",
      "iwr.*iex",
      "eval\\s*\\(",
      "exec\\s*\\("
    ],
    "filesystem_danger": [
      "rm\\s+-rf\\s+/",
      "rm\\s+-rf\\s+~",
      "del\\s+/s\\s+/q\\s+C:",
      "Remove-Item.*-Recurse.*-Force.*(\\$HOME|\\$env:)",
      "Format-Volume",
      "diskpart"
    ],
    "data_exfiltration": [
      "curl.*-X\\s+POST.*-d.*\\$\\(",
      "base64\\s+-d",
      "\\[Convert\\]::FromBase64String"
    ],
    "system_access": [
      "/etc/passwd",
      "/etc/shadow",
      "C:\\\\Windows\\\\System32",
      "\\$env:APPDATA",
      "\\$HOME/\\.ssh"
    ]
  },
  "warning": {
    "network_requests": [
      "curl\\s+",
      "wget\\s+",
      "Invoke-WebRequest",
      "fetch\\s*\\("
    ],
    "file_operations": [
      "writeFile",
      "fs\\.write",
      "Set-Content",
      "Out-File"
    ]
  },
  "whitelist": {
    "domains": [
      "raw.githubusercontent.com/hasugoii/antikit",
      "github.com/hasugoii/antikit"
    ]
  }
}
```

## PowerShell Scanner Pseudocode

```powershell
function Scan-SecurityPatterns {
    param([string]$FilePath)
    
    $patterns = Get-Content "schemas/security-patterns.json" | ConvertFrom-Json
    $content = Get-Content $FilePath -Raw
    $issues = @()
    
    # Check blocked patterns
    foreach ($category in $patterns.blocked.PSObject.Properties) {
        foreach ($pattern in $category.Value) {
            if ($content -match $pattern) {
                $issues += @{
                    Severity = "BLOCKED"
                    Category = $category.Name
                    Pattern = $pattern
                    Line = (Find-LineNumber $content $pattern)
                }
            }
        }
    }
    
    # Check warning patterns
    foreach ($category in $patterns.warning.PSObject.Properties) {
        foreach ($pattern in $category.Value) {
            if ($content -match $pattern) {
                # Check if whitelisted
                if (-not (Is-Whitelisted $content $pattern $patterns.whitelist)) {
                    $issues += @{
                        Severity = "WARNING"
                        Category = $category.Name
                        Pattern = $pattern
                    }
                }
            }
        }
    }
    
    return $issues
}
```

## Tiêu Chí Test

- [ ] Blocked patterns correctly reject test malicious file
- [ ] Warning patterns correctly flag suspicious file
- [ ] Whitelist allows approved domains
- [ ] Scanner runs in < 5 seconds
- [ ] GitHub Actions workflow triggers on PR

## Test Files Cần Tạo

```
tests/
├── security/
│   ├── malicious-curl-pipe.md      # Should BLOCK
│   ├── malicious-rm-rf.md          # Should BLOCK
│   ├── suspicious-network.md       # Should WARN
│   ├── safe-workflow.md            # Should PASS
│   └── whitelisted-curl.md         # Should PASS (whitelist)
```

## Rủi Ro & Blockers

| Rủi ro | Xác suất | Ảnh hưởng | Giải pháp |
|--------|----------|-----------|-----------|
| False positives | Trung bình | Thấp | Whitelist + warning tier |
| Regex performance | Thấp | Trung bình | Limit file size scan |
| Bypass via encoding | Trung bình | Cao | Block base64 decoding |

---
Phase Tiếp Theo: [Phase 03 - Selective Install](./phase-03-install.md)
