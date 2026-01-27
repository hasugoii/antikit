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

# Use Continue to handle errors gracefully
$ErrorActionPreference = "Continue"

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

function Wait-ForKeyPress {
    Write-Host ""
    Write-Host "Press any key to exit..." -ForegroundColor Gray
    try {
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    }
    catch {
        # Fallback for non-interactive sessions
        Start-Sleep -Seconds 5
    }
}

function Show-ErrorGuide($errorType, $details) {
    Write-Host ""
    Write-Host "============================================================" -ForegroundColor Red
    Write-Host "  INSTALLATION FAILED" -ForegroundColor Red
    Write-Host "============================================================" -ForegroundColor Red
    Write-Host ""
    
    switch ($errorType) {
        "FolderInUse" {
            Write-Host "  ERROR: The installation folder is currently in use." -ForegroundColor Yellow
            Write-Host ""
            Write-Host "  CAUSE:" -ForegroundColor Cyan
            Write-Host "    Another program (likely Antigravity/Gemini) is using"
            Write-Host "    the folder: $INSTALL_DIR"
            Write-Host ""
            Write-Host "  HOW TO FIX:" -ForegroundColor Green
            Write-Host "    1. Close Antigravity/Gemini Code Assist completely"
            Write-Host "    2. Close any file explorer windows showing this folder"
            Write-Host "    3. Run this installer again"
            Write-Host ""
            Write-Host "  ALTERNATIVE:" -ForegroundColor Green
            Write-Host "    Run this command first to force close related processes:"
            Write-Host ""
            Write-Host '    Get-Process *gemini*, *antigravity* | Stop-Process -Force' -ForegroundColor White
            Write-Host ""
        }
        "DownloadFailed" {
            Write-Host "  ERROR: Failed to download AntiKit." -ForegroundColor Yellow
            Write-Host ""
            Write-Host "  CAUSE:" -ForegroundColor Cyan
            Write-Host "    - No internet connection"
            Write-Host "    - GitHub is blocked or unreachable"
            Write-Host "    - Release version v$ANTIKIT_VERSION not found"
            Write-Host ""
            Write-Host "  HOW TO FIX:" -ForegroundColor Green
            Write-Host "    1. Check your internet connection"
            Write-Host "    2. Try again later"
            Write-Host "    3. Download manually from:"
            Write-Host "       https://github.com/$GITHUB_REPO/releases" -ForegroundColor White
            Write-Host ""
        }
        "ExtractFailed" {
            Write-Host "  ERROR: Failed to extract downloaded files." -ForegroundColor Yellow
            Write-Host ""
            Write-Host "  CAUSE:" -ForegroundColor Cyan
            Write-Host "    - Downloaded file is corrupted"
            Write-Host "    - Insufficient disk space"
            Write-Host "    - Permission denied"
            Write-Host ""
            Write-Host "  HOW TO FIX:" -ForegroundColor Green
            Write-Host "    1. Check available disk space"
            Write-Host "    2. Run PowerShell as Administrator"
            Write-Host "    3. Try again"
            Write-Host ""
        }
        "PermissionDenied" {
            Write-Host "  ERROR: Permission denied." -ForegroundColor Yellow
            Write-Host ""
            Write-Host "  CAUSE:" -ForegroundColor Cyan
            Write-Host "    - Insufficient permissions to write to the folder"
            Write-Host "    - Antivirus blocking the operation"
            Write-Host ""
            Write-Host "  HOW TO FIX:" -ForegroundColor Green
            Write-Host "    1. Run PowerShell as Administrator"
            Write-Host "    2. Temporarily disable antivirus"
            Write-Host "    3. Check folder permissions for:"
            Write-Host "       $INSTALL_DIR" -ForegroundColor White
            Write-Host ""
        }
        "ExecutionPolicy" {
            Write-Host "  ERROR: Script execution is blocked by policy." -ForegroundColor Yellow
            Write-Host ""
            Write-Host "  CAUSE:" -ForegroundColor Cyan
            Write-Host "    PowerShell Execution Policy prevents running scripts"
            Write-Host ""
            Write-Host "  HOW TO FIX:" -ForegroundColor Green
            Write-Host "    Run this command instead:"
            Write-Host ""
            Write-Host '    powershell -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/hasugoii/antikit/main/install.ps1 | iex"' -ForegroundColor White
            Write-Host ""
        }
        default {
            Write-Host "  ERROR: $details" -ForegroundColor Yellow
            Write-Host ""
            Write-Host "  HOW TO FIX:" -ForegroundColor Green
            Write-Host "    1. Try running as Administrator"
            Write-Host "    2. Check the error message above"
            Write-Host "    3. Report this issue at:"
            Write-Host "       https://github.com/$GITHUB_REPO/issues" -ForegroundColor White
            Write-Host ""
        }
    }
    
    Write-Host "============================================================" -ForegroundColor Red
}

function Backup-Existing {
    if (Test-Path $INSTALL_DIR) {
        Print-Step "Backing up existing installation..."
        
        # Try move first
        try {
            Move-Item -Path $INSTALL_DIR -Destination $BACKUP_DIR -Force -ErrorAction Stop
            Print-Success "Backup created: $BACKUP_DIR"
            return $true
        }
        catch {
            $errorMessage = $_.Exception.Message
            
            # Check if folder is in use
            if ($errorMessage -match "in use|being used|access|denied") {
                Print-Warning "Folder is in use. Trying alternative backup method..."
                
                # Try copy instead of move
                try {
                    Copy-Item -Path $INSTALL_DIR -Destination $BACKUP_DIR -Recurse -Force -ErrorAction Stop
                    Print-Success "Backup copy created: $BACKUP_DIR"
                    Print-Warning "Original folder still exists (will be overwritten)"
                    return $true
                }
                catch {
                    Show-ErrorGuide "FolderInUse" $errorMessage
                    return $false
                }
            }
            else {
                Show-ErrorGuide "PermissionDenied" $errorMessage
                return $false
            }
        }
    }
    return $true
}

function Download-AntiKit {
    Print-Step "Downloading AntiKit v$ANTIKIT_VERSION..."
    
    $downloadUrl = "https://github.com/$GITHUB_REPO/archive/refs/tags/v$ANTIKIT_VERSION.zip"
    $fallbackUrl = "https://github.com/$GITHUB_REPO/archive/refs/heads/main.zip"
    $zipPath = Join-Path $TEMP_DIR "antikit.zip"
    
    # Create temp directory
    try {
        New-Item -ItemType Directory -Path $TEMP_DIR -Force | Out-Null
    }
    catch {
        Show-ErrorGuide "PermissionDenied" $_.Exception.Message
        return $null
    }
    
    # Try tagged release first
    try {
        $ProgressPreference = 'SilentlyContinue'  # Speed up download
        Invoke-WebRequest -Uri $downloadUrl -OutFile $zipPath -UseBasicParsing -ErrorAction Stop
        Print-Success "Download complete (release v$ANTIKIT_VERSION)"
        return $zipPath
    }
    catch {
        Print-Warning "Release v$ANTIKIT_VERSION not found, trying main branch..."
    }
    
    # Fallback to main branch
    try {
        Invoke-WebRequest -Uri $fallbackUrl -OutFile $zipPath -UseBasicParsing -ErrorAction Stop
        Print-Success "Download complete (main branch)"
        return $zipPath
    }
    catch {
        Show-ErrorGuide "DownloadFailed" $_.Exception.Message
        return $null
    }
}

function Install-AntiKit($zipPath) {
    if (-not $zipPath) { return $false }
    
    Print-Step "Installing AntiKit..."
    
    # Extract
    $extractPath = Join-Path $TEMP_DIR "extracted"
    try {
        Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force -ErrorAction Stop
    }
    catch {
        Show-ErrorGuide "ExtractFailed" $_.Exception.Message
        return $false
    }
    
    # Find extracted directory
    $extractedDir = Get-ChildItem -Path $extractPath -Directory | Where-Object { $_.Name -like "antikit-*" } | Select-Object -First 1
    if (-not $extractedDir) {
        Show-ErrorGuide "ExtractFailed" "Could not find extracted AntiKit folder"
        return $false
    }
    
    # Create install directory
    try {
        New-Item -ItemType Directory -Path $INSTALL_DIR -Force | Out-Null
        New-Item -ItemType Directory -Path "$INSTALL_DIR\global_workflows" -Force | Out-Null
    }
    catch {
        Show-ErrorGuide "PermissionDenied" $_.Exception.Message
        return $false
    }
    
    # Copy files
    $sourcePath = $extractedDir.FullName
    $copyErrors = 0
    
    $folders = @(
        @{Source = "workflows"; Dest = "global_workflows" },
        @{Source = "agents"; Dest = "agents" },
        @{Source = "skills"; Dest = "skills" },
        @{Source = "schemas"; Dest = "schemas" },
        @{Source = "templates"; Dest = "templates" }
    )
    
    foreach ($folder in $folders) {
        $srcPath = Join-Path $sourcePath $folder.Source
        $dstPath = Join-Path $INSTALL_DIR $folder.Dest
        
        if (Test-Path $srcPath) {
            try {
                if ($folder.Source -eq "workflows") {
                    Copy-Item -Path "$srcPath\*" -Destination $dstPath -Recurse -Force -ErrorAction Stop
                }
                else {
                    Copy-Item -Path $srcPath -Destination $INSTALL_DIR -Recurse -Force -ErrorAction Stop
                }
            }
            catch {
                Print-Warning "Could not copy $($folder.Source): $($_.Exception.Message)"
                $copyErrors++
            }
        }
    }
    
    if ($copyErrors -gt 0) {
        Print-Warning "Some files could not be copied ($copyErrors errors)"
    }
    
    Print-Success "Files installed to $INSTALL_DIR"
    return $true
}

function Setup-Memory {
    Print-Step "Setting up memory configuration..."
    
    $memoryDir = "$env:USERPROFILE\.gemini\settings"
    $memoryFile = Join-Path $memoryDir "user_global.md"
    
    # Create directory if needed
    try {
        if (-not (Test-Path $memoryDir)) {
            New-Item -ItemType Directory -Path $memoryDir -Force | Out-Null
        }
    }
    catch {
        Print-Warning "Could not create settings directory: $($_.Exception.Message)"
        return $false
    }
    
    # Check if already configured
    if (Test-Path $memoryFile) {
        $content = Get-Content $memoryFile -Raw -ErrorAction SilentlyContinue
        if ($content -match "AntiKit") {
            Print-Success "Memory configuration already exists"
            return $true
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
    
    try {
        Add-Content -Path $memoryFile -Value $memoryContent -ErrorAction Stop
        Print-Success "Memory configuration updated"
        return $true
    }
    catch {
        Print-Warning "Could not update memory configuration: $($_.Exception.Message)"
        return $false
    }
}

function Setup-GeminiMd {
    Print-Step "Setting up GEMINI.md configuration..."
    
    $geminiMdFile = "$env:USERPROFILE\.gemini\GEMINI.md"
    $templateDir = Join-Path $INSTALL_DIR "templates"
    
    # Detect language (default to English)
    $langFile = "$env:USERPROFILE\.gemini\antikit_language"
    $lang = "en"
    if (Test-Path $langFile) {
        $lang = (Get-Content $langFile -Raw -ErrorAction SilentlyContinue).Trim()
        if ($lang -notin @("en", "vi", "zh", "ja")) {
            $lang = "en"
        }
    }
    
    $templateFile = Join-Path $templateDir "gemini_$lang.md"
    
    # Check if template exists
    if (-not (Test-Path $templateFile)) {
        Print-Warning "Template gemini_$lang.md not found, skipping GEMINI.md setup"
        return $false
    }
    
    try {
        # Read template content with UTF-8
        $templateContent = Get-Content $templateFile -Raw -Encoding UTF8 -ErrorAction Stop
        
        # Check if GEMINI.md exists and has AntiKit section
        if (Test-Path $geminiMdFile) {
            $existingContent = Get-Content $geminiMdFile -Raw -Encoding UTF8 -ErrorAction SilentlyContinue
            
            # If already has AntiKit section, replace it
            if ($existingContent -match "<!-- ANTIKIT_START -->") {
                $newContent = $existingContent -replace "(?s)<!-- ANTIKIT_START -->.*?<!-- ANTIKIT_END -->", $templateContent.Trim()
                # Write with UTF-8 BOM for Windows compatibility
                [System.IO.File]::WriteAllText($geminiMdFile, $newContent, [System.Text.Encoding]::UTF8)
            }
            else {
                # Append AntiKit section
                $newContent = $existingContent.TrimEnd() + "`n`n" + $templateContent
                [System.IO.File]::WriteAllText($geminiMdFile, $newContent, [System.Text.Encoding]::UTF8)
            }
        }
        else {
            # Create new file with UTF-8 encoding
            [System.IO.File]::WriteAllText($geminiMdFile, $templateContent, [System.Text.Encoding]::UTF8)
        }
        
        # Save selected language
        [System.IO.File]::WriteAllText($langFile, $lang, [System.Text.Encoding]::UTF8)
        
        Print-Success "GEMINI.md configured with $lang template (UTF-8)"
        return $true
    }
    catch {
        Print-Warning "Could not setup GEMINI.md: $($_.Exception.Message)"
        return $false
    }
}

function Verify-Installation {
    Print-Step "Verifying installation..."
    
    $errors = 0
    $warnings = 0
    
    # Check directories
    $dirs = @("global_workflows", "agents", "skills", "schemas", "templates")
    foreach ($dir in $dirs) {
        $path = Join-Path $INSTALL_DIR $dir
        if (-not (Test-Path $path)) {
            Print-Warning "Missing directory: $dir"
            $warnings++
        }
    }
    
    # Check workflow count
    $workflowPath = Join-Path $INSTALL_DIR "global_workflows"
    if (Test-Path $workflowPath) {
        $workflowCount = (Get-ChildItem -Path $workflowPath -Filter "*.md" -ErrorAction SilentlyContinue | Measure-Object).Count
        if ($workflowCount -lt 15) {
            Print-Warning "Expected 20 workflows, found $workflowCount"
            $warnings++
        }
        else {
            Print-Success "Found $workflowCount workflow files"
        }
    }
    
    if ($errors -eq 0 -and $warnings -eq 0) {
        Print-Success "Installation verified successfully"
        return $true
    }
    elseif ($errors -eq 0) {
        Print-Warning "Installation completed with $warnings warning(s)"
        return $true
    }
    else {
        Print-Error "Installation has $errors error(s)"
        return $false
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
$installSuccess = $false

try {
    Print-Banner
    
    # Step 1: Backup
    $backupOk = Backup-Existing
    if (-not $backupOk) {
        throw "HANDLED"  # Error already shown
    }
    
    # Step 2: Download
    $zipPath = Download-AntiKit
    if (-not $zipPath) {
        throw "HANDLED"  # Error already shown
    }
    
    # Step 3: Install
    $installOk = Install-AntiKit $zipPath
    if (-not $installOk) {
        throw "HANDLED"  # Error already shown
    }
    
    # Step 4: Setup memory
    Setup-Memory | Out-Null  # Non-critical, continue even if fails
    
    # Step 4.5: Setup GEMINI.md with UTF-8 encoding
    Setup-GeminiMd | Out-Null  # Non-critical, continue even if fails
    
    # Step 5: Verify
    Verify-Installation | Out-Null
    
    # Done!
    Print-Completion
    $installSuccess = $true
}
catch {
    if ($_.Exception.Message -ne "HANDLED") {
        # Unexpected error
        Show-ErrorGuide "Unknown" $_.Exception.Message
    }
}
finally {
    Cleanup
    
    # Always wait for user to see the result
    Wait-ForKeyPress
}
