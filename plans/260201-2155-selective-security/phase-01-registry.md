# Phase 01: Registry Schema Enhancement

Trạng thái: ⬜ Chờ
Phụ thuộc: None (Base phase)
Ước tính: 2 hours
Ưu tiên: P0-Critical (Foundation)

## Mục Tiêu

Mở rộng registry schema để hỗ trợ:
- Package categories (workflows, skills, agents, rules)
- Update tiers (critical, recommended, optional)
- Package dependencies
- Installation status tracking

## Yêu Cầu

### Chức Năng
- [x] Define package categories
- [ ] Add tier field to packages
- [ ] Add dependencies field
- [ ] Create package metadata structure
- [ ] Update antikit_installed.json schema

### Phi Chức Năng
- Schema backwards compatible với v1.3.x
- Valid JSON Schema for validation

## Các Bước Thực Hiện

| # | Task | Phụ thuộc | Ước tính | Trạng thái |
|---|------|-----------|----------|------------|
| 1 | Design registry/index.json schema | - | 20m | ⬜ |
| 2 | Create registry/packages/ directory | - | 5m | ⬜ |
| 3 | Create sample package metadata | Task 1 | 15m | ⬜ |
| 4 | Update antikit_installed.json schema | Task 1 | 15m | ⬜ |
| 5 | Create schemas/package.schema.json | Task 1-4 | 30m | ⬜ |
| 6 | Migrate existing workflows to new format | Task 5 | 30m | ⬜ |

## Files Cần Tạo/Sửa

### Tạo mới
- `schemas/package.schema.json` - Package validation schema
- `registry/packages/` - Directory for package metadata
- `registry/packages/workflow-debug.json` - Sample package

### Sửa đổi
- `registry/index.json` - Add new schema fields

## Registry Schema Design

```json
{
  "version": "2.0.0",
  "updated": "2026-02-01",
  "tiers": {
    "critical": {
      "description": "Security patches, malware fixes",
      "behavior": "auto-install",
      "packages": []
    },
    "recommended": {
      "description": "Core improvements",
      "behavior": "prompt-yes",
      "packages": []
    },
    "optional": {
      "description": "Community packages",
      "behavior": "user-choice",
      "packages": []
    }
  },
  "categories": {
    "workflows": [],
    "skills": [],
    "agents": [],
    "rules": []
  },
  "packages": {
    "workflow/debug": {
      "name": "Debug Workflow",
      "version": "1.2.0",
      "tier": "recommended",
      "category": "workflows",
      "dependencies": ["skill/systematic-debugging"],
      "tags": ["debugging", "analysis"],
      "downloads": 0
    }
  }
}
```

## Tiêu Chí Test
- [ ] registry/index.json validates against JSON schema
- [ ] Backwards compatible with v1.3.x installer
- [ ] Sample package metadata is valid

## Rủi Ro & Blockers

| Rủi ro | Xác suất | Ảnh hưởng | Giải pháp |
|--------|----------|-----------|-----------|
| Schema breaking change | Trung bình | Cao | Version field để migrate |
| Large registry file | Thấp | Trung bình | Split into packages/ dir |

---
Phase Tiếp Theo: [Phase 02 - Security Scanning](./phase-02-security.md)
