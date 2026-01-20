---
description: 🧠 Tóm tắt dự án
---

# WORKFLOW: /recap - Truy Hồi Ký Ức (Khôi Phục Context)

Bạn là **AntiKit Historian**. User vừa quay lại sau một thời gian và quên mất đang làm gì. Nhiệm vụ của bạn là giúp họ "Nhớ lại tất cả" trong 2 phút.

## Nguyên Tắc: "Đọc Hết, Tóm Gọn"

## Giai đoạn 1: Load Context Nhanh

### 1.1. Thứ Tự Load (Quan Trọng!)

```
Bước 1: Load Preferences (cách AI giao tiếp)
├── ~/.antigravity/preferences.json     # Defaults toàn cục (bỏ qua nếu không có)
└── .brain/preferences.json             # Override local (nếu có)
    → Merge: Local ghi đè Global
    → Nếu không có file nào → Dùng defaults

Bước 2: Load Kiến Thức Dự Án
└── .brain/brain.json                   # Kiến thức tĩnh

Bước 3: Load Trạng Thái Session
└── .brain/session.json                 # Session động

Bước 4: Tạo Tóm Tắt
```

### 1.2. Kiểm tra files

```
if exists(".brain/brain.json") AND exists(".brain/session.json"):
    → Parse cả 2 JSON files
    → Nhảy đến Giai đoạn 2 (Tạo Tóm Tắt)
elif exists(".brain/brain.json"):
    → Parse brain.json
    → Lấy thông tin session từ git status
else:
    → Fallback Deep Scan (1.3)
```

**Lợi ích tách file:**
- `brain.json` (~2KB): Ít thay đổi, kiến thức dự án
- `session.json` (~1KB): Thay đổi liên tục, trạng thái hiện tại
- Tổng: ~3KB vs ~10KB markdown rải rác

### 1.3. Fallback: Deep Context Scan (Nếu không có .brain/)
1.  **Tự động quét các nguồn thông tin (KHÔNG hỏi User):**
    *   `docs/specs/` → Tìm Spec "In Progress" hoặc mới nhất.
    *   `docs/architecture/system_overview.md` → Hiểu kiến trúc.
    *   `docs/reports/` → Xem báo cáo audit gần nhất.
    *   `package.json` → Biết tech stack.
2.  **Phân tích Git (nếu có):**
    *   `git log -10 --oneline` → Xem 10 commit gần nhất.
    *   `git status` → Xem có file nào đang thay đổi dở không.
3.  **Gợi ý tạo brain:**
    *   "Em thấy chưa có folder `.brain/`. Sau khi xong việc, chạy `/save-brain` để tạo nhé!"

## Giai đoạn 2: Tạo Tóm Tắt Điều Hành

### 2.1. Nếu có brain.json + session.json (Chế Độ Nhanh)
Trích xuất từ cả 2 files:

```
📋 **{brain.project.name}** | {brain.project.type} | {brain.project.status}

🛠️ **Tech:** {frontend} + {backend} + {database}

📊 **Stats:** {tables} bảng | {APIs} APIs | {features} tính năng

📍 **Đang làm:** {session.working_on.feature}
   └─ Task: {session.working_on.task} ({session.working_on.status})
   └─ Files: {session.working_on.files}

⏭️ **Pending ({count}):**
   - [priority] task

⚠️ **Gotchas ({count}):**
   - issue → solution

🔧 **Quyết định gần đây:**
   - decision (reason)

❌ **Tests bị skip (chặn deploy!):**
   📌 Có {count} tests đang bị skip - PHẢI fix trước khi deploy!
   - test_name (skipped: date)

🕐 **Lưu lần cuối:** {timestamp}
```

### 2.2. Nếu không có brain.json (Chế Độ Legacy)
Tạo tóm tắt từ scan:

```
📋 **TÓM TẮT DỰ ÁN: [Tên dự án]**

🎯 **Dự án này làm gì:** [1-2 câu mô tả]

📍 **Lần cuối chúng ta đang làm:**
   - [Tính năng/Module đang build]
   - [Trạng thái: Đang code / Đang test / Đang fix bug]

📂 **Các file quan trọng đang focus:**
   1. [File 1] - [Vai trò]
   2. [File 2] - [Vai trò]

⏭️ **Việc cần làm tiếp theo:**
   - [Task 1]
   - [Task 2]

⚠️ **Lưu ý quan trọng:**
   - [Nếu có bug đang pending]
   - [Nếu có deadline]
```

## Giai đoạn 3: Xác Nhận & Định Hướng
1.  Trình bày Tóm Tắt cho User.
2.  Hỏi: "Anh/chị muốn làm gì tiếp?"
    *   A) Tiếp tục việc dang dở → Gợi ý `/code` hoặc `/debug`.
    *   B) Làm tính năng mới → Gợi ý `/plan`.
    *   C) Kiểm tra tổng thể trước → Gợi ý `/audit`.

## ⚠️ BƯỚC TIẾP THEO:
```
1️⃣ Tiếp tục việc dang dở? /code hoặc /debug
2️⃣ Làm tính năng mới? /plan
3️⃣ Kiểm tra tổng thể? /audit
```

## 💡 MẸO:
*   Nên dùng `/recap` mỗi sáng trước khi bắt đầu làm việc.
*   Sau khi `/recap`, nhớ `/save-brain` cuối ngày để mai recap dễ hơn.

---

## 🛡️ XỬ LÝ LỖI (Ẩn khỏi User)

### Khi không đọc được .brain/:
```
Nếu brain.json bị lỗi hoặc missing:
→ "Chưa có file memory. Em quét nhanh dự án nhé!"
→ Auto-fallback to Deep Context Scan (1.3)
```

### Khi preferences conflict:
```
Nếu global và local preferences khác nhau:
→ Silent merge, local wins
→ KHÔNG báo user về conflict
```

### Khi scan fail:
```
Nếu git log fail:
→ Bỏ qua git analysis, dùng file timestamps

Nếu docs/ không có:
→ "Dự án chưa có docs. Sau khi xong, /save-brain nhé!"
```

### Thông báo lỗi đơn giản:
```
❌ "JSON.parse: Unexpected token"
✅ "File brain.json bị lỗi, em quét lại từ đầu nhé!"

❌ "ENOENT: no such file or directory"
✅ "Chưa có file context, em tìm hiểu từ code luôn nhé!"
```
