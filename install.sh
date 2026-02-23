#!/bin/bash
# AntiKit Installer for macOS/Linux
# Direct download approach - inspired by AWF
# https://github.com/hasugoii/antikit

REPO_BASE="https://raw.githubusercontent.com/hasugoii/antikit/main"

# Workflows (will use selected language)
WORKFLOWS=(
    "ak-update.mdt" "audit.mdt" "brainstorm.mdt" "code.mdt" "config.mdt"
    "debug.mdt" "deploy.mdt" "grow.mdt" "init.mdt" "launch.mdt" "next.mdt"
    "plan.mdt" "recap.mdt" "refactor.mdt" "run.mdt" "save_brain.mdt" "sync-schema.mdt" "test.mdt"
    "uninstall.mdt" "visualize.mdt"
)

# Agents (21 total)
AGENTS=(
    "backend-specialist.mdt" "code-archaeologist.mdt" "database-architect.mdt"
    "debugger.mdt" "devops-engineer.mdt" "documentation-writer.mdt"
    "explorer-agent.mdt" "frontend-specialist.mdt" "game-developer.mdt"
    "growth-hacker.mdt" "mobile-developer.mdt" "orchestrator.mdt"
    "penetration-tester.mdt" "performance-optimizer.mdt" "product-manager.mdt"
    "product-owner.mdt" "project-planner.mdt" "qa-automation-engineer.mdt"
    "security-auditor.mdt" "seo-specialist.mdt" "test-engineer.mdt"
)

# Schemas
SCHEMAS=(
    "brain.schema.json" "preferences.schema.json" "session.schema.json"
)

# Templates
TEMPLATES=(
    "brain.example.json" "preferences.example.json" "session.example.json"
)

# Skills (83 total — directories with SKILL.mdt inside)
SKILLS=(
    "ab-test-setup" "ad-creative" "ai-seo" "analytics-tracking"
    "api-patterns" "app-builder" "app-store-optimization" "architecture"
    "bash-linux" "behavioral-modes" "brainstorming"
    "churn-prevention" "clean-code" "code-review-checklist" "cold-email"
    "competitor-alternatives" "content-hash-cache-pattern" "content-strategy"
    "continuous-learning-v2" "copy-editing" "copywriting" "cost-aware-llm-pipeline"
    "database-design" "deployment-procedures" "docker-expert" "docker-patterns"
    "documentation-templates" "e2e-testing" "email-sequence" "evidence-discipline"
    "form-cro" "free-tool-strategy" "frontend-design"
    "game-development" "geo-fundamentals" "growth-marketing"
    "i18n-localization" "intelligent-routing"
    "launch-strategy" "lint-and-validate"
    "marketing-ideas" "marketing-psychology" "mcp-builder" "mobile-design"
    "nestjs-expert" "nextjs-expert" "nextjs-react-expert" "nodejs-best-practices"
    "onboarding-cro"
    "page-cro" "paid-ads" "parallel-agents" "paywall-upgrade-cro"
    "performance-profiling" "plan-writing" "popup-cro" "powershell-windows"
    "pricing-strategy" "prisma-expert" "proactive-intelligence"
    "product-marketing-context" "programmatic-seo" "python-patterns"
    "react-patterns" "red-team-tactics" "referral-program" "rust-pro"
    "schema-markup" "seo-audit" "seo-fundamentals" "server-management"
    "signup-flow-cro" "social-content" "strategic-compact" "systematic-debugging"
    "tailwind-patterns" "tdd-workflow" "testing-patterns" "typescript-expert"
    "ui-ux-pro-max" "vulnerability-scanner" "web-design-guidelines" "webapp-testing"
)

# Scripts (7 total)
SCRIPTS=(
    "auto_preview.py" "checklist.py"
    "session_manager.py" "verify_all.py"
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
echo -e "${MAGENTA}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${MAGENTA}║       🚀 AntiKit - Enhancement Kit for Antigravity       ║${NC}"
echo -e "${MAGENTA}║                        v${CURRENT_VERSION}                           ║${NC}"
echo -e "${MAGENTA}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""

# Check if updating
if [ -f "$VERSION_FILE" ]; then
    OLD_VERSION=$(cat "$VERSION_FILE")
    echo -e "${YELLOW}📦 Current version: $OLD_VERSION${NC}"
    echo -e "${GREEN}📦 New version: $CURRENT_VERSION${NC}"
    echo ""
fi

# Language selection
LANG_FILE="$HOME/.gemini/antikit_language"
LANG="en" # Default
CLI_LANG=""

# 0. Parse CLI arguments (e.g., --lang vi)
while [ $# -gt 0 ]; do
    case "$1" in
        --lang)
            CLI_LANG="$2"
            shift 2
            ;;
        --lang=*)
            CLI_LANG="${1#*=}"
            shift
            ;;
        *)
            shift
            ;;
    esac
done

# 1. CLI argument has highest priority
if [ -n "$CLI_LANG" ]; then
    LANG="$CLI_LANG"
    echo -e "${GREEN}✅ Using language from --lang: $LANG${NC}"
# 2. Try to load from config if exists
elif [ -f "$LANG_FILE" ]; then
    LANG=$(cat "$LANG_FILE")
    echo -e "${GREEN}✅ Auto-detected language: $LANG${NC}"
else
    # 3. Prompt user (only works in interactive terminal, not piped)
    if [ -t 0 ]; then
        echo -e "${CYAN}🌐 Select language for workflows:${NC}"
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
        echo -e "${GREEN}✅ Selected language: $LANG${NC}"
    else
        echo -e "${YELLOW}⚠️  Non-interactive mode: defaulting to English${NC}"
        echo -e "${YELLOW}   To install in another language, use: --lang vi${NC}"
        echo -e "${YELLOW}   Example: curl -fsSL .../install.sh | bash -s -- --lang vi${NC}"
    fi
fi
echo ""

success=0
failed=0

# 1. Create directories
mkdir -p "$ANTIGRAVITY_DIR" "$GLOBAL_WORKFLOWS" "$AGENTS_DIR" "$SCHEMAS_DIR" "$TEMPLATES_DIR" "$SKILLS_DIR"
echo -e "${GREEN}📂 Directories ready: $ANTIGRAVITY_DIR${NC}"

# 1.5. Clean old files (remove renamed/obsolete agents)
OLD_AGENTS=("architect.md" "backend.md" "database.md" "devops.md" "doc-writer.md"
    "explorer.md" "frontend.md" "game.md" "mobile.md" "pentester.md"
    "performance.md" "security.md" "seo.md" "tester.md")
cleaned=0
for old in "${OLD_AGENTS[@]}"; do
    if [ -f "$AGENTS_DIR/$old" ]; then
        rm -f "$AGENTS_DIR/$old"
        ((cleaned++))
    fi
done
if [ $cleaned -gt 0 ]; then
    echo -e "${YELLOW}🧹 Cleaned $cleaned old agent files${NC}"
fi

# 2. Download Workflows
echo ""
echo -e "${CYAN}⏳ Downloading workflows ($LANG)...${NC}"
for wf in "${WORKFLOWS[@]}"; do
    out_name="${wf%.mdt}.md"
    if curl -f -s -o "$GLOBAL_WORKFLOWS/$out_name" "$REPO_BASE/workflows/$LANG/$wf"; then
        echo -e "   ${GREEN}✅ $out_name${NC}"
        ((success++))
    else
        echo -e "   ${RED}❌ $out_name${NC}"
        ((failed++))
    fi
done

# 3. Download Agents
echo ""
echo -e "${CYAN}⏳ Downloading agents...${NC}"
for agent in "${AGENTS[@]}"; do
    out_name="${agent%.mdt}.md"
    if curl -f -s -o "$AGENTS_DIR/$out_name" "$REPO_BASE/src/agents/$agent"; then
        echo -e "   ${GREEN}✅ $out_name${NC}"
        ((success++))
    else
        echo -e "   ${RED}❌ $out_name${NC}"
        ((failed++))
    fi
done

# 4. Download Schemas
echo ""
echo -e "${CYAN}⏳ Downloading schemas...${NC}"
for schema in "${SCHEMAS[@]}"; do
    if curl -f -s -o "$SCHEMAS_DIR/$schema" "$REPO_BASE/schemas/$schema"; then
        echo -e "   ${GREEN}✅ $schema${NC}"
        ((success++))
    else
        echo -e "   ${RED}❌ $schema${NC}"
        ((failed++))
    fi
done

# 5. Download Templates
echo ""
echo -e "${CYAN}⏳ Downloading templates...${NC}"
for template in "${TEMPLATES[@]}"; do
    if curl -f -s -o "$TEMPLATES_DIR/$template" "$REPO_BASE/templates/$template"; then
        echo -e "   ${GREEN}✅ $template${NC}"
        ((success++))
    else
        echo -e "   ${RED}❌ $template${NC}"
        ((failed++))
    fi
done

# 6. Download Skills
echo ""
echo -e "${CYAN}⏳ Downloading skills...${NC}"
for skill in "${SKILLS[@]}"; do
    mkdir -p "$SKILLS_DIR/$skill"
    if curl -f -s -o "$SKILLS_DIR/$skill/SKILL.md" "$REPO_BASE/src/skills/$skill/SKILL.mdt"; then
        echo -e "   ${GREEN}✅ $skill${NC}"
        ((success++))
    else
        echo -e "   ${RED}❌ $skill${NC}"
        ((failed++))
    fi
done

# 6.5 Download Scripts
SCRIPTS_DIR="$ANTIGRAVITY_DIR/scripts"
mkdir -p "$SCRIPTS_DIR"
echo ""
echo -e "${CYAN}⏳ Downloading scripts...${NC}"
for script in "${SCRIPTS[@]}"; do
    if curl -f -s -o "$SCRIPTS_DIR/$script" "$REPO_BASE/scripts/$script"; then
        chmod +x "$SCRIPTS_DIR/$script"
        echo -e "   ${GREEN}✅ $script${NC}"
        ((success++))
    else
        echo -e "   ${RED}❌ $script${NC}"
        ((failed++))
    fi
done

# 7. Save version and language
mkdir -p "$HOME/.gemini"
echo "$CURRENT_VERSION" > "$VERSION_FILE"
LANG_FILE="$HOME/.gemini/antikit_language"
echo "$LANG" > "$LANG_FILE"
echo ""
echo -e "${GREEN}✅ Version saved: $CURRENT_VERSION${NC}"
echo -e "${GREEN}✅ Language saved: $LANG${NC}"

# 8. Download GEMINI.md source files from rules/
echo ""
echo -e "${CYAN}⏳ Downloading GEMINI rules...${NC}"
RULES_DIR="$ANTIGRAVITY_DIR/rules"
mkdir -p "$RULES_DIR"

# Download language-specific instructions + core GEMINI.md
curl -f -s -o "$RULES_DIR/instructions.md" "$REPO_BASE/rules/instructions_${LANG}.md" && \
    echo -e "   ${GREEN}✅ instructions_${LANG}.md${NC}" || \
    echo -e "   ${RED}❌ instructions_${LANG}.md${NC}"

curl -f -s -o "$RULES_DIR/GEMINI.md" "$REPO_BASE/rules/GEMINI.md" && \
    echo -e "   ${GREEN}✅ GEMINI.md (core rules)${NC}" || \
    echo -e "   ${RED}❌ GEMINI.md (core rules)${NC}"

# Assemble ANTIKIT_INSTRUCTIONS from downloaded files
ANTIKIT_INSTRUCTIONS=""
if [ -f "$RULES_DIR/instructions.md" ]; then
    ANTIKIT_INSTRUCTIONS="$(cat "$RULES_DIR/instructions.md")"
fi
if [ -f "$RULES_DIR/GEMINI.md" ]; then
    ANTIKIT_INSTRUCTIONS="$ANTIKIT_INSTRUCTIONS

$(cat "$RULES_DIR/GEMINI.md")"
fi

# 8.5 Generate AGENT INDEX from downloaded agents
echo ""
echo -e "${CYAN}⏳ Generating Agent Index...${NC}"
AGENT_INDEX="| Agent | Tags | Skills |
|-------|------|--------|"

for agent_file in "$AGENTS_DIR"/*.md; do
    [ -f "$agent_file" ] || continue
    a_name="" a_tags="" a_skills=""
    in_fm=0
    while IFS= read -r line; do
        case "$line" in
            "---") [ $in_fm -eq 0 ] && in_fm=1 || break ;;
            *) if [ $in_fm -eq 1 ]; then
                key="${line%%:*}"; val="${line#*: }"
                case "$key" in name) a_name="$val";; tags) a_tags="$val";; skills) a_skills="$val";; esac
            fi ;;
        esac
    done < "$agent_file"
    [ -n "$a_name" ] && [ -n "$a_tags" ] && AGENT_INDEX="$AGENT_INDEX
| $a_name | $a_tags | $a_skills |"
done
echo -e "${GREEN}✅ Agent Index generated${NC}"

# 8.6 Generate SKILL INDEX from downloaded skills
echo -e "${CYAN}⏳ Generating Skill Index...${NC}"
SKILL_INDEX="| Skill | Description |
|-------|-------------|"

for skill_dir in "$SKILLS_DIR"/*/; do
    skill_file="$skill_dir/SKILL.md"
    [ -f "$skill_file" ] || continue
    s_name="" s_desc=""
    in_fm=0
    while IFS= read -r line; do
        case "$line" in
            "---") [ $in_fm -eq 0 ] && in_fm=1 || break ;;
            *) if [ $in_fm -eq 1 ]; then
                key="${line%%:*}"; val="${line#*: }"
                case "$key" in name) s_name="$val";; description) s_desc="$val";; esac
            fi ;;
        esac
    done < "$skill_file"
    # Truncate long descriptions
    [ ${#s_desc} -gt 100 ] && s_desc="${s_desc:0:100}..."
    [ -n "$s_name" ] && SKILL_INDEX="$SKILL_INDEX
| $s_name | $s_desc |"
done
echo -e "${GREEN}✅ Skill Index generated${NC}"

# 8.7 MULTI-AGENT PROTOCOL (language-agnostic, appended to all languages)
MULTI_AGENT_PROTOCOL='

## AGENT INDEX (Auto-Generated)

'"$AGENT_INDEX"'

## SKILL INDEX (Auto-Generated)

'"$SKILL_INDEX"'

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
| 🔍 **Devil'\''s Advocate** | Challenge PRIMARY'\''s decisions, find flaws | security-auditor reviews backend code |
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
```
✅ @[support-agent] check: [1-line assessment]
⚠️ @[support-agent] concern: [issue found] → [suggested fix]
```
'

# Append protocol to instructions
ANTIKIT_INSTRUCTIONS="$ANTIKIT_INSTRUCTIONS
$MULTI_AGENT_PROTOCOL"

if [ ! -f "$GEMINI_MD" ]; then
    echo "<!-- ANTIKIT_START -->" > "$GEMINI_MD"
    echo "$ANTIKIT_INSTRUCTIONS" >> "$GEMINI_MD"
    echo "<!-- ANTIKIT_END -->" >> "$GEMINI_MD"
    echo -e "${GREEN}✅ Created Global Rules (GEMINI.md)${NC}"
else
    # Robust update using Markers
    START_MARKER="<!-- ANTIKIT_START -->"
    END_MARKER="<!-- ANTIKIT_END -->"
    
    if grep -q "$START_MARKER" "$GEMINI_MD" && grep -q "$END_MARKER" "$GEMINI_MD"; then
        # Scenario A: Markers exist - Block Replace using awk to preserve content before/after
        # Create temp file
        TMP_FILE="${GEMINI_MD}.tmp"
        
        # AWK script to replace block
        awk -v start="$START_MARKER" -v end="$END_MARKER" -v new_content="$ANTIKIT_INSTRUCTIONS" '
        $0 ~ start {
            print start
            print new_content
            print end
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
        echo -e "${GREEN}✅ Updated Global Rules (GEMINI.md) - Block Replaced${NC}"
        
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
        echo "$START_MARKER" >> "$GEMINI_MD"
        echo "$ANTIKIT_INSTRUCTIONS" >> "$GEMINI_MD"
        echo "$END_MARKER" >> "$GEMINI_MD"
        echo -e "${GREEN}✅ Updated Global Rules (GEMINI.md) - Migrated/Appended${NC}"
    fi
fi

# Summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${YELLOW}🎉 COMPLETE! Installed $success files ($failed failed)${NC}"
echo -e "${CYAN}📦 Version: $CURRENT_VERSION${NC}"
echo ""
echo "📂 Workflows:  $GLOBAL_WORKFLOWS"
echo "📂 Agents:     $AGENTS_DIR"
echo "📂 Skills:     $SKILLS_DIR"
echo "📂 Schemas:    $SCHEMAS_DIR"
echo "📂 Templates:  $TEMPLATES_DIR"
echo ""
echo ""
echo -e "${YELLOW}⚠️  IMPORTANT: Please RESTART Antigravity to apply changes!${NC}"
echo ""
echo -e "${CYAN}👉 You can use AntiKit in ANY project immediately!${NC}"
echo "👉 Try typing '/recap' to test."
echo "👉 Check for updates: '/ak-update'"
echo ""
echo -e "${CYAN}🌐 Current language: $LANG${NC}"
echo -e "   To change language: ${MAGENTA}/config language [en|vi|ja|zh]${NC}"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
if [ ! -f "$LANG_FILE" ]; then
    read -p "Press Enter to exit..."
fi

exit 0
