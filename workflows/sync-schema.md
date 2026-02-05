---
description: 🔄 Đồng bộ schema documentation với database
---

# WORKFLOW: /sync-schema - Đồng Bộ Schema

> **Context:** Agent `@doc-writer`
> **Required Skills:** `documentation-templates`
> **Key Behaviors:**
> - Đọc migrations → update docs
> - Check code vs schema
> - Cảnh báo khi có mismatch

Bạn là **AntiKit Schema Guardian**. Nhiệm vụ: Đảm bảo documentation luôn đồng bộ với database thực tế.

---

## Giai đoạn 1: Quét Migrations

### 1.1. Đọc tất cả migration files
```
migrations/
├── 0001_init.sql
├── 0002_users.sql
├── ...
└── XXXX_latest.sql
```

### 1.2. Phân tích schema hiện tại
- Liệt kê TẤT CẢ tables
- Liệt kê TẤT CẢ columns
- Ghi nhận data types và defaults

---

## Giai đoạn 2: So Sánh Với Docs

### 2.1. Đọc docs hiện tại
- `docs/database/schema.md`
- `src/lib/db/schema.ts`
- `.brain/brain.json` → database_schema section

### 2.2. Phát hiện differences
- Columns trong migrations nhưng KHÔNG có trong docs → ⚠️ MISSING DOC
- Columns trong docs nhưng KHÔNG có trong migrations → ⚠️ STALE DOC
- Type mismatch → ⚠️ INCORRECT DOC

---

## Giai đoạn 3: Cập Nhật Docs

### 3.1. Update docs/database/schema.md
- Thêm columns mới
- Xóa columns không còn tồn tại
- Cập nhật business rules nếu cần

### 3.2. Update src/lib/db/schema.ts
- Sync TypeScript interfaces
- Update CRITICAL_COLUMNS nếu cần

### 3.3. Update .brain/brain.json
- Sync database_schema section
- Update updated_at timestamp

---

## Giai đoạn 4: Validation

### 4.1. Check code references
- Grep tất cả API routes cho column references
- Verify columns được dùng đều có trong schema

### 4.2. Check CRITICAL_COLUMNS
- Confirm critical columns vẫn tồn tại
- Warn nếu code remove critical column

---

## Giai đoạn 5: Báo Cáo

```
📊 Schema Sync Report:
- Tables: X
- Total columns: Y
- New columns added: Z
- Stale columns removed: W
- Critical columns verified: ✅

📁 Files updated:
- docs/database/schema.md
- src/lib/db/schema.ts
- .brain/brain.json
```

---

## 🚨 CRITICAL COLUMNS

Những columns KHÔNG ĐƯỢC XÓA (check trước khi modify):

| Column | Business Purpose |
|--------|------------------|
| `products.size` | Shipping fee calculation |
| `products.cost_price` | Profit calculation |
| `products.selling_price` | Profit calculation |
| `orders.platform` | Composite primary key |
| `prefectures.aliases` | Address normalization |

---

## ⚠️ BƯỚC TIẾP THEO:
```
1️⃣ Docs đã sync? /save-brain để lưu
2️⃣ Cần thêm migration? Tạo file rồi /sync-schema lại
3️⃣ Cần check code? grep để verify column usage
```
