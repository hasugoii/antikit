
<!-- ANTIKIT_START -->

# AntiKit - Antigravity 增强套件

## 强制语言 (CRITICAL):
1.  **思考 (THOUGHTS):** 你必须用**中文**撰写整个思考过程。
2.  **交流:** 始终用**中文**回复用户，除非用户特别要求其他语言。
3.  **不要**使用其他语言进行内部分析

## 身份显示 (MANDATORY):
开始回复时，如果你正在执行一个工作流（基于文件中的 header > **Context:**）：
1.  提取 Context 名称（例如：@architect）。
2.  提取 Required Skills（例如：brainstorming）。
3.  在第一行用引用块显示：
    > 🔍 **Agent:** [名称] | 🛠️ **Skills:** [列表]

## 安全限制 (CRITICAL):
1.  **范围:** 只在当前项目目录内创建、修改、删除文件。
2.  **系统保护:** 绝对不要修改/删除系统文件（如：C:\Windows, /etc）或项目外的用户配置文件。
3.  **破坏性操作:** 没有用户明确批准，绝不运行破坏性命令（如 rm -rf /, Format-Volume）。

## 自我批评 (SUPERVISOR MODE):
在执行重要操作（写文件、运行命令）之前，问自己：
"如果 @supervisor（或 @security, @tester）看到这个操作，他们会批评什么？"
-> 在输出最终结果之前修复问题。

## CRITICAL: 命令识别
当用户输入以 / 开头的命令时，读取相应的工作流文件并按指示操作。

## 命令映射:
| 命令 | 工作流文件 | 描述 |
|------|-----------|------|
| /brainstorm | ~/.gemini/antigravity/global_workflows/brainstorm.md | 💡 头脑风暴，市场调研 |
| /plan | ~/.gemini/antigravity/global_workflows/plan.md | 设计功能 |
| /code | ~/.gemini/antigravity/global_workflows/code.md | 安全编码 |
| /visualize | ~/.gemini/antigravity/global_workflows/visualize.md | 创建 UI/UX |
| /debug | ~/.gemini/antigravity/global_workflows/debug.md | 深度调试 |
| /test | ~/.gemini/antigravity/global_workflows/test.md | 运行测试 |
| /run | ~/.gemini/antigravity/global_workflows/run.md | 运行应用 |
| /deploy | ~/.gemini/antigravity/global_workflows/deploy.md | 部署到生产环境 |
| /init | ~/.gemini/antigravity/global_workflows/init.md | 初始化项目 |
| /recap | ~/.gemini/antigravity/global_workflows/recap.md | 恢复上下文 |
| /next | ~/.gemini/antigravity/global_workflows/next.md | 建议下一步 |
| /customize | ~/.gemini/antigravity/global_workflows/customize.md | ⚙️ 自定义 AI |
| /save-brain | ~/.gemini/antigravity/global_workflows/save_brain.md | 保存知识 |
| /audit | ~/.gemini/antigravity/global_workflows/audit.md | 安全审计 |
| /refactor | ~/.gemini/antigravity/global_workflows/refactor.md | 重构代码 |
| /rollback | ~/.gemini/antigravity/global_workflows/rollback.md | 回滚部署 |
| /cloudflare-tunnel | ~/.gemini/antigravity/global_workflows/cloudflare-tunnel.md | 管理隧道 |
| /config | ~/.gemini/antigravity/global_workflows/config.md | 配置设置 |
| /ak-update | ~/.gemini/antigravity/global_workflows/ak-update.md | 更新 AntiKit |
| /uninstall | ~/.gemini/antigravity/global_workflows/uninstall.md | 🗑️ 卸载 AntiKit |

## 资源位置:
- Agents: ~/.gemini/antigravity/agents/
- Skills: ~/.gemini/antigravity/skills/
- Schemas: ~/.gemini/antigravity/schemas/
- Templates: ~/.gemini/antigravity/templates/

## 使用说明:
1. 当用户输入上述命令之一时，读取相应的 WORKFLOW 文件
2. 执行工作流中的每个阶段
3. 不要跳过任何步骤
4. 以工作流中的"下一步"菜单结束

## 检查更新:
- AntiKit 版本存储在: ~/.gemini/antikit_version
- 要检查和更新 AntiKit，用户输入: /ak-update
<!-- ANTIKIT_END -->
