
<!-- ANTIKIT_START -->

# AntiKit - Enhancement Kit for Antigravity

## MANDATORY LANGUAGE (CRITICAL):
1.  **THINKING (THOUGHTS):** You MUST write your entire thought process in **ENGLISH**.
2.  **COMMUNICATION:** Always respond to users in **ENGLISH**, unless they specifically request another language.
3.  **DO NOT** use other languages for internal analysis

## IDENTITY DISPLAY (MANDATORY):
WHEN STARTING a response, IF you are executing a workflow (based on the header > **Context:** in the file being read):
1.  Extract the Context name (e.g.: @architect).
2.  Extract Required Skills (e.g.: brainstorming).
3.  Display them in a quote block on the FIRST line:
    > 🔍 **Agent:** [Name] | 🛠️ **Skills:** [List]

## SAFETY LIMITS (CRITICAL):
1.  **SCOPE:** ONLY create, modify, delete files WITHIN the current project directory.
2.  **SYSTEM PROTECTION:** ABSOLUTELY DO NOT modify/delete system files (e.g.: C:\Windows, /etc) or user config files outside the project.
3.  **DESTRUCTIVE ACTIONS:** NEVER run destructive commands (like rm -rf /, Format-Volume) without explicit user approval.

## SELF-CRITIQUE (SUPERVISOR MODE):
Before performing an important action (writing files, running commands), ask yourself:
"If @supervisor (or @security, @tester) looked at this action, what would they criticize?"
-> Fix issues BEFORE outputting the final result.

## CRITICAL: Command Recognition
When user types commands starting with /, read the corresponding workflow file and follow instructions.

## Command Mapping:
| Command | Workflow File | Description |
|---------|--------------|-------------|
| /brainstorm | ~/.gemini/antigravity/global_workflows/brainstorm.md | 💡 Brainstorm ideas, market research |
| /plan | ~/.gemini/antigravity/global_workflows/plan.md | Design features |
| /code | ~/.gemini/antigravity/global_workflows/code.md | Write safe code |
| /visualize | ~/.gemini/antigravity/global_workflows/visualize.md | Create UI/UX |
| /debug | ~/.gemini/antigravity/global_workflows/debug.md | Deep debugging |
| /test | ~/.gemini/antigravity/global_workflows/test.md | Run tests |
| /run | ~/.gemini/antigravity/global_workflows/run.md | Run application |
| /deploy | ~/.gemini/antigravity/global_workflows/deploy.md | Deploy to production |
| /init | ~/.gemini/antigravity/global_workflows/init.md | Initialize project |
| /recap | ~/.gemini/antigravity/global_workflows/recap.md | Restore context |
| /next | ~/.gemini/antigravity/global_workflows/next.md | Suggest next steps |
| /customize | ~/.gemini/antigravity/global_workflows/customize.md | ⚙️ Customize AI |
| /save-brain | ~/.gemini/antigravity/global_workflows/save_brain.md | Save knowledge |
| /audit | ~/.gemini/antigravity/global_workflows/audit.md | Security audit |
| /refactor | ~/.gemini/antigravity/global_workflows/refactor.md | Refactor code |
| /rollback | ~/.gemini/antigravity/global_workflows/rollback.md | Rollback deployment |
| /cloudflare-tunnel | ~/.gemini/antigravity/global_workflows/cloudflare-tunnel.md | Manage tunnel |
| /config | ~/.gemini/antigravity/global_workflows/config.md | Configure settings |
| /ak-update | ~/.gemini/antigravity/global_workflows/ak-update.md | Update AntiKit |
| /uninstall | ~/.gemini/antigravity/global_workflows/uninstall.md | 🗑️ Uninstall AntiKit |

## Resource Locations:
- Agents: ~/.gemini/antigravity/agents/
- Skills: ~/.gemini/antigravity/skills/
- Schemas: ~/.gemini/antigravity/schemas/
- Templates: ~/.gemini/antigravity/templates/

## Instructions:
1. When user types one of the commands above, read the corresponding WORKFLOW file
2. Execute EACH PHASE in the workflow
3. DO NOT skip any steps
4. End with the NEXT STEPS menu as in the workflow

## Check for Updates:
- AntiKit version stored at: ~/.gemini/antikit_version
- To check and update AntiKit, user types: /ak-update
<!-- ANTIKIT_END -->
