<div align="center">

# AntiKit 🚀

**Bạn đồng hành "Vibe Coding" cho Antigravity AI.**
*Code bằng cảm giác. Để AI lo logic.* 🧘‍♂️✨

[![Version](https://img.shields.io/badge/Version-1.9.4-green?style=for-the-badge)](https://github.com/hasugoii/antikit/releases)
[![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](LICENSE.md)
[![Documentation](https://img.shields.io/badge/Docs-Read%20Manual-orange?style=for-the-badge)](https://antikit.pages.dev/docs)
[![Website](https://img.shields.io/badge/Website-antikit.pages.dev-purple?style=for-the-badge)](https://antikit.pages.dev)
[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20A%20Coffee-FFDD00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://www.buymeacoffee.com/hasugoii)

[English](README.md) | [Tiếng Việt](README.vi.md) | [日本語](README.ja.md) | [中文](README.zh.md)

</div>

---

## 🤔 Tại sao lại cần AntiKit?

Bạn đang sở hữu **Google Antigravity**, con AI code đỉnh nhất hiện nay. Nhưng đôi khi dùng nó thấy...
- 😥 **Quá Kỹ Thuật:** "Contexts", "Schemas", "Prompts"... nghe nhức đầu!
- ⚠️ **Toàn Tiếng Anh:** Bạn hỏi tiếng Việt, nó trả lời tiếng Anh (hoặc nửa nạc nửa mỡ).
- 😨 **Quá Rủi Ro:** Nhỡ nó xóa nhầm file `C:\Windows` thì toang?
- 😵 **Quá Loạn:** Đang nói chuyện với ai? Ông dev hay ông tester?

**AntiKit** sinh ra để fix hết đống đó. Nó biến cỗ máy thô sơ của Antigravity thành một chiếc **Siêu Xe Hạng Sang** mà ai cũng lái được.

---

## ✨ 6 Trụ Cột của "Vibe Coding"

### 1. 🌏 Native Fluency (Nói tiếng của BẠN)
Quên "Engrish" đi. AntiKit buộc AI phải **SUY NGHĨ và TRẢ LỜI** bằng tiếng Việt 100% (hoặc Nhật/Trung tùy bạn chọn).
> *Không còn: "Here is your code" -> Giờ là: "Của bạn đây, sếp ơi!"*

### 2. 🛡️ Zero-Fear Safety (Sandbox An Toàn)
Code thoải mái, không lo hỏng máy. Em đã cài một lớp **Khiên Chắn**:
- 🚫 **Chặn lệnh hủy diệt:** Cấm tiệt `rm -rf`, `format`.
- 🔒 **Khóa phạm vi:** AI chỉ được phép nghịch trong folder dự án.
- 🧱 **Bảo vệ hệ thống:** File Windows/System là bất khả xâm phạm.

### 3. 🤖 Multi-Agent (2+ Bộ Não, 1 Nhiệm Vụ) `MỚI`
Mỗi task giờ có **nhiều AI agent** hợp tác — PRIMARY expert dẫn dắt, SUPPORT agents cung cấp kiến thức đa lĩnh vực.
> `> 🤖 PRIMARY: @backend | SUPPORT: @security, @database | 🛠️ Skills: api-patterns, vulnerability-scanner`

Không còn câu trả lời 1 chiều. Bạn nhận được **output đa chuyên gia** mọi lúc.

### 4. 🔬 Evidence Discipline (Không Có Bug Cảm Tính) `MỚI`
Diệt vĩnh viễn bug do "code theo cảm giác". Trước khi AI động vào code, nó phải chứng minh:
- 🐛 **Fix bug?** → Phải reproduce lỗi trước.
- ⚡ **Tối ưu?** → Phải benchmark trước và sau.
- 📦 **Thêm dependency?** → Phải so sánh 2+ lựa chọn.
- 🚀 **Deploy?** → Tất cả tests phải pass.

> *Không còn "thử đổi cái này xem sao..." nữa.*

### 5. 🧠 Supervisor Brain (Tự Phản Biện)
Em cấy một "Lương tâm" vào cho AI. Trước khi nó đưa code cho bạn, nó sẽ tự hỏi:
> *"Khoan, code này ngon chưa? Senior Dev có chửi không?"*
Nó tự sửa lỗi của chính mình **trước khi** bạn kịp nhìn thấy.

### 6. 🎯 Context Integrity (Chống Lạc Đề)
AI tự kiểm tra mỗi vài turn: *"Mình đang giải quyết đúng cái user hỏi chưa?"*
- Bắt **scope creep** trước khi lan rộng.
- Phát hiện **rabbit holes** và tự kéo mình lại.
- Đảm bảo **file coherence** xuyên suốt các edit.

---

## 🚀 Cài Đặt 1 Chạm

Không cần biết code cao siêu. Mở terminal lên và paste câu **Thần Chú** này vào:

### 🪟 Windows (PowerShell)
```powershell
iwr https://raw.githubusercontent.com/hasugoii/antikit/main/install.ps1 -useb | iex -Language vi
```

### 🍎 macOS / 🐧 Linux
```bash
curl -fsSL https://raw.githubusercontent.com/hasugoii/antikit/main/install.sh | bash -s -- --lang vi
```

> **💡 Mẹo:** Đổi ngôn ngữ bất cứ lúc nào với `/config language [en|vi|ja|zh]`

---

## 🎮 "Vibe" Như Thế Nào?

Cài xong rồi, chỉ cần gõ mấy lệnh `/slash` này vào chat để gọi chuyên gia:

| Lệnh | Triệu hồi... | Dùng khi cảm thấy... |
| :--- | :--- | :--- |
| `/brainstorm` | 💡 **Thánh Ý Tưởng** | "Có ý tưởng mà chưa biết bắt đầu sao..." |
| `/plan` | 📝 **Kiến Trúc Sư** | "Cần một kế hoạch bài bản trước khi code." |
| `/visualize` | 🎨 **Họa Sĩ** | "Muốn giao diện đẹp lung linh." |
| `/code` | 💻 **Senior Dev** | "Code hộ cái, lười quá rồi." |
| `/deploy` | 🚀 **DevOps** | "Cho cái web này lên mạng đi!" |
| `/audit` | 🏥 **Bác Sĩ** | "Khám xem code có bệnh tật gì không?" |
| `/recap` | 🧠 **Thư Ký** | "Nãy giờ làm gì rồi nhỉ, nhắc lại coi." |

---

## 🛠️ Dành Cả Cho Dân PRO ⚡

Nghĩ AntiKit chỉ dành cho người mới? **Nhầm to.** Đây là bộ giáp exoskeleton cho Senior Dev:

1.  **⚡ Tốc độ tối đa:** Tự động hóa những thứ nhàm chán (setup, config, boilerplate) trong 1 giây.
2.  **🧠 45 Skill Chuyên Sâu:** Agent được nạp sẵn kiến thức sâu rộng về:
    *   **Tech:** Next.js, React, Node.js, Python, Rust, Docker, Cloudflare.
    *   **Quy trình:** TDD, Clean Code, DDD, Evidence Discipline, Security Patterns.
    *   **Ngách:** SEO, UX/UI, Tối ưu hiệu năng, Mobile, Game Dev.
3.  **🤖 Multi-Agent Protocol:** Mọi task đều có **2+ agents** hợp tác:
    *   PRIMARY (chuyên gia chính) + SUPPORT (review đa lĩnh vực)
    *   Tự chọn agent từ AGENT INDEX gồm 20 chuyên gia
    *   Bắt buộc cross-review cho task build/create
4.  **⚡ Power Mode Flags:** Mở khóa agent chuyên biệt bằng flags đơn giản:
    *   `/code --mobile` → Expert Mobile với React Native skills
    *   `/audit --pentest` → Penetration tester với MITRE ATT&CK
    *   `/deploy --docker` → DevOps expert với Docker skills
5.  **🔬 Evidence Gates:** Không còn "works on my machine":
    *   Fix bug → phải có bước tái tạo lỗi
    *   Refactor → phải có metrics trước/sau
    *   Deploy → phải pass tests
6.  **🧘 Deep Flow:** Giữ sự tập trung cao độ, để AI xử lý việc tay chân ở background.

---

## 📦 Trong Hộp Có Gì?

-   **20 Agent Chuyên Biệt:** Frontend, Backend, Security, SEO, Mobile, Game Dev...
-   **29 Workflow:** Lệnh slash chuẩn chỉnh trong 4 ngôn ngữ với **Power Mode flags**.
-   **45 Skills:** Module kiến thức chuyên sâu, tải theo yêu cầu.
-   **Multi-Agent Protocol:** Tự chọn PRIMARY + SUPPORT agents cho mỗi task.
-   **Evidence Discipline:** Dev theo bằng chứng, không dựa cảm tính.
-   **Global Memory (GEMINI.md):** "Bộ não" quản lý luật an toàn, ngôn ngữ, và routing.

---

## 🤝 Lời Cảm Ơn (Credits)

Dự án này được tham khảo từ [AWF (Antigravity Workflow Framework)](https://github.com/TUAN130294/awf) của [TUAN130294](https://github.com/TUAN130294).

---

<div align="center">

**Built with ❤️ for the Vibe Coding Community.**

[![Star History Chart](https://api.star-history.com/svg?repos=hasugoii/antikit&type=Date)](https://star-history.com/#hasugoii/antikit&Date)

</div>
