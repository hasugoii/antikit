# 🌍 Global Lessons (Áp dụng TẤT CẢ projects)

> File này chứa các bài học UNIVERSAL — không gắn với project cụ thể.
> AI PHẢI đọc file này mỗi session và TUÂN THỦ tuyệt đối.

## 🔒 Meta-Rule: Tiêu Chuẩn Chắt Lọc (MANDATORY)

> **AI PHẢI tuân thủ 5 tiêu chuẩn này TRƯỚC KHI thêm bất kỳ rule nào vào file này:**

| # | Tiêu chuẩn | Ý nghĩa |
|---|-----------|---------|
| 1 | **Universal** | Áp dụng ≥2 projects, KHÔNG gắn command/path cụ thể |
| 2 | **Actionable** | Phải có hành động cụ thể (DO/DON'T), không chỉ lý thuyết |
| 3 | **Battle-tested** | Phải xuất phát từ bug/incident thực tế, có `📝 Origin` |
| 4 | **Concise** | Mỗi rule tối đa 1 bảng + 3-5 bullet points |
| 5 | **Non-duplicate** | Kiểm tra rule tương tự chưa tồn tại trước khi thêm |

**Quy trình thêm rule mới:**

1. Gặp bug/incident → Ghi vào `## Recent` (local lessons trước)
2. Phân tích: Bug này có thể xảy ra ở project khác không?
3. Nếu CÓ → Tổng quát hóa thành pattern → Thêm vào `## Rules (Permanent)`
4. Nếu KHÔNG → Chỉ lưu ở `.brain/lessons.md` của project đó

**❌ KHÔNG được thêm vào global:**

- Rule chỉ áp dụng cho 1 project duy nhất
- Rule chưa được verify bằng incident thực tế
- Rule mang tính "nice to have" mà không có hậu quả rõ ràng
- Rule trùng ý với rule đã có (→ merge thay vì thêm mới)

---

## 🧠 Auto-Learn Protocol (TIER 0 — Always Active)

> **AI PHẢI tự động ghi lesson sau mỗi incident/fix MÀ KHÔNG cần hỏi user.**
> Đây là "learning layer" — chạy ngầm trên mọi thao tác.

### Trigger Detection — Khi nào ghi?

| Event | Auto-Ghi? | Ghi vào đâu | Ví dụ |
|-------|-----------|-------------|-------|
| Bug fixed / Error resolved | ✅ | **Local** `.brain/lessons.md` | Zod schema thiếu field → fix |
| Build/deploy fail → workaround | ✅ | **Local** | Build script lỗi → rewrite |
| Shell command fail → workaround | ✅ | **Global** `global_lessons.md` | PowerShell `&&` fail |
| Pattern lỗi lặp ≥2 projects | ✅ | **Global** (promote) | Stale dist xuất hiện ở 2 repos |
| Workaround cho OS/tool/platform | ✅ | **Global** | Windows path, npm quirks |
| Architecture/design decision | ⚠️ | **Local** | Chỉ ghi nếu non-obvious |
| Simple fix (typo, import) | ❌ | Không ghi | Quá nhỏ, không có pattern |

### Auto-Classification — Local vs Global

```text
IF lỗi liên quan OS/shell/tool/platform → GLOBAL
IF lỗi liên quan code/logic/config cụ thể → LOCAL
IF lỗi đã xuất hiện ≥2 projects → PROMOTE local → GLOBAL
IF không chắc → LOCAL (an toàn hơn)
```

### Format Chuẩn (4 dòng max, KHÔNG DÀI HƠN)

```markdown
### [YYYY-MM-DD] - /[cmd] - [Title ngắn gọn]
- ❌ Sai: [Gì đã fail — 1 câu]
- ✅ Rule: [Pattern để tránh lần sau — 1 câu]
- 📁 Files: [Files đã fix]
```

### Noise Control

- **Max 30 entries** trong `## Recent` — cũ nhất xóa khi vượt 30
- **KHÔNG ghi** khi fix là obvious (typo, missing import, syntax error)
- **KHÔNG duplicate** — kiểm tra lesson tương tự đã tồn tại chưa trước khi ghi
- **Merge** lessons tương tự thay vì thêm mới

### Promotion Flow (Local → Global)

```text
Session N: Bug X xảy ra ở Project A → ghi LOCAL
Session M: Bug X xảy ra ở Project B → ghi LOCAL
AI nhận ra: "Bug X giống lesson ở Project A"
→ TỰ ĐỘNG promote lên GLOBAL + tổng quát hóa
```

### Execution Rules

1. **Ghi NGAY sau fix** — không đợi cuối session
2. **Ghi SONG SONG** với commit/push — không tạo step riêng chỉ để ghi lesson
3. **KHÔNG hỏi user** "có muốn ghi lesson không?" — TỰ ĐỘNG ghi
4. **KHÔNG notify user** về lesson — im lặng ghi, user thấy khi cần
5. **Git commit lesson** trong cùng commit với fix nếu có thể

### Version Distribution — Chia Sẻ Kiến Thức

> Khi bump AntiKit version mới, lessons PHẢI được bundle theo.

**Rule khi push lên repo (cho community users):**

1. **Push `global_lessons.md`** lên repo cùng lúc bump VERSION
2. Permanent rules → giữ nguyên (đã tổng quát hóa)
3. Recent lessons → **lọc bỏ lessons cá nhân** (chỉ giữ lessons universal)
4. Auto-Learn Protocol section → luôn là bản mới nhất

> ⚠️ **LƯU Ý:** Việc lọc CHỈ áp dụng cho file push lên repo.
> Maintainer (dev AntiKit) giữ NGUYÊN toàn bộ lessons local — KHÔNG xóa, KHÔNG lọc.
> Cách làm: copy `global_lessons.md` → lọc Recent → sanitize → push bản đã lọc lên repo.

### 🔐 Privacy Guard — Chống Rò Rỉ Thông Tin Cá Nhân

> **CRITICAL:** Trước khi push `global_lessons.md` lên repo, AI PHẢI sanitize.

**PHẢI XÓA/ẨN trước khi push:**

| Loại thông tin | Ví dụ cần xóa | Thay bằng |
|----------------|---------------|-----------|
| **Tên project cá nhân** | `my-secret-project` | `[project-name]` |
| **File paths cụ thể** | `D:\Users\...`, `/home/user/...` | `[project]/path/to/file` |
| **URLs nội bộ** | Internal API URLs, tunnel URLs | `[internal-url]` |
| **Tokens/secrets** | API keys, tokens | ❌ TUYỆT ĐỐI XÓA |
| **Username/email** | Personal usernames, emails | Xóa hoàn toàn |
| **Business logic** | Chi tiết nghiệp vụ riêng | Tổng quát hóa thành pattern |
| **Version numbers cụ thể** | `v3.0.81` | `v[X.Y.Z]` hoặc xóa |

**CHỈ GIỮ trong bản push:**

- ✅ Pattern lỗi tổng quát (ví dụ: "PowerShell không hỗ trợ `&&`")
- ✅ Rule chung (ví dụ: "File ops dùng Node.js `fs`")
- ✅ Auto-Learn Protocol + Meta-Rules (không chứa data cá nhân)

**User nhận được khi `/ak-update`:**

- ✅ Auto-Learn Protocol (TIER 0 rule) → agent tự học ngay
- ✅ Tất cả Permanent Rules → kiến thức đã chắt lọc
- ✅ Giữ nguyên Recent lessons cá nhân → không mất data

---

## Rules (Permanent)

### 🚨 Pre-Publish Verification Gate — VS Code Extension

> **Áp dụng:** Mọi VS Code extension project khi publish lên Open VSX / Marketplace

**PATTERN:** Khi publish extension, PHẢI qua đủ 8 bước theo đúng thứ tự:

| Step | Action | Mục đích |
|------|--------|---------|
| 0 | **DETECT** — `git diff --stat` | Biết file nào sửa → biết cần build gì |
| 1 | **BUILD** — Rebuild module đã sửa | Frontend, backend, extension — chỉ build cái đã thay đổi |
| 2 | **SYNC** — Copy build output → dist/ | Đảm bảo dist/ chứa code mới nhất |
| 3 | **SMOKE TEST** — Verify dist/ chứa file mới | 30 giây kiểm tra tránh 1 hotfix version |
| 4 | **BUMP** — Tăng version trong package.json | Registry reject nếu trùng version |
| 5 | **COMMIT + PUSH** — Git | Source code và dist đồng bộ trên remote |
| 6 | **PACKAGE** — vsce package | Tạo VSIX từ dist/ |
| 7 | **PUBLISH** — ovsx publish | Đẩy lên marketplace |

**❌ KHÔNG BAO GIỜ:**

- Chạy `vsce package` mà chưa qua Step 0-3
- Skip smoke test — lỗi stale dist rất khó phát hiện nếu không verify
- Publish mà chưa commit — VSIX chứa code nhưng repo không track

---

### 🔄 Source-Dist Desync Pattern

> **Áp dụng:** Mọi project có build step (compile, bundle, transpile)

**Vấn đề:** Khi sửa source code nhưng KHÔNG rebuild → dist/build artifacts chứa code cũ → ship sản phẩm thiếu tính năng mới mà không biết.

**Các điểm failure phổ biến:**

| Source thay đổi | Build cần chạy | Hậu quả nếu quên |
|----------------|---------------|-------------------|
| Frontend (React/Next.js) | `npm run build` | UI mới không hiện |
| Backend (TypeScript) | `tsc` hoặc bundler | API mới không hoạt động |
| Extension (VS Code) | `npm run compile` | Commands mới không chạy |
| Config (package.json) | Rebuild all | Metadata cũ |

**Rule:** Sau mỗi code change, TỰ HỎI: "Có build step nào cần chạy lại không?"

---

### 📋 Multi-Step Publish = Checklist, Không Nhớ

> **Áp dụng:** Mọi quy trình có ≥3 bước tuần tự

**Vấn đề:** Con người (và AI) dễ quên bước ở giữa khi quy trình có nhiều bước. Đặc biệt nguy hiểm khi:

- Bước đầu và bước cuối rõ ràng (edit code → publish)
- Bước giữa "vô hình" (rebuild, sync dist, smoke test)

**Rule:** Nếu quy trình có ≥3 bước → GHI THÀNH CHECKLIST và follow từng bước. Không dựa vào trí nhớ.

---

### 🖥️ Node.js-First Terminal Commands (Windows)

> **Áp dụng:** Mọi project khi chạy trên Windows

**Vấn đề:** PowerShell và cmd.exe có syntax khác nhau. AI agent chạy qua PowerShell, npm scripts chạy qua cmd.exe. Lệnh viết cho 1 shell sẽ lỗi ở shell khác.

**Rule:**

| Loại command | Dùng gì | Ví dụ |
|-------------|---------|-------|
| **File ops** (copy/rm/rename/read) | Node.js `fs` module | `fs.copyFileSync()`, `fs.rmSync()` |
| **Environment vars** | `process.env` hoặc `execSync({env:})` | `env: { STATIC_EXPORT: 'true' }` |
| **Build scripts** | Gộp vào 1 file `.mjs` | `node build.mjs` thay 5 npm scripts |
| **Dev tools** (git/npm/node) | Shell trực tiếp | `git commit`, `npm install` |
| **Complex logic** | Tạo `.js` file riêng | KHÔNG dùng `node -e` với template literals |

**❌ KHÔNG BAO GIỜ dùng trong npm scripts/build:**

- `set VAR=val` (cmd only), `$env:VAR` (PS only), `export VAR` (bash only)
- `xcopy`, `copy`, `cp -r`, `Remove-Item`, `rm -rf` (shell-specific)

---

### ⛓️ PowerShell Chain Operator

> **Áp dụng:** Mọi project khi chạy trên Windows PowerShell 5.x

**Vấn đề:** PowerShell 5.x KHÔNG hỗ trợ `&&` operator → `ParserError: InvalidEndOfLine`

**Rule:**

- ❌ `cmd1 && cmd2 && cmd3` → FAIL trên PowerShell 5.x
- ✅ Chạy TỪNG LỆNH riêng biệt qua `run_command`
- ✅ Hoặc dùng `;` (chạy tiếp bất kể kết quả — kém an toàn)

---

## Recent

> Lessons tự động ghi bởi Auto-Learn Protocol. Mỗi user có Recent riêng.
