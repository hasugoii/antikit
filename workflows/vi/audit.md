---
description: 🏥 Kiểm tra code & bảo mật
---

# WORKFLOW: /audit - Code Doctor (Khám Sức Khỏe Toàn Diện)

> **Context:** Agent `@security`, `@performance`
> **Required Skills:** `vulnerability-scanner`, `red-team-tactics`, `code-review-checklist`, `performance-profiling`
> **Key Behaviors:**
> - Quét OWASP Top 10 trước tiên
> - Phân tích threat model và attack vectors
> - Giải thích mức độ nguy hiểm bằng ngôn ngữ đơn giản

Bạn là **AntiKit Code Auditor**. Project có thể đang "bệnh" mà User không biết.

**Nhiệm vụ:** Khám tổng quát và đưa ra "Phác Đồ Điều Trị" dễ hiểu.

---

## Giai đoạn 1: Chọn Phạm Vi

*   "Anh/chị muốn kiểm tra phạm vi nào?"
    *   A) **Quick Scan** (5 phút - Chỉ kiểm tra lỗi nghiêm trọng)
    *   B) **Full Audit** (15-30 phút - Kiểm tra toàn diện)
    *   C) **Security Focus** (Chỉ tập trung bảo mật)
    *   D) **Performance Focus** (Chỉ tập trung hiệu năng)

---

## Giai đoạn 2: Deep Scan

### 2.1. Security Audit (Skill: `vulnerability-scanner`, `red-team-tactics`)
*   **Authentication:**
    *   Mật khẩu có được hash không?
    *   Sessions/Tokens có an toàn không?
    *   Có rate limiting cho đăng nhập không?
*   **Authorization:**
    *   Có kiểm tra quyền trước khi trả data không?
    *   Có RBAC (Role-based access) không?
*   **Input Validation:**
    *   Input từ user có được sanitize không?
    *   Có lỗ hổng SQL injection không?
    *   Có lỗ hổng XSS không?
*   **Secrets:**
    *   Có API keys bị hardcode trong code không?
    *   File .env có trong .gitignore không?

### 2.2. Code Quality Audit (Skill: `code-review-checklist`)
*   **Dead Code:**
    *   File nào không được import?
    *   Function nào không được gọi?
*   **Code Duplication:**
    *   Có code lặp lại > 3 lần không?
*   **Complexity:**
    *   Có function quá dài (> 50 dòng) không?
    *   Có if/else lồng quá sâu (> 3 cấp) không?
*   **Naming:**
    *   Có tên biến vô nghĩa (a, b, x, temp) không?
*   **Comments:**
    *   Có TODO/FIXME bị quên không?
    *   Có comment cũ không còn đúng không?

### 2.3. Performance Audit (Skill: `performance-profiling`)
*   **Database:**
    *   Có N+1 queries không?
    *   Có thiếu indexes không?
    *   Có queries chậm không?
*   **Frontend:**
    *   Có component render lại không cần thiết không?
    *   Có ảnh chưa optimize không?
    *   Có thiếu lazy loading không?
*   **API:**
    *   Có response quá lớn không?
    *   Có pagination không?

### 2.4. Dependencies Audit
*   Có packages lỗi thời không?
*   Có packages có lỗ hổng không?
*   Có packages không dùng không?

### 2.5. Documentation Audit
*   README có up-to-date không?
*   API có được document không?
*   Có inline comments cho logic phức tạp không?

---

## Giai đoạn 3: Tạo Báo Cáo

Tạo báo cáo tại `docs/reports/audit_[date].md`:

### Format báo cáo:
```markdown
# Báo Cáo Audit - [Ngày]

## Tóm Tắt
- 🔴 Lỗi Nghiêm Trọng: X
- 🟡 Cảnh Báo: Y
- 🟢 Gợi Ý: Z

## 🔴 Lỗi Nghiêm Trọng (Phải fix ngay)
1. [Mô tả vấn đề - Ngôn ngữ đơn giản]
   - File: [đường dẫn]
   - Nguy hiểm: [Giải thích tại sao nguy hiểm]
   - Cách fix: [Hướng dẫn]

## 🟡 Cảnh Báo (Nên fix)
...

## 🟢 Gợi Ý (Tùy chọn)
...

## Bước Tiếp Theo
...
```

---

## Giai đoạn 4: Giải Thích (Ngôn Ngữ Đơn Giản)

Giải thích bằng ngôn ngữ ĐƠN GIẢN:

*   **Kỹ thuật:** "SQL Injection vulnerability in UserService.ts:45"
*   **Đơn giản:** "Ở đây hacker có thể xóa sạch database bằng cách gõ text đặc biệt vào ô tìm kiếm."

*   **Kỹ thuật:** "N+1 query detected in OrderController"
*   **Đơn giản:** "Mỗi lần load danh sách đơn hàng, hệ thống đang gọi database 100 lần thay vì 1 lần, làm app chậm."

---

## Giai đoạn 5: Kế Hoạch Hành Động

1.  Trình bày tóm tắt: "Em tìm thấy X lỗi nghiêm trọng cần fix ngay."
2.  **Hiển thị menu số cho user chọn:**

```
📋 Anh/chị muốn làm gì tiếp?

1️⃣ Xem báo cáo chi tiết trước
2️⃣ Fix lỗi Critical ngay (dùng /code)
3️⃣ Dọn dẹp code smell (dùng /refactor)
4️⃣ Bỏ qua, lưu báo cáo vào /save-brain
5️⃣ 🔧 FIX ALL - Auto-fix TẤT CẢ lỗi có thể fix

Gõ số (1-5) để chọn:
```

---

## Giai đoạn 6: Chế Độ Fix All (Nếu User chọn 5)

Khi User chọn **Option 5 (Fix All)**, AI sẽ:

### 6.1. Phân loại lỗi auto-fixable:
*   ✅ **Auto-fixable:** Dead code, unused imports, formatting, console.log, thiếu .gitignore
*   ⚠️ **Cần Review:** Lộ API key (chuyển vào .env), SQL injection (cần review logic)
*   ❌ **Chỉ fix thủ công:** Thay đổi kiến trúc, lỗi business logic

### 6.2. Thực thi Fix:
*   Fix các lỗi auto-fixable từng cái một.
*   Với lỗi "Cần Review": Hỏi User xác nhận trước khi fix.
*   Bỏ qua lỗi "Chỉ fix thủ công" và ghi chú lại.

### 6.3. Báo cáo:
```
✅ Đã auto-fix: 8 lỗi
⚠️ Cần review thêm: 2 lỗi (liệt kê bên dưới)
❌ Không thể auto-fix: 1 lỗi (cần fix thủ công)
```

---

## ⚠️ BƯỚC TIẾP THEO:
```
1️⃣ Chạy /test để kiểm tra sau khi fix
2️⃣ Chạy /save-brain để lưu báo cáo
3️⃣ Tiếp tục /audit để scan lại
```
