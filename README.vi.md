<p align="center">
  <img src="assets/logo.png" alt="AntiKit - Vibe Coding Kit cho Google Antigravity" width="120" height="120">
</p>

<h1 align="center">AntiKit</h1>

<p align="center">
  <strong>Hệ Điều Hành Cho Kỹ Sư AI</strong><br>
  <em>Vibe Coding Kit cho Google Antigravity</em>
</p>

<p align="center">
  <a href="https://antikit.pages.dev">🌐 Website</a> • <a href="#vấn-đề">Vấn đề</a> •
  <a href="#giải-pháp">Giải pháp</a> •
  <a href="#cài-đặt">Cài đặt</a> •
  <a href="#workflow-pipeline">Workflows</a> •
  <a href="#giá">Giá</a>
</p>

<p align="center">
  <a href="README.md">🇺🇸 English</a> •
  <a href="README.zh.md">🇨🇳 中文</a> •
  <a href="README.ja.md">🇯🇵 日本語</a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/version-1.0.0-blue" alt="Version">
  <img src="https://img.shields.io/badge/workflows-20-green" alt="Workflows">
  <img src="https://img.shields.io/badge/agents-16-purple" alt="Agents">
  <img src="https://img.shields.io/badge/skills-40-orange" alt="Skills">
</p>

---

## 🎯 AntiKit Là Gì?

**AntiKit** (Antigravity Kit) là công cụ **Vibe Coding** tối ưu cho [Google Antigravity](https://ai.google.dev/aistudio).

> Hệ điều hành cá nhân cho phát triển AI - workflows, agents, và skills biến ý tưởng thành code production-ready.

**Hoàn hảo cho AI Engineers muốn:**
- 🚀 Ship nhanh hơn với AI-powered workflows
- 🧠 Không bao giờ mất context giữa các sessions
- 🛡️ Viết code production-ready từ ngày đầu

---

## 😫 Vấn Đề

**Bạn có gặp những vấn đề này khi code với AI không?**

<table>
<tr>
<td width="50%">

### 🧠 "AI quên hết rồi!"

Chat mới 20-30 tin nhắn, AI đã quên mất bạn đang dùng công nghệ gì, Database ra sao. Bắt đầu bịa code lung tung, tạo bảng trùng lặp.

</td>
<td width="50%">

### 💥 "Chạy được là được"

AI đưa code "chạy tạm", không bắt lỗi (try-catch), hard-code API key, bỏ qua edge case. Lên production là nổ 💥

</td>
</tr>
<tr>
<td>

### 🔄 "Sửa xong lỗi A thì ra lỗi B"

Vòng lặp debug vô tận. AI sửa mò mẫm, không tìm nguyên nhân gốc. Càng sửa code càng nát.

</td>
<td>

### ❓ "Giờ làm gì tiếp đây?"

Ngồi nhìn màn hình không biết bước tiếp theo là gì. Không có roadmap, không có quy trình rõ ràng.

</td>
</tr>
<tr>
<td>

### 🍝 "Codebase như mì Ý"

AI cứ thêm code vào, không tổ chức. File dài hàng nghìn dòng, function lồng nhau chằng chịt. Sau 1 tuần chính mình cũng không hiểu.

</td>
<td>

### 😰 "Sợ sửa vì không có backup"

Muốn sửa feature nhưng sợ làm hỏng cái khác. Không biết Git, không có bản backup. Một sai lầm là mất hết công sức.

</td>
</tr>
</table>

---

## ✅ Giải Pháp

**AntiKit giải quyết TẤT CẢ những vấn đề này bằng quy trình có kỷ luật.**

| Vấn đề | Giải pháp AntiKit |
|--------|-------------------|
| 🧠 AI quên | `/save-brain` lưu context vào folder `.brain/` |
| 💥 Code dễ vỡ | `/code` có kiểm tra bảo mật & best practices |
| 🔄 Debug lòng vòng | `/debug` tìm nguyên nhân gốc, không chỉ vá |
| ❓ Bí không biết làm gì | `/next` gợi ý bước tiếp theo |
| 🍝 Code lộn xộn | `/refactor` + `/audit` giữ code sạch |
| 😰 Không có backup | `/rollback` + tích hợp Git tự động |

---

## 🚀 Cài Đặt

### macOS / Linux

```bash
curl -fsSL https://raw.githubusercontent.com/hasugoii/antikit/main/install.sh | bash
```

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/hasugoii/antikit/main/install.ps1 | iex
```

**Sau khi cài, thử ngay:**

```
/recap
```

---

## 📋 Workflow Pipeline

AntiKit tổ chức công việc thành **4 giai đoạn rõ ràng**:

### Giai đoạn 1: 🎯 Lập Kế Hoạch
> **Không được code ngay!**

| Lệnh | Mục đích |
|------|----------|
| `/init` | Tạo cấu trúc project, Git, môi trường |
| `/recap` | Khôi phục context khi quay lại |
| `/brainstorm` | Bàn ý tưởng trước khi lên kế hoạch |
| `/plan` | Thiết kế database, API, tạo spec |
| `/next` | Gợi ý khi bí |

### Giai đoạn 2: 🔨 Xây Dựng
> **Code an toàn & thẩm mỹ**

| Lệnh | Mục đích |
|------|----------|
| `/visualize` | Thiết kế giao diện đẹp |
| `/code` | Viết code có kiểm tra bảo mật |
| `/run` | Chạy ứng dụng |

### Giai đoạn 3: ⚙️ Vận Hành
> **Bảo trì & tối ưu**

| Lệnh | Mục đích |
|------|----------|
| `/debug` | Tìm nguyên nhân gốc rễ bug |
| `/test` | Chạy tests |
| `/refactor` | Dọn dẹp code |
| `/rollback` | Quay lại phiên bản trước |
| `/deploy` | Deploy lên production |

### Giai đoạn 4: 🛡️ Quản Trị
> **Quản lý & cải tiến**

| Lệnh | Mục đích |
|------|----------|
| `/save-brain` | Lưu kiến thức dự án |
| `/config` | Cấu hình skills & agents |
| `/audit` | Kiểm tra bảo mật & code |
| `/ak-update` | Cập nhật AntiKit |

---

## 🤖 Bao Gồm

### 20 Workflows
Toàn bộ quy trình phát triển từ ý tưởng đến production.

### 16 AI Agents
Chuyên gia: `@frontend`, `@backend`, `@database`, `@security`, `@devops`, `@tester`, `@debugger`, `@performance`, `@architect`, `@doc`, `@orchestrator`, `@pentester`, `@mobile`, `@game`, `@seo`, `@explorer`

### 40 Skills
Kiến thức chuyên sâu tự động load theo context.

---

## 💡 Mẹo Pro

| Khi nào | Làm gì |
|---------|--------|
| 🌅 Mỗi sáng | `/recap` để khôi phục context |
| 🌙 Cuối buổi | `/save-brain` để lưu kiến thức |
| ✅ Xong tính năng | `/save-brain` + Git commit |
| 🆕 Dự án mới | `/init` → `/recap` |
| 😕 Bí? | `/next` để xin gợi ý |
| 🔧 Trước khi sửa lớn | Git commit trước! |

---

## 💰 Giá

| Gói | Giá | Phạm vi |
|-----|-----|---------|
| **Personal** | Miễn phí | Cá nhân, học tập |
| **Startup** | $49/năm | Tới 5 developers |
| **Team** | $149/năm | Tới 20 developers |
| **Enterprise** | Liên hệ | Không giới hạn |

---

## 📜 License

AntiKit được cấp phép theo [Business Source License 1.1](LICENSE.md).

- ✅ Cá nhân/học tập: **Miễn phí**
- 💼 Thương mại: **Cần license**
- 📅 Chuyển Apache 2.0: **2030-01-19**

---

<p align="center">
  <strong>Ngừng chiến đấu với AI. Bắt đầu Vibe Coding với Antigravity.</strong><br>
  Made with ❤️ by <a href="https://github.com/hasugoii">hasugoii</a>
</p>
