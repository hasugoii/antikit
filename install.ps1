# Tự động detect Antigravity và cài đặt Enhancement Kit

param(
    [switch]$Unattended = $false,
    [string]$Language = ""
)

$RepoBase = "https://raw.githubusercontent.com/hasugoii/antikit/main"

# Workflows - organized by language
$WorkflowsEn = @(
    "ak-update", "auto-ship", "audit", "brainstorm", "code", "config",
    "debug", "deploy", "grow", "init", "launch", "next",
    "plan", "recap", "refactor", "run", "save_brain", "test",
    "uninstall", "visualize"
)

# Agents (21 total)
$Agents = @(
    "backend-specialist", "chief-engineer", "code-archaeologist", "database-architect",
    "debugger", "devops-engineer", "documentation-writer",
    "explorer-agent", "frontend-specialist", "game-developer",
    "growth-hacker", "mobile-developer", "orchestrator",
    "penetration-tester", "performance-optimizer", "product-manager",
    "product-owner", "project-planner", "qa-automation-engineer",
    "security-auditor", "seo-specialist", "test-engineer"
)

# Schemas
$Schemas = @(
    "brain.schema.json", "preferences.schema.json", "session.schema.json"
)

# Templates
$Templates = @(
    "brain.example.json", "preferences.example.json", "session.example.json",
    "lessons.example.md"
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
    "auto_preview.py", "checklist.py",
    "session_manager.py", "verify_all.py"
)

# Paths
$AntigravityDir = "$env:USERPROFILE\.gemini\antigravity"
$GlobalWorkflows = "$AntigravityDir\global_workflows"
$AgentsDir = "$AntigravityDir\agents"
$SchemasDir = "$AntigravityDir\schemas"
$TemplatesDir = "$AntigravityDir\templates"
$SkillsDir = "$AntigravityDir\skills"
$ScriptsDir = "$AntigravityDir\scripts"
$GeminiMd = "$env:USERPROFILE\.gemini\GEMINI.md"
$VersionFile = "$env:USERPROFILE\.gemini\antikit_version"
$CustomFile = "$env:USERPROFILE\.gemini\antikit_custom.json"
$RegistryFile = "$AntigravityDir\antikit_installed.json"

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

# 1. Try to load from config if exists (new format first, then old)
if (Test-Path $LangFile) {
    $lang = Get-Content $LangFile -ErrorAction SilentlyContinue
    if ([string]::IsNullOrWhiteSpace($lang)) { $lang = "en" }
    Write-Host "[OK] Auto-detected language: $lang" -ForegroundColor Green
}
elseif (Test-Path "$env:USERPROFILE\.gemini\antikit_lang") {
    $lang = Get-Content "$env:USERPROFILE\.gemini\antikit_lang" -ErrorAction SilentlyContinue
    if ([string]::IsNullOrWhiteSpace($lang)) { $lang = "en" }
    Write-Host "[OK] Auto-detected language (legacy): $lang" -ForegroundColor Green
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

# Init file ownership registry
$Registry = @{}
if (Test-Path $RegistryFile) {
    try {
        $oldReg = Get-Content $RegistryFile -Raw | ConvertFrom-Json
        if ($oldReg.files) {
            $oldReg.files.PSObject.Properties | ForEach-Object { $Registry[$_.Name] = $_.Value }
        }
    } catch {}
}

# 1. Create directories
$dirs = @($AntigravityDir, $GlobalWorkflows, $AgentsDir, $SchemasDir, $TemplatesDir, $SkillsDir, $ScriptsDir)
foreach ($dir in $dirs) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Force -Path $dir | Out-Null
    }
}
Write-Host "[DIR] Directories ready: $AntigravityDir" -ForegroundColor Green

# 1.5. Fetch manifest
Write-Host ""
Write-Host "[...] Fetching manifest..." -ForegroundColor Cyan
$ManifestData = $null
try {
    $ManifestRaw = (Invoke-WebRequest -Uri "$RepoBase/manifest.json" -UseBasicParsing -ErrorAction Stop).Content
    $ManifestData = $ManifestRaw | ConvertFrom-Json
    Write-Host "[OK] Manifest fetched (v$($ManifestData.version))" -ForegroundColor Green

    # Override arrays from manifest
    $WorkflowsEn = $ManifestData.workflows
    $Agents = $ManifestData.agents
    $Skills = $ManifestData.skills
    $Scripts = $ManifestData.scripts
    $Schemas = $ManifestData.schemas
    $Templates = $ManifestData.templates
}
catch {
    Write-Host "[WARN] Manifest not available. Using fallback lists." -ForegroundColor Yellow
}

# 2. Download Workflows
Write-Host ""
Write-Host "[...] Downloading workflows ($lang)..." -ForegroundColor Cyan
foreach ($wf in $WorkflowsEn) {
    try {
        $outName = "${wf}.md"
        $tmpName = "${wf}.md.tmp"
        $url = "$RepoBase/workflows/$lang/${wf}.mdt"
        Invoke-WebRequest -Uri $url -OutFile "$GlobalWorkflows\$tmpName" -UseBasicParsing -ErrorAction Stop
        Move-Item -Path "$GlobalWorkflows\$tmpName" -Destination "$GlobalWorkflows\$outName" -Force
        Write-Host "   [OK] $outName" -ForegroundColor Green
        $Registry["global_workflows/$outName"] = $CurrentVersion
        $success++
    }
    catch {
        Remove-Item -Path "$GlobalWorkflows\${wf}.md.tmp" -ErrorAction SilentlyContinue
        $outName = "${wf}.md"
        Write-Host "   [X] $outName" -ForegroundColor Red
        $failed++
    }
}

# 3. Download Agents
Write-Host ""
Write-Host "[...] Downloading agents..." -ForegroundColor Cyan
foreach ($agent in $Agents) {
    try {
        $outName = "${agent}.md"
        $tmpName = "${agent}.md.tmp"
        $url = "$RepoBase/src/agents/${agent}.mdt"
        Invoke-WebRequest -Uri $url -OutFile "$AgentsDir\$tmpName" -UseBasicParsing -ErrorAction Stop
        Move-Item -Path "$AgentsDir\$tmpName" -Destination "$AgentsDir\$outName" -Force
        Write-Host "   [OK] $outName" -ForegroundColor Green
        $Registry["agents/$outName"] = $CurrentVersion
        $success++
    }
    catch {
        Remove-Item -Path "$AgentsDir\${agent}.md.tmp" -ErrorAction SilentlyContinue
        $outName = "${agent}.md"
        Write-Host "   [X] $outName" -ForegroundColor Red
        $failed++
    }
}

# 4. Download Schemas
Write-Host ""
Write-Host "[...] Downloading schemas..." -ForegroundColor Cyan
foreach ($schema in $Schemas) {
    try {
        $outName = $schema
        $tmpName = "${schema}.tmp"
        $url = "$RepoBase/schemas/$schema"
        Invoke-WebRequest -Uri $url -OutFile "$SchemasDir\$tmpName" -UseBasicParsing -ErrorAction Stop
        Move-Item -Path "$SchemasDir\$tmpName" -Destination "$SchemasDir\$outName" -Force
        Write-Host "   [OK] $outName" -ForegroundColor Green
        $Registry["schemas/$outName"] = $CurrentVersion
        $success++
    }
    catch {
        Remove-Item -Path "$SchemasDir\$schema.tmp" -ErrorAction SilentlyContinue
        Write-Host "   [X] $schema" -ForegroundColor Red
        $failed++
    }
}

# 5. Download Templates
Write-Host ""
Write-Host "[...] Downloading templates..." -ForegroundColor Cyan
foreach ($template in $Templates) {
    try {
        $outName = $template
        $tmpName = "${template}.tmp"
        $url = "$RepoBase/templates/$template"
        Invoke-WebRequest -Uri $url -OutFile "$TemplatesDir\$tmpName" -UseBasicParsing -ErrorAction Stop
        Move-Item -Path "$TemplatesDir\$tmpName" -Destination "$TemplatesDir\$outName" -Force
        Write-Host "   [OK] $outName" -ForegroundColor Green
        $Registry["templates/$outName"] = $CurrentVersion
        $success++
    }
    catch {
        Remove-Item -Path "$TemplatesDir\$template.tmp" -ErrorAction SilentlyContinue
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
        Invoke-WebRequest -Uri $url -OutFile "$skillDir\SKILL.md.tmp" -UseBasicParsing -ErrorAction Stop
        Move-Item -Path "$skillDir\SKILL.md.tmp" -Destination "$skillDir\SKILL.md" -Force
        Write-Host "   [OK] $skill" -ForegroundColor Green
        $Registry["skills/$skill/SKILL.md"] = $CurrentVersion
        $success++
    }
    catch {
        Remove-Item -Path "$SkillsDir\$skill\SKILL.md.tmp" -ErrorAction SilentlyContinue
        Write-Host "   [X] $skill" -ForegroundColor Red
        $failed++
    }
}

# 6.5 Download Scripts
if (-not (Test-Path $ScriptsDir)) { New-Item -ItemType Directory -Force -Path $ScriptsDir | Out-Null }
Write-Host ""
Write-Host "[...] Downloading scripts..." -ForegroundColor Cyan
foreach ($script in $Scripts) {
    $url = "$RepoBase/scripts/$script"
    $downloaded = $false
    try {
        Invoke-WebRequest -Uri $url -OutFile "$ScriptsDir\$script.tmp" -UseBasicParsing -ErrorAction Stop
        Move-Item -Path "$ScriptsDir\$script.tmp" -Destination "$ScriptsDir\$script" -Force
        Write-Host "   [OK] $script" -ForegroundColor Green
        $Registry["scripts/$script"] = $CurrentVersion
        $success++
        $downloaded = $true
    }
    catch {
        # Retry once after 2s (CDN cache may cause transient 404)
        Start-Sleep -Seconds 2
        try {
            Invoke-WebRequest -Uri $url -OutFile "$ScriptsDir\$script.tmp" -UseBasicParsing -ErrorAction Stop
            Move-Item -Path "$ScriptsDir\$script.tmp" -Destination "$ScriptsDir\$script" -Force
            Write-Host "   [OK] $script (retry)" -ForegroundColor Green
            $Registry["scripts/$script"] = $CurrentVersion
            $success++
            $downloaded = $true
        }
        catch {
            Remove-Item -Path "$ScriptsDir\$script.tmp" -ErrorAction SilentlyContinue
            Write-Host "   [!!] $script (optional - will retry next update)" -ForegroundColor Yellow
        }
    }
}

# 7. Registry-based orphan cleanup (safe for user files)
Write-Host ""
Write-Host "[...] Scanning for orphan files (registry-based)..." -ForegroundColor Cyan
$orphanCount = 0

# Build set of current valid files from manifest
$validFiles = @{}
foreach ($wf in $WorkflowsEn) { $validFiles["global_workflows/${wf}.md"] = $true }
foreach ($ag in $Agents) { $validFiles["agents/${ag}.md"] = $true }
foreach ($sk in $Skills) { $validFiles["skills/$sk/SKILL.md"] = $true }
foreach ($sc in $Scripts) { $validFiles["scripts/$sc"] = $true }
foreach ($sch in $Schemas) { $validFiles["schemas/$sch"] = $true }
foreach ($tpl in $Templates) { $validFiles["templates/$tpl"] = $true }

# Only delete files that are IN registry (AntiKit installed) but NOT in current manifest
$keysToRemove = @()
foreach ($regKey in $Registry.Keys) {
    if (-not $validFiles.ContainsKey($regKey)) {
        $filePath = "$AntigravityDir\$($regKey -replace '/', '\')" 
        if (Test-Path $filePath) {
            # Check if it's a directory (skill folder)
            if ((Get-Item $filePath).PSIsContainer) {
                Remove-Item $filePath -Recurse -Force
            } else {
                Remove-Item $filePath -Force
            }
            Write-Host "   [DEL] Orphan (registry): $regKey" -ForegroundColor Yellow
            $orphanCount++
        }
        # Also clean empty parent dir for skills
        $parentDir = Split-Path $filePath -Parent
        if ((Test-Path $parentDir) -and (Get-ChildItem $parentDir -ErrorAction SilentlyContinue).Count -eq 0) {
            Remove-Item $parentDir -Force -ErrorAction SilentlyContinue
        }
        $keysToRemove += $regKey
    }
}
# Remove orphan keys from registry
foreach ($key in $keysToRemove) { $Registry.Remove($key) }

if ($orphanCount -eq 0) {
    Write-Host "   [OK] No orphan files found" -ForegroundColor Green
}
else {
    Write-Host "   [OK] Cleaned $orphanCount orphan file(s)" -ForegroundColor Green
}

# Save registry
$regOutput = @{
    version = $CurrentVersion
    updated_at = (Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ")
    files = $Registry
}
$regOutput | ConvertTo-Json -Depth 3 | Set-Content -Path $RegistryFile -Encoding UTF8
Write-Host "   [OK] Registry saved ($($Registry.Count) files tracked)" -ForegroundColor Green

# 7.5. Save version and language
if (-not (Test-Path "$env:USERPROFILE\.gemini")) {
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.gemini" | Out-Null
}
[System.IO.File]::WriteAllText($VersionFile, $CurrentVersion, [System.Text.Encoding]::UTF8)
# Write to BOTH files for backward compat
$LangFileNew = "$env:USERPROFILE\.gemini\antikit_language"
$LangFileOld = "$env:USERPROFILE\.gemini\antikit_lang"
[System.IO.File]::WriteAllText($LangFileNew, $lang, [System.Text.Encoding]::UTF8)
[System.IO.File]::WriteAllText($LangFileOld, $lang, [System.Text.Encoding]::UTF8)

# Save manifest locally
if ($ManifestData) {
    $ManifestRaw | Out-File "$AntigravityDir\manifest.json" -Encoding UTF8
}
Write-Host ""
Write-Host "[OK] Version saved: $CurrentVersion" -ForegroundColor Green
Write-Host "[OK] Language saved: $lang" -ForegroundColor Green

# 7.6. Download Global Lessons (Continuous Learning)
Write-Host ""
Write-Host "[...] Syncing Global Lessons (Auto-Learn Protocol)..." -ForegroundColor Cyan
$GlobalLessonsFile = "$AntigravityDir\global_lessons.md"
$GlobalLessonsUpstream = "$AntigravityDir\global_lessons_upstream.md"
try {
    Invoke-WebRequest -Uri "$RepoBase/global_lessons.md" -OutFile $GlobalLessonsUpstream -UseBasicParsing -ErrorAction Stop
    if (-not (Test-Path $GlobalLessonsFile)) {
        # New user: copy directly
        Move-Item -Path $GlobalLessonsUpstream -Destination $GlobalLessonsFile -Force
        Write-Host "   [OK] Global Lessons installed (new)" -ForegroundColor Green
    }
    else {
        # Existing user: smart merge - replace Meta-Rule + Auto-Learn, merge Permanent, keep Recent
        $upstreamContent = Get-Content $GlobalLessonsUpstream -Raw
        $localContent = Get-Content $GlobalLessonsFile -Raw

        # Extract user's Recent section (personal lessons)
        $recentMarker = "## Recent"
        $localRecentIdx = $localContent.IndexOf($recentMarker)
        $userRecent = ""
        if ($localRecentIdx -ge 0) {
            $userRecent = $localContent.Substring($localRecentIdx)
        }

        # Use upstream as base but keep user's Recent
        $upstreamRecentIdx = $upstreamContent.IndexOf($recentMarker)
        if ($upstreamRecentIdx -ge 0 -and $userRecent) {
            $mergedContent = $upstreamContent.Substring(0, $upstreamRecentIdx) + $userRecent
        }
        else {
            $mergedContent = $upstreamContent
        }

        [System.IO.File]::WriteAllText($GlobalLessonsFile, $mergedContent, [System.Text.Encoding]::UTF8)
        Remove-Item -Path $GlobalLessonsUpstream -Force -ErrorAction SilentlyContinue
        Write-Host "   [OK] Global Lessons merged (kept personal Recent)" -ForegroundColor Green
    }
    $success++
}
catch {
    Remove-Item -Path $GlobalLessonsUpstream -Force -ErrorAction SilentlyContinue
    Write-Host "   [!!] Global Lessons (optional - will retry next update)" -ForegroundColor Yellow
}

# 7.7. Run Version Migrations (like DB migrations for file system)
Write-Host ""
Write-Host "[...] Checking version migrations..." -ForegroundColor Cyan
$MigrationsTmp = "$env:TEMP\antikit_migrations.json"
$MigrationsApplied = 0
try {
    Invoke-WebRequest -Uri "$RepoBase/migrations.json" -OutFile $MigrationsTmp -UseBasicParsing -ErrorAction Stop
    $migrations = (Get-Content $MigrationsTmp -Raw | ConvertFrom-Json).migrations

    # Get user's current installed version (before this update)
    $InstalledVersion = "0.0.0"
    if (Test-Path $VersionFile) {
        $InstalledVersion = Get-Content $VersionFile -ErrorAction SilentlyContinue
        if ([string]::IsNullOrWhiteSpace($InstalledVersion)) { $InstalledVersion = "0.0.0" }
    }

    # Version compare helper
    function Compare-SemVer($a, $b) {
        $aParts = $a -split '\.' | ForEach-Object { [int]$_ }
        $bParts = $b -split '\.' | ForEach-Object { [int]$_ }
        for ($i = 0; $i -lt 3; $i++) {
            $av = if ($i -lt $aParts.Count) { $aParts[$i] } else { 0 }
            $bv = if ($i -lt $bParts.Count) { $bParts[$i] } else { 0 }
            if ($av -lt $bv) { return -1 }
            if ($av -gt $bv) { return 1 }
        }
        return 0
    }

    # Filter migrations: version > installedVersion, sort ascending
    $pendingMigrations = $migrations | Where-Object {
        (Compare-SemVer $_.version $InstalledVersion) -gt 0
    } | Sort-Object { $v = $_.version -split '\.'; [int]$v[0] * 10000 + [int]$v[1] * 100 + [int]$v[2] }

    if ($pendingMigrations.Count -eq 0) {
        Write-Host "   [OK] No pending migrations" -ForegroundColor Green
    }
    else {
        Write-Host "   [INFO] Found $($pendingMigrations.Count) migration(s) to apply ($InstalledVersion -> $CurrentVersion)" -ForegroundColor Yellow
        foreach ($migration in $pendingMigrations) {
            Write-Host "   [v$($migration.version)] $($migration.description)" -ForegroundColor Cyan
            foreach ($action in $migration.actions) {
                switch ($action.type) {
                    "remove_agent" {
                        $target = "$AgentsDir\$($action.name).md"
                        if (Test-Path $target) {
                            Remove-Item $target -Force
                            Write-Host "      [DEL] Agent: $($action.name).md" -ForegroundColor Yellow
                            $MigrationsApplied++
                        }
                    }
                    "remove_skill" {
                        $target = "$SkillsDir\$($action.name)"
                        if (Test-Path $target) {
                            Remove-Item $target -Recurse -Force
                            Write-Host "      [DEL] Skill: $($action.name)/" -ForegroundColor Yellow
                            $MigrationsApplied++
                        }
                    }
                    "remove_workflow" {
                        $target = "$GlobalWorkflows\$($action.name).md"
                        if (Test-Path $target) {
                            Remove-Item $target -Force
                            Write-Host "      [DEL] Workflow: $($action.name).md" -ForegroundColor Yellow
                            $MigrationsApplied++
                        }
                    }
                    "rename_agent" {
                        $old = "$AgentsDir\$($action.from).md"
                        if (Test-Path $old) {
                            Remove-Item $old -Force
                            Write-Host "      [REN] Agent: $($action.from) -> $($action.to)" -ForegroundColor Yellow
                            $MigrationsApplied++
                        }
                    }
                    "rename_skill" {
                        $old = "$SkillsDir\$($action.from)"
                        if (Test-Path $old) {
                            Remove-Item $old -Recurse -Force
                            Write-Host "      [REN] Skill: $($action.from) -> $($action.to)" -ForegroundColor Yellow
                            $MigrationsApplied++
                        }
                    }
                    "remove_file" {
                        $target = "$AntigravityDir\$($action.path)"
                        if (Test-Path $target) {
                            Remove-Item $target -Force
                            Write-Host "      [DEL] File: $($action.path)" -ForegroundColor Yellow
                            $MigrationsApplied++
                        }
                    }
                    default {
                        # add_file, run_cleanup — handled by other install steps
                    }
                }
            }
        }
        if ($MigrationsApplied -gt 0) {
            Write-Host "   [OK] Applied $MigrationsApplied migration action(s)" -ForegroundColor Green
        } else {
            Write-Host "   [OK] All migrations already applied" -ForegroundColor Green
        }
    }
}
catch {
    Write-Host "   [!!] Migrations check skipped (network error)" -ForegroundColor Yellow
}
finally {
    Remove-Item $MigrationsTmp -Force -ErrorAction SilentlyContinue
}

# 8. Download GEMINI.md source files from rules/
Write-Host ""
Write-Host "[...] Downloading GEMINI rules..." -ForegroundColor Cyan
$RulesDir = "$AntigravityDir\rules"
if (-not (Test-Path $RulesDir)) { New-Item -ItemType Directory -Force -Path $RulesDir | Out-Null }

# Download language-specific instructions + core GEMINI.md
try {
    Invoke-WebRequest -Uri "$RepoBase/rules/instructions_$lang.md" -OutFile "$RulesDir\instructions.md" -UseBasicParsing -ErrorAction Stop
    Write-Host "   [OK] instructions_$lang.md" -ForegroundColor Green
}
catch {
    Write-Host "   [X] instructions_$lang.md" -ForegroundColor Red
}

try {
    Invoke-WebRequest -Uri "$RepoBase/rules/GEMINI.md" -OutFile "$RulesDir\GEMINI.md" -UseBasicParsing -ErrorAction Stop
    Write-Host "   [OK] GEMINI.md (core rules)" -ForegroundColor Green
}
catch {
    Write-Host "   [X] GEMINI.md (core rules)" -ForegroundColor Red
}

# Assemble AntiKitInstructions from downloaded files (strip YAML frontmatter)
function Strip-Frontmatter($filePath) {
    $lines = Get-Content $filePath
    if ($lines.Count -gt 0 -and $lines[0] -eq "---") {
        $endIdx = -1
        for ($i = 1; $i -lt $lines.Count; $i++) {
            if ($lines[$i] -eq "---") { $endIdx = $i; break }
        }
        if ($endIdx -ge 0) {
            return ($lines[($endIdx + 1)..($lines.Count - 1)] | Where-Object { $_ -ne $null }) -join "`n"
        }
    }
    return Get-Content $filePath -Raw
}

$AntiKitInstructions = ""
if (Test-Path "$RulesDir\instructions.md") {
    $AntiKitInstructions = Strip-Frontmatter "$RulesDir\instructions.md"
}
if (Test-Path "$RulesDir\GEMINI.md") {
    $AntiKitInstructions = $AntiKitInstructions + "`n`n" + (Strip-Frontmatter "$RulesDir\GEMINI.md")
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

# 8.6 Generate SKILL INDEX from downloaded skills
Write-Host "[...] Generating Skill Index..." -ForegroundColor Cyan
$SkillIndexRows = @()
$SkillIndexRows += "| Skill | Description |"
$SkillIndexRows += "|-------|-------------|"

foreach ($skill in $Skills) {
    $skillFile = "$SkillsDir\$skill\SKILL.md"
    if (-not (Test-Path $skillFile)) { continue }
    $sName = ""; $sDesc = ""
    $inFm = $false
    $hasFm = $false
    foreach ($line in (Get-Content $skillFile)) {
        if ($line -eq "---") {
            if (-not $inFm) { $inFm = $true; $hasFm = $true; continue } else { break }
        }
        if ($inFm -and $line -match '^(\w+):\s*(.+)$') {
            switch ($Matches[1]) {
                'name' { $sName = $Matches[2] }
                'description' { $sDesc = $Matches[2] }
            }
        }
    }
    # Fallback: no frontmatter -> use directory name + first > line
    if (-not $sName) {
        $sName = $skill
        $descLine = Get-Content $skillFile | Where-Object { $_ -match '^>' } | Select-Object -First 1
        if ($descLine) { $sDesc = ($descLine -replace '^>\s*', '').Trim() }
    }
    if ($sDesc.Length -gt 100) { $sDesc = $sDesc.Substring(0, 100) + "..." }
    if ($sName) { $SkillIndexRows += "| $sName | $sDesc |" }
}
$SkillIndex = $SkillIndexRows -join "`n"
Write-Host "[OK] Skill Index generated" -ForegroundColor Green

# 8.7 MULTI-AGENT PROTOCOL (language-agnostic)
$MultiAgentProtocol = @"

## AGENT INDEX (Auto-Generated)

$AgentIndex

## SKILL INDEX (Auto-Generated)

$SkillIndex

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

# ── AUTO-BACKUP ──────────────────────────────────────────────
$BackupCreated = ""
if (Test-Path $GeminiMd) {
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $BackupFile = "${GeminiMd}.backup.${timestamp}"
    Copy-Item $GeminiMd $BackupFile -Force
    $BackupCreated = $BackupFile
    Write-Host "[BACKUP] $(Split-Path $BackupFile -Leaf)" -ForegroundColor Green

    # Keep only 3 most recent backups
    $backups = Get-ChildItem "${GeminiMd}.backup.*" -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending
    if ($backups.Count -gt 3) {
        $backups | Select-Object -Skip 3 | Remove-Item -Force
    }
}

# ── UPDATE GEMINI.MD ─────────────────────────────────────────
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

# ── DETECT CUSTOM CONTENT ───────────────────────────────────
$CustomBefore = 0
$CustomAfter = 0
$AntiKitLineCount = 0

if (Test-Path $GeminiMd) {
    $allContent = Get-Content $GeminiMd -Raw -ErrorAction SilentlyContinue
    if ($allContent -and $allContent.Contains($StartMarker) -and $allContent.Contains($EndMarker)) {
        $startIdx = $allContent.IndexOf($StartMarker)
        $endIdx = $allContent.IndexOf($EndMarker) + $EndMarker.Length
        $beforeContent = if ($startIdx -gt 0) { $allContent.Substring(0, $startIdx).Trim() } else { "" }
        $afterContent = if ($endIdx -lt $allContent.Length) { $allContent.Substring($endIdx).Trim() } else { "" }
        $antiKitContent = $allContent.Substring($startIdx, $endIdx - $startIdx)
        if ($beforeContent) { $CustomBefore = ($beforeContent -split "`n" | Where-Object { $_.Trim() }).Count }
        if ($afterContent) { $CustomAfter = ($afterContent -split "`n" | Where-Object { $_.Trim() }).Count }
        $AntiKitLineCount = ($antiKitContent -split "`n").Count
    }
}

Write-Host ""
Write-Host "[REPORT] GEMINI.md UPDATE REPORT:" -ForegroundColor Cyan
if ($BackupCreated) {
    Write-Host "   [BACKUP] $(Split-Path $BackupCreated -Leaf)" -ForegroundColor Green
}
Write-Host "   [UPDATE] AntiKit rules: Updated ($AntiKitLineCount lines)" -ForegroundColor Green
if ($CustomBefore -gt 0) {
    Write-Host "   [CUSTOM] Rules before markers: $CustomBefore lines - preserved" -ForegroundColor Green
}
if ($CustomAfter -gt 0) {
    Write-Host "   [CUSTOM] Rules after markers: $CustomAfter lines - preserved" -ForegroundColor Green
}
if ($CustomBefore -eq 0 -and $CustomAfter -eq 0) {
    Write-Host "   [CUSTOM] No custom rules detected" -ForegroundColor Yellow
    Write-Host "   [TIP] Add your custom rules OUTSIDE the markers to preserve them during updates" -ForegroundColor Yellow
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
