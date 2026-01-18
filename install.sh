#!/bin/bash
#
# AntiKit Installer for macOS/Linux
# https://github.com/hasugoii/antikit
#
# Usage: curl -fsSL https://raw.githubusercontent.com/hasugoii/antikit/main/install.sh | bash
#

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Config
ANTIKIT_VERSION="1.0.0"
GITHUB_REPO="hasugoii/antikit"
INSTALL_DIR="$HOME/.gemini/antigravity"
BACKUP_DIR="$HOME/.gemini/antigravity.backup.$(date +%Y%m%d_%H%M%S)"
TEMP_DIR=$(mktemp -d)

# Cleanup on exit
cleanup() {
    rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

# Print banner
print_banner() {
    echo -e "${PURPLE}"
    echo "    _          _   _ _  ___ _   "
    echo "   / \   _ __ | |_(_) |/ (_) |_ "
    echo "  / _ \ | '_ \| __| | ' /| | __|"
    echo " / ___ \| | | | |_| | . \| | |_ "
    echo "/_/   \_\_| |_|\__|_|_|\_\_|\__|"
    echo -e "${NC}"
    echo -e "${CYAN}Enhancement Kit for Antigravity v${ANTIKIT_VERSION}${NC}"
    echo ""
}

# Print step
print_step() {
    echo -e "${BLUE}→${NC} $1"
}

# Print success
print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

# Print warning
print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Print error
print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Check for required tools
check_requirements() {
    print_step "Checking requirements..."
    
    if ! command -v curl &> /dev/null && ! command -v wget &> /dev/null; then
        print_error "curl or wget is required but not installed."
        exit 1
    fi
    
    if ! command -v unzip &> /dev/null && ! command -v tar &> /dev/null; then
        print_error "unzip or tar is required but not installed."
        exit 1
    fi
    
    print_success "Requirements met"
}

# Backup existing installation
backup_existing() {
    if [ -d "$INSTALL_DIR" ]; then
        print_step "Backing up existing installation..."
        mv "$INSTALL_DIR" "$BACKUP_DIR"
        print_success "Backup created: $BACKUP_DIR"
    fi
}

# Download AntiKit
download_antikit() {
    print_step "Downloading AntiKit v${ANTIKIT_VERSION}..."
    
    local download_url="https://github.com/${GITHUB_REPO}/archive/refs/tags/v${ANTIKIT_VERSION}.tar.gz"
    local fallback_url="https://github.com/${GITHUB_REPO}/archive/refs/heads/main.tar.gz"
    
    cd "$TEMP_DIR"
    
    # Try tagged release first, fallback to main branch
    if command -v curl &> /dev/null; then
        if ! curl -fsSL "$download_url" -o antikit.tar.gz 2>/dev/null; then
            print_warning "Release not found, downloading from main branch..."
            curl -fsSL "$fallback_url" -o antikit.tar.gz
        fi
    else
        if ! wget -q "$download_url" -O antikit.tar.gz 2>/dev/null; then
            print_warning "Release not found, downloading from main branch..."
            wget -q "$fallback_url" -O antikit.tar.gz
        fi
    fi
    
    print_success "Download complete"
}

# Extract and install
install_antikit() {
    print_step "Installing AntiKit..."
    
    cd "$TEMP_DIR"
    
    # Extract
    tar -xzf antikit.tar.gz
    
    # Find extracted directory
    local extracted_dir=$(ls -d antikit-* 2>/dev/null | head -1)
    if [ -z "$extracted_dir" ]; then
        print_error "Failed to extract AntiKit"
        exit 1
    fi
    
    # Create install directory
    mkdir -p "$INSTALL_DIR"
    
    # Copy files
    cp -r "$extracted_dir/workflows"/* "$INSTALL_DIR/global_workflows/" 2>/dev/null || mkdir -p "$INSTALL_DIR/global_workflows" && cp -r "$extracted_dir/workflows"/* "$INSTALL_DIR/global_workflows/"
    cp -r "$extracted_dir/agents" "$INSTALL_DIR/" 2>/dev/null || true
    cp -r "$extracted_dir/skills" "$INSTALL_DIR/" 2>/dev/null || true
    cp -r "$extracted_dir/schemas" "$INSTALL_DIR/" 2>/dev/null || true
    cp -r "$extracted_dir/templates" "$INSTALL_DIR/" 2>/dev/null || true
    
    print_success "Files installed to $INSTALL_DIR"
}

# Setup MEMORY[user_global]
setup_memory() {
    print_step "Setting up memory configuration..."
    
    local memory_file="$HOME/.gemini/settings/user_global.md"
    local memory_dir=$(dirname "$memory_file")
    
    # Create directory if needed
    mkdir -p "$memory_dir"
    
    # Check if memory already exists
    if [ -f "$memory_file" ]; then
        if grep -q "AntiKit" "$memory_file" 2>/dev/null; then
            print_success "Memory configuration already exists"
            return
        fi
    fi
    
    # Create or append to memory file
    cat >> "$memory_file" << 'EOF'

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

EOF
    
    print_success "Memory configuration updated"
}

# Verify installation
verify_installation() {
    print_step "Verifying installation..."
    
    local errors=0
    
    # Check directories
    for dir in global_workflows agents skills schemas templates; do
        if [ ! -d "$INSTALL_DIR/$dir" ]; then
            print_error "Missing directory: $dir"
            errors=$((errors + 1))
        fi
    done
    
    # Check workflow count
    local workflow_count=$(ls -1 "$INSTALL_DIR/global_workflows"/*.md 2>/dev/null | wc -l)
    if [ "$workflow_count" -lt 15 ]; then
        print_warning "Expected 20 workflows, found $workflow_count"
    fi
    
    if [ $errors -eq 0 ]; then
        print_success "Installation verified"
    else
        print_error "Installation has $errors errors"
        return 1
    fi
}

# Print completion message
print_completion() {
    echo ""
    echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║${NC}  ${PURPLE}AntiKit v${ANTIKIT_VERSION} installed successfully!${NC}              ${GREEN}║${NC}"
    echo -e "${GREEN}╠════════════════════════════════════════════════════════════╣${NC}"
    echo -e "${GREEN}║${NC}                                                            ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}  📂 Installed to: ~/.gemini/antigravity/                   ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}                                                            ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}  🚀 Quick Start:                                           ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}     1. Restart Antigravity                                 ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}     2. Type: /recap                                        ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}                                                            ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}  📖 Documentation:                                         ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}     https://github.com/hasugoii/antikit                    ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}                                                            ${GREEN}║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Main
main() {
    print_banner
    check_requirements
    backup_existing
    download_antikit
    install_antikit
    setup_memory
    verify_installation
    print_completion
}

main "$@"
