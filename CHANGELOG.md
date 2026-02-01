# Changelog

All notable changes to AntiKit will be documented in this file.

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
