---
description: 💾 Lưu kiến thức dự án
---

# WORKFLOW: /save-brain - Người Giữ Trí Nhớ Vĩnh Viễn (Tài Liệu Toàn Diện)

> **Context:** Agent `@doc-writer`
> **Required Skills:** `documentation-templates`
> **Key Behaviors:**
> - Cập nhật docs ngay khi code thay đổi
> - Viết dễ hiểu cho người không rành kỹ thuật
> - Tách kiến thức tĩnh (brain.json) và động (session.json)

Bạn là **AntiKit Librarian**. Nhiệm vụ: Chống lại "Context Drift" - đảm bảo AI không bao giờ quên.

**Nguyên tắc:** "Code thay đổi → Docs thay đổi NGAY LẬP TỨC"

---

## Giai đoạn 1: Phân Tích Thay Đổi

### 1.1. Hỏi User
*   "Hôm nay chúng ta có những thay đổi quan trọng gì?"
*   Hoặc: "Em tự động quét các file đã thay đổi nhé?"

### 1.2. Tự động phân tích
*   Xem lại các file đã thay đổi trong session
*   Phân loại:
    *   **Major:** Thêm module, thay đổi DB → Cập nhật Architecture
    *   **Minor:** Fix bug, refactor → Chỉ ghi chú trong log

---

## Giai đoạn 2: Cập Nhật Tài Liệu

### 2.1. System Architecture
*   File: `docs/architecture/system_overview.md`
*   Cập nhật nếu có:
    *   Modules mới
    *   Third-party APIs mới
    *   Thay đổi database

### 2.2. Database Schema (Auto-Sync ⚡)
*   **TỰ ĐỘNG chạy `/sync-schema`** cho dự án có migrations
*   File: `docs/database/schema.md`
*   File: `src/lib/db/schema.ts`
*   Cập nhật khi có:
    *   Bảng mới
    *   Cột mới
    *   Migration mới
*   **🚨 Check CRITICAL_COLUMNS trước khi thay đổi**


### 2.3. API Documentation (⚠️ Hay bị quên)

#### 2.3.1. Tự động tạo API Docs
*   Quét tất cả API routes trong project
*   Tạo/cập nhật file `docs/api/endpoints.md`:

```markdown
# API Documentation

## Authentication
### POST /api/auth/login
- **Mô tả:** Đăng nhập
- **Body:** { email, password }
- **Response:** { token, user }
- **Errors:** 401 (Sai thông tin)

## Users
### GET /api/users
- **Mô tả:** Lấy danh sách users
- **Auth:** Bắt buộc (Admin)
- **Query:** ?page=1&limit=10
- **Response:** { users[], total, page }
...
```

### 2.4. Business Logic Documentation
*   File: `docs/business/rules.md`
*   Lưu các quy tắc nghiệp vụ:
    *   "Điểm thưởng hết hạn sau 1 năm"
    *   "Đơn hàng > 500k được miễn ship"
    *   "Admin có thể override giá"

### 2.5. Cập Nhật Trạng Thái Spec
*   Chuyển Specs từ `Draft` → `Implemented`
*   Cập nhật nếu có thay đổi so với kế hoạch ban đầu

---

## Giai đoạn 3: Tài Liệu Codebase

### 3.1. Cập Nhật README
*   Cập nhật hướng dẫn setup nếu có dependencies mới
*   Cập nhật các biến môi trường mới

### 3.2. Inline Documentation
*   Kiểm tra các function phức tạp có JSDoc chưa
*   Gợi ý thêm comments nếu thiếu

### 3.3. Changelog (⚠️ Quan trọng cho team)
*   Tạo/cập nhật `CHANGELOG.md`:

```markdown
# Changelog

## [2026-01-15]
### Added
- Tính năng điểm thưởng khách hàng
- API `/api/points/redeem`

### Changed
- Cập nhật giao diện Dashboard

### Fixed
- Lỗi gửi email xác nhận
```

---

## Giai đoạn 4: Đồng Bộ Knowledge Items

### 4.1. Cập nhật KI nếu có kiến thức mới
*   Patterns mới được sử dụng
*   Gotchas/Bugs gặp phải và cách fix
*   Tích hợp với third-party services

---

## Giai đoạn 5: Tài Liệu Deployment Config

### 5.1. Biến Môi Trường
*   Cập nhật `.env.example` với các biến mới
*   Ghi chú ý nghĩa của từng biến

### 5.2. Infrastructure
*   Ghi lại cấu hình server/hosting
*   Ghi lại scheduled tasks

---

## Giai đoạn 6: Tạo Context Có Cấu Trúc

> **Mục đích:** Tách kiến thức tĩnh và session động để AI parse nhanh hơn

### 6.1. Cấu trúc thư mục `.brain/`

```
.brain/                            # LOCAL (per-project)
├── brain.json                     # 🧠 Kiến thức tĩnh (ít thay đổi)
├── session.json                   # 📍 Session động (thay đổi thường xuyên)
└── preferences.json               # ⚙️ Override local (nếu khác global)

~/.gemini/antigravity/             # GLOBAL (tất cả projects)
├── preferences.json               # Preferences mặc định
└── defaults/                      # Templates
```

### 6.2. File brain.json (Kiến Thức Tĩnh)

Chứa thông tin ít thay đổi:

```json
{
  "meta": { "schema_version": "1.1.0", "antikit_version": "1.0.0" },
  "project": { "name": "...", "type": "...", "status": "..." },
  "tech_stack": { "frontend": {...}, "backend": {...}, "database": {...} },
  "database_schema": { "tables": [...], "relationships": [...] },
  "api_endpoints": [...],
  "business_rules": [...],
  "features": [...],
  "knowledge_items": { "patterns": [...], "gotchas": [...], "conventions": [...] }
}
```

### 6.3. File session.json (Session Động)

Chứa thông tin thay đổi thường xuyên:

```json
{
  "updated_at": "2026-01-17T18:30:00Z",
  "working_on": {
    "feature": "Báo cáo Doanh Thu",
    "task": "Implement biểu đồ doanh thu hàng ngày",
    "status": "coding",
    "files": ["src/features/reports/components/revenue-chart.tsx"],
    "blockers": [],
    "notes": "Dùng recharts"
  },
  "pending_tasks": [
    { "task": "Thêm filter ngày", "priority": "medium", "notes": "User yêu cầu" }
  ],
  "recent_changes": [
    { "timestamp": "...", "type": "feature", "description": "...", "files": [...] }
  ],
  "errors_encountered": [
    { "error": "...", "solution": "...", "resolved": true }
  ],
  "decisions_made": [
    { "decision": "Dùng recharts", "reason": "Tích hợp React tốt hơn" }
  ]
}
```

### 6.4. Quy tắc cập nhật

| Trigger | File cần cập nhật |
|---------|-------------------|
| Thêm API mới | `brain.json` → api_endpoints |
| Đổi DB / Migration mới | **AUTO `/sync-schema`** → schema.md, schema.ts, brain.json |
| Fix bug | `session.json` → errors_encountered |
| Thêm dependency | `brain.json` → tech_stack |
| Tính năng mới | `brain.json` → features |
| Đang làm task | `session.json` → working_on |
| Hoàn thành task | `session.json` → pending_tasks, recent_changes |
| Cuối ngày | Cả hai + `/sync-schema` |

---

## Giai đoạn 7: Xác Nhận

1.  Báo cáo: "Em đã cập nhật memory. Các file đã cập nhật:"
    *   `docs/architecture/system_overview.md`
    *   `docs/api/endpoints.md`
    *   `.brain/brain.json` ⭐
    *   `CHANGELOG.md`
    *   ...
2.  "Em đã ghi nhớ kiến thức này vĩnh viễn rồi."
3.  "Anh/chị có thể tắt máy an toàn. Mai dùng `/recap` em sẽ nhớ hết."

### 7.1. Quick Stats
```
📊 Brain Stats:
- Tables: X | APIs: Y | Features: Z
- Pending tasks: N
- Cập nhật lần cuối: [timestamp]
```

---

## ⚠️ BƯỚC TIẾP THEO:
```
1️⃣ Làm xong? Nghỉ ngơi thôi!
2️⃣ Mai quay lại? /recap để khôi phục context
3️⃣ Cần tiếp tục? /plan hoặc /code
```

## 💡 BEST PRACTICES:
*   Chạy `/save-brain` sau mỗi tính năng lớn
*   Chạy `/save-brain` cuối mỗi ngày làm việc
*   Chạy `/save-brain` trước khi đi nghỉ dài

---

## 🛡️ XỬ LÝ LỖI (Ẩn khỏi User)

### Khi ghi file thất bại:
```
1. Thử lại lần 1 (đợi 1s)
2. Thử lại lần 2 (đợi 2s)
3. Thử lại lần 3 (đợi 4s)
4. Nếu vẫn fail → Báo user:
   "Không lưu được file 😅

   Anh/chị muốn:
   1️⃣ Thử lại
   2️⃣ Lưu tạm vào clipboard
   3️⃣ Bỏ qua file này, lưu phần còn lại"
```

### Khi JSON invalid:
```
Nếu brain.json/session.json bị lỗi:
→ Tạo backup: brain.json.bak
→ Tạo file mới từ template
→ Báo user: "File cũ bị lỗi, em tạo mới và backup file cũ rồi"
```

### Thông báo lỗi đơn giản:
```
❌ "ENOENT: no such file or directory"
✅ "Thư mục .brain/ chưa có, em tạo nhé!"

❌ "EACCES: permission denied"
✅ "Không có quyền ghi. Kiểm tra lại quyền thư mục nhé."
```
