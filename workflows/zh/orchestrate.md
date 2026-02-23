---
description: 协调多个代理处理复杂任务。多视角分析、综合评审或需要不同领域专业知识的任务。
---

# 多代理编排

你现在处于 **编排模式**。任务: 协调专业代理来解决这个复杂问题。

## 编排对象
$ARGUMENTS

---

## 🔴 关键: 最低代理要求

> ⚠️ **编排 = 最少3个不同代理**
>
> 少于3个 → 不是编排，只是委派。
>
> **完成前验证:**
> - 统计调用的代理数量
> - 如果 `agent_count < 3` → 停止并增加代理
> - 单个代理 = 编排失败

### 代理选择矩阵

| 任务类型 | 必需代理 (最少) |
|---------|---------------|
| **Web应用** | frontend-specialist, backend-specialist, test-engineer |
| **API** | backend-specialist, security-auditor, test-engineer |
| **UI/设计** | frontend-specialist, seo-specialist, performance-optimizer |
| **数据库** | database-architect, backend-specialist, security-auditor |
| **全栈** | project-planner, frontend-specialist, backend-specialist, devops-engineer |
| **调试** | debugger, explorer-agent, test-engineer |
| **安全** | security-auditor, penetration-tester, devops-engineer |

---

## 🔴 严格的两阶段编排

### 阶段1: 规划（顺序执行 - 无并行代理）

| 步骤 | 代理 | 操作 |
|-----|------|-----|
| 1 | `project-planner` | 创建 docs/PLAN.md |
| 2 | (可选) `explorer-agent` | 需要时进行代码库调查 |

> 🔴 **规划期间禁止其他代理!**

### ⏸️ 检查点: 用户批准

```
PLAN.md完成后，确认:

"✅ 计划已创建: docs/PLAN.md

是否批准? (Y/N)
- Y: 开始实施
- N: 我会修改计划"
```

> 🔴 **未经用户明确批准，不得进入阶段2!**

### 阶段2: 实施（批准后 - 并行代理）

| 并行组 | 代理 |
|-------|------|
| 基础 | `database-architect`, `security-auditor` |
| 核心 | `backend-specialist`, `frontend-specialist` |
| 完善 | `test-engineer`, `devops-engineer` |

---

## 输出格式

```markdown
## 🎼 编排报告

### 任务
[原始任务摘要]

### 调用的代理 (最少3个)
| # | 代理 | 负责领域 | 状态 |
|---|------|---------|-----|
| 1 | project-planner | 任务分解 | ✅ |
| 2 | frontend-specialist | UI实现 | ✅ |
| 3 | test-engineer | 验证 | ✅ |

### 总结
[所有代理工作的综合概述]
```

---

## 🔴 退出检查

完成前验证:
1. ✅ **代理数量:** `invoked_agents >= 3`
2. ✅ **验证执行:** 至少运行了 `security_scan.py`
3. ✅ **报告生成:** 包含所有代理的报告

**立即开始编排。选择3+代理，执行，综合结果。**
