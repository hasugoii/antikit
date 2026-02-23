# Tự động detect Antigravity và cài đặt Enhancement Kit

param(
    [switch]$Unattended = $false,
    [string]$Language = ""
)

$RepoBase = "https://raw.githubusercontent.com/hasugoii/antikit/main"

# Workflows - organized by language
$WorkflowsEn = @(
    "ak-update.mdt", "audit.mdt", "brainstorm.mdt", "code.mdt", "config.mdt",
    "debug.mdt", "deploy.mdt", "grow.mdt", "init.mdt", "launch.mdt", "next.mdt",
    "plan.mdt", "recap.mdt", "refactor.mdt", "run.mdt", "save_brain.mdt", "sync-schema.mdt", "test.mdt",
    "uninstall.mdt", "visualize.mdt"
)

# Agents (21 total)
$Agents = @(
    "backend-specialist.mdt", "code-archaeologist.mdt", "database-architect.mdt",
    "debugger.mdt", "devops-engineer.mdt", "documentation-writer.mdt",
    "explorer-agent.mdt", "frontend-specialist.mdt", "game-developer.mdt",
    "growth-hacker.mdt", "mobile-developer.mdt", "orchestrator.mdt",
    "penetration-tester.mdt", "performance-optimizer.mdt", "product-manager.mdt",
    "product-owner.mdt", "project-planner.mdt", "qa-automation-engineer.mdt",
    "security-auditor.mdt", "seo-specialist.mdt", "test-engineer.mdt"
)

# Schemas
$Schemas = @(
    "brain.schema.json", "preferences.schema.json", "session.schema.json"
)

# Templates
$Templates = @(
    "brain.example.json", "preferences.example.json", "session.example.json"
)

# Skills (83 total — directories with SKILL.mdt inside)
$Skills = @(
    "ab-test-setup", "ad-creative", "ai-seo", "analytics-tracking",
    "api-patterns", "app-builder", "app-store-optimization", "architecture",
    "bash-linux", "behavioral-modes", "brainstorming",
    "churn-prevention", "clean-code", "code-review-checklist", "cold-email",
    "competitor-alternatives", "content-hash-cache-pattern", "content-strategy",
    "continuous-learning-v2", "copy-editing", "copywriting", "cost-aware-llm-pipeline",
    "database-design", "deployment-procedures", "docker-expert", "docker-patterns",
    "documentation-templates", "e2e-testing", "email-sequence", "evidence-discipline",
    "form-cro", "free-tool-strategy", "frontend-design",
    "game-development", "geo-fundamentals", "growth-marketing",
    "i18n-localization", "intelligent-routing",
    "launch-strategy", "lint-and-validate",
    "marketing-ideas", "marketing-psychology", "mcp-builder", "mobile-design",
    "nestjs-expert", "nextjs-expert", "nextjs-react-expert", "nodejs-best-practices",
    "onboarding-cro",
    "page-cro", "paid-ads", "parallel-agents", "paywall-upgrade-cro",
    "performance-profiling", "plan-writing", "popup-cro", "powershell-windows",
    "pricing-strategy", "prisma-expert", "proactive-intelligence",
    "product-marketing-context", "programmatic-seo", "python-patterns",
    "react-patterns", "red-team-tactics", "referral-program", "rust-pro",
    "schema-markup", "seo-audit", "seo-fundamentals", "server-management",
    "signup-flow-cro", "social-content", "strategic-compact", "systematic-debugging",
    "tailwind-patterns", "tdd-workflow", "testing-patterns", "typescript-expert",
    "ui-ux-pro-max", "vulnerability-scanner", "web-design-guidelines", "webapp-testing"
)

# Scripts (7 total)
$Scripts = @(
    "auto_preview.py", "checklist.py", "generate-index.sh",
    "security-scan.ps1", "security-scan.sh", "session_manager.py", "verify_all.py"
)

# Paths
$AntigravityDir = "$env:USERPROFILE\.gemini\antigravity"
$GlobalWorkflows = "$AntigravityDir\global_workflows"
$AgentsDir = "$AntigravityDir\agents"
$SchemasDir = "$AntigravityDir\schemas"
$TemplatesDir = "$AntigravityDir\templates"
$SkillsDir = "$AntigravityDir\skills"
$GeminiMd = "$env:USERPROFILE\.gemini\GEMINI.md"
$VersionFile = "$env:USERPROFILE\.gemini\antikit_version"

# Get version from repo
try {
    $CurrentVersion = (Invoke-WebRequest -Uri "$RepoBase/VERSION" -UseBasicParsing).Content.Trim()
}
catch {
    $CurrentVersion = "1.0.0"
}

Write-Host ""
Write-Host "╔══════════════════════════════════════════════════════════╗" -ForegroundColor Magenta
Write-Host "║        AntiKit - Enhancement Kit for Antigravity       ║" -ForegroundColor Magenta
Write-Host "║                        v$CurrentVersion                           ║" -ForegroundColor Magenta
Write-Host "╚══════════════════════════════════════════════════════════╝" -ForegroundColor Magenta
Write-Host ""

# Check if updating
if (Test-Path $VersionFile) {
    $OldVersion = Get-Content $VersionFile
    Write-Host "[PKG] Current version: $OldVersion" -ForegroundColor Yellow
    Write-Host "[PKG] New version: $CurrentVersion" -ForegroundColor Green
    Write-Host ""
}

# Language selection
$LangFile = "$env:USERPROFILE\.gemini\antikit_language"
$lang = "en" # Default

# 1. Try to load from config if exists
if (Test-Path $LangFile) {
    $lang = Get-Content $LangFile -ErrorAction SilentlyContinue
    if ([string]::IsNullOrWhiteSpace($lang)) { $lang = "en" }
    Write-Host "[OK] Auto-detected language: $lang" -ForegroundColor Green
}
# 2. Override with param if provided
if (-not [string]::IsNullOrWhiteSpace($Language)) {
    $lang = $Language
    Write-Host "[OK] Using language from parameter: $lang" -ForegroundColor Green
}
# 3. Prompt user ONLY if not Unattended and no config found and no param
if (-not $Unattended -and (-not (Test-Path $LangFile)) -and [string]::IsNullOrWhiteSpace($Language)) {
    Write-Host "[LANG] Select language for workflows:" -ForegroundColor Cyan
    Write-Host "   1. English (en)" -ForegroundColor White
    Write-Host "   2. Japanese (ja)" -ForegroundColor White
    Write-Host "   3. Vietnamese (vi)" -ForegroundColor White
    Write-Host "   4. Chinese (zh)" -ForegroundColor White
    Write-Host ""

    $langChoice = Read-Host "Enter choice (1-4, default: 1)"
    switch ($langChoice) {
        "2" { $lang = "ja" }
        "3" { $lang = "vi" }
        "4" { $lang = "zh" }
        default { $lang = "en" }
    }
    Write-Host "[OK] Selected language: $lang" -ForegroundColor Green
}
Write-Host ""

$success = 0
$failed = 0

# 1. Create directories
$dirs = @($AntigravityDir, $GlobalWorkflows, $AgentsDir, $SchemasDir, $TemplatesDir, $SkillsDir)
foreach ($dir in $dirs) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Force -Path $dir | Out-Null
    }
}
Write-Host "[DIR] Directories ready: $AntigravityDir" -ForegroundColor Green

# 1.5. Clean old files (remove renamed/obsolete agents)
$OldAgents = @("architect.md", "backend.md", "database.md", "devops.md", "doc-writer.md",
    "explorer.md", "frontend.md", "game.md", "mobile.md", "pentester.md",
    "performance.md", "security.md", "seo.md", "tester.md")
$cleaned = 0
foreach ($old in $OldAgents) {
    $oldPath = "$AgentsDir\$old"
    if (Test-Path $oldPath) {
        Remove-Item $oldPath -Force
        $cleaned++
    }
}
if ($cleaned -gt 0) {
    Write-Host "[CLEAN] Cleaned $cleaned old agent files" -ForegroundColor Yellow
}

# 2. Download Workflows
Write-Host ""
Write-Host "[...] Downloading workflows ($lang)..." -ForegroundColor Cyan
foreach ($wf in $WorkflowsEn) {
    try {
        $outName = $wf -replace '\.mdt$', '.md'
        $url = "$RepoBase/workflows/$lang/$wf"
        Invoke-WebRequest -Uri $url -OutFile "$GlobalWorkflows\$outName" -UseBasicParsing -ErrorAction Stop
        Write-Host "   [OK] $outName" -ForegroundColor Green
        $success++
    }
    catch {
        $outName = $wf -replace '\.mdt$', '.md'
        Write-Host "   [X] $outName" -ForegroundColor Red
        $failed++
    }
}

# 3. Download Agents
Write-Host ""
Write-Host "[...] Downloading agents..." -ForegroundColor Cyan
foreach ($agent in $Agents) {
    try {
        $outName = $agent -replace '\.mdt$', '.md'
        $url = "$RepoBase/src/agents/$agent"
        Invoke-WebRequest -Uri $url -OutFile "$AgentsDir\$outName" -UseBasicParsing -ErrorAction Stop
        Write-Host "   [OK] $outName" -ForegroundColor Green
        $success++
    }
    catch {
        $outName = $agent -replace '\.mdt$', '.md'
        Write-Host "   [X] $outName" -ForegroundColor Red
        $failed++
    }
}

# 4. Download Schemas
Write-Host ""
Write-Host "[...] Downloading schemas..." -ForegroundColor Cyan
foreach ($schema in $Schemas) {
    try {
        $url = "$RepoBase/schemas/$schema"
        Invoke-WebRequest -Uri $url -OutFile "$SchemasDir\$schema" -UseBasicParsing -ErrorAction Stop
        Write-Host "   [OK] $schema" -ForegroundColor Green
        $success++
    }
    catch {
        Write-Host "   [X] $schema" -ForegroundColor Red
        $failed++
    }
}

# 5. Download Templates
Write-Host ""
Write-Host "[...] Downloading templates..." -ForegroundColor Cyan
foreach ($template in $Templates) {
    try {
        $url = "$RepoBase/templates/$template"
        Invoke-WebRequest -Uri $url -OutFile "$TemplatesDir\$template" -UseBasicParsing -ErrorAction Stop
        Write-Host "   [OK] $template" -ForegroundColor Green
        $success++
    }
    catch {
        Write-Host "   [X] $template" -ForegroundColor Red
        $failed++
    }
}

# 6. Download Skills
Write-Host ""
Write-Host "[...] Downloading skills..." -ForegroundColor Cyan
foreach ($skill in $Skills) {
    try {
        $skillDir = "$SkillsDir\$skill"
        if (-not (Test-Path $skillDir)) {
            New-Item -ItemType Directory -Force -Path $skillDir | Out-Null
        }
        $url = "$RepoBase/src/skills/$skill/SKILL.mdt"
        Invoke-WebRequest -Uri $url -OutFile "$skillDir\SKILL.md" -UseBasicParsing -ErrorAction Stop
        Write-Host "   [OK] $skill" -ForegroundColor Green
        $success++
    }
    catch {
        Write-Host "   [X] $skill" -ForegroundColor Red
        $failed++
    }
}

# 6.5 Download Scripts
$ScriptsDir = "$AntigravityDir\scripts"
if (-not (Test-Path $ScriptsDir)) { New-Item -ItemType Directory -Force -Path $ScriptsDir | Out-Null }
Write-Host ""
Write-Host "[...] Downloading scripts..." -ForegroundColor Cyan
foreach ($script in $Scripts) {
    try {
        $url = "$RepoBase/scripts/$script"
        Invoke-WebRequest -Uri $url -OutFile "$ScriptsDir\$script" -UseBasicParsing -ErrorAction Stop
        Write-Host "   [OK] $script" -ForegroundColor Green
        $success++
    }
    catch {
        Write-Host "   [X] $script" -ForegroundColor Red
        $failed++
    }
}

# 7. Save version and language
if (-not (Test-Path "$env:USERPROFILE\.gemini")) {
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.gemini" | Out-Null
}
[System.IO.File]::WriteAllText($VersionFile, $CurrentVersion, [System.Text.Encoding]::UTF8)
$LangFile = "$env:USERPROFILE\.gemini\antikit_language"
[System.IO.File]::WriteAllText($LangFile, $lang, [System.Text.Encoding]::UTF8)
Write-Host ""
Write-Host "[OK] Version saved: $CurrentVersion" -ForegroundColor Green
Write-Host "[OK] Language saved: $lang" -ForegroundColor Green

# 8. Update Global Rules (GEMINI.md) - Language specific
$AntiKitInstructions = switch ($lang) {
    "vi" {
        @"

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
"@
    }
    "ja" {
        @"

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
| `/code` | ~/.gemini/antigravity/global_workflows/code.md | 安全なコード作成 |
| `/visualize` | ~/.gemini/antigravity/global_workflows/visualize.md | UI/UX作成 |
| `/debug` | ~/.gemini/antigravity/global_workflows/debug.md | 詳細デバッグ |
| `/test` | ~/.gemini/antigravity/global_workflows/test.md | テスト |
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
"@
    }
    "zh" {
        @"

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
| `/code` | ~/.gemini/antigravity/global_workflows/code.md | 安全编写代码 |
| `/visualize` | ~/.gemini/antigravity/global_workflows/visualize.md | 创建UI/UX |
| `/debug` | ~/.gemini/antigravity/global_workflows/debug.md | 深度调试 |
| `/test` | ~/.gemini/antigravity/global_workflows/test.md | 测试 |
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
"@
    }
    default {
        @"

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
| `/code` | ~/.gemini/antigravity/global_workflows/code.md | Write code safely |
| `/visualize` | ~/.gemini/antigravity/global_workflows/visualize.md | Create UI/UX |
| `/debug` | ~/.gemini/antigravity/global_workflows/debug.md | Deep debugging |
| `/test` | ~/.gemini/antigravity/global_workflows/test.md | Testing |
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
"@
    }
}

# 8.5 Generate AGENT INDEX from downloaded agents
Write-Host ""
Write-Host "[...] Generating Agent Index..." -ForegroundColor Cyan
$AgentIndexRows = @()
$AgentIndexRows += "| Agent | Tags | Skills |"
$AgentIndexRows += "|-------|------|--------|"

foreach ($agentFile in Get-ChildItem "$AgentsDir\*.md" -ErrorAction SilentlyContinue) {
    $aName = ""; $aTags = ""; $aSkills = ""
    $inFm = $false
    foreach ($line in Get-Content $agentFile.FullName) {
        if ($line -eq "---") {
            if (-not $inFm) { $inFm = $true; continue } else { break }
        }
        if ($inFm) {
            if ($line -match "^name:\s*(.+)") { $aName = $Matches[1].Trim() }
            elseif ($line -match "^tags:\s*(.+)") { $aTags = $Matches[1].Trim() }
            elseif ($line -match "^skills:\s*(.+)") { $aSkills = $Matches[1].Trim() }
        }
    }
    if ($aName -and $aTags) {
        $AgentIndexRows += "| $aName | $aTags | $aSkills |"
    }
}
$AgentIndex = $AgentIndexRows -join "`n"
Write-Host "[OK] Agent Index generated" -ForegroundColor Green

# 8.6 MULTI-AGENT PROTOCOL (language-agnostic)
$MultiAgentProtocol = @"

## AGENT INDEX (Auto-Generated)

$AgentIndex

## MULTI-AGENT TASK PROTOCOL

### 🔴 ALWAYS-ON RULE (NO EXCEPTIONS)
Every task MUST use minimum 2 agents: 1 PRIMARY + 1+ SUPPORT.
Single-agent responses are a PROTOCOL VIOLATION, even for simple tasks.

**Why:** SUPPORT agents catch mistakes PRIMARY would miss, challenge assumptions,
and split work for higher quality. This is non-negotiable.

### Selection Rules
1. Extract keywords from user request
2. Match keywords against agent Tags in AGENT INDEX above
3. Select minimum 2 agents: 1 PRIMARY (best match) + 1+ SUPPORT
4. If only 1 agent matches, add the closest related agent as SUPPORT
5. Do NOT select orchestrator unless 3+ domains are involved

### SUPPORT Agent Roles
SUPPORT agents MUST serve at least one of these roles:

| Role | What they do | Example |
|------|-------------|---------|
| 🔍 **Devil's Advocate** | Challenge PRIMARY's decisions, find flaws | security-auditor reviews backend code |
| ✂️ **Task Splitter** | Take ownership of sub-tasks | test-engineer writes tests while dev codes |
| 🛡️ **Quality Gate** | Verify output meets standards | code-archaeologist reviews for clean code |

### Loading Strategy (Token Optimization)
1. READ full agent file for PRIMARY agent only
2. For SUPPORT agents: use only their Skills list from AGENT INDEX (do NOT read their full file)
3. LOAD skill files (SKILL.md) from PRIMARY + unique skills from SUPPORT agents

### Execution
1. Apply PRIMARY agent persona and rules
2. Use SUPPORT agent skills as additional knowledge
3. Announce: "🤖 **PRIMARY:** @[primary] | **SUPPORT:** @[support1], @[support2]"

### Cross-Review (MANDATORY for all code changes)
After completing ANY code task, SUPPORT agent(s) MUST review:

| Task Type | Cross-Review |
|-----------|-------------|
| build, create, implement | MANDATORY — full review from all SUPPORT perspectives |
| fix, debug, refactor | MANDATORY — check for side effects + regressions |
| question, explain | LIGHT — verify accuracy from SUPPORT perspective |

Cross-review format:
``````
✅ @[support-agent] check: [1-line assessment]
⚠️ @[support-agent] concern: [issue found] → [suggested fix]
``````
"@

# Append protocol to instructions
$AntiKitInstructions = "$AntiKitInstructions`n$MultiAgentProtocol"

# Define markers for robust updates
$StartMarker = "<!-- ANTIKIT_START -->"
$EndMarker = "<!-- ANTIKIT_END -->"
$FullContent = "$StartMarker`n$AntiKitInstructions`n$EndMarker"

if (-not (Test-Path $GeminiMd)) {
    [System.IO.File]::WriteAllText($GeminiMd, $FullContent, [System.Text.Encoding]::UTF8)
    Write-Host "[OK] Created Global Rules (GEMINI.md)" -ForegroundColor Green
}
else {
    $content = Get-Content $GeminiMd -Raw -ErrorAction SilentlyContinue
    if ($null -eq $content) { $content = "" }

    if ($content.Contains($StartMarker) -and $content.Contains($EndMarker)) {
        # Scenario A: Markers exist - Replace block
        $pattern = "(?s)$StartMarker.*?$EndMarker"
        $content = $content -replace $pattern, $FullContent
        [System.IO.File]::WriteAllText($GeminiMd, $content, [System.Text.Encoding]::UTF8)
        Write-Host "[OK] Updated Global Rules (GEMINI.md) - Block Replaced" -ForegroundColor Green
    }
    else {
        # Scenario B: Legacy Header or Fresh Install
        # Remove old AntiKit or AWF section if found (Legacy Migration)
        $antiKitMarker = "# AntiKit - Enhancement Kit for Antigravity"
        $awfMarker = "# AWF - Antigravity Workflow Framework"
        
        $markerIndex = $content.IndexOf($antiKitMarker)
        if ($markerIndex -lt 0) {
            $markerIndex = $content.IndexOf($awfMarker)
        }
        
        if ($markerIndex -ge 0) {
            $content = $content.Substring(0, $markerIndex)
        }
        
        $content = $content.TrimEnd() + "`n`n" + $FullContent
        [System.IO.File]::WriteAllText($GeminiMd, $content, [System.Text.Encoding]::UTF8)
        Write-Host "[OK] Updated Global Rules (GEMINI.md) - Migrated/Appended" -ForegroundColor Green
    }
}

# Summary
Write-Host ""
Write-Host "----------------------------------------------------------" -ForegroundColor DarkGray
Write-Host "[SUCCESS] COMPLETE! Installed $success files ($failed failed)" -ForegroundColor Yellow
Write-Host "[PKG] Version: $CurrentVersion" -ForegroundColor Cyan
Write-Host ""
Write-Host "[DIR] Workflows:  $GlobalWorkflows" -ForegroundColor DarkGray
Write-Host "[DIR] Agents:     $AgentsDir" -ForegroundColor DarkGray
Write-Host "[DIR] Skills:     $SkillsDir" -ForegroundColor DarkGray
Write-Host "[DIR] Schemas:    $SchemasDir" -ForegroundColor DarkGray
Write-Host "[DIR] Templates:  $TemplatesDir" -ForegroundColor DarkGray
Write-Host ""
Write-Host ""
Write-Host "[!]  IMPORTANT: Please RESTART Antigravity to apply changes!" -ForegroundColor Yellow
Write-Host ""
Write-Host "[>] You can use AntiKit in ANY project immediately!" -ForegroundColor Cyan
Write-Host "[>] Try typing '/recap' to test." -ForegroundColor White
Write-Host "[>] Check for updates: '/ak-update'" -ForegroundColor White
Write-Host ""
Write-Host "[LANG] Current language: $lang" -ForegroundColor Cyan
Write-Host "   To change language: /config language [en|vi|ja|zh]" -ForegroundColor Magenta
Write-Host ""
Write-Host "----------------------------------------------------------" -ForegroundColor DarkGray
Write-Host ""
if (-not $Unattended) {
    Write-Host "Press any key to exit..." -ForegroundColor DarkGray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

# Exit cleanly
exit 0
