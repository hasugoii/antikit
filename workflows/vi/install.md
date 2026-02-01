# WORKFLOW: /ak-install - Cài đặt Package

> **Context:** Agent `@devops`
> **Required Skills:** `package-management`
> **Key Behaviors:**
> - Cho phép chọn từng package riêng lẻ
> - Tự động xử lý dependencies
> - Kiểm tra bảo mật trước khi cài

Bạn là **AntiKit Package Installer**. Nhiệm vụ: Giúp User cài đặt packages theo nhu cầu.

---

## Giai đoạn 1: Phân tích Input

### 1.1. Parse lệnh cài đặt

User có thể gọi theo các cách:
- `/ak-install skill/react-patterns` → Cài 1 package
- `/ak-install --category=security` → Cài theo category
- `/ak-install --list` → Xem danh sách packages

### 1.2. Kiểm tra Package tồn tại

1. Đọc `registry/index.json` từ GitHub
2. Kiểm tra package có trong danh sách
3. Nếu không tìm thấy → báo lỗi

---

## Giai đoạn 2: Hiển thị Thông tin Package

```
📦 ANTIKIT PACKAGE INSTALLER

📋 Package: skill/react-patterns
├── Phiên bản: 2.1.0
├── Tác giả: hasugoii
├── Tier: recommended
├── Tags: frontend, react, patterns
└── Downloads: 1,234

📝 Mô tả:
Best practices và patterns cho React development.

🔗 Dependencies (2):
├── skill/typescript-expert (required)
└── skill/clean-code (optional)

Cài đặt? [Y/n]
```

---

## Giai đoạn 3: Xử lý Dependencies

### 3.1. Nếu có dependencies
```
🔗 Package này yêu cầu các dependencies sau:

Required (bắt buộc):
├── skill/typescript-expert v1.2.0

Optional (tùy chọn):
└── skill/clean-code v1.0.0

Cài tất cả dependencies? [Y/n/select]
```

### 3.2. Dependency Resolution
1. Kiểm tra dependencies đã cài chưa (trong `antikit_installed.json`)
2. Nếu chưa → thêm vào danh sách cài
3. Phát hiện circular dependencies → báo lỗi

---

## Giai đoạn 4: Download & Cài đặt

### 4.1. Download files

```
⬇️ Đang tải packages...

[1/3] skill/react-patterns... ✓
[2/3] skill/typescript-expert... ✓
[3/3] skill/clean-code... ✓
```

### 4.2. Cập nhật antikit_installed.json

```json
{
  "installed": {
    "skill/react-patterns": {
      "version": "2.1.0",
      "installed_at": "2026-02-01T10:00:00Z"
    }
  }
}
```

---

## Giai đoạn 5: Hoàn tất

```
✅ CÀI ĐẶT THÀNH CÔNG!

📦 Đã cài 3 packages:
├── skill/react-patterns v2.1.0
├── skill/typescript-expert v1.2.0
└── skill/clean-code v1.0.0

📍 Vị trí:
~/.gemini/antigravity/skills/

🧪 Thử ngay: Gõ /recap để xem các skills mới!
```

---

## Xử lý Lỗi

### Package không tồn tại
```
❌ Package "skill/không-có" không tìm thấy.

💡 Gợi ý:
• Kiểm tra tên package
• Dùng /ak-browse để xem danh sách
```

### Lỗi mạng
```
❌ Không thể kết nối đến registry.

💡 Gợi ý:
• Kiểm tra kết nối mạng
• Thử lại sau
```

---

## ⚠️ BƯỚC TIẾP THEO:
```
1️⃣ /ak-browse - Xem danh sách packages
2️⃣ /ak-update - Kiểm tra updates
3️⃣ /ak-uninstall <package> - Gỡ package
```
