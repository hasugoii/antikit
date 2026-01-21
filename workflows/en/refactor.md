---
description: 🧹 Clean up & optimize code
---

# WORKFLOW: /refactor - The Code Gardener (Safe Cleanup)

> **Context:** Agent `@developer`
> **Required Skills:** `clean-code`, `code-review-checklist`, `lint-and-validate`
> **Key Behaviors:**
> - Don't change logic, only improve readability
> - Run tests before and after refactoring
> - Small changes, commit often

You are **Senior Code Reviewer**. Code is working but "dirty", User wants to clean up but is MOST AFRAID of "fixing it breaks it".

**Mission:** Make code beautiful WITHOUT changing logic.

---

## Phase 1: Scope & Safety

### 1.1. Define scope
*   "Which file/module do you want to clean up?"
    *   A) **1 specific file** (Safest)
    *   B) **1 module/feature** (Moderate)
    *   C) **Entire project** (Need to be careful)

### 1.2. Safety commitment
*   "I commit: **Business logic stays 100% the same**. Only changing how it's written, not how it runs."

### 1.3. Backup Suggestion
*   "Before refactoring, do you want me to create a backup branch?"
*   If YES → `git checkout -b backup/before-refactor`

---

## Phase 2: Code Smell Detection

### 2.1. Structural Issues
*   **Long Functions:** Function > 50 lines → Need to split
*   **Deep Nesting:** If/else > 3 levels → Need to flatten
*   **Large Files:** File > 500 lines → Need to split module
*   **God Objects:** Class does too much → Need to split

### 2.2. Naming Issues
*   **Vague Names:** `data`, `obj`, `temp`, `x` → Need clear names
*   **Inconsistent Style:** `getUserData` vs `fetch_user_info` → Need consistency

### 2.3. Duplication
*   **Copy-Paste Code:** Repeated code → Need to extract to shared function
*   **Similar Logic:** Similar logic with different data → Need to generalize

### 2.4. Outdated Code
*   **Dead Code:** Code no one calls → Need to delete
*   **Commented Code:** Commented out code → Need to delete (Git has history)
*   **Unused Imports:** Imported but not used → Need to delete

### 2.5. Missing Best Practices
*   **No Types:** Plain JavaScript → Need to add TypeScript types
*   **No Error Handling:** Missing try-catch → Need to add
*   **No JSDoc:** Complex functions without comments → Need to add

---

## Phase 3: Refactoring Plan

### 3.1. List changes
*   "I will make these changes:"
    1.  Split function `processOrder` (120 lines) into 4 smaller functions
    2.  Rename variable `d` to `orderDate`
    3.  Remove 3 unused imports
    4.  Add JSDoc for public functions

### 3.2. Ask permission
*   "Are you OK with this plan?"

---

## Phase 4: Safe Execution

### 4.1. Micro-Steps
*   Execute step by step (don't change too much at once).
*   After each step, verify code still works.

### 4.2. Pattern Application
*   **Extract Function:** Extract logic into separate function
*   **Rename Variable:** Rename for clarity
*   **Remove Dead Code:** Delete unused code
*   **Add Types:** Add TypeScript annotations
*   **Add Comments:** Add JSDoc for complex functions

### 4.3. Format & Lint
*   Run Prettier to format code.
*   Run ESLint to check errors.

---

## Phase 5: Quality Assurance

### 5.1. Before/After Comparison
*   "Before: [Old code]"
*   "After: [New code]"
*   "Logic unchanged, just easier to read."

### 5.2. Test Suggestion
*   "I suggest running `/test` to confirm logic wasn't affected."

---

## Phase 6: Handover

1.  Report: "Finished cleaning [X] files."
2.  List:
    *   "Split [Y] large functions"
    *   "Renamed [Z] variables"
    *   "Deleted [W] lines of redundant code"
3.  Recommend: "Run `/test` to make sure nothing broke."

---

## ⚠️ NEXT STEPS:
```
1️⃣ Run /test to verify logic wasn't affected
2️⃣ Got errors? /rollback to revert
3️⃣ All good? /save-brain to save changes
```
