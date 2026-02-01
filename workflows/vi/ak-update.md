---
description: Cập nhật AntiKit với chọn lựa package
---

# WORKFLOW: /ak-update - Cập Nhật AntiKit (Enhanced)

> **Context:** Agent `@devops`
> **Required Skills:** `server-management`, `git-workflow`
> **Key Behaviors:**
> - Hiển thị danh sách packages có thể update
> - Cho phép chọn lựa selective update
> - Lưu lịch sử update local

Bạn là **AntiKit Update Manager**. Nhiệm vụ: Kiểm tra và cập nhật AntiKit với khả năng chọn lựa packages.

---

## Giai đoạn 1: Fetch Registry

### 1.1. Kiểm tra phiên bản core

```bash
# Local version
cat ~/.gemini/antikit_version 2>/dev/null || echo "unknown"

# Remote version
curl -s https://raw.githubusercontent.com/hasugoii/antikit/main/VERSION
```

### 1.2. Fetch library registry

```bash
curl -s https://raw.githubusercontent.com/hasugoii/antikit/main/registry/index.json
```

---

## Giai đoạn 2: So Sánh với Local

### 2.1. Đọc installed packages

```bash
cat ~/.gemini/antikit_installed.json
```

### 2.2. Nếu chưa có file, tạo mới

```json
{
  "version": "1.2.1",
  "language": "vi",
  "installed": {
    "workflows": {},
    "skills": {},
    "agents": {},
    "rules": {}
  },
  "history": []
}
```

---

## Giai đoạn 3: Hiển Thị Updates Available

```
📦 ANTIKIT UPDATE CENTER

🔷 CORE: v{local} → v{remote} {status}

┌─────────────────────────────────────────────────────┐
│ 📂 WORKFLOWS ({count} updates)                      │
├─────────────────────────────────────────────────────┤
│ [ ] 1. /debug         1.0.0 → 1.2.0  ⭐ Hot update  │
│ [ ] 2. /code          1.1.0 → 1.2.1  🆕 New version │
│ [✓] 3. /plan          1.2.0          ✅ Up to date  │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│ 🛠️ SKILLS ({count} available, {installed} installed)│
├─────────────────────────────────────────────────────┤
│ [ ] 4. react-patterns  v2.0  ⭐ Popular (5k↓)       │
│ [ ] 5. nextjs-expert   v1.5  🆕 New                 │
│ [ ] 6. prisma-guru     v1.2  📈 Trending            │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│ 🤖 AGENTS ({count} available)                       │
├─────────────────────────────────────────────────────┤
│ [ ] 7. @game-dev       v1.0  🎮 For game developers │
│ [ ] 8. @ml-engineer    v1.0  🧠 AI/ML specialist    │
└─────────────────────────────────────────────────────┘

📊 Your language: 🇻🇳 Vietnamese
   (All packages auto-translated to your language)
```

---

## Giai đoạn 4: Chọn Lựa

```
🔽 CHỌN ĐỂ CẬP NHẬT:

Nhập số (cách nhau bằng dấu phẩy) hoặc:
• all       - Cập nhật tất cả
• workflows - Chỉ workflows
• skills    - Chỉ skills
• agents    - Chỉ agents
• core      - Chỉ core framework
• cancel    - Hủy

Ví dụ: 1,2,4,5 hoặc all

> _
```

---

## Giai đoạn 5: Thực Hiện Update

### 5.1. Download Selected

```
⬇️ ĐANG TẢI...

├── /debug (vi)... ✓
├── /code (vi)... ✓
├── react-patterns... ✓
└── nextjs-expert... ✓

Đã tải: 4 packages
```

### 5.2. Update Local Files

```bash
# Copy từ git repo sang local
cp -r antikit/library/workflows/debug/translations/vi.md ~/.gemini/antigravity/global_workflows/debug.md
```

### 5.3. Update antikit_installed.json

```json
{
  "installed": {
    "workflows": {
      "debug": { "version": "1.2.0", "installed": "2026-02-01" }
    }
  },
  "history": [
    {
      "date": "2026-02-01T16:00:00Z",
      "action": "update",
      "packages": ["workflow/debug", "workflow/code", "skill/react-patterns"]
    }
  ]
}
```

---

## Giai đoạn 6: Xác Nhận

```
✅ CẬP NHẬT HOÀN TẤT!

📦 Đã cập nhật:
├── workflow/debug 1.0.0 → 1.2.0
├── workflow/code 1.1.0 → 1.2.1
├── skill/react-patterns (new)
└── skill/nextjs-expert (new)

📊 Thống kê:
├── Workflows: 21 installed
├── Skills: 42 installed
├── Agents: 16 installed
└── Total packages: 79

📝 Lịch sử được lưu tại: ~/.gemini/antikit_installed.json

👉 Khởi động lại IDE để áp dụng thay đổi.
```

---

## Giai đoạn 7: Next Steps

```
⚠️ BƯỚC TIẾP THEO:

1️⃣ Duyệt thêm packages? /ak-browse
2️⃣ Xem lịch sử update? /ak-history
3️⃣ Đóng góp package? /ak-contribute
4️⃣ Test workflow mới? /recap
```

---

## ⚠️ Lưu Ý

- Packages được auto-translate sang ngôn ngữ của bạn
- Core framework update sẽ overwrite global files
- Lịch sử update được lưu để rollback nếu cần
- Chạy `/ak-history` để xem chi tiết
