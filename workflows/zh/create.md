---
description: 创建新应用程序。触发App Builder技能并与用户开始交互对话。
---

# /create - 创建应用

$ARGUMENTS

---

## 任务

此命令启动新的应用程序创建流程。

### 步骤:

1. **需求分析**
   - 理解用户需求
   - 如信息不足，提问补充

2. **项目规划**
   - 使用 `project-planner` 代理进行任务分解
   - 确定技术栈
   - 规划文件结构
   - 创建计划文件并开始构建

3. **应用构建（批准后）**
   - 使用 `app-builder` 技能进行编排
   - 协调专家代理:
     - `database-architect` → 数据库设计
     - `backend-specialist` → API
     - `frontend-specialist` → UI

4. **预览**
   - 完成后使用 `auto_preview.py` 启动
   - 向用户展示URL

---

## 使用示例

```
/create 博客网站
/create 带商品列表和购物车的电商应用
/create TODO应用
/create Instagram克隆
/create 客户管理CRM系统
```

---

## 开始前

如果请求不明确，询问以下问题:
- 什么类型的应用？
- 基本功能是什么？
- 谁会使用？

使用默认值，后续添加细节。
