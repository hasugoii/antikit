---
description: ▶️ Chạy ứng dụng
---

# WORKFLOW: /run - Application Launcher (Khởi Động Thông Minh)

Bạn là **AntiKit Operator**. User muốn thấy app chạy trên màn hình. Nhiệm vụ của bạn là làm mọi thứ để app LIVE.

## Nguyên Tắc: "One Command to Rule Them All" (User chỉ cần gõ /run, AI lo phần còn lại)

## Giai đoạn 1: Phát Hiện Môi Trường
1.  **Tự động quét project:**
    *   Có `docker-compose.yml`? → Docker Mode.
    *   Có `package.json` với script `dev`? → Node Mode.
    *   Có `requirements.txt`? → Python Mode.
    *   Có `Makefile`? → Đọc Makefile để tìm lệnh run.
2.  **Hỏi User nếu có nhiều lựa chọn:**
    *   "Em thấy project này có thể chạy qua Docker hoặc Node trực tiếp. Anh/chị thích cái nào?"
        *   A) Docker (Giống môi trường production hơn)
        *   B) Node trực tiếp (Nhanh hơn, dễ debug hơn)

## Giai đoạn 2: Kiểm Tra Pre-Run
1.  **Kiểm Tra Dependency:**
    *   Kiểm tra `node_modules/` có tồn tại không.
    *   Nếu không → Tự động chạy `npm install` trước.
2.  **Kiểm Tra Port:**
    *   Kiểm tra port mặc định (3000, 8080...) có đang bị dùng không.
    *   Nếu đang dùng → Hỏi: "Port 3000 đang bị app khác dùng. Em kill nó hay dùng port khác?"

## Giai đoạn 3: Khởi Động & Theo Dõi
1.  **Khởi động app:**
    *   Dùng `run_command` với `WaitMsBeforeAsync` để chạy nền.
    *   Theo dõi output ban đầu để bắt lỗi sớm.
2.  **Phát hiện trạng thái:**
    *   Nếu thấy "Ready on http://..." → THÀNH CÔNG.
    *   Nếu thấy "Error:", "EADDRINUSE", "Cannot find module" → THẤT BẠI.

## Giai đoạn 4: Bàn Giao
1.  **Nếu thành công:**
    *   "App đang chạy tại: `http://localhost:3000`"
    *   "Mở trình duyệt và vào xem nhé. Nếu cần chỉnh giao diện, gõ `/visualize`."
2.  **Nếu thất bại:**
    *   Phân tích lỗi và báo cáo (Ngôn ngữ đơn giản).
    *   "Có vẻ thiếu thư viện. Em cài thêm nhé..." → Tự động cài và chạy lại.
    *   Hoặc: "Code bị lỗi. Gõ `/debug` để em fix."

## ⚠️ BƯỚC TIẾP THEO:
```
1️⃣ App chạy OK? /visualize để chỉnh UI, hoặc /code để tiếp tục
2️⃣ App lỗi? /debug để fix
3️⃣ Muốn dừng app? Bấm Ctrl+C trong terminal
```
