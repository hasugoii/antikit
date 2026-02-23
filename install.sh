#!/bin/bash
# AntiKit Installer for macOS/Linux
# Direct download approach - inspired by AWF
# https://github.com/hasugoii/antikit

REPO_BASE="https://raw.githubusercontent.com/hasugoii/antikit/main"

# Workflows (will use selected language)
WORKFLOWS=(
    "ak-update.mdt" "audit.mdt" "brainstorm.mdt" "code.mdt" "config.mdt"
    "debug.mdt" "deploy.mdt" "init.mdt" "next.mdt" "plan.mdt" "recap.mdt"
    "refactor.mdt" "run.mdt" "test.mdt" "uninstall.mdt" "visualize.mdt"
)

# Agents
AGENTS=(
    "backend-specialist.mdt" "code-archaeologist.mdt" "database-architect.mdt"
    "debugger.mdt" "devops-engineer.mdt" "documentation-writer.mdt"
    "explorer-agent.mdt" "frontend-specialist.mdt" "game-developer.mdt"
    "mobile-developer.mdt" "orchestrator.mdt" "penetration-tester.mdt"
    "performance-optimizer.mdt" "product-manager.mdt" "product-owner.mdt"
    "project-planner.mdt" "qa-automation-engineer.mdt" "security-auditor.mdt"
    "seo-specialist.mdt" "test-engineer.mdt"
)

# Schemas
SCHEMAS=(
    "brain.schema.json" "preferences.schema.json" "session.schema.json"
)

# Templates
TEMPLATES=(
    "brain.example.json" "preferences.example.json" "session.example.json"
)

# Skills (directories with SKILL.md inside)
SKILLS=(
    "api-patterns" "app-builder" "architecture" "bash-linux" "behavioral-modes"
    "brainstorming" "clean-code" "code-review-checklist" "database-design"
    "deployment-procedures" "docker-expert" "documentation-templates" "evidence-discipline" "frontend-design"
    "game-development" "geo-fundamentals" "growth-marketing" "i18n-localization" "lint-and-validate"
    "mcp-builder" "mobile-design" "nestjs-expert" "nextjs-expert" "nodejs-best-practices"
    "parallel-agents" "performance-profiling" "plan-writing" "powershell-windows" "proactive-intelligence"
    "prisma-expert" "python-patterns" "react-patterns" "red-team-tactics"
    "seo-fundamentals" "server-management" "systematic-debugging" "tailwind-patterns"
    "tdd-workflow" "testing-patterns" "typescript-expert" "ui-ux-pro-max"
    "vulnerability-scanner" "webapp-testing"
)

# Paths
ANTIGRAVITY_DIR="$HOME/.gemini/antigravity"
GLOBAL_WORKFLOWS="$ANTIGRAVITY_DIR/global_workflows"
AGENTS_DIR="$ANTIGRAVITY_DIR/agents"
SCHEMAS_DIR="$ANTIGRAVITY_DIR/schemas"
TEMPLATES_DIR="$ANTIGRAVITY_DIR/templates"
SKILLS_DIR="$ANTIGRAVITY_DIR/skills"
GEMINI_MD="$HOME/.gemini/GEMINI.md"
VERSION_FILE="$HOME/.gemini/antikit_version"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m'

# Get version from repo
CURRENT_VERSION=$(curl -s "$REPO_BASE/VERSION" 2>/dev/null || echo "1.0.0")

echo ""
echo -e "${MAGENTA}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${MAGENTA}║       🚀 AntiKit - Enhancement Kit for Antigravity       ║${NC}"
echo -e "${MAGENTA}║                        v${CURRENT_VERSION}                           ║${NC}"
echo -e "${MAGENTA}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""

# Check if updating
if [ -f "$VERSION_FILE" ]; then
    OLD_VERSION=$(cat "$VERSION_FILE")
    echo -e "${YELLOW}📦 Current version: $OLD_VERSION${NC}"
    echo -e "${GREEN}📦 New version: $CURRENT_VERSION${NC}"
    echo ""
fi

# Language selection
LANG_FILE="$HOME/.gemini/antikit_language"
LANG="en" # Default
CLI_LANG=""

# 0. Parse CLI arguments (e.g., --lang vi)
while [ $# -gt 0 ]; do
    case "$1" in
        --lang)
            CLI_LANG="$2"
            shift 2
            ;;
        --lang=*)
            CLI_LANG="${1#*=}"
            shift
            ;;
        *)
            shift
            ;;
    esac
done

# 1. CLI argument has highest priority
if [ -n "$CLI_LANG" ]; then
    LANG="$CLI_LANG"
    echo -e "${GREEN}✅ Using language from --lang: $LANG${NC}"
# 2. Try to load from config if exists
elif [ -f "$LANG_FILE" ]; then
    LANG=$(cat "$LANG_FILE")
    echo -e "${GREEN}✅ Auto-detected language: $LANG${NC}"
else
    # 3. Prompt user (only works in interactive terminal, not piped)
    if [ -t 0 ]; then
        echo -e "${CYAN}🌐 Select language for workflows:${NC}"
        echo "   1. English (en)"
        echo "   2. Japanese (ja)"
        echo "   3. Vietnamese (vi)"
        echo "   4. Chinese (zh)"
        echo ""
        read -p "Enter choice (1-4, default: 1): " lang_choice

        case $lang_choice in
            2) LANG="ja" ;;
            3) LANG="vi" ;;
            4) LANG="zh" ;;
            *) LANG="en" ;;
        esac
        echo -e "${GREEN}✅ Selected language: $LANG${NC}"
    else
        echo -e "${YELLOW}⚠️  Non-interactive mode: defaulting to English${NC}"
        echo -e "${YELLOW}   To install in another language, use: --lang vi${NC}"
        echo -e "${YELLOW}   Example: curl -fsSL .../install.sh | bash -s -- --lang vi${NC}"
    fi
fi
echo ""

success=0
failed=0

# 1. Create directories
mkdir -p "$ANTIGRAVITY_DIR" "$GLOBAL_WORKFLOWS" "$AGENTS_DIR" "$SCHEMAS_DIR" "$TEMPLATES_DIR" "$SKILLS_DIR"
echo -e "${GREEN}📂 Directories ready: $ANTIGRAVITY_DIR${NC}"

# 1.5. Clean old files (remove renamed/obsolete agents)
OLD_AGENTS=("architect.md" "backend.md" "database.md" "devops.md" "doc-writer.md"
    "explorer.md" "frontend.md" "game.md" "mobile.md" "pentester.md"
    "performance.md" "security.md" "seo.md" "tester.md")
cleaned=0
for old in "${OLD_AGENTS[@]}"; do
    if [ -f "$AGENTS_DIR/$old" ]; then
        rm -f "$AGENTS_DIR/$old"
        ((cleaned++))
    fi
done
if [ $cleaned -gt 0 ]; then
    echo -e "${YELLOW}🧹 Cleaned $cleaned old agent files${NC}"
fi

# 2. Download Workflows
echo ""
echo -e "${CYAN}⏳ Downloading workflows ($LANG)...${NC}"
for wf in "${WORKFLOWS[@]}"; do
    out_name="${wf%.mdt}.md"
    if curl -f -s -o "$GLOBAL_WORKFLOWS/$out_name" "$REPO_BASE/workflows/$LANG/$wf"; then
        echo -e "   ${GREEN}✅ $out_name${NC}"
        ((success++))
    else
        echo -e "   ${RED}❌ $out_name${NC}"
        ((failed++))
    fi
done

# 3. Download Agents
echo ""
echo -e "${CYAN}⏳ Downloading agents...${NC}"
for agent in "${AGENTS[@]}"; do
    out_name="${agent%.mdt}.md"
    if curl -f -s -o "$AGENTS_DIR/$out_name" "$REPO_BASE/src/agents/$agent"; then
        echo -e "   ${GREEN}✅ $out_name${NC}"
        ((success++))
    else
        echo -e "   ${RED}❌ $out_name${NC}"
        ((failed++))
    fi
done

# 4. Download Schemas
echo ""
echo -e "${CYAN}⏳ Downloading schemas...${NC}"
for schema in "${SCHEMAS[@]}"; do
    if curl -f -s -o "$SCHEMAS_DIR/$schema" "$REPO_BASE/schemas/$schema"; then
        echo -e "   ${GREEN}✅ $schema${NC}"
        ((success++))
    else
        echo -e "   ${RED}❌ $schema${NC}"
        ((failed++))
    fi
done

# 5. Download Templates
echo ""
echo -e "${CYAN}⏳ Downloading templates...${NC}"
for template in "${TEMPLATES[@]}"; do
    if curl -f -s -o "$TEMPLATES_DIR/$template" "$REPO_BASE/templates/$template"; then
        echo -e "   ${GREEN}✅ $template${NC}"
        ((success++))
    else
        echo -e "   ${RED}❌ $template${NC}"
        ((failed++))
    fi
done

# 6. Download Skills
echo ""
echo -e "${CYAN}⏳ Downloading skills...${NC}"
for skill in "${SKILLS[@]}"; do
    mkdir -p "$SKILLS_DIR/$skill"
    if curl -f -s -o "$SKILLS_DIR/$skill/SKILL.md" "$REPO_BASE/src/skills/$skill/SKILL.mdt"; then
        echo -e "   ${GREEN}✅ $skill${NC}"
        ((success++))
    else
        echo -e "   ${RED}❌ $skill${NC}"
        ((failed++))
    fi
done

# 7. Save version and language
mkdir -p "$HOME/.gemini"
echo "$CURRENT_VERSION" > "$VERSION_FILE"
LANG_FILE="$HOME/.gemini/antikit_language"
echo "$LANG" > "$LANG_FILE"
echo ""
echo -e "${GREEN}✅ Version saved: $CURRENT_VERSION${NC}"
echo -e "${GREEN}✅ Language saved: $LANG${NC}"

# 8. Update Global Rules (GEMINI.md) - Language specific
case $LANG in
    "vi")
        ANTIKIT_INSTRUCTIONS='
# AntiKit - Enhancement Kit for Antigravity

## NGÔN NGỮ BẮT BUỘC (CRITICAL):
1.  **SUY NGHĨ (THOUGHTS):** Bạn PHẢI viết toàn bộ quy trình suy nghĩ (thought process) bằng **TIẾNG VIỆT**.
2.  **TRAO ĐỔI:** Luôn trả lời user bằng **TIẾNG VIỆT**, trừ khi user yêu cầu cụ thể ngôn ngữ khác.
3.  **KHÔNG** dùng tiếng Anh cho phân tích nội bộ.

## HIỂN THỊ DANH TÍNH (MANDATORY):
KHI BẮT ĐẦU phản hồi, BẠN PHẢI:
1.  Xác định **PRIMARY** agent (từ workflow `> **Context:**` hoặc match keywords trong AGENT INDEX). PRIMARY luôn chỉ có 1. Nếu ≥3 domains → PRIMARY = `orchestrator`.
2.  Chọn ít nhất **1 SUPPORT** agent từ AGENT INDEX (match keywords khác trong request). LUÔN LUÔN có SUPPORT. Nếu ≥3 domains → dùng nhiều SUPPORT.
3.  Trích xuất `Required Skills` từ cả PRIMARY và SUPPORT.
4.  Hiển thị ở dòng ĐẦU TIÊN:
    `> 🤖 **PRIMARY:** @[agent] | **SUPPORT:** @[agent2], @[...] | 🛠️ **Skills:** [danh sách]`

## ĐỊNH DẠNG PHẢN HỒI (MANDATORY):
Khi đưa ra lựa chọn cho user (bước tiếp theo, menu, options), LUÔN hiển thị dạng **DANH SÁCH DỌC** (mỗi option 1 dòng riêng). KHÔNG BAO GIỜ viết tất cả options trên 1 hàng ngang.

## GIỚI HẠN AN TOÀN (CRITICAL):
1.  **PHẠM VI:** CHỈ tạo, sửa, xóa file TRONG thư mục dự án hiện tại.
2.  **BẢO VỆ HỆ THỐNG:** TUYỆT ĐỐI KHÔNG sửa/xóa file hệ thống (ví dụ: `C:\Windows`, `/etc`) hoặc file cấu hình user bên ngoài dự án.
3.  **HÀNH ĐỘNG HỦY DIỆT:** KHÔNG BAO GIỜ chạy lệnh hủy diệt (như `rm -rf /`, `Format-Volume`) nếu không có sự chấp thuận rõ ràng từ user.

## TỰ PHẢN BIỆN (SUPERVISOR MODE):
Trước khi thực hiện một hành động quan trọng (viết file, chạy lệnh), hãy tự hỏi:
"Nếu @supervisor (hoặc @security, @tester) nhìn vào hành động này, họ sẽ phê bình điều gì?"
-> Hãy tự sửa lỗi TRƯỚC khi đưa ra output cuối cùng.

## CRITICAL: Nhận Diện Lệnh
Khi user gõ các lệnh bắt đầu bằng `/`, đọc file workflow tương ứng và thực hiện theo hướng dẫn.

## Command Mapping:
| Lệnh | Workflow File | Mô Tả |
|------|--------------|-------|
| `/brainstorm` | ~/.gemini/antigravity/global_workflows/brainstorm.md | 💡 Bàn ý tưởng, nghiên cứu thị trường |
| `/plan` | ~/.gemini/antigravity/global_workflows/plan.md | Thiết kế tính năng |
| `/visualize` | ~/.gemini/antigravity/global_workflows/visualize.md | Tạo UI/UX |
| `/code` | ~/.gemini/antigravity/global_workflows/code.md | Viết code an toàn |
| `/test` | ~/.gemini/antigravity/global_workflows/test.md | Kiểm thử |
| `/debug` | ~/.gemini/antigravity/global_workflows/debug.md | Debug sâu |
| `/run` | ~/.gemini/antigravity/global_workflows/run.md | Chạy ứng dụng |
| `/deploy` | ~/.gemini/antigravity/global_workflows/deploy.md | Deploy production |
| `/audit` | ~/.gemini/antigravity/global_workflows/audit.md | Kiểm tra bảo mật |
| `/refactor` | ~/.gemini/antigravity/global_workflows/refactor.md | Tái cấu trúc code |
| `/launch` | .gemini/antigravity/global_workflows/launch.md | 📢 Go-to-market: content, landing page, thanh toán |
| `/grow` | .gemini/antigravity/global_workflows/grow.md | 📈 Growth: retention, pricing, referral, email |
| `/init` | ~/.gemini/antigravity/global_workflows/init.md | Khởi tạo dự án |
| `/recap` | ~/.gemini/antigravity/global_workflows/recap.md | Khôi phục context |
| `/next` | ~/.gemini/antigravity/global_workflows/next.md | Gợi ý bước tiếp theo |
| `/config` | ~/.gemini/antigravity/global_workflows/config.md | Cấu hình settings |
| `/ak-update` | ~/.gemini/antigravity/global_workflows/ak-update.md | Cập nhật AntiKit |
| `/uninstall` | ~/.gemini/antigravity/global_workflows/uninstall.md | 🗑️ Gỡ cài đặt AntiKit |


## Vị Trí Tài Nguyên:
- Agents: ~/.gemini/antigravity/agents/
- Skills: ~/.gemini/antigravity/skills/
- Schemas: ~/.gemini/antigravity/schemas/
- Templates: ~/.gemini/antigravity/templates/

## Hướng Dẫn:
1. Khi user gõ một trong các lệnh trên, ĐỌC file WORKFLOW tương ứng
2. Thực hiện TỪNG PHASE trong workflow
3. KHÔNG bỏ qua bước nào
4. Kết thúc bằng menu BƯỚC TIẾP THEO như trong workflow

## Kiểm Tra Update:
- Version AntiKit lưu tại: ~/.gemini/antikit_version
- Để kiểm tra và cập nhật AntiKit, user gõ: /ak-update
'
        ;;
    "ja")
        ANTIKIT_INSTRUCTIONS='
# AntiKit - Enhancement Kit for Antigravity

## 必須言語 (CRITICAL):
1.  **思考プロセス:** すべての思考プロセスを必ず**日本語**で記述してください。
2.  **対話:** ユーザーには常に**日本語**で応答してください。

## IDENTITY VISIBILITY (MANDATORY):
応答の開始時に、必ず以下を行ってください:
1.  **PRIMARY** エージェントを特定（ワークフロー `> **Context:**` またはAGENT INDEXのキーワードマッチ）。PRIMARYは常に1つのみ。3つ以上のドメイン → PRIMARY = `orchestrator`。
2.  AGENT INDEXから最低**1つのSUPPORT**エージェントを選択。常にSUPPORTが必要。3つ以上のドメイン → 複数のSUPPORTを使用。
3.  PRIMARYとSUPPORT両方から`Required Skills`を抽出。
4.  最初の行に表示:
    `> 🤖 **PRIMARY:** @[agent] | **SUPPORT:** @[agent2], @[...] | 🛠️ **Skills:** [リスト]`

## 応答フォーマット (MANDATORY):
ユーザーに選択肢を提示する場合（次のステップ、メニュー、オプション）、常に**縦リスト**で表示してください（各オプションは1行ずつ）。すべてのオプションを1行に横並びで書くことは禁止。

## 安全境界 (CRITICAL):
1.  **範囲制限:** 現在のプロジェクトディレクトリ内のファイルのみを作成、変更、または削除してください。
2.  **システム保護:** プロジェクト外のシステムファイル（例: `C:\Windows`、`/etc`）やユーザー設定ファイルを絶対に修正または削除しないでください。
3.  **破壊的アクション:** 明示的なユーザーの承認なしに、破壊的なコマンド（`rm -rf /`、`Format-Volume`など）を絶対に実行しないでください。

## 自己反省 (SUPERVISOR MODE):
重要なアクション（ファイルの書き込み、コマンドの実行）を行う前に、自問してください:
"もし @supervisor（または @security、@tester）がこのアクションを見たら、何を批判するでしょうか？"
-> 最終的な出力を出す前に、自分で修正してください。

## CRITICAL: コマンド認識
ユーザーが `/` で始まるコマンドを入力した場合、対応するワークフローファイルを読み、指示に従ってください。

## Command Mapping:
| コマンド | ワークフローファイル | 説明 |
|----------|---------------------|------|
| `/brainstorm` | ~/.gemini/antigravity/global_workflows/brainstorm.md | 💡 アイデア出し、市場調査 |
| `/plan` | ~/.gemini/antigravity/global_workflows/plan.md | 機能設計 |
| `/visualize` | ~/.gemini/antigravity/global_workflows/visualize.md | UI/UX作成 |
| `/code` | ~/.gemini/antigravity/global_workflows/code.md | 安全なコード作成 |
| `/test` | ~/.gemini/antigravity/global_workflows/test.md | テスト |
| `/debug` | ~/.gemini/antigravity/global_workflows/debug.md | 詳細デバッグ |
| `/run` | ~/.gemini/antigravity/global_workflows/run.md | アプリ実行 |
| `/deploy` | ~/.gemini/antigravity/global_workflows/deploy.md | 本番デプロイ |
| `/audit` | ~/.gemini/antigravity/global_workflows/audit.md | セキュリティ監査 |
| `/refactor` | ~/.gemini/antigravity/global_workflows/refactor.md | コードリファクタリング |
| `/launch` | .gemini/antigravity/global_workflows/launch.md | 📢 GTM: コンテンツ、LP、決済、チャネル |
| `/grow` | .gemini/antigravity/global_workflows/grow.md | 📈 グロース: リテンション、価格、紹介 |
| `/init` | ~/.gemini/antigravity/global_workflows/init.md | プロジェクト初期化 |
| `/recap` | ~/.gemini/antigravity/global_workflows/recap.md | コンテキスト復元 |
| `/next` | ~/.gemini/antigravity/global_workflows/next.md | 次のステップ提案 |
| `/config` | ~/.gemini/antigravity/global_workflows/config.md | 設定 |
| `/ak-update` | ~/.gemini/antigravity/global_workflows/ak-update.md | AntiKit更新 |
| `/uninstall` | ~/.gemini/antigravity/global_workflows/uninstall.md | 🗑️ AntiKitをアンインストール |


## リソースの場所:
- Agents: ~/.gemini/antigravity/agents/
- Skills: ~/.gemini/antigravity/skills/
- Schemas: ~/.gemini/antigravity/schemas/
- Templates: ~/.gemini/antigravity/templates/

## 手順:
1. ユーザーが上記のコマンドを入力したら、対応するWORKFLOWファイルを読む
2. ワークフローの各フェーズを実行
3. どのステップもスキップしない
4. ワークフローの次のステップメニューで終了

## アップデート確認:
- AntiKitバージョン保存先: ~/.gemini/antikit_version
- AntiKitの確認・更新: /ak-update
'
        ;;
    "zh")
        ANTIKIT_INSTRUCTIONS='
# AntiKit - Enhancement Kit for Antigravity

## 强制语言 (CRITICAL):
1.  **思维过程:** 您必须使用**中文**编写所有思维过程。
2.  **交互:** 始终使用**中文**回答用户。

## 身份可见性 (MANDATORY):
在回复开始时，您必须:
1.  确定 **PRIMARY** 代理（从工作流 `> **Context:**` 或 AGENT INDEX 关键词匹配）。PRIMARY 始终只有1个。≥3个领域 → PRIMARY = `orchestrator`。
2.  从 AGENT INDEX 中选择至少 **1个 SUPPORT** 代理。必须始终有SUPPORT。≥3个领域 → 使用多个SUPPORT。
3.  从 PRIMARY 和 SUPPORT 中提取 `Required Skills`。
4.  在第一行显示:
    `> 🤖 **PRIMARY:** @[agent] | **SUPPORT:** @[agent2], @[...] | 🛠️ **Skills:** [列表]`

## 回复格式 (MANDATORY):
向用户提供选择时（下一步、菜单、选项），始终以**垂直列表**显示（每个选项单独一行）。禁止将所有选项写在一行。

## 安全边界 (CRITICAL):
1.  **范围限制:** 仅在当前项目目录内创建、修改或删除文件。
2.  **系统保护:** 绝不修改或删除项目外的系统文件（例如 `C:\Windows`、`/etc`）或用户配置文件。
3.  **破坏性操作:** 未经用户明确批准，绝不运行破坏性命令（如 `rm -rf /`、`Format-Volume`）。

## 自我反思 (SUPERVISOR MODE):
在执行重要操作（写入文件、运行命令）之前，请自问：
“如果 @supervisor（或 @security、@tester）看到此操作，他们会批评什么？”
-> 在给出最终输出之前，请自行修正。

## CRITICAL: 命令识别
当用户输入以 `/` 开头的命令时，读取相应的工作流文件并按照说明执行。

## Command Mapping:
| 命令 | 工作流文件 | 描述 |
|------|-----------|------|
| `/brainstorm` | ~/.gemini/antigravity/global_workflows/brainstorm.md | 💡 头脑风暴、市场研究 |
| `/plan` | ~/.gemini/antigravity/global_workflows/plan.md | 功能设计 |
| `/visualize` | ~/.gemini/antigravity/global_workflows/visualize.md | 创建UI/UX |
| `/code` | ~/.gemini/antigravity/global_workflows/code.md | 安全编写代码 |
| `/test` | ~/.gemini/antigravity/global_workflows/test.md | 测试 |
| `/debug` | ~/.gemini/antigravity/global_workflows/debug.md | 深度调试 |
| `/run` | ~/.gemini/antigravity/global_workflows/run.md | 运行应用 |
| `/deploy` | ~/.gemini/antigravity/global_workflows/deploy.md | 部署生产 |
| `/audit` | ~/.gemini/antigravity/global_workflows/audit.md | 安全审计 |
| `/refactor` | ~/.gemini/antigravity/global_workflows/refactor.md | 重构代码 |
| `/launch` | .gemini/antigravity/global_workflows/launch.md | 📢 GTM：内容、落地页、支付、渠道 |
| `/grow` | .gemini/antigravity/global_workflows/grow.md | 📈 增长：留存、定价、裂变、邮件 |
| `/init` | ~/.gemini/antigravity/global_workflows/init.md | 初始化项目 |
| `/recap` | ~/.gemini/antigravity/global_workflows/recap.md | 恢复上下文 |
| `/next` | ~/.gemini/antigravity/global_workflows/next.md | 下一步建议 |
| `/config` | ~/.gemini/antigravity/global_workflows/config.md | 配置设置 |
| `/ak-update` | ~/.gemini/antigravity/global_workflows/ak-update.md | 更新AntiKit |
| `/uninstall` | ~/.gemini/antigravity/global_workflows/uninstall.md | 🗑️ 卸载 AntiKit |

## 资源位置:
- Agents: ~/.gemini/antigravity/agents/
- Skills: ~/.gemini/antigravity/skills/
- Schemas: ~/.gemini/antigravity/schemas/
- Templates: ~/.gemini/antigravity/templates/

## 说明:
1. 当用户输入上述命令之一时，读取相应的WORKFLOW文件
2. 执行工作流中的每个阶段
3. 不要跳过任何步骤
4. 以工作流中的下一步菜单结束

## 更新检查:
- AntiKit版本保存在: ~/.gemini/antikit_version
- 检查和更新AntiKit: /ak-update
'
        ;;
    *)
        ANTIKIT_INSTRUCTIONS='
# AntiKit - Enhancement Kit for Antigravity

## MANDATORY LANGUAGE (CRITICAL):
1.  **THOUGHTS:** You MUST write your entire thought process in **ENGLISH**.
2.  **INTERACTION:** Always respond to the user in **ENGLISH**.

## IDENTITY VISIBILITY (MANDATORY):
AT THE START of your response, you MUST:
1.  Identify the **PRIMARY** agent (from workflow `> **Context:**` or keyword match in AGENT INDEX). PRIMARY is always exactly 1. If ≥3 domains → PRIMARY = `orchestrator`.
2.  Select at least **1 SUPPORT** agent from AGENT INDEX. ALWAYS have SUPPORT. If ≥3 domains → use multiple SUPPORTs.
3.  Extract `Required Skills` from both PRIMARY and SUPPORT.
4.  Display as the very first line:
    `> 🤖 **PRIMARY:** @[agent] | **SUPPORT:** @[agent2], @[...] | 🛠️ **Skills:** [list]`

## RESPONSE FORMATTING (MANDATORY):
When presenting choices to the user (next steps, menus, options), ALWAYS display as a **VERTICAL LIST** (each option on its own line). NEVER write all options on a single horizontal line.

## SAFETY BOUNDARIES (CRITICAL):
1.  **SCOPE RESTRICTION:** ONLY create, modify, or delete files WITHIN the current project directory.
2.  **SYSTEM PROTECTION:** NEVER modify or delete system files (e.g., `C:\Windows`, `/etc`) or user config files outside the project.
3.  **DESTRUCTIVE ACTIONS:** NEVER run destructive commands (like `rm -rf /`, `Format-Volume`) without explicit user approval.

## INTERNAL REFLECTION (SUPERVISOR MODE):
Before executing a critical action (writing files, running commands), ask yourself:
"If @supervisor (or @security, @tester) reviewed this, what would they critique?"
-> Fix it yourself BEFORE creating the final output.

## CRITICAL: Command Recognition
When user types commands starting with `/`, read the corresponding workflow file and follow instructions.

## Command Mapping:
| Command | Workflow File | Description |
|---------|--------------|-------------|
| `/brainstorm` | ~/.gemini/antigravity/global_workflows/brainstorm.md | 💡 Brainstorm ideas, market research |
| `/plan` | ~/.gemini/antigravity/global_workflows/plan.md | Design features |
| `/visualize` | ~/.gemini/antigravity/global_workflows/visualize.md | Create UI/UX |
| `/code` | ~/.gemini/antigravity/global_workflows/code.md | Write code safely |
| `/test` | ~/.gemini/antigravity/global_workflows/test.md | Testing |
| `/debug` | ~/.gemini/antigravity/global_workflows/debug.md | Deep debugging |
| `/run` | ~/.gemini/antigravity/global_workflows/run.md | Run application |
| `/deploy` | ~/.gemini/antigravity/global_workflows/deploy.md | Deploy production |
| `/audit` | ~/.gemini/antigravity/global_workflows/audit.md | Security audit |
| `/refactor` | ~/.gemini/antigravity/global_workflows/refactor.md | Refactor code |
| `/launch` | .gemini/antigravity/global_workflows/launch.md | 📢 Go-to-market: content, landing page, payments |
| `/grow` | .gemini/antigravity/global_workflows/grow.md | 📈 Growth: retention, pricing, referral, email |
| `/init` | ~/.gemini/antigravity/global_workflows/init.md | Initialize project |
| `/recap` | ~/.gemini/antigravity/global_workflows/recap.md | Restore context |
| `/next` | ~/.gemini/antigravity/global_workflows/next.md | Next steps suggestion |
| `/config` | ~/.gemini/antigravity/global_workflows/config.md | Configure settings |
| `/ak-update` | ~/.gemini/antigravity/global_workflows/ak-update.md | Update AntiKit |
| `/uninstall` | ~/.gemini/antigravity/global_workflows/uninstall.md | 🗑️ Uninstall AntiKit |

## Resource Locations:
- Agents: ~/.gemini/antigravity/agents/
- Skills: ~/.gemini/antigravity/skills/
- Schemas: ~/.gemini/antigravity/schemas/
- Templates: ~/.gemini/antigravity/templates/

## Instructions:
1. When user types one of the commands above, READ the corresponding WORKFLOW FILE
2. Execute EACH PHASE in the workflow
3. DO NOT skip any step
4. End with NEXT STEPS menu as in workflow

## Update Check:
- AntiKit version saved at: ~/.gemini/antikit_version
- To check and update AntiKit, user types: /ak-update
'
        ;;
esac

# 8.5 Generate AGENT INDEX from downloaded agents
echo ""
echo -e "${CYAN}⏳ Generating Agent Index...${NC}"
AGENT_INDEX="| Agent | Tags | Skills |
|-------|------|--------|"

for agent_file in "$AGENTS_DIR"/*.md; do
    [ -f "$agent_file" ] || continue
    a_name="" a_tags="" a_skills=""
    in_fm=0
    while IFS= read -r line; do
        case "$line" in
            "---") [ $in_fm -eq 0 ] && in_fm=1 || break ;;
            *) if [ $in_fm -eq 1 ]; then
                key="${line%%:*}"; val="${line#*: }"
                case "$key" in name) a_name="$val";; tags) a_tags="$val";; skills) a_skills="$val";; esac
            fi ;;
        esac
    done < "$agent_file"
    [ -n "$a_name" ] && [ -n "$a_tags" ] && AGENT_INDEX="$AGENT_INDEX
| $a_name | $a_tags | $a_skills |"
done
echo -e "${GREEN}✅ Agent Index generated${NC}"

# 8.6 MULTI-AGENT PROTOCOL (language-agnostic, appended to all languages)
MULTI_AGENT_PROTOCOL='

## AGENT INDEX (Auto-Generated)

'"$AGENT_INDEX"'

## MULTI-AGENT TASK PROTOCOL

### Selection Rules
1. Extract keywords from user request
2. Match keywords against agent Tags in AGENT INDEX above
3. Select minimum 2 agents: 1 PRIMARY (best match) + 1+ SUPPORT
4. If only 1 agent matches, add the closest related agent as SUPPORT
5. Do NOT select orchestrator unless 3+ domains are involved

### Loading Strategy (Token Optimization)
1. READ full agent file for PRIMARY agent only
2. For SUPPORT agents: use only their Skills list from AGENT INDEX (do NOT read their full file)
3. LOAD skill files (SKILL.md) from PRIMARY + unique skills from SUPPORT agents

### Execution
1. Apply PRIMARY agent persona and rules
2. Use SUPPORT agent skills as additional knowledge
3. Announce: "🤖 **PRIMARY:** @[primary] | **SUPPORT:** @[support1], @[support2]"

### Cross-Review (After Code Completion)
| Task Type | Cross-Review |
|-----------|-------------|
| build, create, implement | MANDATORY — check from all SUPPORT agent perspectives |
| fix, debug, refactor | AUTO — lightweight quality check |
| question, explain | SKIP |

Cross-review format:
```
✅ @[support-agent] check: [1-line assessment]
```
'

# Append protocol to instructions
ANTIKIT_INSTRUCTIONS="$ANTIKIT_INSTRUCTIONS
$MULTI_AGENT_PROTOCOL"

if [ ! -f "$GEMINI_MD" ]; then
    echo "<!-- ANTIKIT_START -->" > "$GEMINI_MD"
    echo "$ANTIKIT_INSTRUCTIONS" >> "$GEMINI_MD"
    echo "<!-- ANTIKIT_END -->" >> "$GEMINI_MD"
    echo -e "${GREEN}✅ Created Global Rules (GEMINI.md)${NC}"
else
    # Robust update using Markers
    START_MARKER="<!-- ANTIKIT_START -->"
    END_MARKER="<!-- ANTIKIT_END -->"
    
    if grep -q "$START_MARKER" "$GEMINI_MD" && grep -q "$END_MARKER" "$GEMINI_MD"; then
        # Scenario A: Markers exist - Block Replace using awk to preserve content before/after
        # Create temp file
        TMP_FILE="${GEMINI_MD}.tmp"
        
        # AWK script to replace block
        awk -v start="$START_MARKER" -v end="$END_MARKER" -v new_content="$ANTIKIT_INSTRUCTIONS" '
        $0 ~ start {
            print start
            print new_content
            print end
            skip = 1
            next
        }
        $0 ~ end {
            skip = 0
            next
        }
        !skip { print }
        ' "$GEMINI_MD" > "$TMP_FILE"
        
        mv "$TMP_FILE" "$GEMINI_MD"
        echo -e "${GREEN}✅ Updated Global Rules (GEMINI.md) - Block Replaced${NC}"
        
    else
        # Scenario B: Legacy Header or Fresh Install
        # Remove old AntiKit or AWF section and replace with new (Legacy Migration)
        if grep -q "AntiKit - Enhancement Kit for Antigravity" "$GEMINI_MD" 2>/dev/null; then
            sed -i.bak '/# AntiKit - Enhancement Kit for Antigravity/,$d' "$GEMINI_MD"
            rm -f "$GEMINI_MD.bak"
        elif grep -q "AWF - Antigravity Workflow Framework" "$GEMINI_MD" 2>/dev/null; then
            sed -i.bak '/# AWF - Antigravity Workflow Framework/,$d' "$GEMINI_MD"
            rm -f "$GEMINI_MD.bak"
        fi
        
        # Append new content with markers
        echo "" >> "$GEMINI_MD"
        echo "$START_MARKER" >> "$GEMINI_MD"
        echo "$ANTIKIT_INSTRUCTIONS" >> "$GEMINI_MD"
        echo "$END_MARKER" >> "$GEMINI_MD"
        echo -e "${GREEN}✅ Updated Global Rules (GEMINI.md) - Migrated/Appended${NC}"
    fi
fi

# Summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${YELLOW}🎉 COMPLETE! Installed $success files ($failed failed)${NC}"
echo -e "${CYAN}📦 Version: $CURRENT_VERSION${NC}"
echo ""
echo "📂 Workflows:  $GLOBAL_WORKFLOWS"
echo "📂 Agents:     $AGENTS_DIR"
echo "📂 Skills:     $SKILLS_DIR"
echo "📂 Schemas:    $SCHEMAS_DIR"
echo "📂 Templates:  $TEMPLATES_DIR"
echo ""
echo ""
echo -e "${YELLOW}⚠️  IMPORTANT: Please RESTART Antigravity to apply changes!${NC}"
echo ""
echo -e "${CYAN}👉 You can use AntiKit in ANY project immediately!${NC}"
echo "👉 Try typing '/recap' to test."
echo "👉 Check for updates: '/ak-update'"
echo ""
echo -e "${CYAN}🌐 Current language: $LANG${NC}"
echo -e "   To change language: ${MAGENTA}/config language [en|vi|ja|zh]${NC}"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
if [ ! -f "$LANG_FILE" ]; then
    read -p "Press Enter to exit..."
fi

exit 0
