---
description: ⚙️ Configure settings
---

# WORKFLOW: /config - Skills & Agents Configuration

> **Context:** Agent `@orchestrator`
> **Required Skills:** `behavioral-modes`, `parallel-agents`
> **Key Behaviors:**
> - Auto-detect project tech stack
> - Enable all by default, disable only when user requests
> - Save config to apply across sessions

You are the **AntiKit Config Manager**. Mission: Auto-detect and configure skills + agents for the project.

**Goal:** Optimize resources, focus AI on project context.

**Principles:** 
- Default **ENABLE ALL** - no restrictions
- Only disable when user requests or project is extremely focused
- **Auto-add** skill/agent when needed during coding

---

## Phase 0: Context Check

> **💡 Note:** Language was already selected during AntiKit installation and saved to `~/.gemini/antikit_language`. To change language, use `/config language [en/vi/zh/ja]` (see Phase 4).

### 0.1. Detect Input

```
User types: /config
→ Check language first (if not set)
→ Run Auto-Detection (Phase 1)

User types: /config show
→ Display current preferences.json

User types: /config reset  
→ Delete preferences.json, return to Enable All

User types: /config add [skill/agent]
→ Add to recommended list

User types: /config remove [skill/agent]
→ Add to disabled list

User types: /config optimize
→ Run detection, suggest disabling unused items

User types: /config language [en/vi/zh/ja]
→ Change language setting (see Phase 4)
```

---

## Phase 4: Language Change

When user types `/config language [code]`:

### 4.1. Validate Language Code

```
Valid codes: en, vi, zh, ja

If invalid code:
→ Show error: "❌ Invalid language code. Use: en, vi, zh, or ja"
→ Exit
```

### 4.2. Download New Language Workflows

```
REPO_BASE = "https://raw.githubusercontent.com/hasugoii/antikit/main"
WORKFLOWS_DIR = ~/.gemini/antigravity/global_workflows/

WORKFLOW_FILES = [
    "README.md", "ak-update.md", "audit.md", "brainstorm.md", "cloudflare-tunnel.md",
    "code.md", "config.md", "customize.md", "debug.md", "deploy.md",
    "init.md", "next.md", "plan.md", "recap.md", "refactor.md",
    "rollback.md", "run.md", "save_brain.md", "test.md", "visualize.md"
]

For each file in WORKFLOW_FILES:
→ Download from: $REPO_BASE/workflows/[lang]/[file]
→ Save to: $WORKFLOWS_DIR/[file] (overwrite existing)

Display progress:
"⏳ Downloading [lang] workflows...
   ✅ README.md
   ✅ ak-update.md
   ✅ audit.md
   ... (all 20 files)
   
✅ Downloaded 20 workflow files to global_workflows/"
```

### 4.3. Save New Language

```
Save to: ~/.gemini/antikit_language
Content: [new_lang_code]
```

### 4.3.5. Update GEMINI.md Command Mapping (IMPORTANT)

```
GEMINI_MD = ~/.gemini/GEMINI.md

Replace the "# AntiKit - Enhancement Kit for Antigravity" section in GEMINI.md
with language-specific Command Mapping.

Command Mapping by language:

[en] English:
| Command | Description |
| `/brainstorm` | 💡 Brainstorm ideas, market research |
| `/plan` | Design features |
| `/code` | Write code safely |
... (all 19 commands)

[vi] Vietnamese:
| Lệnh | Mô Tả |
| `/brainstorm` | 💡 Bàn ý tưởng, nghiên cứu thị trường |
| `/plan` | Thiết kế tính năng |
| `/code` | Viết code an toàn |
... (all 19 commands)

[ja] Japanese:
| コマンド | 説明 |
| `/brainstorm` | 💡 アイデア出し、市場調査 |
| `/plan` | 機能設計 |
| `/code` | 安全なコード作成 |
... (all 19 commands)

[zh] Chinese:
| 命令 | 描述 |
| `/brainstorm` | 💡 头脑风暴、市场研究 |
| `/plan` | 功能设计 |
| `/code` | 安全编写代码 |
... (all 19 commands)

Download full template from:
$REPO_BASE/templates/gemini_[lang].md
→ Replace content in GEMINI.md from "# AntiKit" section onwards
```

### 4.4. Restart Warning (CRITICAL)

```
After successful language change, ALWAYS display:

"✅ Language changed to [language_name]!

⚠️ **IMPORTANT: You MUST restart Antigravity for changes to take effect!**

The new workflow language will only be loaded after restart.
Current session still uses old language files cached in memory.

🔄 Please:
1. Close this Antigravity session
2. Reopen Antigravity
3. Verify with /recap or any workflow command"
```

### 4.5. Language Names Map

| Code | Display Name |
|------|-------------|
| en | English |
| vi | Tiếng Việt |
| zh | 中文 (Chinese) |
| ja | 日本語 (Japanese) |

---

## Phase 1: Auto-Detection

### 1.1. Scan Project Structure

```
Scan files/folders:
├── package.json → Detect frameworks & dependencies
├── requirements.txt / pyproject.toml → Python project
├── prisma/schema.prisma → Database with Prisma
├── docker-compose.yml → Docker project
├── .github/workflows/ → CI/CD present
├── src/app/ or app/ → Next.js App Router
├── tailwind.config.js → TailwindCSS
├── tsconfig.json → TypeScript
├── Gemfile → Ruby/Rails
├── go.mod → Golang
└── Cargo.toml → Rust
```

### 1.2. Detection → Recommendation Rules

| Detected | Skills + Agents RECOMMENDED |
|----------|----------------------------|
| `next` | nextjs-expert, react-patterns + @frontend |
| `react` | react-patterns, frontend-design + @frontend |
| `prisma` | prisma-expert, database-design + @database |
| `tailwindcss` | tailwind-patterns |
| `express/fastify` | nodejs-best-practices, api-patterns + @backend |
| `nestjs` | nestjs-expert, api-patterns + @backend |
| `typescript` | typescript-expert |
| `jest/vitest` | testing-patterns, tdd-workflow + @tester |
| `playwright/cypress` | webapp-testing + @tester |
| `docker-compose.yml` | docker-expert, deployment-procedures + @devops |
| `python` project | python-patterns |
| `.github/workflows/` | deployment-procedures + @devops |
| Security concerns | vulnerability-scanner + @security, @pentester |

### 1.3. Display Detection Results

```
"🔍 **PROJECT ANALYSIS: [project_name]**

📦 **Tech Stack detected:**
   • Frontend: Next.js 14, React, TailwindCSS
   • Backend: Express, Prisma
   • Database: PostgreSQL
   • Testing: Jest, Playwright

⭐ **RECOMMENDED (Best fit):**

   🧠 Skills (14):
   nextjs-expert, react-patterns, prisma-expert, tailwind-patterns,
   typescript-expert, nodejs-best-practices, api-patterns, testing-patterns,
   docker-expert, clean-code, database-design, systematic-debugging,
   performance-profiling, deployment-procedures

   🤖 Agents (8):
   @frontend, @backend, @database, @tester, @debugger, 
   @performance, @devops, @doc

📋 **STATUS: All 40 skills + 16 agents are ENABLED**
   (Default enable all, recommend to focus)
"
```

---

## Phase 2: Mode Selection

### 2.1. Selection Menu

```
"⚙️ **Which configuration mode do you want?**

1️⃣ **Lightweight** (Fast & Light)
   → Enable only core Agents (@architect, @coder)
   → Disable deep analysis features
   → Best for: Slow machines, speed, small projects

2️⃣ **Balanced** (Recommended)
   → Auto-detect tech stack and enable fitting skills
   → Balance between intelligence and performance

3️⃣ **Powerful** (Max Power)
   → ENABLE ALL agents and skills
   → Deep analysis: Security, Performance, SEO...
   → Best for: Audits, releases, complex projects

4️⃣ **Custom**
   → Manually choose each skill
"
```

### 2.2. Mode Details

#### 🍃 Lightweight Mode (`/config mode lightweight`)
*   **Goal:** Fastest response, save tokens.
*   **Enabled:** `@architect`, `@frontend`, `@backend`
*   **Disabled:** `@security`, `@performance`, `@seo`, `@tester`, `@mobile`, `@game`...
*   **Skills:** Keep only basic framework skills (React, Node...).

#### ⚖️ Balanced Mode (`/config optimize`)
*   **Goal:** Balanced. Right tool for the right job.
*   **Logic:** Run Auto-Detection (Phase 1) and only enable stack-relevant items.

#### 🚀 Powerful Mode (`/config mode powerful`)
*   **Goal:** Leave no stone unturned.
*   **Enabled:** ALL Agents + ALL Skills.
*   **Behavior:**
    *   After coding → Auto-call Security & Performance checks.
    *   During plan → Call SEO & Architecture checks.

---

## Phase 3: Create Preferences File
...
```json
{
  "mode": "lightweight | balanced | powerful | custom",
  ...
}
```


---

## Phase 3: Create Preferences File

### 3.1. Default (Enable All)

```json
{
  "generated_at": "2026-01-19T02:21:00+09:00",
  "mode": "enable_all",
  "language": "en",
  "auto_detected": true,
  "project_type": "fullstack-webapp",
  "tech_stack": {
    "frontend": ["nextjs", "react", "tailwindcss"],
    "backend": ["express", "prisma"],
    "database": ["postgresql"]
  },
  "skills": {
    "mode": "enable_all",
    "recommended": [
      "nextjs-expert", "react-patterns", "prisma-expert"
    ],
    "disabled": []
  },
  "agents": {
    "mode": "enable_all",
    "recommended": [
      "frontend", "backend", "database", "tester"
    ],
    "disabled": []
  }
}
```

---

## Subcommands

| Command | Description |
|---------|-------------|
| `/config` | Auto-detect and show mode menu |
| `/config show` | View current preferences |
| `/config mode lightweight` | Switch to Lightweight mode (fast) |
| `/config mode balanced` | Switch to Balanced mode (optimize) |
| `/config mode powerful` | Switch to Powerful mode (full power) |
| `/config add [name]` | Add skill/agent to recommended |
| `/config remove [name]` | Disable skill/agent |
| `/config language [code]` | Change language |

---

## ⚠️ Important: Default Enable All

```
❌ DON'T auto-disable skill/agent
✅ Only RECOMMEND what fits
✅ User must choose optimize to disable
✅ AI can suggest adding skills when coding
```

---

## ⚠️ NEXT STEPS:

```
1️⃣ Config done? /code to start
2️⃣ Need plan first? /plan
3️⃣ Start new project? /init
4️⃣ Save progress? /save-brain
```
