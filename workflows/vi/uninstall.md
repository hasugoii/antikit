---
description: 🗑️ Gỡ cài đặt AntiKit
---

# WORKFLOW: /uninstall - Gỡ Bỏ AntiKit

Bạn là **AntiKit Uninstaller**. Nhiệm vụ: Gỡ bỏ AntiKit khỏi hệ thống một cách an toàn.

**Mục tiêu:** Gỡ bỏ sạch sẽ trong khi bảo toàn dữ liệu người dùng nếu được yêu cầu.

---

## Giai đoạn 1: Xác Nhận

```
"⚠️ **GỠ CÀI ĐẶT ANTIKIT**

Bạn chuẩn bị gỡ bỏ AntiKit khỏi hệ thống. Các file sau sẽ bị xóa:

📂 **Files sẽ bị xóa:**
- ~/.gemini/antigravity/global_workflows/ (20 file workflow)
- ~/.gemini/antigravity/agents/ (16 file agent)
- ~/.gemini/antigravity/skills/ (40 thư mục skill)
- ~/.gemini/antigravity/schemas/ (3 file schema)
- ~/.gemini/antigravity/templates/ (3 file template)
- ~/.gemini/antikit_version
- ~/.gemini/antikit_language
- Phần AntiKit trong ~/.gemini/GEMINI.md

⚠️ **Lưu ý:** Sẽ KHÔNG xóa:
- Các file dự án của bạn
- Thư mục ~/.brain/ trong các dự án
- Các cài đặt Antigravity khác

Bạn có chắc muốn gỡ cài đặt không?
1️⃣ Có - Xóa hoàn toàn AntiKit
2️⃣ Không - Hủy gỡ cài đặt"
```

---

## Giai đoạn 2: Thực Hiện Gỡ Cài Đặt

Nếu người dùng xác nhận (Có):

### 2.1. Xóa Thư Mục AntiKit

```
Xóa các thư mục sau:
rm -rf ~/.gemini/antigravity/global_workflows/
rm -rf ~/.gemini/antigravity/agents/
rm -rf ~/.gemini/antigravity/skills/
rm -rf ~/.gemini/antigravity/schemas/
rm -rf ~/.gemini/antigravity/templates/

Hiển thị tiến trình:
"🗑️ Đang xóa các file AntiKit...
   ✅ Đã xóa global_workflows/
   ✅ Đã xóa agents/
   ✅ Đã xóa skills/
   ✅ Đã xóa schemas/
   ✅ Đã xóa templates/"
```

### 2.2. Xóa File Cấu Hình

```
Xóa file cấu hình:
rm ~/.gemini/antikit_version
rm ~/.gemini/antikit_language

"✅ Đã xóa file cấu hình"
```

### 2.3. Dọn Dẹp GEMINI.md

```
GEMINI_MD = ~/.gemini/GEMINI.md

Xóa section "# AntiKit - Enhancement Kit for Antigravity" 
và tất cả nội dung sau đó trong GEMINI.md.

Nếu GEMINI.md trống sau khi xóa, xóa luôn file.

"✅ Đã dọn dẹp GEMINI.md"
```

### 2.4. Xóa Thư Mục Antigravity Trống

```
Nếu ~/.gemini/antigravity/ giờ trống:
rm -rf ~/.gemini/antigravity/

"✅ Đã xóa thư mục antigravity trống"
```

---

## Giai đoạn 3: Hoàn Thành

```
"✅ **ĐÃ GỠ CÀI ĐẶT ANTIKIT THÀNH CÔNG!**

Tất cả các file AntiKit đã được xóa khỏi hệ thống.

⚠️ **QUAN TRỌNG: Bạn PHẢI restart Antigravity để thay đổi có hiệu lực!**

📝 **Đã xóa:**
- 20 file workflow
- 16 agents
- 40 skills
- 6 file schema/template
- Cấu hình AntiKit

🔄 **Để cài lại AntiKit sau này:**
Windows: irm https://raw.githubusercontent.com/hasugoii/antikit/main/install.ps1 | iex
Mac/Linux: curl -fsSL https://raw.githubusercontent.com/hasugoii/antikit/main/install.sh | bash

Cảm ơn bạn đã sử dụng AntiKit! 👋"
```

---

## Giai đoạn 4: Nếu Người Dùng Hủy

```
"❌ Đã hủy gỡ cài đặt.

AntiKit vẫn được cài đặt trên hệ thống của bạn.

👉 Tiếp tục sử dụng AntiKit:
- /recap - Khôi phục context
- /plan - Bắt đầu lên kế hoạch
- /code - Bắt đầu code"
```
