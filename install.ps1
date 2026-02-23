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
    "session_manager.py", "verify_all.py"
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

# 8. Download GEMINI.md source files from rules/
Write-Host ""
Write-Host "[...] Downloading GEMINI rules..." -ForegroundColor Cyan
$RulesDir = "$AntigravityDir\rules"
if (-not (Test-Path $RulesDir)) { New-Item -ItemType Directory -Force -Path $RulesDir | Out-Null }

# Download language-specific instructions + core GEMINI.md
try {
    Invoke-WebRequest -Uri "$RepoBase/rules/instructions_$Language.md" -OutFile "$RulesDir\instructions.md" -UseBasicParsing -ErrorAction Stop
    Write-Host "   [OK] instructions_$Language.md" -ForegroundColor Green
} catch {
    Write-Host "   [X] instructions_$Language.md" -ForegroundColor Red
}

try {
    Invoke-WebRequest -Uri "$RepoBase/rules/GEMINI.md" -OutFile "$RulesDir\GEMINI.md" -UseBasicParsing -ErrorAction Stop
    Write-Host "   [OK] GEMINI.md (core rules)" -ForegroundColor Green
} catch {
    Write-Host "   [X] GEMINI.md (core rules)" -ForegroundColor Red
}

# Assemble AntiKitInstructions from downloaded files
$AntiKitInstructions = ""
if (Test-Path "$RulesDir\instructions.md") {
    $AntiKitInstructions = Get-Content "$RulesDir\instructions.md" -Raw
}
if (Test-Path "$RulesDir\GEMINI.md") {
    $AntiKitInstructions = $AntiKitInstructions + "`n`n" + (Get-Content "$RulesDir\GEMINI.md" -Raw)
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
