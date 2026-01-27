#!/bin/bash
# AntiKit Installer for macOS/Linux
# Downloads and installs Enhancement Kit for Antigravity
# https://github.com/hasugoii/antikit

REPO_BASE="https://raw.githubusercontent.com/hasugoii/antikit/main"

# Workflows (will use selected language)
WORKFLOWS=(
    "ak-update.md" "audit.md" "brainstorm.md" "cloudflare-tunnel.md"
    "code.md" "config.md" "customize.md" "debug.md" "deploy.md"
    "init.md" "next.md" "plan.md" "recap.md" "refactor.md"
    "rollback.md" "run.md" "save_brain.md" "test.md" "uninstall.md" "visualize.md"
)

# Agents
AGENTS=(
    "architect.md" "backend.md" "database.md" "debugger.md" "devops.md"
    "doc-writer.md" "explorer.md" "frontend.md" "game.md" "mobile.md"
    "orchestrator.md" "pentester.md" "performance.md" "security.md" "seo.md" "tester.md"
)

# Schemas
SCHEMAS=(
    "brain.schema.json" "preferences.schema.json" "session.schema.json"
)

# Templates (including GEMINI.md templates)
TEMPLATES=(
    "brain.example.json" "preferences.example.json" "session.example.json"
    "gemini_en.md" "gemini_vi.md" "gemini_zh.md" "gemini_ja.md"
)

# Skills (directories with SKILL.md inside)
SKILLS=(
    "api-patterns" "app-builder" "architecture" "bash-linux" "behavioral-modes"
    "brainstorming" "clean-code" "code-review-checklist" "database-design"
    "deployment-procedures" "docker-expert" "documentation-templates" "frontend-design"
    "game-development" "geo-fundamentals" "i18n-localization" "lint-and-validate"
    "mcp-builder" "mobile-design" "nestjs-expert" "nextjs-expert" "nodejs-best-practices"
    "parallel-agents" "performance-profiling" "plan-writing" "powershell-windows"
    "prisma-expert" "python-patterns" "react-patterns" "red-team-tactics"
    "seo-fundamentals" "server-management" "systematic-debugging" "tailwind-patterns"
    "tdd-workflow" "testing-patterns" "typescript-expert" "ui-ux-pro-max"
    "vulnerability-scanner" "webapp-testing"
)

# Paths
ANTIGRAVITY_DIR="$HOME/.gemini/antigravity"
GLOBAL_WORKFLOWS="$ANTIGRAVITY_DIR/global_workflows"
AGENTS_DIR="$ANTIGRAVITY_DIR/agents"
SCHEMAS_DIR="$ANTIGRAVITY_DIR/schemas"
TEMPLATES_DIR="$ANTIGRAVITY_DIR/templates"
SKILLS_DIR="$ANTIGRAVITY_DIR/skills"
GEMINI_MD="$HOME/.gemini/GEMINI.md"
VERSION_FILE="$HOME/.gemini/antikit_version"
LANG_FILE="$HOME/.gemini/antikit_language"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m'

# Get version from repo
CURRENT_VERSION=$(curl -s "$REPO_BASE/VERSION" 2>/dev/null || echo "1.0.0")

echo ""
echo -e "${MAGENTA}======================================${NC}"
echo -e "${MAGENTA}  AntiKit - Enhancement Kit v${CURRENT_VERSION}${NC}"
echo -e "${MAGENTA}======================================${NC}"
echo ""

# Check if updating
if [ -f "$VERSION_FILE" ]; then
    OLD_VERSION=$(cat "$VERSION_FILE")
    echo -e "${YELLOW}Current version: $OLD_VERSION${NC}"
    echo -e "${GREEN}New version: $CURRENT_VERSION${NC}"
    echo ""
fi

# Language selection
LANG="en" # Default

# 1. Try to load from config if exists
if [ -f "$LANG_FILE" ]; then
    LANG=$(cat "$LANG_FILE")
    echo -e "${GREEN}[OK] Auto-detected language: $LANG${NC}"
else
    # 2. Prompt user ONLY if no config found
    echo -e "${CYAN}Select language for workflows:${NC}"
    echo "   1. English (en)"
    echo "   2. Japanese (ja)"
    echo "   3. Vietnamese (vi)"
    echo "   4. Chinese (zh)"
    echo ""
    read -p "Enter choice (1-4, default: 1): " lang_choice

    case $lang_choice in
        2) LANG="ja" ;;
        3) LANG="vi" ;;
        4) LANG="zh" ;;
        *) LANG="en" ;;
    esac
    echo -e "${GREEN}[OK] Selected language: $LANG${NC}"
fi
echo ""

success=0
failed=0

# 1. Create directories
mkdir -p "$ANTIGRAVITY_DIR" "$GLOBAL_WORKFLOWS" "$AGENTS_DIR" "$SCHEMAS_DIR" "$TEMPLATES_DIR" "$SKILLS_DIR"
echo -e "${GREEN}[OK] Directories ready: $ANTIGRAVITY_DIR${NC}"

# 2. Download Workflows
echo ""
echo -e "${CYAN}[->] Downloading workflows ($LANG)...${NC}"
for wf in "${WORKFLOWS[@]}"; do
    if curl -f -s -o "$GLOBAL_WORKFLOWS/$wf" "$REPO_BASE/workflows/$LANG/$wf"; then
        echo -e "   ${GREEN}[OK] $wf${NC}"
        ((success++))
    else
        echo -e "   ${RED}[X] $wf${NC}"
        ((failed++))
    fi
done

# 3. Download Agents
echo ""
echo -e "${CYAN}[->] Downloading agents...${NC}"
for agent in "${AGENTS[@]}"; do
    if curl -f -s -o "$AGENTS_DIR/$agent" "$REPO_BASE/agents/$agent"; then
        echo -e "   ${GREEN}[OK] $agent${NC}"
        ((success++))
    else
        echo -e "   ${RED}[X] $agent${NC}"
        ((failed++))
    fi
done

# 4. Download Schemas
echo ""
echo -e "${CYAN}[->] Downloading schemas...${NC}"
for schema in "${SCHEMAS[@]}"; do
    if curl -f -s -o "$SCHEMAS_DIR/$schema" "$REPO_BASE/schemas/$schema"; then
        echo -e "   ${GREEN}[OK] $schema${NC}"
        ((success++))
    else
        echo -e "   ${RED}[X] $schema${NC}"
        ((failed++))
    fi
done

# 5. Download Templates
echo ""
echo -e "${CYAN}[->] Downloading templates...${NC}"
for template in "${TEMPLATES[@]}"; do
    if curl -f -s -o "$TEMPLATES_DIR/$template" "$REPO_BASE/templates/$template"; then
        echo -e "   ${GREEN}[OK] $template${NC}"
        ((success++))
    else
        echo -e "   ${RED}[X] $template${NC}"
        ((failed++))
    fi
done

# 6. Download Skills
echo ""
echo -e "${CYAN}[->] Downloading skills...${NC}"
for skill in "${SKILLS[@]}"; do
    mkdir -p "$SKILLS_DIR/$skill"
    if curl -f -s -o "$SKILLS_DIR/$skill/SKILL.md" "$REPO_BASE/skills/$skill/SKILL.md"; then
        echo -e "   ${GREEN}[OK] $skill${NC}"
        ((success++))
    else
        echo -e "   ${RED}[X] $skill${NC}"
        ((failed++))
    fi
done

# 7. Save version and language
mkdir -p "$HOME/.gemini"
echo "$CURRENT_VERSION" > "$VERSION_FILE"
echo "$LANG" > "$LANG_FILE"
echo ""
echo -e "${GREEN}[OK] Version saved: $CURRENT_VERSION${NC}"
echo -e "${GREEN}[OK] Language saved: $LANG${NC}"

# 8. Update Global Rules (GEMINI.md) - Download template from repository
echo ""
echo -e "${CYAN}[->] Setting up GEMINI.md...${NC}"

TEMPLATE_URL="$REPO_BASE/templates/gemini_$LANG.md"
echo "   Downloading template: gemini_$LANG.md"

# Download template
ANTIKIT_INSTRUCTIONS=$(curl -f -s "$TEMPLATE_URL" 2>/dev/null)

if [ -z "$ANTIKIT_INSTRUCTIONS" ]; then
    echo -e "   ${RED}[X] Failed to download template${NC}"
    echo -e "   ${YELLOW}[!] Skipping GEMINI.md setup${NC}"
else
    echo -e "   ${GREEN}[OK] Template downloaded successfully${NC}"
    
    START_MARKER="<!-- ANTIKIT_START -->"
    END_MARKER="<!-- ANTIKIT_END -->"
    
    # Ensure content has markers
    if ! echo "$ANTIKIT_INSTRUCTIONS" | grep -q "$START_MARKER"; then
        ANTIKIT_INSTRUCTIONS="$START_MARKER
$ANTIKIT_INSTRUCTIONS
$END_MARKER"
    fi
    
    if [ ! -f "$GEMINI_MD" ]; then
        # Create new file
        echo "$ANTIKIT_INSTRUCTIONS" > "$GEMINI_MD"
        echo -e "   ${GREEN}[OK] Created Global Rules (GEMINI.md)${NC}"
    else
        # Check for existing markers
        if grep -q "$START_MARKER" "$GEMINI_MD" && grep -q "$END_MARKER" "$GEMINI_MD"; then
            # Scenario A: Markers exist - Block Replace using awk
            TMP_FILE="${GEMINI_MD}.tmp"
            
            awk -v start="$START_MARKER" -v end="$END_MARKER" -v new_content="$ANTIKIT_INSTRUCTIONS" '
            $0 ~ start {
                print new_content
                skip = 1
                next
            }
            $0 ~ end {
                skip = 0
                next
            }
            !skip { print }
            ' "$GEMINI_MD" > "$TMP_FILE"
            
            mv "$TMP_FILE" "$GEMINI_MD"
            echo -e "   ${GREEN}[OK] Updated Global Rules (GEMINI.md) - Block Replaced${NC}"
            
        else
            # Scenario B: Legacy Header or Fresh Install
            # Remove old AntiKit or AWF section and replace with new (Legacy Migration)
            if grep -q "AntiKit - Enhancement Kit for Antigravity" "$GEMINI_MD" 2>/dev/null; then
                sed -i.bak '/# AntiKit - Enhancement Kit for Antigravity/,$d' "$GEMINI_MD"
                rm -f "$GEMINI_MD.bak"
            elif grep -q "AWF - Antigravity Workflow Framework" "$GEMINI_MD" 2>/dev/null; then
                sed -i.bak '/# AWF - Antigravity Workflow Framework/,$d' "$GEMINI_MD"
                rm -f "$GEMINI_MD.bak"
            fi
            
            # Append new content with markers
            echo "" >> "$GEMINI_MD"
            echo "$ANTIKIT_INSTRUCTIONS" >> "$GEMINI_MD"
            echo -e "   ${GREEN}[OK] Updated Global Rules (GEMINI.md) - Migrated/Appended${NC}"
        fi
    fi
fi

# Summary
echo ""
echo "======================================"
echo -e "${YELLOW}COMPLETE! Installed $success files ($failed failed)${NC}"
echo -e "${CYAN}Version: $CURRENT_VERSION${NC}"
echo ""
echo "Workflows:  $GLOBAL_WORKFLOWS"
echo "Agents:     $AGENTS_DIR"
echo "Skills:     $SKILLS_DIR"
echo "Schemas:    $SCHEMAS_DIR"
echo "Templates:  $TEMPLATES_DIR"
echo ""
echo ""
echo -e "${YELLOW}IMPORTANT: Please RESTART Antigravity to apply changes!${NC}"
echo ""
echo -e "${CYAN}You can use AntiKit in ANY project immediately!${NC}"
echo "Try typing '/recap' to test."
echo "Check for updates: '/ak-update'"
echo ""
echo "======================================"
echo ""

exit 0
