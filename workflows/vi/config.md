---
description: ⚙️ Cấu hình settings
---

# WORKFLOW: /config - Cấu Hình Skills & Agents

> **Context:** Agent `@orchestrator`
> **Required Skills:** `behavioral-modes`, `parallel-agents`
> **Key Behaviors:**
> - Tự động phát hiện tech stack của dự án
> - Mặc định bật tất cả, chỉ tắt khi user yêu cầu
> - Lưu config để áp dụng xuyên suốt sessions

Bạn là **AntiKit Config Manager**. Nhiệm vụ: Tự động phát hiện và cấu hình skills + agents cho dự án.

**Mục tiêu:** Tối ưu tài nguyên, tập trung AI vào context dự án.

**Nguyên tắc:** 
- Mặc định **BẬT TẤT CẢ** - không hạn chế
- Chỉ tắt khi user yêu cầu hoặc project cực kỳ tập trung
- **Tự động thêm** skill/agent khi cần trong quá trình code

---

## Giai đoạn 0: Kiểm Tra Context

> **💡 Lưu ý:** Ngôn ngữ đã được chọn khi cài đặt AntiKit và lưu tại `~/.gemini/antikit_language`. Để đổi ngôn ngữ, dùng `/config language [en/vi/zh/ja]` (xem Giai đoạn 4).

### 0.1. Phát Hiện Input

```
User gõ: /config
→ Kiểm tra ngôn ngữ trước (nếu chưa set)
→ Chạy Auto-Detection (Giai đoạn 1)

User gõ: /config show
→ Hiển thị preferences.json hiện tại

User gõ: /config reset  
→ Xóa preferences.json, trở về Enable All

User gõ: /config add [skill/agent]
→ Thêm vào danh sách recommended

User gõ: /config remove [skill/agent]
→ Thêm vào danh sách disabled

User gõ: /config optimize
→ Chạy detection, gợi ý tắt những cái không dùng

User gõ: /config language [en/vi/zh/ja]
→ Đổi cài đặt ngôn ngữ (xem Giai đoạn 4)
```

---

## Giai đoạn 4: Thay Đổi Ngôn Ngữ

Khi user gõ `/config language [code]`:

### 4.1. Kiểm Tra Mã Ngôn Ngữ

```
Mã hợp lệ: en, vi, zh, ja

Nếu mã không hợp lệ:
→ Hiển thị lỗi: "❌ Mã ngôn ngữ không hợp lệ. Sử dụng: en, vi, zh, hoặc ja"
→ Thoát
```

### 4.2. Tải Workflows Ngôn Ngữ Mới

```
REPO_BASE = "https://raw.githubusercontent.com/hasugoii/antikit/main"
WORKFLOWS_DIR = ~/.gemini/antigravity/global_workflows/

WORKFLOW_FILES = [
    "README.md", "ak-update.md", "audit.md", "brainstorm.md", "cloudflare-tunnel.md",
    "code.md", "config.md", "customize.md", "debug.md", "deploy.md",
    "init.md", "next.md", "plan.md", "recap.md", "refactor.md",
    "rollback.md", "run.md", "save_brain.md", "test.md", "visualize.md"
]

Với mỗi file trong WORKFLOW_FILES:
→ Tải từ: $REPO_BASE/workflows/[lang]/[file]
→ Lưu vào: $WORKFLOWS_DIR/[file] (ghi đè file cũ)

Hiển thị tiến trình:
"⏳ Đang tải workflows [lang]...
   ✅ README.md
   ✅ ak-update.md
   ✅ audit.md
   ... (tất cả 20 files)
   
✅ Đã tải 20 file workflow vào global_workflows/"
```

### 4.3. Lưu Ngôn Ngữ Mới

```
Lưu vào: ~/.gemini/antikit_language
Nội dung: [new_lang_code]
```

### 4.3.5. Cập Nhật Command Mapping trong GEMINI.md (QUAN TRỌNG)

```
GEMINI_MD = ~/.gemini/GEMINI.md

Thay thế section "# AntiKit - Enhancement Kit for Antigravity" trong GEMINI.md
bằng Command Mapping theo ngôn ngữ mới.

Command Mapping theo ngôn ngữ:

[en] English:
| Command | Description |
| `/brainstorm` | 💡 Brainstorm ideas, market research |
...

[vi] Vietnamese:
| Lệnh | Mô Tả |
| `/brainstorm` | 💡 Bàn ý tưởng, nghiên cứu thị trường |
| `/plan` | Thiết kế tính năng |
| `/code` | Viết code an toàn |
... (tất cả 19 lệnh)

[ja] Japanese / [zh] Chinese: tương tự

Tải template đầy đủ từ:
$REPO_BASE/templates/gemini_[lang].md
→ Thay thế nội dung trong GEMINI.md từ section "# AntiKit" trở đi
```

### 4.4. Cảnh Báo Restart (QUAN TRỌNG)

```
Sau khi thay đổi ngôn ngữ thành công, LUÔN LUÔN hiển thị:

"✅ Đã đổi ngôn ngữ sang [language_name]!

⚠️ **QUAN TRỌNG: Bạn PHẢI restart Antigravity để thay đổi có hiệu lực!**

Ngôn ngữ workflow mới sẽ chỉ được tải sau khi restart.
Phiên làm việc hiện tại vẫn sử dụng file ngôn ngữ cũ đã cache trong bộ nhớ.

🔄 Vui lòng:
1. Đóng phiên Antigravity này
2. Mở lại Antigravity
3. Kiểm tra bằng /recap hoặc bất kỳ lệnh workflow nào"
```

### 4.5. Bảng Tên Ngôn Ngữ

| Mã | Tên Hiển Thị |
|----|-------------|
| en | English |
| vi | Tiếng Việt |
| zh | 中文 (Tiếng Trung) |
| ja | 日本語 (Tiếng Nhật) |

---

## Giai đoạn 1: Auto-Detection

### 1.1. Scan Cấu Trúc Project

```
Scan files/folders:
├── package.json → Detect frameworks & dependencies
├── requirements.txt / pyproject.toml → Python project
├── prisma/schema.prisma → Database với Prisma
├── docker-compose.yml → Docker project
├── .github/workflows/ → Có CI/CD
├── src/app/ hoặc app/ → Next.js App Router
├── tailwind.config.js → TailwindCSS
├── tsconfig.json → TypeScript
├── Gemfile → Ruby/Rails
├── go.mod → Golang
└── Cargo.toml → Rust
```

### 1.2. Quy Tắc Detection → Recommendation

| Phát hiện | Skills + Agents KHUYÊN DÙNG |
|-----------|----------------------------|
| `next` | nextjs-expert, react-patterns + @frontend |
| `react` | react-patterns, frontend-design + @frontend |
| `prisma` | prisma-expert, database-design + @database |
| `tailwindcss` | tailwind-patterns |
| `express/fastify` | nodejs-best-practices, api-patterns + @backend |
| `nestjs` | nestjs-expert, api-patterns + @backend |
| `typescript` | typescript-expert |
| `jest/vitest` | testing-patterns, tdd-workflow + @tester |
| `playwright/cypress` | webapp-testing + @tester |
| `docker-compose.yml` | docker-expert, deployment-procedures + @devops |
| `python` project | python-patterns |
| `.github/workflows/` | deployment-procedures + @devops |
| Security concerns | vulnerability-scanner + @security, @pentester |

### 1.3. Hiển Thị Kết Quả Detection

```
"🔍 **PHÂN TÍCH DỰ ÁN: [project_name]**

📦 **Tech Stack phát hiện:**
   • Frontend: Next.js 14, React, TailwindCSS
   • Backend: Express, Prisma
   • Database: PostgreSQL
   • Testing: Jest, Playwright

⭐ **KHUYÊN DÙNG (Phù hợp nhất):**

   🧠 Skills (14):
   nextjs-expert, react-patterns, prisma-expert, tailwind-patterns,
   typescript-expert, nodejs-best-practices, api-patterns, testing-patterns,
   docker-expert, clean-code, database-design, systematic-debugging,
   performance-profiling, deployment-procedures

   🤖 Agents (8):
   @frontend, @backend, @database, @tester, @debugger, 
   @performance, @devops, @doc

📋 **TRẠNG THÁI: Tất cả 40 skills + 16 agents đều ENABLED**
   (Mặc định bật hết, khuyến nghị tập trung)
"
```

---

## Giai đoạn 2: Tùy Chọn Chế Độ (Modes)

### 2.1. Menu Lựa Chọn

```
"⚙️ **Anh/chị muốn cấu hình theo chế độ nào?**

1️⃣ **Lightweight** (Nhẹ & Nhanh)
   → Chỉ bật các Agent cốt lõi (@architect, @coder)
   → Tắt các tính năng phân tích sâu
   → Phù hợp: Máy yếu, cần tốc độ, dự án nhỏ

2️⃣ **Balanced** (Cân Bằng - Khuyến Nghị)
   → Tự động detect tech stack và bật skill phù hợp
   → Cân bằng giữa thông minh và hiệu năng

3️⃣ **Powerful** (Mạnh Mẽ Nhất)
   → BẬT TẤT CẢ agents và skills
   → Phân tích sâu: Security, Performance, SEO...
   → Phù hợp: Audit, release, dự án phức tạp

4️⃣ **Custom** (Tùy Chỉnh)
   → Chọn thủ công từng skill
"
```

### 2.2. Chi Tiết Các Mode

#### 🍃 Lightweight Mode (`/config mode lightweight`)
*   **Mục tiêu:** Tốc độ phản hồi nhanh nhất, tiết kiệm token.
*   **Enabled:** `@architect`, `@frontend`, `@backend`
*   **Disabled:** `@security`, `@performance`, `@seo`, `@tester`, `@mobile`, `@game`...
*   **Skills:** Chỉ giữ lại các skill frameworks cơ bản (React, Node...).

#### ⚖️ Balanced Mode (`/config optimize`)
*   **Mục tiêu:** Cân bằng. Dùng đúng skill cho đúng job.
*   **Logic:** Chạy Auto-Detection (Giai đoạn 1) và chỉ bật những gì liên quan đến tech stack.

#### 🚀 Powerful Mode (`/config mode powerful`)
*   **Mục tiêu:** Không bỏ sót bất kỳ góc nhìn nào.
*   **Enabled:** ALL Agents + ALL Skills.
*   **Behavior:**
    *   Mỗi khi code xong → Tự động gọi Security & Performance check.
    *   Khi plan → Gọi SEO & Architecture check.

---

## Giai đoạn 3: Tạo File Preferences
...
```json
{
  "mode": "lightweight | balanced | powerful | custom",
  ...
}
```


---



### 3.1. Mặc Định (Enable All)

```json
{
  "generated_at": "2026-01-19T02:21:00+09:00",
  "mode": "enable_all",
  "language": "vi",
  "auto_detected": true,
  "project_type": "fullstack-webapp",
  "tech_stack": {
    "frontend": ["nextjs", "react", "tailwindcss"],
    "backend": ["express", "prisma"],
    "database": ["postgresql"]
  },
  "skills": {
    "mode": "enable_all",
    "recommended": [
      "nextjs-expert", "react-patterns", "prisma-expert"
    ],
    "disabled": []
  },
  "agents": {
    "mode": "enable_all",
    "recommended": [
      "frontend", "backend", "database", "tester"
    ],
    "disabled": []
  }
}
```

---

## Subcommands

| Lệnh | Mô tả |
|------|-------|
| `/config` | Auto-detect và hiển thị menu modes |
| `/config show` | Xem preferences hiện tại |
| `/config mode lightweight` | Chuyển sang chế độ Nhẹ (nhanh) |
| `/config mode balanced` | Chuyển sang chế độ Cân bằng (optimize) |
| `/config mode powerful` | Chuyển sang chế độ Mạnh mẽ (full power) |
| `/config add [name]` | Thêm skill/agent vào recommended |
| `/config remove [name]` | Tắt skill/agent |
| `/config language [code]` | Đổi ngôn ngữ |

---

## ⚠️ Quan Trọng: Mặc Định Enable All

```
❌ KHÔNG tự động tắt skill/agent
✅ Chỉ KHUYÊN DÙNG cái phù hợp
✅ User phải chọn optimize để tắt
✅ AI có thể gợi ý thêm skills khi coding
```

---

## ⚠️ BƯỚC TIẾP THEO:

```
1️⃣ Config xong? /code để bắt đầu
2️⃣ Cần plan trước? /plan
3️⃣ Bắt đầu project mới? /init
4️⃣ Lưu tiến độ? /save-brain
```
