# Changelog

All notable changes to AntiKit will be documented in this file.

---

## [1.13.3] - 2026-02-24

### 🔄 Merge /sync-schema + Website Redesign

### Changed
- **`/sync-schema` merged into `/save-brain`** — schema sync now runs inline, no standalone command needed
- Deleted `sync-schema.mdt` (4 languages)
- Removed from `install.sh` + `install.ps1` download lists
- Updated `save_brain.mdt` (4 langs): inline sync instead of calling `/sync-schema`
- Workflow count: 20 → **19**

### Added — Website Redesign (`antikit-web`)
- **Homepage** (13 sections): Hero, Animated Stats, Story, Live Terminal Demo, Solution Grid, Comparison Table, Pipeline, Agent Showcase, Safety 7-Layer, Memory, Daily Workflow, Social Proof, CTA
- **Docs** (4 pages): Overview, Workflows (search+filter), Agents (search+expand), Skills (search+category)
- **Data files**: `agents.ts`, `workflows.ts`, `skills.ts` — all data-driven
- **Sidebar navigation** for docs
- Color scheme: cyan/emerald

### Updated
- READMEs (4 langs): 20 → 19 workflows
- Website locales (4 langs): stats, pipeline, descriptions

---

## [1.13.2] - 2026-02-24

### 🛡️ GEMINI.md Protection & Installer Fixes

### Added
- **Auto-Backup** — GEMINI.md auto-backed up before every update (keeps 3 most recent)
- **Custom Content Detection** — Detects and reports user custom rules outside markers
- **Update Report** — Shows summary after GEMINI.md update (backup path, lines updated, custom rules preserved)

### Fixed
- **awk crash** — Replaced broken `awk -v` multiline approach with `sed` + temp file (fixes GEMINI.md becoming empty)
- **Skill Index fallback** — Skills without YAML frontmatter now indexed using directory name + description line
- Both `install.sh` and `install.ps1` updated

---


### 🔧 Orphan Workflow Fix + Full save_brain Translation

### Fixed — Missing Workflows
- **`save_brain.mdt`** was orphan at `workflows/` root — never distributed to users
  - Created EN translation (289 lines, hand-translated from VI source)
  - Created JA translation (287 lines, fully hand-translated)
  - Created ZH translation (287 lines, fully hand-translated)
  - Copied VI source to `workflows/vi/`
  - Added to `install.sh` + `install.ps1` WORKFLOWS arrays
- **`sync-schema.mdt`** — same orphan issue, same fix (4 language versions)
- Installer WORKFLOWS count: 18 → 20

### Fixed — Install Commands
- README.vi.md → `bash -s -- --lang vi` / `-Language vi`
- README.ja.md → `bash -s -- --lang ja` / `-Language ja`
- README.zh.md → `bash -s -- --lang zh` / `-Language zh`
- Users copy-pasting from localized README now auto-select matching language

---

## [1.13.0] - 2026-02-23

### 🌐 Full 4-Language Workflow Parity — 72 Files Synchronized

Complete audit and sync of all 18 workflows across EN, VI, JA, ZH. Previously JA/ZH were 30-60% rut gọn (missing phases, logic gaps). Now all 4 languages have identical structure and logic.

### Added — New Workflows
- **`/launch` translations** (4 languages): Go-to-market workflow with 8 phases, localized channels per country
- **`/grow` translations** (4 languages): Product Flywheel with 7 phases, retention + viral loop design

### Fixed — Content Gaps (JA/ZH)
| Workflow | Gap Fixed |
|----------|-----------|
| `/brainstorm` JA/ZH | +Product Type chooser, Active Listening, Feature Grouping, Technical Reality Check, BRIEF.md template, Important Rules (was 32-38% → 98-100%) |
| `/next` JA/ZH | +Session.json integration, Plan progress bars, Resilience patterns (was 46% → 84-100%) |
| `/visualize` JA/ZH | +Phase 8 (Auto Design System), Phase 9 (Professional UI Checklist) (was 37-48% → 100%) |
| `/deploy` JA/ZH | Full 11-phase deploy flow (was 43-64% → 100%) |
| `/plan` JA/ZH | Full 6-phase planning with dependencies, time estimation, risks (was 46-57% → 100%) |
| `/code` JA/ZH | Full pre-commit checklist, breaking change detection (was 50-59% → 100%) |
| All P2/P3 workflows | Synced to EN baseline (audit, debug, recap, init, config, test, refactor, ak-update) |

### Fixed — Content Gaps (VI ↔ EN)
| File | Direction | What was added |
|------|-----------|---------------|
| `brainstorm.mdt` | EN→VI | Full rewrite VI from EN (147→404 lines) |
| `visualize.mdt` | VI→EN | +Phase 8 (Auto Design System) + Phase 9 (UI Checklist) |
| `recap.mdt` | VI→EN | +Phase 5 (Quick Dashboard: Agent Status, Files, Preview) |
| `init.mdt` | VI→EN | +Phase 9 (Build App from Scaffold) |
| `config.mdt` | Fix EN | Removed duplicate Phase 3 stub |

### Fixed — Logic Gaps (launch/grow JA/ZH)
- `grow.mdt` JA: +Phase 7 (Track & Celebrate + Monthly Recap)
- `grow.mdt` ZH: +Phase 7 (Track & Celebrate + Monthly Recap)
- `launch.mdt` JA: +Section 7.3 (Re-engagement) + Phase 8 (Confirm & Handoff)
- `launch.mdt` ZH: +Section 7.3 (Re-engagement) + Phase 8 (Confirm & Handoff)

### Changed — Installer
- `install.sh`: Added `launch.mdt` + `grow.mdt` to WORKFLOWS array
- `install.ps1`: Added `launch.mdt` + `grow.mdt` to $WorkflowsEn array

### Stats
- **72 workflow files** across 4 languages, all synced
- **+6,500 lines** added/changed
- **16/18 workflows** at 90-100% line parity between EN and all languages
- **18 workflows × 4 languages × identical power flags** ✅

---

## [1.12.0] - 2026-02-23

### 🌐 Community Skills Import — 36 Skills from 3 Repos

Audited and imported 36 high-quality skills from community repos. Security-scanned, verified clean.

### Added — Marketing & Growth (29 skills from `coreyhaines31/marketingskills`)
- **CRO Skills** (6): `page-cro`, `form-cro`, `signup-flow-cro`, `onboarding-cro`, `popup-cro`, `paywall-upgrade-cro`
- **Content & Copy** (4): `copywriting`, `copy-editing`, `content-strategy`, `social-content`
- **SEO** (4): `ai-seo`, `programmatic-seo`, `seo-audit`, `schema-markup`
- **Growth** (4): `churn-prevention`, `referral-program`, `email-sequence`, `ab-test-setup`
- **Strategy** (4): `pricing-strategy`, `launch-strategy`, `marketing-psychology`, `marketing-ideas`
- **Acquisition** (4): `ad-creative`, `paid-ads`, `cold-email`, `competitor-alternatives`
- **Other** (3): `analytics-tracking`, `free-tool-strategy`, `product-marketing-context`

### Added — Engineering (6 skills from `affaan-m/everything-claude-code`)
- `continuous-learning-v2` — AI self-learning via instinct-based hooks
- `cost-aware-llm-pipeline` — LLM cost management patterns
- `content-hash-cache-pattern` — Smart caching strategy
- `strategic-compact` — Context compression for efficiency
- `docker-patterns` — Docker/compose best practices
- `e2e-testing` — E2E testing with Playwright

### Added — Mobile (1 skill from `sickn33/antigravity-awesome-skills`)
- `app-store-optimization` — ASO for iOS/Android launches

### Workflow Enhancements (via new skills)
| Workflow | New Skills Available |
|----------|---------------------|
| `/brainstorm` | competitor-alternatives, marketing-ideas, product-marketing-context |
| `/visualize` | page-cro, form-cro, signup-flow-cro, copywriting, marketing-psychology |
| `/code` | schema-markup, content-hash-cache-pattern, cost-aware-llm-pipeline |
| `/test` | ab-test-setup, e2e-testing |
| `/deploy` | analytics-tracking, programmatic-seo, docker-patterns |
| `/audit` | seo-audit |
| `/launch` | launch-strategy, ad-creative, cold-email, app-store-optimization |
| `/grow` | churn-prevention, pricing-strategy, referral-program, email-sequence |

### Security
- All 36 skills scanned for prompt injection, hidden instructions, executable code
- 2 false positives verified (docker-compose override, prompt caching references)
- Sources: repos with 14K-50K GitHub stars

---

## [1.11.0] - 2026-02-23

### 🚀 Deep Research Edition — Launch & Grow System v2

Major upgrade based on deep research: indie hacker playbooks, Product Hunt strategies, SaaS growth frameworks, viral loop design, and landing page conversion optimization.

### Upgraded
- **`growth-marketing` skill v2.0** (~500 lines):
  - Pre-sell validation (5 payments in 7 days rule)
  - "Build in Public" content framework
  - Product Hunt deep strategy (hunter, 12:01AM PT, Tue-Thu, asset specs)
  - Hacker News "Show HN" protocol
  - Content formulas: AIDA (revenue), Build-in-Public (community)
  - Channel deep dives: per-country, per-platform timing, format, frequency
  - Landing page: proven 8-section conversion structure
  - Viral loop design: double-sided rewards, gamification, tiers
  - Sean Ellis PMF test (40% "very disappointed" = PMF)
  - Retention benchmarks (NRR, churn, D1/D7/D30)
  - TTFV optimization (Time to First Value < 2 min)
  - Success milestones (🌱→💎 growth stages)

### Added
- **`/grow` workflow** (7 phases, 6 power flags):
  - Phase 1: Health Check + PMF Score
  - Phase 2: Feedback → Roadmap pipeline
  - Phase 3: Improve → Ship (connects to /debug, /enhance, /code)
  - Phase 4: Promote Update (copy-paste content templates)
  - Phase 5: Viral Loop (referral, social sharing, embedded brand)
  - Phase 6: Retention (onboarding audit, re-engagement emails)
  - Phase 7: Track & Celebrate (milestones, monthly recap)
  - **Product Flywheel:** /grow → /brainstorm → /plan → /code → /deploy → /grow

### New Pipeline (Complete)
```
🆕 New product:  /brainstorm → /plan → /code → /deploy → /launch
🔄 Improve:      /grow → /enhance → /deploy → /grow --update
🌟 New feature:  /grow --feedback → /brainstorm → /plan → /code → /deploy
```

---

## [1.10.0] - 2026-02-23

### 🚀 Launch System — Go-to-Market for Coders

Complete go-to-market system that takes products from "just deployed" to "users love it". AI writes copy-paste ready content, creates landing pages, sets up payments, and plans 30-day marketing calendars — all localized per country.

### Added

#### New Workflow: `/launch`
- **8-phase go-to-market:** Goal discovery → Competitor intel → Marketing plan → Content creation → Landing page → Payment → Distribution → Post-launch
- **Power mode flags:** `--landing`, `--content`, `--pricing`, `--ads`
- **Goal-first:** 💰 Revenue / 🆓 Free / 👥 Community / 🏆 Reputation / 🎯 Hybrid
- Content is **COPY-PASTE READY** — user just pastes into Facebook/TikTok/Product Hunt

#### New Agent: `growth-hacker`
- Marketing expert that speaks coder language
- Translates marketing jargon for freshers
- Localized per country/culture

#### New Skill: `growth-marketing`
- **Goal Discovery** — determines strategy from launch objective
- **Competitor Intelligence** — research + USP positioning
- **Content Creation** — channel-specific, copy-paste ready (FB, TikTok, PH, X, etc.)
- **Landing Page Patterns** — high-conversion structure
- **Payment Setup (2026)** — SePay, MoMo, VNPay, PayPay, Stripe, Paddle, etc.
- **30-Day Calendar** — pre-launch → launch → growth phases
- **Post-Launch Retention** — onboarding, re-engagement, feedback
- **Growth Metrics** — KPIs per goal type

### Changed
- **`install.sh`** — Added `growth-marketing` to SKILLS array (now 47 skills)
- **`install.ps1`** — Added `growth-marketing` to $Skills array

### New Pipeline
```
/brainstorm → /plan → /code → /deploy → /launch (NEW!)
```

---

## [1.9.8] - 2026-02-23

### 🗣️ Dialect & Regional Language Detection

AI now detects local speech patterns (miền Nam/Bắc, Gen Z, Kansai, 繁體/简体, casual English) to calibrate formality.

### Added
- **Dialect signal matrix** — 10 regional patterns across 4 languages
- **Critical rules** — RECOGNIZE dialect but NEVER mimic (AI stays professional)
- **Examples** — miền Nam casual, miền Bắc polite, Gen Z energy matching

---

## [1.9.7] - 2026-02-23

### 🌏 Cultural Adaptation — AI Speaks Your Culture

Added section 8 to `proactive-intelligence` skill: AI adapts tone, formality, and style based on user's language/culture.

### Added
- **Cultural Matrix** — Vietnamese (casual-warm), Japanese (formal-polite), Chinese (professional-direct), English (friendly-balanced)
- **Context-aware adaptation** — error messages, options, celebrations, and suggestions styled per culture
- Auto-detects language from GEMINI.md config or user's first message

---

## [1.9.6] - 2026-02-23

### 🧠 Proactive Intelligence — AI Adapts to You

New skill that makes AI adapt its communication to user expertise level, choose smart defaults, and add best practices automatically.

### Added

#### New Skill: `proactive-intelligence` (P0 priority)
- **🎯 Adaptive Level Detection** — Silently detects fresher/mid/senior from vocabulary and request style
- **🗣️ Human-First Language** — Translates jargon to plain language for freshers, uses technical terms for seniors
- **🛡️ Proactive Guardrails** — Gently suggests better alternatives when detecting anti-patterns
- **⚡ Smart Defaults** — AI picks best default (most popular + lightest), explains in 1 line
- **📦 Token Budget** — No repetition, references instead of re-explaining, diff-only for updates
- **🔮 Expert Override** — Adds best practices automatically (error handling, loading states, validation), tags what was added
- **🤫 Silent Excellence** — Technical decisions made silently, only asks about business logic

### Changed
- **8 agents** now include `proactive-intelligence`:
  - `orchestrator`, `frontend-specialist`, `backend-specialist`, `mobile-developer`
  - `game-developer`, `project-planner`, `explorer-agent`, `debugger`
- **`install.sh`** — Added `proactive-intelligence` to SKILLS array
- **`install.ps1`** — Added `proactive-intelligence` to $Skills array

---

## [1.9.5] - 2026-02-23

### 📋 Response Formatting Rule — Vertical List Enforcement

Options and menus now always display as vertical lists (one option per line), never as a single horizontal line.

### Added
- **Response Formatting rule** (all 4 languages × 2 installers):
  - Choices, next steps, and menus must be vertical lists
  - Prevents AI from cramming all options on one line

---

## [1.9.4] - 2026-02-23

### 📝 README Overhaul — 6 Pillars, Multi-Agent Showcase

Complete rewrite of all 4 READMEs (en, vi, ja, zh) to showcase v1.9.x features and make users want to install immediately.

### Changed
- **Version badge:** 1.6.0 → 1.9.4
- **4 Pillars → 6 Pillars:** Added Multi-Agent Collaboration, Evidence Discipline, Context Integrity
- **Skills count:** 44 → 45
- **Identity format:** Updated from `🆔 Agent` to `🤖 PRIMARY + SUPPORT`
- **Pro section:** Added Multi-Agent Protocol, Evidence Gates
- **What's Inside:** Added Multi-Agent Protocol and Evidence Discipline lines
- **ARCHITECTURE.md:** Synced skill count, agent skills, added `evidence-discipline` entry

---

## [1.9.3] - 2026-02-23

### 🎯 Multi-Agent Format Clarification — Flexible SUPPORT Count

Clarified multi-agent rules: PRIMARY is always exactly 1 agent, SUPPORT supports 1+ agents with clear escalation rules.

### Changed
- **Identity Visibility** (all 4 languages × 2 installers):
  - Format now shows `@[agent2], @[...]` for multiple SUPPORTs
  - PRIMARY = always 1. If ≥3 domains → PRIMARY = `orchestrator`
  - SUPPORT = always ≥1. If ≥3 domains → multiple SUPPORTs

---

## [1.9.2] - 2026-02-23

### 🤖 Multi-Agent Identity Enforcement — Always PRIMARY + SUPPORT

Fixed: Identity Visibility rule now **enforces** multi-agent display at GEMINI.md level. Previously, workflows only showed 1 agent despite the Multi-Agent Protocol requiring minimum 2.

### Changed

#### Identity Visibility Rule (All 4 Languages × 2 Installers)
- **Before:** `> 🆔 **Agent:** [Name] | 🛠️ **Skills:** [List]` — only showed 1 agent
- **After:** `> 🤖 **PRIMARY:** @[agent] | **SUPPORT:** @[agent2] | 🛠️ **Skills:** [list]` — enforces 2+ agents
- New rule: "ALWAYS have a SUPPORT, never just 1 agent"
- PRIMARY from workflow `> **Context:**` or AGENT INDEX keyword match
- SUPPORT from AGENT INDEX keyword match on request

### Benefits
- Multi-Agent Protocol is now enforced at the highest priority level (GEMINI.md)
- AI cannot skip SUPPORT agent selection even when workflow specifies only 1 Context
- Consistent multi-perspective output in every response

---

## [1.9.1] - 2026-02-23

### 🔬 Evidence Discipline + Context Integrity — No Vibe Coding

New skill that enforces evidence-based development and prevents context drift. Inspired by [HiveMind](https://github.com/shynlee04/hivemind-plugin) governance patterns, optimized for AntiKit's rule-based system.

### Added

#### New Skill: `evidence-discipline`
- **Evidence Gates** — Mandatory proof before action (reproduce bugs, benchmark before optimize, compare before adding dependencies)
- **Context Integrity** — Self-check rules to detect drift: goal alignment, scope creep, rabbit holes, file coherence
- **Intent Declaration** — State goal/scope/estimate at start of complex tasks
- **Verification Checkpoints** — Phase-specific checklist (Debug, Feature, Refactor, Deploy)
- **Token Optimization** — Read-once, apply-always; evidence overhead proportional to task complexity

### Changed
- **7 agents** now include `evidence-discipline` in their skills:
  - `orchestrator`, `debugger`, `backend-specialist`, `frontend-specialist`
  - `code-archaeologist`, `test-engineer`, `explorer-agent`
- **`install.sh`** — Added `evidence-discipline` to SKILLS array
- **`install.ps1`** — Added `evidence-discipline` to $Skills array

### Benefits
- Prevents "maybe if I change this..." random fixes
- Forces bug reproduction before attempting fixes
- Catches scope creep and context drift mid-task
- Zero token overhead for simple tasks; full evidence gates for complex ones
- Integrates with existing workflows (`/debug`, `/code`, `/refactor`, `/deploy`, `/audit`)

---

## [1.9.0] - 2026-02-23

### 🤖 Multi-Agent Task Protocol — Dynamic Agent Selection

Every task now uses 2+ agents collaborating together. Agent selection is automatic based on keyword matching against an auto-generated AGENT INDEX.

### Added

#### Agent Tags System
- All 20 agents now have `tags:` field in frontmatter for keyword-based matching
- Tags cover domain-specific keywords (e.g., `auth,jwt,oauth` for security-auditor)

#### AGENT INDEX (Auto-Generated)
- Installer generates an AGENT INDEX table from agent frontmatter at install time
- Table is embedded directly in GEMINI.md (~500 tokens, always available)
- No need to read individual agent files for routing decisions

#### Multi-Agent Task Protocol
- **Selection**: Match request keywords → agent tags, select PRIMARY + SUPPORT agents
- **Loading**: Read only PRIMARY agent file; use SUPPORT skills from index (token-optimized)
- **Execution**: PRIMARY persona + SUPPORT knowledge
- **Cross-Review**: Mandatory for build/create, auto for fix/refactor, skip for questions

#### Scripts
- **`scripts/generate-index.sh`** — Generates AGENT INDEX table from agent frontmatter

### Changed
- **`intelligent-routing/SKILL.mdt`** — Rewritten from v1 (hardcoded matrix) to v2 (dynamic tag matching)
- **`install.sh`** — Generates AGENT INDEX, appends MULTI-AGENT PROTOCOL to GEMINI.md
- **`install.ps1`** — Same changes mirrored for PowerShell

### Benefits
- Higher code quality through multi-perspective collaboration
- Token-efficient: ~11-20k tokens (vs ~80-150k if reading all agents)
- Cross-review catches issues from multiple domain perspectives
- Deterministic baseline (tags) with AI flexibility (override)

---

## [1.8.0] - 2026-02-23

### 🔒 MDT Extension Migration — Anti-Scan Protection

Source files in the repo are now stored with `.mdt` extension instead of `.md` to prevent Antigravity from scanning them as active skills/agents/workflows when users open the antikit workspace.

### Changed

#### File Extension Migration (265 files)
- **Agents** (`src/agents/`): 20 files renamed `.md` → `.mdt`
- **Skills** (`src/skills/`): 124 files renamed `.md` → `.mdt`
- **Workflows** (`workflows/`): 121 files renamed `.md` → `.mdt`

#### Installer Updates
- **`install.sh`**: Downloads `.mdt` from GitHub, saves as `.md` locally
- **`install.ps1`**: Same `.mdt` → `.md` conversion during installation

### Benefits
- No more duplicate skills/agents appearing in slash command autocomplete
- Cleaner workspace when developing on the antikit repo
- Zero impact on end-user installation — files are saved as `.md` as before

---

## [1.5.0] - 2026-02-05

### 🔄 Living Documentation System

This release introduces automatic schema synchronization to ensure AI agents always have accurate database documentation.

### Added

#### New Workflow
- **`/sync-schema`** - Synchronize database documentation with actual schema
  - Reads migrations and updates `docs/database/schema.md`
  - Updates `src/lib/db/schema.ts` with TypeScript types
  - Syncs `.brain/brain.json` database_schema section
  - Validates CRITICAL_COLUMNS before any changes

#### Auto-Sync Integration
Automatic `/sync-schema` triggers added to existing workflows:

- **`/save-brain`** - Auto-sync at end of session and when DB changes
- **`/code`** - Auto-sync after creating new migrations or changing DB schema
- **`/plan`** - Auto-sync after completing phase-02 (database phase)
- **`/deploy`** - Pre-flight check includes schema sync verification

#### Critical Columns Protection
- New `CRITICAL_COLUMNS` pattern to prevent accidental deletion of business-critical columns
- AI must check critical columns before removing any database column
- Documents business purpose for each critical column

### Benefits
- AI no longer makes incorrect changes due to outdated documentation
- Database schema changes are automatically reflected in docs
- Business rules for columns are preserved and accessible
- Reduces "blind fixes" where AI removes important columns

### Files Added
- `workflows/sync-schema.md` - New schema sync workflow

### Files Modified
- `workflows/save_brain.md` - Added auto sync-schema trigger
- `workflows/code.md` - Added migration change detection
- `workflows/plan.md` - Added database phase completion trigger
- `workflows/deploy.md` - Added pre-deploy schema verification

---

## [1.4.0] - 2026-02-01

### 📦 Selective Update System

A major release introducing selective package installation and comprehensive security system.

### Added

#### Selective Package Installation
- **`/ak-install`** - Install individual packages on demand
  - Install single: `/ak-install skill/react-patterns`
  - Install by category: `/ak-install --category=security`
  - Automatic dependency resolution
- New workflows for all 4 languages (vi, en, ja, zh)

#### Security Scanning System
- **`schemas/security-patterns.json`** - Comprehensive pattern definitions
  - Blocked patterns: curl pipe, rm -rf, base64 decode, credential theft
  - Warning patterns: network requests, file operations
  - Whitelist for approved domains
- **`scripts/security-scan.ps1`** - PowerShell scanner (8/8 tests pass)
- **`scripts/security-scan.sh`** - Bash scanner for macOS/Linux
- **`.github/workflows/security-scan.yml`** - CI/CD integration

#### Trust System & Moderation
- **Contributor Trust Levels**:
  - 🆕 New: Manual review required
  - ⭐ Verified (5+ approvals): Auto-approve if scan passes
  - 👑 Maintainer: Instant publish + moderation rights
- **`/ak-moderate`** - Admin moderation dashboard
- **`/ak-report`** - Community reporting system
- **Auto-quarantine**: 3 reports → package disabled

#### Update Tiers
- **CRITICAL**: Security patches (auto-install)
- **RECOMMENDED**: Core improvements (prompt Y)
- **OPTIONAL**: Community packages (user choice)

#### Registry Schema v2.0.0
- Package categories and tags
- Tier classification
- Dependency tracking
- Download statistics

### Files Added
- `schemas/package.schema.json` - Package validation
- `schemas/security-patterns.json` - Security patterns
- `scripts/security-scan.ps1` - Windows scanner
- `scripts/security-scan.sh` - Unix scanner
- `.github/workflows/security-scan.yml` - CI check
- `contributors/trust-levels.json` - Trust system
- `registry/audit-log.json` - Transparency log
- `workflows/*/install.md` (4 languages)
- `workflows/*/moderate.md` (4 languages)
- `workflows/*/report.md` (4 languages)

---

## [1.3.1] - 2026-02-01

### 🐛 Hotfix: Installer Missing Community Workflows

### Fixed
- **Installer Scripts**: Added missing Community workflows to download lists
  - `install.ps1`: Added `browse.md`, `contribute.md`, `history.md` to `$WorkflowsEn` array
  - `install.sh`: Added same 3 files to `WORKFLOWS` array
- **GEMINI.md Templates**: Added missing command mappings for all 4 languages
  - `/ak-browse` - Browse Community Library
  - `/ak-contribute` - Contribute to Library
  - `/ak-history` - Update History

### Root Cause
- Workflows were added to `workflows/{lang}/` directories but not added to installer download lists
- Command mappings were documented in CHANGELOG 1.3.0 but not added to GEMINI.md templates

---

## [1.3.0] - 2026-02-01

### 🤝 Community Contribution System

This major release introduces a complete community contribution ecosystem for AntiKit.

### Added

#### Infrastructure
- **Community Library** (`library/`) - New directory structure for community packages
- **Registry System** (`registry/index.json`) - Package index with metadata
- **Contributor Profiles** (`contributors/`) - User profiles, points, and leaderboard
- **Manifest Schema** (`schemas/manifest.schema.json`) - Package validation

#### New Workflows
- **`/ak-contribute`** - Submit local customizations to the community library
  - Auto-validate content format
  - Auto-translate to all 4 languages (vi, en, ja, zh)
  - Auto-commit and push to git
  - Earn contributor points

- **`/ak-update` (Enhanced)** - Selective package updates
  - Browse available updates with UI
  - Choose individual packages to install
  - Track update history
  - Language-aware (auto-translate to user's language)

- **`/ak-browse`** - Browse community library
  - Filter by type, tag, language, popularity
  - View package details
  - One-click install

- **`/ak-history`** - View update history
  - Timeline of updates and installs
  - Rollback capability
  - Contribution tracking

#### Cross-Language Features
- Users can contribute in ANY language
- AI auto-translates to all 4 supported languages
- Users see content in their preferred language
- Universal content layer separates logic from text

#### Contributor Recognition
- Points system (100 pts for workflow, 50 for skill, 30 for translation)
- Level system (Bronze → Silver → Gold → Diamond)
- Leaderboard with top contributors
- Badges for achievements

### Benefits
- Community-driven growth
- Cross-language collaboration
- Selective updates (no more download-all)
- Full transparency with Git-based storage

---

## [1.2.1] - 2026-02-01

### 🌐 Full Multilingual Workflow Support

This release completes multilingual support for all enhanced workflows across Vietnamese, English, Japanese, and Chinese.

### Added

#### Complete Language Parity
All 5 enhanced workflows now have identical features across all 4 languages:

**`/debug` (vi, en, ja, zh):**
- 5 Whys Root Cause Analysis template
- Bug Severity Classification (CRITICAL, MAJOR, MINOR, TRIVIAL)
- Pattern Matching with previously fixed bugs
- Enhanced bug logging with timestamp, severity, root cause, lesson learned
- Suggestion to save common patterns to global

**`/code` (vi, en, ja, zh):**
- Pre-Commit Self-Review Checklist
- Breaking Change Detection with impacted file warnings
- Test Reminder for critical business logic
- Pattern discovery suggestion for global saving

**`/plan` (vi, en, ja, zh):**
- Task Dependencies with visual Dependency Map
- Time Estimation per task and phase
- Priority System (P0-Critical to P3-Low)
- Risks & Blockers tracking table
- Smart Phase Detection based on complexity

**`/test` (vi, en, ja, zh):**
- Priority Testing (P0-P3 levels)
- Critical Path First execution strategy
- Risk-Based Testing prioritization
- Enhanced Coverage Report by category
- Coverage saving to session.json

**`/recap` (vi, en, ja, zh):**
- Daily Standup Format (Done/Doing/Blocked)
- Blockers Highlight with action table
- Auto-Detect Blockers from session.json, git commits, and tests

### Benefits
- Users can use AntiKit in their preferred language with full feature parity
- Consistent experience across all supported languages
- Better adoption for international teams

---

## [1.2.0] - 2026-02-01

### ✨ Enhanced Workflows & Global Rules

This release introduces significant improvements to bug management, code quality, and proactive knowledge sharing.

### Added

#### Global Rules System
- **Proactive Behavior**: AI now proactively suggests saving useful patterns/rules to global memory
- **Git Workflow**: Main/Develop branching strategy with merge confirmation and diff review
- **Bug Management**: Severity classification (CRITICAL, MAJOR, MINOR, TRIVIAL)
- **Task Management**: Priority system (P0-P3) with dependency tracking
- **Code Quality**: Pre-commit checklist, breaking change detection, test reminders
- **Learning System**: Lesson learned logging, pattern library, anti-pattern warnings

#### Workflow Improvements

**`/debug` Enhanced:**
- 5 Whys Root Cause Analysis template
- Bug severity classification
- Pattern matching with previously fixed bugs
- Enhanced bug logging with timestamp, severity, root cause, and lesson learned
- Suggestion to save common bug patterns to global

**`/code` Enhanced:**
- Pre-Commit Self-Review Checklist (validation, security, error handling)
- Breaking Change Detection with warnings for impacted files
- Test reminder for critical business logic
- Pattern discovery suggestion for global saving

**`/preferences` Template:**
- Full global rules template with git workflow, bug management, task management
- Proactive behavior configuration
- Code quality settings

### Benefits
- Better bug tracking and prevention across projects
- Improved code quality with self-review before commit
- Knowledge retention through global pattern library
- Safer deployments with merge confirmation workflow

---

## [1.1.12] - 2026-01-22
### Fixed
- **Windows Emoji Support**: Replaced 🇺🇸 (US Flag) with ⚠️ (Warning) in Vietnamese, Japanese, and Chinese READMEs to fix rendering issues on Windows.

## [1.1.11] - 2026-01-22
### Fixed
- **English Logic**: Rephrased "Native Fluency" section in English README to focus on "Strict Language Enforcement" (removed illogical "struggling with Engrish" complaint).

## [1.1.10] - 2026-01-22
### Fixed
- **Content Logic**: Fixed logical inconsistency in English README (replaced "Too English" complaint with "Too Random/Risky").
- **Link Targets**: Updated all project/PR links to point to the official site `https://antikit.pages.dev`.

## [1.1.9] - 2026-01-22
### Changed
- **Content Accuracy**: Updated READMEs to correctly state "**20+ Core Workflows**" (instead of misleading 80+ file count).
- **Pro Appeal**: Added "**For the Pros**" section highlighting efficiency, standardized enforcement, and deep flow state.
- **Skill Library**: Clearly listed 40+ specialized skills (Tech, Process, Niche) to demonstrate Agent capability.

## [1.1.8] - 2026-01-22
### Added
- **Global README Support**: Added professional READMEs in Vietnamese (`README.vi.md`), Japanese (`README.ja.md`), and Chinese (`README.zh.md`).
- **Professional Badges**: Added Version, License, and **Buy Me A Coffee** badges to the README header.

## [1.1.7] - 2026-01-22
### Changed
- **Marketing Overhaul**: Completely rewrote `README.md` and `antikit-web` to focus on "Vibe Coding".
- **Documentation**: Highlighted 4 key pillars: Native Fluency, Zero-Fear Safety, Identity Badges, and Supervisor Brain.

## [1.1.6] - 2026-01-22
### Added
- **Supervisor Mode (Self-Reflection)**: Implemented "Internal Reflection" rules. Agents now self-critique critical actions against `@supervisor`/`@security` standards before execution, improving quality without the cost of a full multi-agent loop.

## [1.1.5] - 2026-01-22
### Added
- **Safety Boundaries**: Implemented strictly enforced safety rules in `install.ps1`, `install.sh`, and `GEMINI.md`.
    - **Scope Restriction**: Agents are restricted to the current project directory.
    - **System Protection**: Agents are prohibited from modifying system files (e.g., `C:\Windows`, `/etc`).
    - **Destructive Actions**: Agents must ask for explicit approval before running destructive commands.

## [1.1.4] - 2026-01-22
### Added
- **Identity Badge**: Agents now explicitly display their identity and active skills at the start of responses (e.g., `> 🆔 **Agent:** @architect | 🛠️ **Skills:** brainstorming`).
- Enforced Identity Visibility in `install.ps1`, `install.sh`, and `GEMINI.md`.

## [1.1.3] - 2026-01-22
### Changed
- Enforced **Strict Language Support** in `install.ps1`, `install.sh` and `GEMINI.md`.
- Agents now **MUST** use the selected language for both internal "Thoughts" and user interactions.

## [1.1.2] - 2026-01-22
### Fixed
- Fixed `ak-update` hanging on Windows by adding `-Unattended` mode to `install.ps1`.
- Fixed `GEMINI.md` duplication issue on re-install by implementing robust `<!-- ANTIKIT_START -->` marker replacement logic.
- Improved installer language detection to automatically use previously selected language.

## [1.1.1] - 2026-01-21
### Added
- Enhanced `/config` workflow with **Lightweight**, **Balanced**, and **Powerful** priority modes.
- Full multilingual support for new config modes (English, Vietnamese, Japanese, Chinese).

## [1.1.0] - 2026-01-21

### ✨ Workflow Power Mode - Key Behaviors

- **Key Behaviors Added**: All 80 workflow files now include `Key Behaviors` extracted from 16 agent personas
- Each workflow header now shows 2-3 specific behaviors AI should follow
- Behaviors are translated to each supported language (vi, en, ja, zh)

**Example:**
```markdown
> **Context:** Agent `@architect`
> **Required Skills:** `brainstorming`, `plan-writing`
> **Key Behaviors:**
> - Clarify requirements before proposing solutions
> - Break tasks into phases (max 3 days/phase)
> - Always consider trade-offs and constraints
```

### Benefits
- AI follows agent persona more consistently
- Lightweight approach (no installer mode required)
- Consistent behavior across all 4 languages

---

## [1.0.1] - 2026-01-21

### 🔧 Workflow Optimization

- **Agent/Skill Injection**: All 84 workflow files now include explicit `Context` (Agent Persona) and `Required Skills` headers
- Applied consistently across all 4 languages: English, Vietnamese, Japanese, Chinese
- Each workflow now explicitly specifies which agent(s) and skill(s) to activate

---

## [1.0.0] - 2026-01-20

### 🎉 Initial Release

First public release of AntiKit - Enhancement Kit for Antigravity.

### Features

#### Workflows (20)
- `/init` - Project initialization
- `/plan` - Feature planning with auto phase generation
- `/code` - Safe coding with auto-test loop
- `/visualize` - UI/UX design
- `/run` - Application runner
- `/test` - Test execution
- `/debug` - Bug fixing
- `/deploy` - Production deployment
- `/audit` - Security & code audit
- `/refactor` - Code cleanup
- `/rollback` - Version rollback
- `/recap` - Context recovery
- `/save-brain` - Knowledge persistence
- `/next` - Next step suggestions
- `/customize` - AI personalization
- `/config` - Configuration management
- `/brainstorm` - Idea discovery
- `/cloudflare-tunnel` - Tunnel management
- `/ak-update` - Self-update
- `/uninstall` - Complete removal

#### Agents (16)
- `@frontend` - React/Next.js specialist
- `@backend` - Node.js/API expert
- `@database` - Prisma/SQL expert
- `@security` - Security specialist
- `@devops` - CI/CD/Docker expert
- `@tester` - Testing specialist
- `@debugger` - Bug fixing expert
- `@performance` - Optimization specialist
- `@architect` - System design expert
- `@doc` - Documentation writer
- `@orchestrator` - Team coordinator
- `@pentester` - Penetration tester
- `@mobile` - React Native/Flutter expert
- `@game` - Game development
- `@seo` - SEO specialist
- `@explorer` - Code explorer

#### Skills (40)
- Frontend: react-patterns, nextjs-expert, tailwind-patterns, frontend-design, ui-ux-pro-max
- Backend: api-patterns, nodejs-best-practices, nestjs-expert, python-patterns
- Database: prisma-expert, database-design
- TypeScript: typescript-expert, clean-code, lint-and-validate
- Testing: testing-patterns, tdd-workflow, webapp-testing, code-review-checklist
- Security: vulnerability-scanner, red-team-tactics
- DevOps: docker-expert, deployment-procedures, server-management, bash-linux, powershell-windows
- Architecture: architecture, brainstorming, plan-writing, documentation-templates
- Performance: performance-profiling, systematic-debugging
- Special: mobile-design, game-development, seo-fundamentals, geo-fundamentals, i18n-localization, mcp-builder, app-builder
- Coordination: parallel-agents, behavioral-modes

#### Multi-language Support
- 🌐 English (en)
- 🇻🇳 Vietnamese (vi)
- 🇯🇵 Japanese (ja)
- 🇨🇳 Chinese (zh)

#### Installation
- One-line install for Windows (PowerShell)
- One-line install for macOS/Linux (Bash)
- Automatic language selection during install
- Restart reminder after installation

---

## Links

- Repository: https://github.com/hasugoii/antikit
- Issues: https://github.com/hasugoii/antikit/issues
