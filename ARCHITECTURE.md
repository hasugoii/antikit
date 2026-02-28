# Antigravity Kit Architecture

> Comprehensive AI Agent Capability Expansion Toolkit

---

## 📋 Overview

Antigravity Kit is a modular system consisting of:

- **22 Specialist Agents** - Role-based AI personas
- **83 Skills** - Domain-specific knowledge modules
- **20 Workflows** - Slash command procedures (×4 languages)

---

## 🏗️ Directory Structure

```plaintext
.agent/
├── ARCHITECTURE.md          # This file
├── src/
│   ├── agents/              # 22 Specialist Agents
│   └── skills/              # 83 Skills
├── workflows/               # 20 Slash Commands (×4 languages)
├── rules/                   # Global Rules
└── scripts/                 # Master Validation Scripts
```

---

## 🤖 Agents (22)

Specialist AI personas for different domains.

| Agent                    | Focus                      | Skills Used                                              |
| ------------------------ | -------------------------- | -------------------------------------------------------- |
| `chief-engineer`         | Autonomous self-development| evidence-discipline, clean-code, architecture            |
| `orchestrator`           | Multi-agent coordination   | parallel-agents, behavioral-modes                        |
| `project-planner`        | Discovery, task planning   | brainstorming, plan-writing, architecture                |
| `frontend-specialist`    | Web UI/UX                  | frontend-design, react-best-practices, tailwind-patterns |
| `backend-specialist`     | API, business logic        | api-patterns, nodejs-best-practices, database-design     |
| `database-architect`     | Schema, SQL                | database-design, prisma-expert                           |
| `mobile-developer`       | iOS, Android, RN           | mobile-design, ui-ux-pro-max                             |
| `game-developer`         | Game logic, mechanics      | game-development, ui-ux-pro-max                          |
| `growth-hacker`          | Marketing, launch, growth  | growth-marketing, ui-ux-pro-max                          |
| `devops-engineer`        | CI/CD, Docker              | deployment-procedures, docker-expert                     |
| `security-auditor`       | Security compliance        | vulnerability-scanner, red-team-tactics                  |
| `penetration-tester`     | Offensive security         | red-team-tactics                                         |
| `test-engineer`          | Testing strategies         | testing-patterns, tdd-workflow, webapp-testing           |
| `debugger`               | Root cause analysis        | systematic-debugging, evidence-discipline                |
| `performance-optimizer`  | Speed, Web Vitals          | performance-profiling                                    |
| `seo-specialist`         | Ranking, visibility        | seo-fundamentals, geo-fundamentals                       |
| `documentation-writer`   | Manuals, docs              | documentation-templates                                  |
| `product-manager`        | Requirements, user stories | plan-writing, brainstorming                              |
| `product-owner`          | Strategy, backlog, MVP     | plan-writing, brainstorming                              |
| `qa-automation-engineer` | E2E testing, CI pipelines  | webapp-testing, testing-patterns                         |
| `code-archaeologist`     | Legacy code, refactoring   | clean-code, code-review-checklist, evidence-discipline   |
| `explorer-agent`         | Codebase analysis          | architecture, systematic-debugging, evidence-discipline  |

---

## 🧩 Skills (83)

Modular knowledge domains that agents can load on-demand. based on task context.

### Frontend & UI

| Skill                   | Description                                                           |
| ----------------------- | --------------------------------------------------------------------- |
| `react-best-practices`  | React & Next.js performance optimization (Vercel - 57 rules)          |
| `web-design-guidelines` | Web UI audit - 100+ rules for accessibility, UX, performance (Vercel) |
| `tailwind-patterns`     | Tailwind CSS v4 utilities                                             |
| `frontend-design`       | UI/UX patterns, design systems                                        |
| `ui-ux-pro-max`         | 50 styles, 21 palettes, 50 fonts                                      |

### Backend & API

| Skill                   | Description                    |
| ----------------------- | ------------------------------ |
| `api-patterns`          | REST, GraphQL, tRPC            |
| `nestjs-expert`         | NestJS modules, DI, decorators |
| `nodejs-best-practices` | Node.js async, modules         |
| `python-patterns`       | Python standards, FastAPI      |

### Database

| Skill             | Description                 |
| ----------------- | --------------------------- |
| `database-design` | Schema design, optimization |
| `prisma-expert`   | Prisma ORM, migrations      |

### TypeScript/JavaScript

| Skill               | Description                         |
| ------------------- | ----------------------------------- |
| `typescript-expert` | Type-level programming, performance |

### Cloud & Infrastructure

| Skill                   | Description               |
| ----------------------- | ------------------------- |
| `docker-expert`         | Containerization, Compose |
| `deployment-procedures` | CI/CD, deploy workflows   |
| `server-management`     | Infrastructure management |

### Testing & Quality

| Skill                   | Description              |
| ----------------------- | ------------------------ |
| `testing-patterns`      | Jest, Vitest, strategies |
| `webapp-testing`        | E2E, Playwright          |
| `tdd-workflow`          | Test-driven development  |
| `code-review-checklist` | Code review standards    |
| `lint-and-validate`     | Linting, validation      |

### Security

| Skill                   | Description              |
| ----------------------- | ------------------------ |
| `vulnerability-scanner` | Security auditing, OWASP |
| `red-team-tactics`      | Offensive security       |

### Architecture & Planning

| Skill           | Description                |
| --------------- | -------------------------- |
| `app-builder`   | Full-stack app scaffolding |
| `architecture`  | System design patterns     |
| `plan-writing`  | Task planning, breakdown   |
| `brainstorming` | Socratic questioning       |

### Mobile

| Skill           | Description           |
| --------------- | --------------------- |
| `mobile-design` | Mobile UI/UX patterns |

### Game Development

| Skill              | Description           |
| ------------------ | --------------------- |
| `game-development` | Game logic, mechanics |

### SEO & Growth

| Skill              | Description                   |
| ------------------ | ----------------------------- |
| `seo-fundamentals` | SEO, E-E-A-T, Core Web Vitals |
| `geo-fundamentals` | GenAI optimization            |

### Shell/CLI

| Skill                | Description               |
| -------------------- | ------------------------- |
| `bash-linux`         | Linux commands, scripting |
| `powershell-windows` | Windows PowerShell        |

### Other

| Skill                     | Description               |
| ------------------------- | ------------------------- |
| `clean-code`              | Coding standards (Global) |
| `behavioral-modes`        | Agent personas            |
| `parallel-agents`         | Multi-agent patterns      |
| `mcp-builder`             | Model Context Protocol    |
| `documentation-templates` | Doc formats               |
| `evidence-discipline`     | Evidence gates, context integrity |
| `i18n-localization`       | Internationalization      |
| `performance-profiling`   | Web Vitals, optimization  |
| `systematic-debugging`    | Troubleshooting           |

### Skill Tiers & Connection Map

Skills are organized into 4 tiers forming a **mesh network** — each skill declares its `connections` in YAML frontmatter.

| Tier | Role | Skills |
|------|------|--------|
| **T1 Orchestrators** | Coordinate multiple skills | `app-builder`, `parallel-agents`, `intelligent-routing` |
| **T2 Hubs** | Cross-domain coordination | `brainstorming`, `plan-writing`, `evidence-discipline`, `frontend-design`, `mobile-design`, `growth-marketing` |
| **T3 Utilities** | Domain-specific tools | `api-patterns`, `database-design`, `testing-patterns`, `clean-code`, `react-best-practices`, `nodejs-best-practices`, `tailwind-patterns`, `seo-fundamentals`, `vulnerability-scanner`, `deployment-procedures`, `performance-profiling` |
| **T4 Standalone** | Independent skills | All other skills (game-development, rust-pro, docker-patterns, etc.) |

**Connection flow:**
```
T1 Orchestrators → call → T2 Hubs → call → T3 Utilities
                                    ↕ cross-call ↕
```

---

## 🔄 Workflows (20)

Slash command procedures. Invoke with `/command`. All available in 4 languages (EN, VI, JA, ZH).

### Core Development

| Command | Description | Power Mode Flags |
| ------- | ----------- | ---------------- |
| `/init` | Create new project | `--mobile` `--game` `--api` `--mcp` `--docker` |
| `/code` | Write code from spec | `--mobile` `--api` `--nestjs` `--nextjs` `--db` `--rust` `--python` `--ts` |
| `/plan` | Task breakdown | - |
| `/visualize` | UI/UX design | `--mobile` `--game` `--audit` |
| `/auto-evolve` | Autonomous self-development | `--dry-run` `--budget N` `--focus X` |
| `/brainstorm` | Socratic discovery | - |

### Quality & Testing

| Command | Description | Power Mode Flags |
| ------- | ----------- | ---------------- |
| `/test` | Run tests | `--e2e` `--tdd` `--perf` |
| `/audit` | Code & security audit | `--seo` `--perf` `--pentest` `--docs` `--i18n` `--deps` `--full` |
| `/debug` | Debug issues | - |
| `/refactor` | Clean up & optimize | `--perf` `--types` `--arch` `--review` |

### Deployment & Ops

| Command | Description | Power Mode Flags |
| ------- | ----------- | ---------------- |
| `/deploy` | Deploy to production | `--docker` `--server` `--seo` |
| `/run` | Run application | - |

### Growth & Marketing

| Command | Description | Power Mode Flags |
| ------- | ----------- | ---------------- |
| `/launch` | Go-to-market | `--landing` `--content` `--pricing` `--ads` |
| `/grow` | Product flywheel | - |

### Knowledge & Config

| Command | Description |
| ------- | ----------- |
| `/save_brain` | Save project knowledge |
| `/recap` | Summarize project |
| `/config` | Configure settings |
| `/next` | What to do next |

### AntiKit Management

| Command | Description |
| ------- | ----------- |
| `/ak-update` | Update AntiKit |
| `/uninstall` | Uninstall AntiKit |

---

## 🎯 Skill Loading Protocol

```plaintext
User Request → Skill Description Match → Load SKILL.md
                                            ↓
                                    Read references/
                                            ↓
                                    Read scripts/
```

### Skill Structure

```plaintext
skill-name/
├── SKILL.md           # (Required) Metadata & instructions
├── scripts/           # (Optional) Python/Bash scripts
├── references/        # (Optional) Templates, docs
└── assets/            # (Optional) Images, logos
```

### Enhanced Skills (with scripts/references)

| Skill               | Files | Coverage                            |
| ------------------- | ----- | ----------------------------------- |
| `ui-ux-pro-max`     | 27    | 50 styles, 21 palettes, 50 fonts    |
| `app-builder`       | 20    | Full-stack scaffolding              |

---

## 🛠 Scripts (4)

Master validation scripts that orchestrate skill-level scripts.

### Master Scripts

| Script               | Purpose                                 | When to Use              |
| -------------------- | --------------------------------------- | ------------------------ |
| `checklist.py`       | Priority-based validation (Core checks) | Development, pre-commit  |
| `verify_all.py`      | Comprehensive verification (All checks) | Pre-deployment, releases |
| `auto_preview.py`    | Auto-preview server management          | During development       |
| `session_manager.py` | Session state tracking                  | Session start/end        |

### Usage

```bash
# Quick validation during development
python .agent/scripts/checklist.py .

# Full verification before deployment
python .agent/scripts/verify_all.py . --url http://localhost:3000
```

### What They Check

**checklist.py** (Core checks):

- Security (vulnerabilities, secrets)
- Code Quality (lint, types)
- Schema Validation
- Test Suite
- UX Audit
- SEO Check

**verify_all.py** (Full suite):

- Everything in checklist.py PLUS:
- Lighthouse (Core Web Vitals)
- Playwright E2E
- Bundle Analysis
- Mobile Audit
- i18n Check

For details, see [scripts/README.md](scripts/README.md)

---

## 📊 Statistics

| Metric              | Value                           |
| ------------------- | ------------------------------- |
| **Total Agents**    | 22                              |
| **Total Skills**    | 83                              |
| **Total Workflows** | 20 (×4 languages = 80 files)    |
| **Total Scripts**   | 4 (master)                      |
| **Schemas**         | 3                               |
| **Templates**       | 4                               |
| **Power Mode Flags**| 28+ across 8 workflows          |
| **Coverage**        | ~95% web/mobile development     |

---

## 🔗 Quick Reference

| Need     | Agent                 | Skills                                |
| -------- | --------------------- | ------------------------------------- |
| Web App  | `frontend-specialist` | react-best-practices, frontend-design |
| API      | `backend-specialist`  | api-patterns, nodejs-best-practices   |
| Mobile   | `mobile-developer`    | mobile-design                         |
| Database | `database-architect`  | database-design, prisma-expert        |
| Security | `security-auditor`    | vulnerability-scanner                 |
| Testing  | `test-engineer`       | testing-patterns, webapp-testing      |
| Debug    | `debugger`            | systematic-debugging                  |
| Plan     | `project-planner`     | brainstorming, plan-writing           |
