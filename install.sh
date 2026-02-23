#!/bin/bash
# AntiKit Installer for macOS/Linux
# Direct download approach - inspired by AWF
# https://github.com/hasugoii/antikit

REPO_BASE="https://raw.githubusercontent.com/hasugoii/antikit/main"

# Workflows (will use selected language)
# Note: moderate.md is admin-only, not included in standard install
WORKFLOWS=(
    "ak-update.md" "audit.md" "brainstorm.md" "browse.md" "cloudflare-tunnel.md"
    "code.md" "config.md" "contribute.md" "customize.md" "debug.md" "deploy.md"
    "history.md" "init.md" "install.md" "next.md" "plan.md" "recap.md"
    "refactor.md" "report.md" "rollback.md" "run.md" "save_brain.md" "scan.md"
    "test.md" "uninstall.md" "visualize.md"
)

# Agents
AGENTS=(
    "backend-specialist.md" "code-archaeologist.md" "database-architect.md"
    "debugger.md" "devops-engineer.md" "documentation-writer.md"
    "explorer-agent.md" "frontend-specialist.md" "game-developer.md"
    "mobile-developer.md" "orchestrator.md" "penetration-tester.md"
    "performance-optimizer.md" "product-manager.md" "product-owner.md"
    "project-planner.md" "qa-automation-engineer.md" "security-auditor.md"
    "seo-specialist.md" "test-engineer.md"
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
    "deployment-procedures" "docker-expert" "documentation-templates" "frontend-design"
    "game-development" "geo-fundamentals" "i18n-localization" "lint-and-validate"
    "mcp-builder" "mobile-design" "nestjs-expert" "nextjs-expert" "nodejs-best-practices"
    "parallel-agents" "performance-profiling" "plan-writing" "powershell-windows"
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

# 2. Download Workflows
echo ""
echo -e "${CYAN}⏳ Downloading workflows ($LANG)...${NC}"
for wf in "${WORKFLOWS[@]}"; do
    if curl -f -s -o "$GLOBAL_WORKFLOWS/$wf" "$REPO_BASE/workflows/$LANG/$wf"; then
        echo -e "   ${GREEN}✅ $wf${NC}"
        ((success++))
    else
        echo -e "   ${RED}❌ $wf${NC}"
        ((failed++))
    fi
done

# 3. Download Agents
echo ""
echo -e "${CYAN}⏳ Downloading agents...${NC}"
for agent in "${AGENTS[@]}"; do
    if curl -f -s -o "$AGENTS_DIR/$agent" "$REPO_BASE/src/agents/$agent"; then
        echo -e "   ${GREEN}✅ $agent${NC}"
        ((success++))
    else
        echo -e "   ${RED}❌ $agent${NC}"
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
    if curl -f -s -o "$SKILLS_DIR/$skill/SKILL.md" "$REPO_BASE/src/skills/$skill/SKILL.md"; then
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
KHI BẮT ĐẦU phản hồi, NẾU bạn đang thực thi một workflow (dựa trên header `> **Context:**` trong file được đọc):
1.  Trích xuất tên `Context` (ví dụ: `@architect`).
2.  Trích xuất `Required Skills` (ví dụ: `brainstorming`).
3.  Hiển thị chúng trong một block trích dẫn ở dòng ĐẦU TIÊN:
    `> 🆔 **Agent:** [Tên] | 🛠️ **Skills:** [Danh sách]`

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
| `/code` | ~/.gemini/antigravity/global_workflows/code.md | Viết code an toàn |
| `/visualize` | ~/.gemini/antigravity/global_workflows/visualize.md | Tạo UI/UX |
| `/debug` | ~/.gemini/antigravity/global_workflows/debug.md | Debug sâu |
| `/test` | ~/.gemini/antigravity/global_workflows/test.md | Kiểm thử |
| `/run` | ~/.gemini/antigravity/global_workflows/run.md | Chạy ứng dụng |
| `/deploy` | ~/.gemini/antigravity/global_workflows/deploy.md | Deploy production |
| `/init` | ~/.gemini/antigravity/global_workflows/init.md | Khởi tạo dự án |
| `/recap` | ~/.gemini/antigravity/global_workflows/recap.md | Khôi phục context |
| `/next` | ~/.gemini/antigravity/global_workflows/next.md | Gợi ý bước tiếp theo |
| `/customize` | ~/.gemini/antigravity/global_workflows/customize.md | ⚙️ Tùy chỉnh AI |
| `/save-brain` | ~/.gemini/antigravity/global_workflows/save_brain.md | Lưu kiến thức |
| `/audit` | ~/.gemini/antigravity/global_workflows/audit.md | Kiểm tra bảo mật |
| `/refactor` | ~/.gemini/antigravity/global_workflows/refactor.md | Tái cấu trúc code |
| `/rollback` | ~/.gemini/antigravity/global_workflows/rollback.md | Rollback deployment |
| `/cloudflare-tunnel` | ~/.gemini/antigravity/global_workflows/cloudflare-tunnel.md | Quản lý tunnel |
| `/config` | ~/.gemini/antigravity/global_workflows/config.md | Cấu hình settings |
| `/ak-update` | ~/.gemini/antigravity/global_workflows/ak-update.md | Cập nhật AntiKit |
| `/ak-browse` | ~/.gemini/antigravity/global_workflows/browse.md | 🔍 Duyệt Community Library |
| `/ak-contribute` | ~/.gemini/antigravity/global_workflows/contribute.md | 🤝 Đóng góp vào Library |
| `/ak-history` | ~/.gemini/antigravity/global_workflows/history.md | 📜 Lịch sử cập nhật |
| `/ak-install` | ~/.gemini/antigravity/global_workflows/install.md | 📦 Cài đặt package |
| `/ak-moderate` | ~/.gemini/antigravity/global_workflows/moderate.md | 🛡️ Quản lý đóng góp (Admin) |
| `/ak-report` | ~/.gemini/antigravity/global_workflows/report.md | 🚩 Báo cáo package |
| `/ak-scan` | ~/.gemini/antigravity/global_workflows/scan.md | 🔍 Quét bảo mật |
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
応答の開始時に、ワークフローを実行している場合（読み込まれたファイルの `> **Context:**` ヘッダーに基づく）:
1.  `Context` 名（例: `@architect`）を抽出します。
2.  `Required Skills`（例: `brainstorming`）を抽出します。
3.  それらを最初の行の引用ブロックに表示します:
    `> 🆔 **Agent:** [名前] | 🛠️ **Skills:** [リスト]`

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
| `/code` | ~/.gemini/antigravity/global_workflows/code.md | 安全なコード作成 |
| `/visualize` | ~/.gemini/antigravity/global_workflows/visualize.md | UI/UX作成 |
| `/debug` | ~/.gemini/antigravity/global_workflows/debug.md | 詳細デバッグ |
| `/test` | ~/.gemini/antigravity/global_workflows/test.md | テスト |
| `/run` | ~/.gemini/antigravity/global_workflows/run.md | アプリ実行 |
| `/deploy` | ~/.gemini/antigravity/global_workflows/deploy.md | 本番デプロイ |
| `/init` | ~/.gemini/antigravity/global_workflows/init.md | プロジェクト初期化 |
| `/recap` | ~/.gemini/antigravity/global_workflows/recap.md | コンテキスト復元 |
| `/next` | ~/.gemini/antigravity/global_workflows/next.md | 次のステップ提案 |
| `/customize` | ~/.gemini/antigravity/global_workflows/customize.md | ⚙️ AIカスタマイズ |
| `/save-brain` | ~/.gemini/antigravity/global_workflows/save_brain.md | 知識保存 |
| `/audit` | ~/.gemini/antigravity/global_workflows/audit.md | セキュリティ監査 |
| `/refactor` | ~/.gemini/antigravity/global_workflows/refactor.md | コードリファクタリング |
| `/rollback` | ~/.gemini/antigravity/global_workflows/rollback.md | ロールバック |
| `/cloudflare-tunnel` | ~/.gemini/antigravity/global_workflows/cloudflare-tunnel.md | トンネル管理 |
| `/config` | ~/.gemini/antigravity/global_workflows/config.md | 設定 |
| `/ak-update` | ~/.gemini/antigravity/global_workflows/ak-update.md | AntiKit更新 |
| `/ak-browse` | ~/.gemini/antigravity/global_workflows/browse.md | 🔍 ライブラリを閲覧 |
| `/ak-contribute` | ~/.gemini/antigravity/global_workflows/contribute.md | 🤝 ライブラリに貢献 |
| `/ak-history` | ~/.gemini/antigravity/global_workflows/history.md | 📜 更新履歴 |
| `/ak-install` | ~/.gemini/antigravity/global_workflows/install.md | 📦 パッケージをインストール |
| `/ak-moderate` | ~/.gemini/antigravity/global_workflows/moderate.md | 🛡️ モデレーション (Admin) |
| `/ak-report` | ~/.gemini/antigravity/global_workflows/report.md | 🚩 パッケージを報告 |
| `/ak-scan` | ~/.gemini/antigravity/global_workflows/scan.md | 🔍 セキュリティスキャン |
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
在回复开始时，如果您正在执行工作流（基于读取文件中的 `> **Context:**` 标头）：
1.  提取 `Context` 名称（例如：`@architect`）。
2.  提取 `Required Skills`（例如：`brainstorming`）。
3.  在第一行的引用块中显示它们：
    `> 🆔 **Agent:** [名称] | 🛠️ **Skills:** [列表]`

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
| `/code` | ~/.gemini/antigravity/global_workflows/code.md | 安全编写代码 |
| `/visualize` | ~/.gemini/antigravity/global_workflows/visualize.md | 创建UI/UX |
| `/debug` | ~/.gemini/antigravity/global_workflows/debug.md | 深度调试 |
| `/test` | ~/.gemini/antigravity/global_workflows/test.md | 测试 |
| `/run` | ~/.gemini/antigravity/global_workflows/run.md | 运行应用 |
| `/deploy` | ~/.gemini/antigravity/global_workflows/deploy.md | 部署生产 |
| `/init` | ~/.gemini/antigravity/global_workflows/init.md | 初始化项目 |
| `/recap` | ~/.gemini/antigravity/global_workflows/recap.md | 恢复上下文 |
| `/next` | ~/.gemini/antigravity/global_workflows/next.md | 下一步建议 |
| `/customize` | ~/.gemini/antigravity/global_workflows/customize.md | ⚙️ 自定义AI |
| `/save-brain` | ~/.gemini/antigravity/global_workflows/save_brain.md | 保存知识 |
| `/audit` | ~/.gemini/antigravity/global_workflows/audit.md | 安全审计 |
| `/refactor` | ~/.gemini/antigravity/global_workflows/refactor.md | 重构代码 |
| `/rollback` | ~/.gemini/antigravity/global_workflows/rollback.md | 回滚部署 |
| `/cloudflare-tunnel` | ~/.gemini/antigravity/global_workflows/cloudflare-tunnel.md | 管理隧道 |
| `/config` | ~/.gemini/antigravity/global_workflows/config.md | 配置设置 |
| `/ak-update` | ~/.gemini/antigravity/global_workflows/ak-update.md | 更新AntiKit |
| `/ak-browse` | ~/.gemini/antigravity/global_workflows/browse.md | 🔍 浏览社区库 |
| `/ak-contribute` | ~/.gemini/antigravity/global_workflows/contribute.md | 🤝 贡献到库 |
| `/ak-history` | ~/.gemini/antigravity/global_workflows/history.md | 📜 更新历史 |
| `/ak-install` | ~/.gemini/antigravity/global_workflows/install.md | 📦 安装软件包 |
| `/ak-moderate` | ~/.gemini/antigravity/global_workflows/moderate.md | 🛡️ 审核管理 (Admin) |
| `/ak-report` | ~/.gemini/antigravity/global_workflows/report.md | 🚩 举报软件包 |
| `/ak-scan` | ~/.gemini/antigravity/global_workflows/scan.md | 🔍 安全扫描 |
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
AT THE START of your response, IF you are executing a defined workflow (determined by the `> **Context:**` header in the loaded file):
1.  Extract the `Context` name (e.g., `@architect`).
2.  Extract the `Required Skills` (e.g., `brainstorming`).
3.  Display them in a quote block as the very first line:
    `> 🆔 **Agent:** [Name] | 🛠️ **Skills:** [List]`

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
| `/code` | ~/.gemini/antigravity/global_workflows/code.md | Write code safely |
| `/visualize` | ~/.gemini/antigravity/global_workflows/visualize.md | Create UI/UX |
| `/debug` | ~/.gemini/antigravity/global_workflows/debug.md | Deep debugging |
| `/test` | ~/.gemini/antigravity/global_workflows/test.md | Testing |
| `/run` | ~/.gemini/antigravity/global_workflows/run.md | Run application |
| `/deploy` | ~/.gemini/antigravity/global_workflows/deploy.md | Deploy production |
| `/init` | ~/.gemini/antigravity/global_workflows/init.md | Initialize project |
| `/recap` | ~/.gemini/antigravity/global_workflows/recap.md | Restore context |
| `/next` | ~/.gemini/antigravity/global_workflows/next.md | Next steps suggestion |
| `/customize` | ~/.gemini/antigravity/global_workflows/customize.md | ⚙️ Customize AI |
| `/save-brain` | ~/.gemini/antigravity/global_workflows/save_brain.md | Save knowledge |
| `/audit` | ~/.gemini/antigravity/global_workflows/audit.md | Security audit |
| `/refactor` | ~/.gemini/antigravity/global_workflows/refactor.md | Refactor code |
| `/rollback` | ~/.gemini/antigravity/global_workflows/rollback.md | Rollback deployment |
| `/cloudflare-tunnel` | ~/.gemini/antigravity/global_workflows/cloudflare-tunnel.md | Manage tunnel |
| `/config` | ~/.gemini/antigravity/global_workflows/config.md | Configure settings |
| `/ak-update` | ~/.gemini/antigravity/global_workflows/ak-update.md | Update AntiKit |
| `/ak-browse` | ~/.gemini/antigravity/global_workflows/browse.md | 🔍 Browse Community Library |
| `/ak-contribute` | ~/.gemini/antigravity/global_workflows/contribute.md | 🤝 Contribute to Library |
| `/ak-history` | ~/.gemini/antigravity/global_workflows/history.md | 📜 Update History |
| `/ak-install` | ~/.gemini/antigravity/global_workflows/install.md | 📦 Install Package |
| `/ak-moderate` | ~/.gemini/antigravity/global_workflows/moderate.md | 🛡️ Moderation (Admin) |
| `/ak-report` | ~/.gemini/antigravity/global_workflows/report.md | 🚩 Report Package |
| `/ak-scan` | ~/.gemini/antigravity/global_workflows/scan.md | 🔍 Security Scan |
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
