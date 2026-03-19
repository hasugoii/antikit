#!/bin/bash
# AntiKit Installer for macOS/Linux
# Manifest-based approach — single source of truth
# https://github.com/hasugoii/antikit

REPO_BASE="https://raw.githubusercontent.com/hasugoii/antikit/main"

# Paths
ANTIGRAVITY_DIR="$HOME/.gemini/antigravity"
GLOBAL_WORKFLOWS="$ANTIGRAVITY_DIR/global_workflows"
AGENTS_DIR="$ANTIGRAVITY_DIR/agents"
SCHEMAS_DIR="$ANTIGRAVITY_DIR/schemas"
TEMPLATES_DIR="$ANTIGRAVITY_DIR/templates"
SKILLS_DIR="$ANTIGRAVITY_DIR/skills"
SCRIPTS_DIR="$ANTIGRAVITY_DIR/scripts"
GEMINI_MD="$HOME/.gemini/GEMINI.md"
VERSION_FILE="$HOME/.gemini/antikit_version"
CUSTOM_FILE="$HOME/.gemini/antikit_custom.json"

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

# ── LANGUAGE SELECTION ──────────────────────────────────────
LANG_FILE_NEW="$HOME/.gemini/antikit_language"
LANG_FILE_OLD="$HOME/.gemini/antikit_lang"
LANG="en" # Default
CLI_LANG=""

# Parse CLI arguments
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

# Priority: CLI > antikit_language > antikit_lang > prompt > en
if [ -n "$CLI_LANG" ]; then
    LANG="$CLI_LANG"
    echo -e "${GREEN}✅ Using language from --lang: $LANG${NC}"
elif [ -f "$LANG_FILE_NEW" ]; then
    LANG=$(cat "$LANG_FILE_NEW")
    echo -e "${GREEN}✅ Auto-detected language: $LANG${NC}"
elif [ -f "$LANG_FILE_OLD" ]; then
    LANG=$(cat "$LANG_FILE_OLD")
    echo -e "${GREEN}✅ Auto-detected language: $LANG${NC}"
else
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

# ── FETCH MANIFEST ──────────────────────────────────────────
echo -e "${CYAN}⏳ Fetching manifest...${NC}"
MANIFEST_TMP="/tmp/antikit_manifest.json"
if curl -f -s -o "$MANIFEST_TMP" "$REPO_BASE/manifest.json"; then
    echo -e "${GREEN}✅ Manifest fetched (v$(python3 -c "import json;print(json.load(open('$MANIFEST_TMP'))['version'])" 2>/dev/null || echo '?'))${NC}"
else
    echo -e "${YELLOW}⚠️  Manifest not available. Using fallback hardcoded lists.${NC}"
    MANIFEST_TMP=""
fi

# ── PARSE MANIFEST ──────────────────────────────────────────
# Helper: parse JSON array to bash array (works without jq)
parse_json_array() {
    python3 -c "
import json, sys
data = json.load(open('$MANIFEST_TMP'))
items = data.get('$1', [])
for item in items:
    print(item)
" 2>/dev/null
}

if [ -n "$MANIFEST_TMP" ] && [ -f "$MANIFEST_TMP" ]; then
    # Read arrays from manifest using python3 (fully POSIX-compatible, no mapfile/process substitution)
    MANIFEST_EVAL="$(python3 -c "
import json
data = json.load(open('$MANIFEST_TMP'))
for key in ['workflows','agents','skills','scripts','schemas','templates']:
    items = data.get(key, [])
    bash_key = key.upper()
    # Strip dangerous characters from values
    safe = []
    for i in items:
        s = i.replace('\"','').replace(';','').replace('&','').replace('|','')
        safe.append('\"' + s + '\"')
    quoted = ' '.join(safe)
    print(f'{bash_key}=({quoted})')
" 2>/dev/null)"

    # Validate: only eval if output contains expected array assignment patterns
    if [ -n "$MANIFEST_EVAL" ] && echo "$MANIFEST_EVAL" | head -1 | grep -qE '^[A-Z]+=\('; then
        eval "$MANIFEST_EVAL"
    else
        echo -e "${YELLOW}⚠️  Manifest output suspicious. Using fallback lists.${NC}"
        MANIFEST_TMP=""
    fi

    # Verify manifest parsed correctly (safety check)
    if [ ${#WORKFLOWS[@]} -eq 0 ] || [ ${#AGENTS[@]} -eq 0 ]; then
        echo -e "${YELLOW}⚠️  Manifest parse failed. Using fallback lists.${NC}"
        MANIFEST_TMP=""
    fi
else
    # Fallback: hardcoded (keep for backward compat)
    WORKFLOWS=(
        "ak-update" "auto-ship" "audit" "brainstorm" "code" "config"
        "debug" "deploy" "grow" "init" "launch" "next"
        "plan" "recap" "refactor" "run" "save_brain" "test"
        "uninstall" "visualize"
    )
    AGENTS=(
        "backend-specialist" "chief-engineer" "code-archaeologist" "database-architect"
        "debugger" "devops-engineer" "documentation-writer"
        "explorer-agent" "frontend-specialist" "game-developer"
        "growth-hacker" "mobile-developer" "orchestrator"
        "penetration-tester" "performance-optimizer" "product-manager"
        "product-owner" "project-planner" "qa-automation-engineer"
        "security-auditor" "seo-specialist" "test-engineer"
    )
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
    SCRIPTS=("auto_preview.py" "checklist.py" "session_manager.py" "verify_all.py")
    SCHEMAS=("brain.schema.json" "preferences.schema.json" "session.schema.json")
    TEMPLATES=("brain.example.json" "preferences.example.json" "session.example.json" "lessons.example.md")
fi

success=0
failed=0

# ── CREATE DIRECTORIES ──────────────────────────────────────
mkdir -p "$ANTIGRAVITY_DIR" "$GLOBAL_WORKFLOWS" "$AGENTS_DIR" "$SCHEMAS_DIR" "$TEMPLATES_DIR" "$SKILLS_DIR" "$SCRIPTS_DIR"
echo -e "${GREEN}📂 Directories ready: $ANTIGRAVITY_DIR${NC}"

# ── DOWNLOAD FILES ──────────────────────────────────────────

# Workflows
echo ""
echo -e "${CYAN}⏳ Downloading workflows ($LANG)...${NC}"
for wf in "${WORKFLOWS[@]}"; do
    if curl -f -s -o "$GLOBAL_WORKFLOWS/${wf}.md.tmp" "$REPO_BASE/workflows/$LANG/${wf}.mdt"; then
        mv -f "$GLOBAL_WORKFLOWS/${wf}.md.tmp" "$GLOBAL_WORKFLOWS/${wf}.md"
        echo -e "   ${GREEN}✅ ${wf}.md${NC}"
        ((success++))
    else
        rm -f "$GLOBAL_WORKFLOWS/${wf}.md.tmp"
        echo -e "   ${RED}❌ ${wf}.md${NC}"
        ((failed++))
    fi
done

# Agents
echo ""
echo -e "${CYAN}⏳ Downloading agents...${NC}"
for agent in "${AGENTS[@]}"; do
    if curl -f -s -o "$AGENTS_DIR/${agent}.md.tmp" "$REPO_BASE/src/agents/${agent}.mdt"; then
        mv -f "$AGENTS_DIR/${agent}.md.tmp" "$AGENTS_DIR/${agent}.md"
        echo -e "   ${GREEN}✅ ${agent}.md${NC}"
        ((success++))
    else
        rm -f "$AGENTS_DIR/${agent}.md.tmp"
        echo -e "   ${RED}❌ ${agent}.md${NC}"
        ((failed++))
    fi
done

# Schemas
echo ""
echo -e "${CYAN}⏳ Downloading schemas...${NC}"
for schema in "${SCHEMAS[@]}"; do
    if curl -f -s -o "$SCHEMAS_DIR/$schema.tmp" "$REPO_BASE/schemas/$schema"; then
        mv -f "$SCHEMAS_DIR/$schema.tmp" "$SCHEMAS_DIR/$schema"
        echo -e "   ${GREEN}✅ $schema${NC}"
        ((success++))
    else
        rm -f "$SCHEMAS_DIR/$schema.tmp"
        echo -e "   ${RED}❌ $schema${NC}"
        ((failed++))
    fi
done

# Templates
echo ""
echo -e "${CYAN}⏳ Downloading templates...${NC}"
for template in "${TEMPLATES[@]}"; do
    if curl -f -s -o "$TEMPLATES_DIR/$template.tmp" "$REPO_BASE/templates/$template"; then
        mv -f "$TEMPLATES_DIR/$template.tmp" "$TEMPLATES_DIR/$template"
        echo -e "   ${GREEN}✅ $template${NC}"
        ((success++))
    else
        rm -f "$TEMPLATES_DIR/$template.tmp"
        echo -e "   ${RED}❌ $template${NC}"
        ((failed++))
    fi
done

# Skills
echo ""
echo -e "${CYAN}⏳ Downloading skills...${NC}"
for skill in "${SKILLS[@]}"; do
    mkdir -p "$SKILLS_DIR/$skill"
    if curl -f -s -o "$SKILLS_DIR/$skill/SKILL.md.tmp" "$REPO_BASE/src/skills/$skill/SKILL.mdt"; then
        mv -f "$SKILLS_DIR/$skill/SKILL.md.tmp" "$SKILLS_DIR/$skill/SKILL.md"
        echo -e "   ${GREEN}✅ $skill${NC}"
        ((success++))
    else
        rm -f "$SKILLS_DIR/$skill/SKILL.md.tmp"
        echo -e "   ${RED}❌ $skill${NC}"
        ((failed++))
    fi
done

# Scripts
echo ""
echo -e "${CYAN}⏳ Downloading scripts...${NC}"
for script in "${SCRIPTS[@]}"; do
    if curl -f -s -o "$SCRIPTS_DIR/$script.tmp" "$REPO_BASE/scripts/$script"; then
        mv -f "$SCRIPTS_DIR/$script.tmp" "$SCRIPTS_DIR/$script"
        chmod +x "$SCRIPTS_DIR/$script"
        echo -e "   ${GREEN}✅ $script${NC}"
        ((success++))
    else
        # Retry once after 2s (CDN cache may cause transient 404)
        sleep 2
        if curl -f -s -o "$SCRIPTS_DIR/$script.tmp" "$REPO_BASE/scripts/$script"; then
            mv -f "$SCRIPTS_DIR/$script.tmp" "$SCRIPTS_DIR/$script"
            chmod +x "$SCRIPTS_DIR/$script"
            echo -e "   ${GREEN}✅ $script (retry)${NC}"
            ((success++))
        else
            rm -f "$SCRIPTS_DIR/$script.tmp"
            echo -e "   ${YELLOW}⚠️  $script (optional — will retry next update)${NC}"
            ((failed++))
        fi
    fi
done

# ── ORPHAN CLEANUP (ONLY if all downloads succeeded) ───────
if [ $failed -gt 0 ]; then
    echo ""
    echo -e "${YELLOW}⚠️  Skipping orphan cleanup ($failed download(s) failed — files may be valid)${NC}"
else
    echo ""
    echo -e "${CYAN}🧹 Scanning for orphan files...${NC}"
    orphan_count=0

    # Load custom files list (user-created workflows/agents/skills)
    custom_workflows=()
    custom_agents=()
    custom_skills=()
    if [ -f "$CUSTOM_FILE" ]; then
        while IFS= read -r line; do custom_workflows+=("$line"); done < <(python3 -c "
import json
data = json.load(open('$CUSTOM_FILE'))
for w in data.get('custom_workflows', []): print(w)
" 2>/dev/null)
        while IFS= read -r line; do custom_agents+=("$line"); done < <(python3 -c "
import json
data = json.load(open('$CUSTOM_FILE'))
for a in data.get('custom_agents', []): print(a)
" 2>/dev/null)
        while IFS= read -r line; do custom_skills+=("$line"); done < <(python3 -c "
import json
data = json.load(open('$CUSTOM_FILE'))
for s in data.get('custom_skills', []): print(s)
" 2>/dev/null)
    fi

    # Helper: check if value is in array
    in_array() {
        local needle="$1"; shift
        for item in "$@"; do
            [ "$item" = "$needle" ] && return 0
        done
        return 1
    }

    # Scan workflows for orphans
    for file in "$GLOBAL_WORKFLOWS"/*.md; do
        [ -f "$file" ] || continue
        name=$(basename "$file" .md)
        if ! in_array "$name" "${WORKFLOWS[@]}" && ! in_array "$name" "${custom_workflows[@]}"; then
            echo -e "   ${YELLOW}🗑️  Removing orphan workflow: ${name}.md${NC}"
            rm -f "$file"
            ((orphan_count++))
        fi
    done

    # Scan agents for orphans
    for file in "$AGENTS_DIR"/*.md; do
        [ -f "$file" ] || continue
        name=$(basename "$file" .md)
        if ! in_array "$name" "${AGENTS[@]}" && ! in_array "$name" "${custom_agents[@]}"; then
            echo -e "   ${YELLOW}🗑️  Removing orphan agent: ${name}.md${NC}"
            rm -f "$file"
            ((orphan_count++))
        fi
    done

    # Scan skills for orphans
    for dir in "$SKILLS_DIR"/*/; do
        [ -d "$dir" ] || continue
        name=$(basename "$dir")
        if ! in_array "$name" "${SKILLS[@]}" && ! in_array "$name" "${custom_skills[@]}"; then
            echo -e "   ${YELLOW}🗑️  Removing orphan skill: $name/${NC}"
            rm -rf "$dir"
            ((orphan_count++))
        fi
    done

    if [ $orphan_count -eq 0 ]; then
        echo -e "   ${GREEN}✅ No orphan files found${NC}"
    else
        echo -e "   ${GREEN}✅ Cleaned $orphan_count orphan file(s)${NC}"
    fi
fi

# ── SAVE VERSION + LANGUAGE ─────────────────────────────────
mkdir -p "$HOME/.gemini"
echo "$CURRENT_VERSION" > "$VERSION_FILE"
# Write to BOTH files for backward compat
echo "$LANG" > "$LANG_FILE_NEW"
echo "$LANG" > "$LANG_FILE_OLD"
echo ""
echo -e "${GREEN}✅ Version saved: $CURRENT_VERSION${NC}"
echo -e "${GREEN}✅ Language saved: $LANG${NC}"

# ── SYNC GLOBAL LESSONS (Continuous Learning) ──────────────
echo ""
echo -e "${CYAN}🧠 Syncing Global Lessons (Auto-Learn Protocol)...${NC}"
GLOBAL_LESSONS_FILE="$ANTIGRAVITY_DIR/global_lessons.md"
GLOBAL_LESSONS_UPSTREAM="$ANTIGRAVITY_DIR/global_lessons_upstream.md"

if curl -f -s -o "$GLOBAL_LESSONS_UPSTREAM" "$REPO_BASE/global_lessons.md"; then
    if [ ! -f "$GLOBAL_LESSONS_FILE" ]; then
        # New user: copy directly
        mv -f "$GLOBAL_LESSONS_UPSTREAM" "$GLOBAL_LESSONS_FILE"
        echo -e "   ${GREEN}✅ Global Lessons installed (new)${NC}"
    else
        # Existing user: smart merge — keep user's Recent, update everything else
        if python3 -c "
import sys
upstream = open('$GLOBAL_LESSONS_UPSTREAM', 'r').read()
local = open('$GLOBAL_LESSONS_FILE', 'r').read()
marker = '## Recent'
local_idx = local.find(marker)
user_recent = local[local_idx:] if local_idx >= 0 else ''
upstream_idx = upstream.find(marker)
if upstream_idx >= 0 and user_recent:
    merged = upstream[:upstream_idx] + user_recent
else:
    merged = upstream
open('$GLOBAL_LESSONS_FILE', 'w').write(merged)
" 2>/dev/null; then
            rm -f "$GLOBAL_LESSONS_UPSTREAM"
            echo -e "   ${GREEN}✅ Global Lessons merged (kept personal Recent)${NC}"
        else
            # Fallback: just copy upstream if python3 not available
            mv -f "$GLOBAL_LESSONS_UPSTREAM" "$GLOBAL_LESSONS_FILE"
            echo -e "   ${GREEN}✅ Global Lessons updated (fallback)${NC}"
        fi
    fi
    ((success++))
else
    rm -f "$GLOBAL_LESSONS_UPSTREAM"
    echo -e "   ${YELLOW}⚠️  Global Lessons (optional — will retry next update)${NC}"
fi

# ── SAVE MANIFEST LOCALLY ──────────────────────────────────
if [ -n "$MANIFEST_TMP" ] && [ -f "$MANIFEST_TMP" ]; then
    cp "$MANIFEST_TMP" "$ANTIGRAVITY_DIR/manifest.json"
    rm -f "$MANIFEST_TMP"
fi

# ── DOWNLOAD GEMINI RULES ──────────────────────────────────
echo ""
echo -e "${CYAN}⏳ Downloading GEMINI rules...${NC}"
RULES_DIR="$ANTIGRAVITY_DIR/rules"
mkdir -p "$RULES_DIR"

curl -f -s -o "$RULES_DIR/instructions.md" "$REPO_BASE/rules/instructions_${LANG}.md" && \
    echo -e "   ${GREEN}✅ instructions_${LANG}.md${NC}" || \
    echo -e "   ${RED}❌ instructions_${LANG}.md${NC}"

curl -f -s -o "$RULES_DIR/GEMINI.md" "$REPO_BASE/rules/GEMINI.md" && \
    echo -e "   ${GREEN}✅ GEMINI.md (core rules)${NC}" || \
    echo -e "   ${RED}❌ GEMINI.md (core rules)${NC}"

# Assemble ANTIKIT_INSTRUCTIONS from downloaded files (strip YAML frontmatter)
strip_frontmatter() {
    local file="$1"
    if head -1 "$file" | grep -q "^---$"; then
        sed -n '/^---$/,/^---$/d; p' "$file"
    else
        cat "$file"
    fi
}

ANTIKIT_INSTRUCTIONS=""
if [ -f "$RULES_DIR/instructions.md" ]; then
    ANTIKIT_INSTRUCTIONS="$(strip_frontmatter "$RULES_DIR/instructions.md")"
fi
if [ -f "$RULES_DIR/GEMINI.md" ]; then
    ANTIKIT_INSTRUCTIONS="$ANTIKIT_INSTRUCTIONS

$(strip_frontmatter "$RULES_DIR/GEMINI.md")"
fi

# ── GENERATE AGENT INDEX ────────────────────────────────────
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

# ── GENERATE SKILL INDEX ────────────────────────────────────
echo -e "${CYAN}⏳ Generating Skill Index...${NC}"
SKILL_INDEX="| Skill | Description |
|-------|-------------|"

for skill_dir in "$SKILLS_DIR"/*/; do
    skill_file="$skill_dir/SKILL.md"
    [ -f "$skill_file" ] || continue
    s_name="" s_desc=""
    in_fm=0
    has_fm=0
    while IFS= read -r line; do
        case "$line" in
            "---") [ $in_fm -eq 0 ] && { in_fm=1; has_fm=1; } || break ;;
            *) if [ $in_fm -eq 1 ]; then
                key="${line%%:*}"; val="${line#*: }"
                case "$key" in name) s_name="$val";; description) s_desc="$val";; esac
            fi ;;
        esac
    done < "$skill_file"
    if [ -z "$s_name" ]; then
        s_name=$(basename "$skill_dir")
        s_desc=$(grep -m1 '^>' "$skill_file" 2>/dev/null | sed 's/^> *//' || echo "")
    fi
    [ ${#s_desc} -gt 100 ] && s_desc="${s_desc:0:100}..."
    [ -n "$s_name" ] && SKILL_INDEX="$SKILL_INDEX
| $s_name | $s_desc |"
done
echo -e "${GREEN}✅ Skill Index generated${NC}"

# ── MULTI-AGENT PROTOCOL ───────────────────────────────────
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

# ── UPDATE GEMINI.MD ────────────────────────────────────────
INSTR_TMP="${GEMINI_MD}.instr.tmp"
printf '%s\n' "$ANTIKIT_INSTRUCTIONS" > "$INSTR_TMP"

START_MARKER="<!-- ANTIKIT_START -->"
END_MARKER="<!-- ANTIKIT_END -->"

# Auto-backup
BACKUP_CREATED=""
if [ -f "$GEMINI_MD" ]; then
    BACKUP_FILE="${GEMINI_MD}.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$GEMINI_MD" "$BACKUP_FILE"
    BACKUP_CREATED="$BACKUP_FILE"
    echo -e "${GREEN}💾 Backup: $(basename "$BACKUP_FILE")${NC}"

    # Keep only 3 most recent backups
    ls -t "${GEMINI_MD}.backup."* 2>/dev/null | tail -n +4 | while read -r old_backup; do
        rm -f "$old_backup"
    done
fi

if [ ! -f "$GEMINI_MD" ]; then
    echo "$START_MARKER" > "$GEMINI_MD"
    cat "$INSTR_TMP" >> "$GEMINI_MD"
    echo "$END_MARKER" >> "$GEMINI_MD"
    echo -e "${GREEN}✅ Created Global Rules (GEMINI.md)${NC}"
else
    if grep -q "$START_MARKER" "$GEMINI_MD" && grep -q "$END_MARKER" "$GEMINI_MD"; then
        TMP_FILE="${GEMINI_MD}.tmp"
        {
            sed -n "1,/^${START_MARKER}/{ /^${START_MARKER}/!p; }" "$GEMINI_MD"
            echo "$START_MARKER"
            cat "$INSTR_TMP"
            echo "$END_MARKER"
            sed -n "/^${END_MARKER}/,\${ /^${END_MARKER}/!p; }" "$GEMINI_MD"
        } > "$TMP_FILE"
        mv "$TMP_FILE" "$GEMINI_MD"
        echo -e "${GREEN}✅ Updated Global Rules (GEMINI.md) - Block Replaced${NC}"
    else
        if grep -q "AntiKit - Enhancement Kit for Antigravity" "$GEMINI_MD" 2>/dev/null; then
            sed -i.bak '/# AntiKit - Enhancement Kit for Antigravity/,$d' "$GEMINI_MD"
            rm -f "$GEMINI_MD.bak"
        elif grep -q "AWF - Antigravity Workflow Framework" "$GEMINI_MD" 2>/dev/null; then
            sed -i.bak '/# AWF - Antigravity Workflow Framework/,$d' "$GEMINI_MD"
            rm -f "$GEMINI_MD.bak"
        fi
        echo "" >> "$GEMINI_MD"
        echo "$START_MARKER" >> "$GEMINI_MD"
        cat "$INSTR_TMP" >> "$GEMINI_MD"
        echo "$END_MARKER" >> "$GEMINI_MD"
        echo -e "${GREEN}✅ Updated Global Rules (GEMINI.md) - Migrated/Appended${NC}"
    fi
fi

# ── DETECT CUSTOM CONTENT ──────────────────────────────────
CUSTOM_BEFORE=0
CUSTOM_AFTER=0
ANTIKIT_LINES=0

if [ -f "$GEMINI_MD" ] && grep -q "$START_MARKER" "$GEMINI_MD" && grep -q "$END_MARKER" "$GEMINI_MD"; then
    CUSTOM_BEFORE=$(sed -n "1,/^${START_MARKER}/{ /^${START_MARKER}/d; /^$/d; p; }" "$GEMINI_MD" | wc -l | tr -d ' ')
    CUSTOM_AFTER=$(sed -n "/^${END_MARKER}/,\${ /^${END_MARKER}/d; /^$/d; p; }" "$GEMINI_MD" | wc -l | tr -d ' ')
    ANTIKIT_LINES=$(sed -n "/^${START_MARKER}/,/^${END_MARKER}/p" "$GEMINI_MD" | wc -l | tr -d ' ')
fi

echo ""
echo -e "${CYAN}📋 GEMINI.md UPDATE REPORT:${NC}"
if [ -n "$BACKUP_CREATED" ]; then
    echo -e "   💾 Backup: ${GREEN}$(basename "$BACKUP_CREATED")${NC}"
fi
echo -e "   🔄 AntiKit rules: ${GREEN}Updated ($ANTIKIT_LINES lines)${NC}"
if [ "$CUSTOM_BEFORE" -gt 0 ] 2>/dev/null; then
    echo -e "   📝 Custom rules (before markers): ${GREEN}$CUSTOM_BEFORE lines ✅ preserved${NC}"
fi
if [ "$CUSTOM_AFTER" -gt 0 ] 2>/dev/null; then
    echo -e "   📝 Custom rules (after markers): ${GREEN}$CUSTOM_AFTER lines ✅ preserved${NC}"
fi
if [ "$CUSTOM_BEFORE" -eq 0 ] 2>/dev/null && [ "$CUSTOM_AFTER" -eq 0 ] 2>/dev/null; then
    echo -e "   📝 Custom rules: ${YELLOW}None detected${NC}"
    echo -e "   ${YELLOW}💡 Tip: Add your custom rules OUTSIDE the markers to preserve them during updates${NC}"
fi

# Clean up temp file
rm -f "$INSTR_TMP"

# ── SUMMARY ─────────────────────────────────────────────────
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${YELLOW}🎉 COMPLETE! Installed $success files ($failed failed)${NC}"
if [ $orphan_count -gt 0 ]; then
    echo -e "${YELLOW}🧹 Cleaned $orphan_count orphan file(s)${NC}"
fi
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

exit 0
