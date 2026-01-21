---
description: Cập nhật AntiKit lên phiên bản mới nhất
---

# WORKFLOW: /ak-update - Cập Nhật AntiKit

> **Context:** Agent `@devops`
> **Required Skills:** `server-management`

Bạn là **AntiKit Update Manager**. Nhiệm vụ kiểm tra và cập nhật lên phiên bản mới nhất.

## Giai đoạn 1: Kiểm Tra Phiên Bản

1. Đọc phiên bản đã cài:
   ```bash
   cat ~/.gemini/awf_version 2>/dev/null || echo "Chưa biết"
   ```

2. Kiểm tra phiên bản mới nhất từ GitHub:
   ```bash
   curl -s https://raw.githubusercontent.com/hasugoii/antikit/main/VERSION
   ```

3. So sánh và báo cáo:

```
📦 **KIỂM TRA PHIÊN BẢN AntiKit**

Phiên bản hiện tại: [installed version]
Phiên bản mới nhất:  [github version]

Trạng thái: [ĐÃ MỚI NHẤT / CÓ PHIÊN BẢN MỚI]
```

## Giai đoạn 2: Hiển Thị Changelog (nếu có cập nhật)

Nếu có phiên bản mới, fetch và hiển thị changelog:
```bash
curl -s https://raw.githubusercontent.com/hasugoii/antikit/main/CHANGELOG.md | head -50
```

## Giai đoạn 3: Tùy Chọn Cập Nhật

```
🔄 **TÙY CHỌN CẬP NHẬT**

1️⃣ Cập nhật ngay (khuyến nghị)
2️⃣ Bỏ qua lần này
3️⃣ Xem đầy đủ changelog
```

## Giai đoạn 4: Thực Hiện Cập Nhật (nếu chọn 1)

### Mac/Linux:
```bash
curl -fsSL https://raw.githubusercontent.com/hasugoii/antikit/main/install.sh | sh
```

### Windows (PowerShell):
```powershell
iex "& { $(irm https://raw.githubusercontent.com/hasugoii/antikit/main/install.ps1) }"
```

## Giai đoạn 5: Xác Nhận

```
✅ **CẬP NHẬT HOÀN TẤT**

AntiKit đã được cập nhật lên phiên bản [new version].

Có gì mới:
- [Key changes từ changelog]

👉 Khởi động lại IDE để áp dụng thay đổi.
```

## BƯỚC TIẾP THEO:
```
1️⃣ Test workflow? Thử /recap
2️⃣ Xem tất cả lệnh? /help
3️⃣ Bắt đầu project mới? /init
```
