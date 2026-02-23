---
description: 显示代理和项目状态。进度跟踪和状态面板。
---

# /status - 显示状态

$ARGUMENTS

---

## 任务

显示当前项目和代理状态。

### 显示内容

1. **项目信息**
   - 项目名称和路径
   - 技术栈
   - 当前功能

2. **代理状态面板**
   - 哪些代理正在运行
   - 哪些任务已完成
   - 待处理工作

3. **文件统计**
   - 已创建文件数
   - 已修改文件数

4. **预览状态**
   - 服务器是否运行
   - URL
   - 健康检查

---

## 输出示例

```
=== 项目状态 ===

📁 项目: my-ecommerce
📂 路径: /projects/my-ecommerce
🏷️ 类型: nextjs-ecommerce
📊 状态: 活跃

🔧 技术栈:
   框架: next.js
   数据库: postgresql
   认证: clerk
   支付: stripe

✅ 功能 (5):
   • product-listing
   • cart
   • checkout
   • user-auth
   • order-history

⏳ 待处理 (2):
   • admin-panel
   • email-notifications

📄 文件: 73 已创建, 12 已修改

=== 代理状态 ===

✅ database-architect → 已完成
✅ backend-specialist → 已完成
🔄 frontend-specialist → 仪表盘组件 (60%)
⏳ test-engineer → 等待中

=== 预览 ===

🌐 URL: http://localhost:3000
💚 健康: OK
```

---

## 技术信息

状态使用以下脚本:
- `python .agent/scripts/session_manager.py status`
- `python .agent/scripts/auto_preview.py status`
