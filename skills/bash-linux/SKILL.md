# Bash Linux

> Shell scripting và Linux commands

## Common Commands

```bash
# File operations
ls -la           # List files
cp src dst       # Copy
mv src dst       # Move/rename
rm -rf dir       # Remove

# Text processing
grep pattern file
cat file | sort | uniq
awk '{print $1}' file
sed 's/old/new/g' file

# Process
ps aux | grep node
kill -9 PID
htop

# Network
curl -X GET url
netstat -tulpn
```

## Script Template

```bash
#!/bin/bash
set -euo pipefail

# Variables
VAR="${1:-default}"

# Functions
log() { echo "[$(date)] $1"; }

# Main
main() {
  log "Starting..."
  # ... logic
  log "Done!"
}

main "$@"
```
