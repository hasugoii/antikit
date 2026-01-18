# PowerShell Windows

> PowerShell và Windows scripting

## Common Commands

```powershell
# File operations
Get-ChildItem -Recurse
Copy-Item src dst
Remove-Item -Recurse -Force dir

# Environment
$env:PATH
[Environment]::SetEnvironmentVariable("VAR", "value", "User")

# Processes
Get-Process | Where-Object { $_.Name -like "node*" }
Stop-Process -Name "process"

# Network
Invoke-WebRequest -Uri "url" -OutFile "file"
Test-Connection "hostname"
```

## Script Template

```powershell
#Requires -Version 5.1

param(
    [string]$Path = ".",
    [switch]$Force
)

function Main {
    Write-Host "Starting..."
    # ... logic
    Write-Host "Done!"
}

Main
```

## Tips

- Use `-WhatIf` for dry run
- Use `-Verbose` for details
- Error handling with try/catch
- Profile customization
