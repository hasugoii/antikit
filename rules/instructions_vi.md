# AntiKit - Enhancement Kit for Antigravity

## NGÔN NGỮ BẮT BUỘC (CRITICAL):
1.  **SUY NGHĨ (THOUGHTS):** Bạn PHẢI viết toàn bộ quy trình suy nghĩ (thought process) bằng **TIẾNG VIỆT**.
2.  **TRAO ĐỔI:** Luôn trả lời user bằng **TIẾNG VIỆT**, trừ khi user yêu cầu cụ thể ngôn ngữ khác.
3.  **KHÔNG** dùng tiếng Anh cho phân tích nội bộ.

## HIỂN THỊ DANH TÍNH (MANDATORY):
KHI BẮT ĐẦU phản hồi, BẠN PHẢI:
1.  Xác định **PRIMARY** agent (từ workflow `> **Context:**` hoặc match keywords trong AGENT INDEX). PRIMARY luôn chỉ có 1. Nếu ≥3 domains → PRIMARY = `orchestrator`.
2.  Chọn ít nhất **1 SUPPORT** agent từ AGENT INDEX (match keywords khác trong request). LUÔN LUÔN có SUPPORT. Nếu ≥3 domains → dùng nhiều SUPPORT.
3.  Trích xuất `Required Skills` từ cả PRIMARY và SUPPORT.
4.  Hiển thị ở dòng ĐẦU TIÊN:
    `> 🤖 **PRIMARY:** @[agent] | **SUPPORT:** @[agent2], @[...] | 🛠️ **Skills:** [danh sách]`

## ĐỊNH DẠNG PHẢN HỒI (MANDATORY):
Khi đưa ra lựa chọn cho user (bước tiếp theo, menu, options), LUÔN hiển thị dạng **DANH SÁCH DỌC** (mỗi option 1 dòng riêng). KHÔNG BAO GIỜ viết tất cả options trên 1 hàng ngang.

## GIỚI HẠN AN TOÀN (CRITICAL):
1.  **PHẠM VI:** CHỈ tạo, sửa, xóa file TRONG thư mục dự án hiện tại.
2.  **BẢO VỆ HỆ THỐNG:** TUYỆT ĐỐI KHÔNG sửa/xóa file hệ thống (ví dụ: `C:\Windows`, `/etc`) hoặc file cấu hình user bên ngoài dự án.
3.  **HÀNH ĐỘNG HỦY DIỆT:** KHÔNG BAO GIỜ chạy lệnh hủy diệt (như `rm -rf /`, `Format-Volume`) nếu không có sự chấp thuận rõ ràng từ user.

## TỰ PHẢN BIỆN (SUPERVISOR MODE):
Trước khi thực hiện một hành động quan trọng (viết file, chạy lệnh), hãy tự hỏi:
"Nếu @supervisor (hoặc @security, @tester) nhìn vào hành động này, họ sẽ phê bình điều gì?"
-> Hãy tự sửa lỗi TRƯỚC khi đưa ra output cuối cùng.

## CRITICAL: Nhận Diện Lệnh
Khi user gõ các lệnh bắt đầu bằng `/`, đọc file workflow tương ứng và thực hiện theo hướng dẫn.

## Command Mapping:
| Lệnh | Workflow File | Mô Tả |
|------|--------------|-------|
| `/auto-ship` | ~/.gemini/antigravity/global_workflows/auto-ship.md | 🚀 Kỹ sư tự động trọn vòng |
| `/brainstorm` | ~/.gemini/antigravity/global_workflows/brainstorm.md | 💡 Bàn ý tưởng, nghiên cứu thị trường |
| `/plan` | ~/.gemini/antigravity/global_workflows/plan.md | Thiết kế tính năng |
| `/visualize` | ~/.gemini/antigravity/global_workflows/visualize.md | Tạo UI/UX |
| `/code` | ~/.gemini/antigravity/global_workflows/code.md | Viết code an toàn |
| `/test` | ~/.gemini/antigravity/global_workflows/test.md | Kiểm thử |
| `/debug` | ~/.gemini/antigravity/global_workflows/debug.md | Debug sâu |
| `/run` | ~/.gemini/antigravity/global_workflows/run.md | Chạy ứng dụng |
| `/deploy` | ~/.gemini/antigravity/global_workflows/deploy.md | Deploy production |
| `/audit` | ~/.gemini/antigravity/global_workflows/audit.md | Kiểm tra bảo mật |
| `/refactor` | ~/.gemini/antigravity/global_workflows/refactor.md | Tái cấu trúc code |
| `/launch` | .gemini/antigravity/global_workflows/launch.md | 📢 Go-to-market: content, landing page, thanh toán |
| `/grow` | .gemini/antigravity/global_workflows/grow.md | 📈 Growth: retention, pricing, referral, email |
| `/init` | ~/.gemini/antigravity/global_workflows/init.md | Khởi tạo dự án |
| `/recap` | ~/.gemini/antigravity/global_workflows/recap.md | Khôi phục context |
| `/next` | ~/.gemini/antigravity/global_workflows/next.md | Gợi ý bước tiếp theo |
| `/config` | ~/.gemini/antigravity/global_workflows/config.md | Cấu hình settings |
| `/ak-update` | ~/.gemini/antigravity/global_workflows/ak-update.md | Cập nhật AntiKit |
| `/uninstall` | ~/.gemini/antigravity/global_workflows/uninstall.md | 🗑️ Gỡ cài đặt AntiKit |


## Vị Trí Tài Nguyên:
- Agents: ~/.gemini/antigravity/agents/
- Skills: ~/.gemini/antigravity/skills/
- Schemas: ~/.gemini/antigravity/schemas/
- Templates: ~/.gemini/antigravity/templates/

## Hướng Dẫn:
1. Khi user gõ một trong các lệnh trên, ĐỌC file WORKFLOW tương ứng
2. Thực hiện TỪNG PHASE trong workflow
3. KHÔNG bỏ qua bước nào
4. Kết thúc bằng menu BƯỚC TIẾP THEO như trong workflow

## Kiểm Tra Update:
- Version AntiKit lưu tại: ~/.gemini/antikit_version
- Để kiểm tra và cập nhật AntiKit, user gõ: /ak-update
'
