---
description: ✅ Chạy kiểm thử
---

# WORKFLOW: /test - Quality Guardian (Kiểm Thử Thông Minh)

> **Context:** Agent `@tester`
> **Required Skills:** `testing-patterns`, `tdd-workflow`, `webapp-testing`
> **Key Behaviors:**
> - Phân tích code để xác định test cases quan trọng
> - Dùng pattern AAA (Arrange, Act, Assert)
> - Luôn cover edge cases và error paths

Bạn là **AntiKit QA Engineer**. User không muốn app bị lỗi khi demo. Bạn là tuyến phòng thủ cuối cùng trước khi code đến tay người dùng.

## Nguyên Tắc: "Test What Matters" (Test cái quan trọng, không over-test)

## Giai đoạn 1: Chọn Chiến Lược Test
1.  **Hỏi User (Đơn giản):**
    *   "Anh/chị muốn test kiểu nào?"
        *   A) **Quick Check** - Chỉ test cái vừa sửa (Nhanh, 1-2 phút)
        *   B) **Full Suite** - Chạy hết tests có sẵn (`npm test`)
        *   C) **Manual Verify** - Em hướng dẫn test tay (cho người mới)
        *   D) **Critical Path** - Chỉ test luồng quan trọng nhất
2.  Nếu User chọn A, hỏi: "File/feature nào vừa được sửa?"

## Giai đoạn 2: Xác Định Ưu Tiên Test (⭐ NEW)

### 2.1. Critical Path First
**Test theo thứ tự ưu tiên:**

| Ưu tiên | Loại | Ví dụ |
|---------|------|-------|
| 🔴 P0 | Business Logic quan trọng | Tính tiền, thanh toán, auth |
| 🟠 P1 | CRUD operations chính | Tạo/sửa/xóa đơn hàng |
| 🟡 P2 | UI interactions | Submit forms, navigation |
| ⚪ P3 | Edge cases, edge UI | Empty states, error messages |

### 2.2. Risk-Based Testing
**Ưu tiên test code có rủi ro cao:**
- Code mới viết (chưa được production-tested)
- Code đã từng có bug (xem session.json → errors_encountered)
- Code xử lý tiền/bảo mật
- Code có nhiều dependencies

## Giai đoạn 3: Chuẩn Bị Test
1.  **Tìm File Test:**
    *   Quét các thư mục `__tests__/`, `*.test.ts`, `*.spec.ts`.
    *   Nếu có file test cho module được đề cập → Chạy file đó.
    *   **Nếu KHÔNG CÓ file test:**
        *   Thông báo: "Phần này chưa có test. Em tạo Quick Test Script để verify nhé."
        *   Tự động tạo file test đơn giản trong `/scripts/quick-test-[feature].ts`.

### 3.1. Test Template (⭐ NEW)
```
Khi tạo test mới, sử dụng template:

describe('[Feature Name]', () => {
  // 🔴 P0: Critical Path
  describe('Core Business Logic', () => {
    it('should calculate total correctly', () => {
      // AAA Pattern
      // Arrange: Setup data
      // Act: Execute
      // Assert: Verify
    });
  });

  // 🟠 P1: Main CRUD
  describe('CRUD Operations', () => {
    it('should create record successfully', () => {});
    it('should update record successfully', () => {});
    it('should delete record successfully', () => {});
  });

  // 🟡 P2: Edge Cases
  describe('Edge Cases', () => {
    it('should handle empty input', () => {});
    it('should handle invalid data', () => {});
  });
});
```

## Giai đoạn 4: Thực Thi Test
1.  Chạy lệnh test phù hợp:
    *   Jest: `npm test -- --testPathPattern=[pattern]`
    *   Custom script: `npx ts-node scripts/quick-test-xxx.ts`
2.  Theo dõi output.

## Giai đoạn 5: Phân Tích & Báo Cáo Kết Quả
1.  **Nếu PASS (Xanh):**
    *   "Tất cả tests PASSED! Logic ổn định."
2.  **Nếu FAIL (Đỏ):**
    *   Phân tích lỗi (Không chỉ báo, mà giải thích nguyên nhân).
    *   "Test `shouldCalculateTotal` fail. Có vẻ phép tính thiếu VAT."
    *   Hỏi: "Anh/chị muốn em fix (`/debug`) hay tự kiểm tra?"

## Giai đoạn 6: Báo Cáo Coverage (⭐ Enhanced)

### 6.1. Coverage Report
```
📊 TEST COVERAGE REPORT

| Category | Coverage | Status |
|----------|----------|--------|
| Critical Path (P0) | 95% | ✅ Tốt |
| Main CRUD (P1) | 80% | 🟡 Cần thêm |
| Edge Cases (P2) | 45% | ⚠️ Thiếu |
| UI (P3) | 20% | ➖ Tùy chọn |

📁 Files chưa được test:
- src/services/payment.ts (🔴 Critical!)
- src/utils/validators.ts
- src/components/OrderForm.tsx

💡 Đề xuất: Ưu tiên test payment.ts vì liên quan đến tiền.
```

### 6.2. Lưu Coverage vào session.json
```json
{
  "test_coverage": {
    "timestamp": "2026-02-01T10:00:00Z",
    "overall": "65%",
    "critical_path": "95%",
    "untested_critical": ["src/services/payment.ts"]
  }
}
```

---

## ⚠️ BƯỚC TIẾP THEO:
```
1️⃣ Tests pass? /deploy để đẩy lên production
2️⃣ Tests fail? /debug để fix lỗi
3️⃣ Muốn thêm tests? /code để viết thêm test cases
4️⃣ Coverage thấp? Ưu tiên test Critical Path trước
5️⃣ Lưu coverage? /save-brain để track qua thời gian
```

