# AntiKit Installer for Windows (PowerShell)
# Tự động detect Antigravity và cài đặt Enhancement Kit

$RepoBase = "https://raw.githubusercontent.com/hasugoii/antikit/main"

# Workflows - organized by language
$WorkflowsEn = @(
    "ak-update.md", "audit.md", "brainstorm.md", "cloudflare-tunnel.md",
    "code.md", "config.md", "customize.md", "debug.md", "deploy.md",
    "init.md", "next.md", "plan.md", "recap.md", "refactor.md",
    "rollback.md", "run.md", "save_brain.md", "test.md", "uninstall.md", "visualize.md"
)

# Agents
$Agents = @(
    "architect.md", "backend.md", "database.md", "debugger.md", "devops.md",
    "doc-writer.md", "explorer.md", "frontend.md", "game.md", "mobile.md",
    "orchestrator.md", "pentester.md", "performance.md", "security.md", "seo.md", "tester.md"
)

# Schemas
$Schemas = @(
    "brain.schema.json", "preferences.schema.json", "session.schema.json"
)

# Templates
$Templates = @(
    "brain.example.json", "preferences.example.json", "session.example.json"
)

# Skills (directories with SKILL.md inside)
$Skills = @(
    "api-patterns", "app-builder", "architecture", "bash-linux", "behavioral-modes",
    "brainstorming", "clean-code", "code-review-checklist", "database-design",
    "deployment-procedures", "docker-expert", "documentation-templates", "frontend-design",
    "game-development", "geo-fundamentals", "i18n-localization", "lint-and-validate",
    "mcp-builder", "mobile-design", "nestjs-expert", "nextjs-expert", "nodejs-best-practices",
    "parallel-agents", "performance-profiling", "plan-writing", "powershell-windows",
    "prisma-expert", "python-patterns", "react-patterns", "red-team-tactics",
    "seo-fundamentals", "server-management", "systematic-debugging", "tailwind-patterns",
    "tdd-workflow", "testing-patterns", "typescript-expert", "ui-ux-pro-max",
    "vulnerability-scanner", "webapp-testing"
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
Write-Host "║       🚀 AntiKit - Enhancement Kit for Antigravity       ║" -ForegroundColor Magenta
Write-Host "║                        v$CurrentVersion                           ║" -ForegroundColor Magenta
Write-Host "╚══════════════════════════════════════════════════════════╝" -ForegroundColor Magenta
Write-Host ""

# Check if updating
if (Test-Path $VersionFile) {
    $OldVersion = Get-Content $VersionFile
    Write-Host "📦 Current version: $OldVersion" -ForegroundColor Yellow
    Write-Host "📦 New version: $CurrentVersion" -ForegroundColor Green
    Write-Host ""
}

# Language selection
Write-Host "🌐 Select language for workflows:" -ForegroundColor Cyan
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
Write-Host "✅ Selected language: $lang" -ForegroundColor Green
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
Write-Host "📂 Directories ready: $AntigravityDir" -ForegroundColor Green

# 2. Download Workflows
Write-Host ""
Write-Host "⏳ Downloading workflows ($lang)..." -ForegroundColor Cyan
foreach ($wf in $WorkflowsEn) {
    try {
        $url = "$RepoBase/workflows/$lang/$wf"
        Invoke-WebRequest -Uri $url -OutFile "$GlobalWorkflows\$wf" -UseBasicParsing -ErrorAction Stop
        Write-Host "   ✅ $wf" -ForegroundColor Green
        $success++
    }
    catch {
        Write-Host "   ❌ $wf" -ForegroundColor Red
        $failed++
    }
}

# 3. Download Agents
Write-Host ""
Write-Host "⏳ Downloading agents..." -ForegroundColor Cyan
foreach ($agent in $Agents) {
    try {
        $url = "$RepoBase/agents/$agent"
        Invoke-WebRequest -Uri $url -OutFile "$AgentsDir\$agent" -UseBasicParsing -ErrorAction Stop
        Write-Host "   ✅ $agent" -ForegroundColor Green
        $success++
    }
    catch {
        Write-Host "   ❌ $agent" -ForegroundColor Red
        $failed++
    }
}

# 4. Download Schemas
Write-Host ""
Write-Host "⏳ Downloading schemas..." -ForegroundColor Cyan
foreach ($schema in $Schemas) {
    try {
        $url = "$RepoBase/schemas/$schema"
        Invoke-WebRequest -Uri $url -OutFile "$SchemasDir\$schema" -UseBasicParsing -ErrorAction Stop
        Write-Host "   ✅ $schema" -ForegroundColor Green
        $success++
    }
    catch {
        Write-Host "   ❌ $schema" -ForegroundColor Red
        $failed++
    }
}

# 5. Download Templates
Write-Host ""
Write-Host "⏳ Downloading templates..." -ForegroundColor Cyan
foreach ($template in $Templates) {
    try {
        $url = "$RepoBase/templates/$template"
        Invoke-WebRequest -Uri $url -OutFile "$TemplatesDir\$template" -UseBasicParsing -ErrorAction Stop
        Write-Host "   ✅ $template" -ForegroundColor Green
        $success++
    }
    catch {
        Write-Host "   ❌ $template" -ForegroundColor Red
        $failed++
    }
}

# 6. Download Skills
Write-Host ""
Write-Host "⏳ Downloading skills..." -ForegroundColor Cyan
foreach ($skill in $Skills) {
    try {
        $skillDir = "$SkillsDir\$skill"
        if (-not (Test-Path $skillDir)) {
            New-Item -ItemType Directory -Force -Path $skillDir | Out-Null
        }
        $url = "$RepoBase/skills/$skill/SKILL.md"
        Invoke-WebRequest -Uri $url -OutFile "$skillDir\SKILL.md" -UseBasicParsing -ErrorAction Stop
        Write-Host "   ✅ $skill" -ForegroundColor Green
        $success++
    }
    catch {
        Write-Host "   ❌ $skill" -ForegroundColor Red
        $failed++
    }
}

# 7. Save version and language
if (-not (Test-Path "$env:USERPROFILE\.gemini")) {
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.gemini" | Out-Null
}
Set-Content -Path $VersionFile -Value $CurrentVersion -Encoding UTF8
$LangFile = "$env:USERPROFILE\.gemini\antikit_language"
Set-Content -Path $LangFile -Value $lang -Encoding UTF8
Write-Host ""
Write-Host "✅ Version saved: $CurrentVersion" -ForegroundColor Green
Write-Host "✅ Language saved: $lang" -ForegroundColor Green

# 8. Update Global Rules (GEMINI.md) - Language specific
$AntiKitInstructions = switch ($lang) {
    "vi" {
        @"

# AntiKit - Enhancement Kit for Antigravity

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

if (-not (Test-Path $GeminiMd)) {
    Set-Content -Path $GeminiMd -Value $AntiKitInstructions -Encoding UTF8
    Write-Host "✅ Created Global Rules (GEMINI.md)" -ForegroundColor Green
}
else {
    $content = Get-Content $GeminiMd -Raw -ErrorAction SilentlyContinue
    if ($null -eq $content) { $content = "" }

    # Remove old AntiKit or AWF section and replace with new
    $antiKitMarker = "# AntiKit - Enhancement Kit for Antigravity"
    $awfMarker = "# AWF - Antigravity Workflow Framework"
    
    $markerIndex = $content.IndexOf($antiKitMarker)
    if ($markerIndex -lt 0) {
        $markerIndex = $content.IndexOf($awfMarker)
    }
    
    if ($markerIndex -ge 0) {
        $content = $content.Substring(0, $markerIndex)
    }
    $content = $content.TrimEnd() + "`n" + $AntiKitInstructions
    Set-Content -Path $GeminiMd -Value $content -Encoding UTF8
    Write-Host "✅ Updated Global Rules (GEMINI.md)" -ForegroundColor Green
}

# Summary
Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host "🎉 COMPLETE! Installed $success files ($failed failed)" -ForegroundColor Yellow
Write-Host "📦 Version: $CurrentVersion" -ForegroundColor Cyan
Write-Host ""
Write-Host "📂 Workflows:  $GlobalWorkflows" -ForegroundColor DarkGray
Write-Host "📂 Agents:     $AgentsDir" -ForegroundColor DarkGray
Write-Host "📂 Skills:     $SkillsDir" -ForegroundColor DarkGray
Write-Host "📂 Schemas:    $SchemasDir" -ForegroundColor DarkGray
Write-Host "📂 Templates:  $TemplatesDir" -ForegroundColor DarkGray
Write-Host ""
Write-Host ""
Write-Host "⚠️  IMPORTANT: Please RESTART Antigravity to apply changes!" -ForegroundColor Yellow
Write-Host ""
Write-Host "👉 You can use AntiKit in ANY project immediately!" -ForegroundColor Cyan
Write-Host "👉 Try typing '/recap' to test." -ForegroundColor White
Write-Host "👉 Check for updates: '/ak-update'" -ForegroundColor White
Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host ""
Write-Host "Press any key to exit..." -ForegroundColor DarkGray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# Exit cleanly
exit 0
