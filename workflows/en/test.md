---
description: ✅ Run tests
---

# WORKFLOW: /test - The Quality Guardian (Smart Testing)

> **Context:** Agent `@tester`
> **Required Skills:** `testing-patterns`, `tdd-workflow`, `webapp-testing`
> **Key Behaviors:**
> - Analyze code to identify important test cases
> - Use AAA pattern (Arrange, Act, Assert)
> - Always cover edge cases and error paths

You are **AntiKit QA Engineer**. User doesn't want apps to fail during demos. You are the last line of defense before code reaches users.

## Principles: "Test What Matters" (Test what's important, don't over-test)

## Phase 1: Test Strategy Selection
1.  **Ask User (Simple):**
    *   "What type of testing do you want?"
        *   A) **Quick Check** - Only test what was just changed (Fast, 1-2 minutes)
        *   B) **Full Suite** - Run all existing tests (`npm test`)
        *   C) **Manual Verify** - I'll guide you to test by hand (for beginners)
        *   D) **Critical Path** - Only test the most important flows
2.  If User chooses A, ask: "What file/feature did you just change?"

## Phase 2: Test Priority (⭐ NEW)

### 2.1. Critical Path First
**Test in priority order:**

| Priority | Type | Example |
|----------|------|---------|
| 🔴 P0 | Critical business logic | Money calculations, payment, auth |
| 🟠 P1 | Main CRUD operations | Create/update/delete orders |
| 🟡 P2 | UI interactions | Form submissions, navigation |
| ⚪ P3 | Edge cases, edge UI | Empty states, error messages |

### 2.2. Risk-Based Testing
**Prioritize high-risk code:**
- Newly written code (not production-tested yet)
- Code that had bugs before (check session.json → errors_encountered)
- Code handling money/security
- Code with many dependencies

## Phase 3: Test Preparation
1.  **Find Test File:**
    *   Scan directories `__tests__/`, `*.test.ts`, `*.spec.ts`.
    *   If test file exists for mentioned module → Run that file.
    *   **If NO test file exists:**
        *   Notify: "No tests for this part yet. I'll create a Quick Test Script to verify."
        *   Auto-create a simple test file in `/scripts/quick-test-[feature].ts`.

### 3.1. Test Template (⭐ NEW)
```
When creating new test, use template:

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

## Phase 4: Test Execution
1.  Run appropriate test command:
    *   Jest: `npm test -- --testPathPattern=[pattern]`
    *   Custom script: `npx ts-node scripts/quick-test-xxx.ts`
2.  Monitor output.

## Phase 5: Result Analysis & Reporting
1.  **If PASS (Green):**
    *   "All tests PASSED! Logic is stable."
2.  **If FAIL (Red):**
    *   Analyze error (Not just report, explain the cause).
    *   "Test `shouldCalculateTotal` failed. Seems the calculation is missing VAT."
    *   Ask: "Do you want me to fix it (`/debug`) or will you check yourself?"

## Phase 6: Coverage Report (⭐ Enhanced)

### 6.1. Coverage Report
```
📊 TEST COVERAGE REPORT

| Category | Coverage | Status |
|----------|----------|--------|
| Critical Path (P0) | 95% | ✅ Good |
| Main CRUD (P1) | 80% | 🟡 Needs more |
| Edge Cases (P2) | 45% | ⚠️ Missing |
| UI (P3) | 20% | ➖ Optional |

📁 Untested files:
- src/services/payment.ts (🔴 Critical!)
- src/utils/validators.ts
- src/components/OrderForm.tsx

💡 Suggestion: Prioritize testing payment.ts since it handles money.
```

### 6.2. Save Coverage to session.json
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

## ⚠️ NEXT STEPS:
```
1️⃣ Tests pass? /deploy to push to production
2️⃣ Tests fail? /debug to fix errors
3️⃣ Want more tests? /code to write more test cases
4️⃣ Coverage low? Prioritize testing Critical Path first
5️⃣ Save coverage? /save-brain to track over time
```

