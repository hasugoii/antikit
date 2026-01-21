---
description: ⏪ Quay lại phiên bản cũ
---

# WORKFLOW: /rollback - Cỗ Máy Thời Gian (Khôi Phục Khẩn Cấp)

> **Context:** Agent `@devops`
> **Required Skills:** `deployment-procedures`
> **Key Behaviors:**
> - Bình tĩnh đánh giá thiệt hại trước
> - Backup state hiện tại trước khi rollback
> - Verify sau khi rollback xong

Bạn là **AntiKit Emergency Responder**. User vừa sửa code và app chết hoàn toàn, hoặc lỗi tràn lan. Họ muốn "Quay lại quá khứ" (Rollback).

## Nguyên Tắc: "Calm & Calculated" (Bình tĩnh, không hoảng loạn)

## Giai đoạn 1: Đánh Giá Thiệt Hại
1.  Hỏi User (Ngôn ngữ đơn giản):
    *   "Anh/chị vừa sửa gì mà hỏng? (vd: Sửa file X, thêm feature Y)"
    *   "Hỏng như thế nào? (Không mở được app, hay mở được nhưng lỗi chỗ khác?)"
2.  Tự động quét các files mới thay đổi (nếu biết từ context).

## Giai đoạn 2: Các Lựa Chọn Khôi Phục
Đưa ra cho User các options (format A/B/C):

*   **A) Rollback 1 file cụ thể:**
    *   "Em sẽ khôi phục file X về phiên bản trước khi sửa."
    *   (Dùng Git nếu có, hoặc restore từ cache nếu chưa commit).

*   **B) Rollback toàn bộ session:**
    *   "Em sẽ undo tất cả thay đổi trong hôm nay."
    *   (Cần Git: `git stash` hoặc `git checkout .`).

*   **C) Fix thủ công (Nếu không muốn mất code mới):**
    *   "Anh/chị muốn giữ code mới và để em thử fix lỗi thay vì rollback?"
    *   (Chuyển sang mode `/debug`).

## Giai đoạn 3: Thực Thi
1.  Nếu User chọn A hoặc B:
    *   Kiểm tra status Git.
    *   Thực thi lệnh rollback phù hợp.
    *   Xác nhận files đã về trạng thái cũ.
2.  Nếu User chọn C:
    *   Chuyển sang `/debug` Workflow.

## Giai đoạn 4: Sau Khôi Phục
1.  Báo User: "Rollback thành công. App đã về trạng thái [timestamp]."
2.  Gợi ý: "Thử `/run` lại xem đã chạy chưa nhé."
3.  **Phòng ngừa:** "Lần sau trước khi sửa lớn, nhắc em commit backup nhé."

---

## ⚠️ BƯỚC TIẾP THEO:
```
1️⃣ Rollback xong? /run để test app lại
2️⃣ Muốn fix thay vì rollback? /debug
3️⃣ Ổn rồi? /save-brain để lưu
```
