---
description: 🌐 Quản lý Cloudflare Tunnel
---

# Cấu Hình Cloudflare Tunnel

## ⚠️ QUAN TRỌNG - ĐỌC TRƯỚC KHI THAY ĐỔI

Hệ thống dùng **MỘT tunnel duy nhất** cho nhiều services. KHÔNG tạo tunnel mới, chỉ thêm hostnames vào config có sẵn.

---

## 📋 Trạng Thái Hiện Tại

### Active Tunnel
| Thuộc tính | Giá trị |
|------------|---------|
| **Tunnel ID** | `aa304557-6390-44bd-a052-7d7fe2a6e7d6` |
| **Tunnel Name** | `revenue-bot` |
| **Domain** | `ebebot.click` |
| **Chạy dưới** | Windows Scheduled Task (`CloudflaredTunnel`) |

### Hostnames Đã Cấu Hình
| Hostname | Service (Port) | Mô tả |
|----------|----------------|-------|
| `webhook.ebebot.click` | `http://localhost:39412` | LINE Bot webhook server |
| `pg.ebebot.click` | `http://localhost:8888` | Erablue App (Docker production) |

---

## 🔧 Cách Thêm Hostname Mới

### Bước 1: Cập nhật config.yml
Thêm hostname mới **TRƯỚC** dòng `- service: http_status:404`:

```yaml
tunnel: aa304557-6390-44bd-a052-7d7fe2a6e7d6
credentials-file: C:\Windows\System32\config\systemprofile\.cloudflared\aa304557-...json
ingress:
  - hostname: webhook.ebebot.click
    service: http://localhost:39412
  # === THÊM HOSTNAME MỚI Ở ĐÂY ===
  - hostname: new-service.ebebot.click
    service: http://localhost:XXXX
  # ==============================
  - service: http_status:404  # <-- LUÔN GIỮ CUỐI
```

### Bước 2: Thêm DNS route
```powershell
cloudflared tunnel route dns aa304557-... new-service.ebebot.click
```

### Bước 3: Restart tunnel
```powershell
Stop-ScheduledTask -TaskName "CloudflaredTunnel"
Start-Sleep 2
Start-ScheduledTask -TaskName "CloudflaredTunnel"
```

### Bước 4: Verify
```powershell
curl https://new-service.ebebot.click
```

---

## ⚠️ Lỗi Thường Gặp

### Error 1033 - Tunnel not connected
**Nguyên nhân**: Cloudflared không chạy
**Giải pháp**: Restart Scheduled Task

### Error 502 - Bad Gateway
**Nguyên nhân**: Service không chạy hoặc sai port
**Giải pháp**: Kiểm tra port với `netstat -ano | findstr ":PORT"`

---

## 🚫 KHÔNG LÀM

1. ❌ KHÔNG tạo tunnel mới
2. ❌ KHÔNG xóa file `.json` credentials
3. ❌ KHÔNG chạy cloudflared thủ công
