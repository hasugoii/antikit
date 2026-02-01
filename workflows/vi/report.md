# WORKFLOW: /ak-report - Báo Cáo Package

> **Context:** Agent `@security`
> **Required Skills:** `reporting`
> **Key Behaviors:**
> - Cho phép báo cáo package đáng ngờ
> - Auto-quarantine sau 3 reports
> - Bảo vệ cộng đồng

---

## Giai đoạn 1: Xác định Package

### 1.1. Parse Input
```
/ak-report skill/suspicious-tool
```

### 1.2. Kiểm tra Package tồn tại
- Đọc registry/index.json
- Nếu không tìm thấy → báo lỗi

---

## Giai đoạn 2: Hiển thị Thông tin

```
🚩 BÁO CÁO PACKAGE

📦 Package: skill/suspicious-tool
├── Tác giả: @unknown_user
├── Version: 1.0.0
├── Downloads: 45
└── Reports hiện tại: 2

Tại sao bạn muốn báo cáo package này?
1️⃣ Vấn đề bảo mật (malware, đánh cắp dữ liệu)
2️⃣ Nội dung không phù hợp
3️⃣ Chất lượng kém / Không hoạt động
4️⃣ Khác

> 
```

---

## Giai đoạn 3: Thu thập Chi tiết

```
📝 Mô tả vấn đề:
> Package này dường như gửi API keys đến server bên ngoài

📎 Bằng chứng (optional):
- Line numbers có vấn đề
- Screenshots
- Logs
```

---

## Giai đoạn 4: Xác nhận & Gửi

```
📋 XÁC NHẬN BÁO CÁO

Package: skill/suspicious-tool
Lý do: Vấn đề bảo mật
Mô tả: Package này dường như gửi API keys đến server bên ngoài

Gửi báo cáo? [Y/n]
```

---

## Giai đoạn 5: Kết quả

### 5.1. Báo cáo thành công
```
✅ BÁO CÁO ĐÃ GỬI

📊 Tình trạng package:
├── Reports: 3/3 (threshold reached!)
├── Status: 🔒 AUTO-QUARANTINED
└── Maintainers đã được thông báo

Cảm ơn bạn đã giúp bảo vệ cộng đồng AntiKit!
```

### 5.2. Nếu chưa đủ threshold
```
✅ BÁO CÁO ĐÃ GỬI

📊 Tình trạng package:
├── Reports: 2/3
├── Status: Đang chờ review
└── Sẽ auto-quarantine khi đạt 3 reports

Cảm ơn bạn đã báo cáo!
```

---

## Lưu ý

⚠️ **Cảnh báo**:
- Báo cáo sai sự thật có thể ảnh hưởng đến trust level của bạn
- Mỗi người chỉ có thể báo cáo 1 package 1 lần
- Maintainers sẽ review tất cả báo cáo

---

## ⚠️ BƯỚC TIẾP THEO:
```
1️⃣ /ak-browse - Xem packages khác
2️⃣ /ak-update - Kiểm tra updates
3️⃣ Quay lại làm việc
```
