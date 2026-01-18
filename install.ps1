#Requires -Version 5.1
<#
.SYNOPSIS
    AntiKit Installer for Windows
.DESCRIPTION
    Downloads and installs AntiKit - Enhancement Kit for Antigravity
.LINK
    https://github.com/hasugoii/antikit
.EXAMPLE
    irm https://raw.githubusercontent.com/hasugoii/antikit/main/install.ps1 | iex
#>

$ErrorActionPreference = "Stop"

# Config
$ANTIKIT_VERSION = "1.0.0"
$GITHUB_REPO = "hasugoii/antikit"
$INSTALL_DIR = "$env:USERPROFILE\.gemini\antigravity"
$BACKUP_DIR = "$env:USERPROFILE\.gemini\antigravity.backup.$(Get-Date -Format 'yyyyMMdd_HHmmss')"
$TEMP_DIR = Join-Path $env:TEMP "antikit-install-$(Get-Random)"

# Colors
function Write-ColorOutput($ForegroundColor) {
    $fc = $host.UI.RawUI.ForegroundColor
    $host.UI.RawUI.ForegroundColor = $ForegroundColor
    if ($args) {
        Write-Output $args
    }
    $host.UI.RawUI.ForegroundColor = $fc
}

function Print-Banner {
    Write-Host ""
    Write-Host "    _          _   _ _  ___ _   " -ForegroundColor Magenta
    Write-Host "   / \   _ __ | |_(_) |/ (_) |_ " -ForegroundColor Magenta
    Write-Host "  / _ \ | '_ \| __| | ' /| | __|" -ForegroundColor Magenta
    Write-Host " / ___ \| | | | |_| | . \| | |_ " -ForegroundColor Magenta
    Write-Host "/_/   \_\_| |_|\__|_|_|\_\_|\__|" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "Enhancement Kit for Antigravity v$ANTIKIT_VERSION" -ForegroundColor Cyan
    Write-Host ""
}

function Print-Step($message) {
    Write-Host "-> " -NoNewline -ForegroundColor Blue
    Write-Host $message
}

function Print-Success($message) {
    Write-Host "[OK] " -NoNewline -ForegroundColor Green
    Write-Host $message
}

function Print-Warning($message) {
    Write-Host "[!] " -NoNewline -ForegroundColor Yellow
    Write-Host $message
}

function Print-Error($message) {
    Write-Host "[X] " -NoNewline -ForegroundColor Red
    Write-Host $message
}

function Backup-Existing {
    if (Test-Path $INSTALL_DIR) {
        Print-Step "Backing up existing installation..."
        Move-Item -Path $INSTALL_DIR -Destination $BACKUP_DIR -Force
        Print-Success "Backup created: $BACKUP_DIR"
    }
}

function Download-AntiKit {
    Print-Step "Downloading AntiKit v$ANTIKIT_VERSION..."
    
    $downloadUrl = "https://github.com/$GITHUB_REPO/archive/refs/tags/v$ANTIKIT_VERSION.zip"
    $fallbackUrl = "https://github.com/$GITHUB_REPO/archive/refs/heads/main.zip"
    $zipPath = Join-Path $TEMP_DIR "antikit.zip"
    
    # Create temp directory
    New-Item -ItemType Directory -Path $TEMP_DIR -Force | Out-Null
    
    try {
        # Try tagged release first
        Invoke-WebRequest -Uri $downloadUrl -OutFile $zipPath -UseBasicParsing
    }
    catch {
        Print-Warning "Release not found, downloading from main branch..."
        Invoke-WebRequest -Uri $fallbackUrl -OutFile $zipPath -UseBasicParsing
    }
    
    Print-Success "Download complete"
    return $zipPath
}

function Install-AntiKit($zipPath) {
    Print-Step "Installing AntiKit..."
    
    # Extract
    $extractPath = Join-Path $TEMP_DIR "extracted"
    Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force
    
    # Find extracted directory
    $extractedDir = Get-ChildItem -Path $extractPath -Directory | Where-Object { $_.Name -like "antikit-*" } | Select-Object -First 1
    if (-not $extractedDir) {
        throw "Failed to extract AntiKit"
    }
    
    # Create install directory
    New-Item -ItemType Directory -Path $INSTALL_DIR -Force | Out-Null
    New-Item -ItemType Directory -Path "$INSTALL_DIR\global_workflows" -Force | Out-Null
    
    # Copy files
    $sourcePath = $extractedDir.FullName
    
    if (Test-Path "$sourcePath\workflows") {
        Copy-Item -Path "$sourcePath\workflows\*" -Destination "$INSTALL_DIR\global_workflows\" -Recurse -Force
    }
    if (Test-Path "$sourcePath\agents") {
        Copy-Item -Path "$sourcePath\agents" -Destination $INSTALL_DIR -Recurse -Force
    }
    if (Test-Path "$sourcePath\skills") {
        Copy-Item -Path "$sourcePath\skills" -Destination $INSTALL_DIR -Recurse -Force
    }
    if (Test-Path "$sourcePath\schemas") {
        Copy-Item -Path "$sourcePath\schemas" -Destination $INSTALL_DIR -Recurse -Force
    }
    if (Test-Path "$sourcePath\templates") {
        Copy-Item -Path "$sourcePath\templates" -Destination $INSTALL_DIR -Recurse -Force
    }
    
    Print-Success "Files installed to $INSTALL_DIR"
}

function Setup-Memory {
    Print-Step "Setting up memory configuration..."
    
    $memoryDir = "$env:USERPROFILE\.gemini\settings"
    $memoryFile = Join-Path $memoryDir "user_global.md"
    
    # Create directory if needed
    if (-not (Test-Path $memoryDir)) {
        New-Item -ItemType Directory -Path $memoryDir -Force | Out-Null
    }
    
    # Check if already configured
    if (Test-Path $memoryFile) {
        $content = Get-Content $memoryFile -Raw
        if ($content -match "AntiKit") {
            Print-Success "Memory configuration already exists"
            return
        }
    }
    
    # Append configuration
    $memoryContent = @"

# AntiKit - Antigravity Workflow Framework

## Command Recognition
When user types commands starting with `/`, read the corresponding workflow file and follow instructions.

## Command Mapping:
| Command | Workflow File |
|---------|--------------|
| `/brainstorm` | ~/.gemini/antigravity/global_workflows/brainstorm.md |
| `/plan` | ~/.gemini/antigravity/global_workflows/plan.md |
| `/code` | ~/.gemini/antigravity/global_workflows/code.md |
| `/visualize` | ~/.gemini/antigravity/global_workflows/visualize.md |
| `/debug` | ~/.gemini/antigravity/global_workflows/debug.md |
| `/test` | ~/.gemini/antigravity/global_workflows/test.md |
| `/run` | ~/.gemini/antigravity/global_workflows/run.md |
| `/deploy` | ~/.gemini/antigravity/global_workflows/deploy.md |
| `/init` | ~/.gemini/antigravity/global_workflows/init.md |
| `/recap` | ~/.gemini/antigravity/global_workflows/recap.md |
| `/next` | ~/.gemini/antigravity/global_workflows/next.md |
| `/customize` | ~/.gemini/antigravity/global_workflows/customize.md |
| `/save-brain` | ~/.gemini/antigravity/global_workflows/save_brain.md |
| `/audit` | ~/.gemini/antigravity/global_workflows/audit.md |
| `/refactor` | ~/.gemini/antigravity/global_workflows/refactor.md |
| `/rollback` | ~/.gemini/antigravity/global_workflows/rollback.md |

"@
    
    Add-Content -Path $memoryFile -Value $memoryContent
    Print-Success "Memory configuration updated"
}

function Verify-Installation {
    Print-Step "Verifying installation..."
    
    $errors = 0
    
    # Check directories
    $dirs = @("global_workflows", "agents", "skills", "schemas", "templates")
    foreach ($dir in $dirs) {
        $path = Join-Path $INSTALL_DIR $dir
        if (-not (Test-Path $path)) {
            Print-Error "Missing directory: $dir"
            $errors++
        }
    }
    
    # Check workflow count
    $workflowPath = Join-Path $INSTALL_DIR "global_workflows"
    $workflowCount = (Get-ChildItem -Path $workflowPath -Filter "*.md" -ErrorAction SilentlyContinue | Measure-Object).Count
    if ($workflowCount -lt 15) {
        Print-Warning "Expected 20 workflows, found $workflowCount"
    }
    
    if ($errors -eq 0) {
        Print-Success "Installation verified"
    }
    else {
        Print-Error "Installation has $errors errors"
    }
}

function Print-Completion {
    Write-Host ""
    Write-Host "+============================================================+" -ForegroundColor Green
    Write-Host "|  AntiKit v$ANTIKIT_VERSION installed successfully!              |" -ForegroundColor Green
    Write-Host "+============================================================+" -ForegroundColor Green
    Write-Host "|                                                            |"
    Write-Host "|  Installed to: ~/.gemini/antigravity/                      |"
    Write-Host "|                                                            |"
    Write-Host "|  Quick Start:                                              |"
    Write-Host "|     1. Restart Antigravity                                 |"
    Write-Host "|     2. Type: /recap                                        |"
    Write-Host "|                                                            |"
    Write-Host "|  Documentation:                                            |"
    Write-Host "|     https://github.com/hasugoii/antikit                    |"
    Write-Host "|                                                            |"
    Write-Host "+============================================================+" -ForegroundColor Green
    Write-Host ""
}

function Cleanup {
    if (Test-Path $TEMP_DIR) {
        Remove-Item -Path $TEMP_DIR -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# Main
try {
    Print-Banner
    Backup-Existing
    $zipPath = Download-AntiKit
    Install-AntiKit $zipPath
    Setup-Memory
    Verify-Installation
    Print-Completion
}
catch {
    Print-Error "Installation failed: $_"
    exit 1
}
finally {
    Cleanup
}
