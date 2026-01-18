# 🚀 AntiKit - Antigravity Workflow Kit v1.0

**Vibe Coding Workflows for Google Antigravity** - Just have an idea, AI handles everything.

> 💡 **Philosophy:** You create and decide. AI handles ALL the technical stuff - including things you didn't know you needed.

---

## 📋 Command List (20 Workflows)

### 🌟 Startup & Context
| Command | Description | Blind Spots Handled |
|---------|-------------|---------------------|
| `/init` | Create complete new project | Env vars, Git, Code quality tools |
| `/recap` | Restore context when returning | Context recovery |
| `/save-brain` | Save knowledge at end of session | API Docs, Changelog, Business rules |
| `/config` | Configure skills & agents | Resource optimization |

### 🎯 Feature Development
| Command | Description | Blind Spots Handled |
|---------|-------------|---------------------|
| `/brainstorm` | Explore ideas before planning | Market research, MVP definition |
| `/plan` | Design comprehensive features | Auth, DB, Charts, PDF, Maps, Scheduled Tasks |
| `/visualize` | Design beautiful UI/UX | Loading/Error states, Accessibility, Dark mode |
| `/code` | Write quality code | Security, Validation, Error handling |

### ⚙️ Operations
| Command | Description | Blind Spots Handled |
|---------|-------------|---------------------|
| `/run` | Start the app | Environment detection, Port conflicts |
| `/test` | Check logic | Auto-generate tests if missing |
| `/deploy` | Push to production | SEO, Analytics, Legal, Backup, Monitoring |

### 🔧 Maintenance
| Command | Description | Blind Spots Handled |
|---------|-------------|---------------------|
| `/debug` | Fix bugs | Root cause analysis |
| `/refactor` | Clean up code | Safe execution, Before/After comparison |
| `/audit` | Health check | Security, Performance, Dependencies |
| `/rollback` | Revert to previous version | Emergency recovery |

### 🌐 Infrastructure
| Command | Description | Blind Spots Handled |
|---------|-------------|---------------------|
| `/cloudflare-tunnel` | Expose app to internet | Tunnel management |

### 🛡️ Admin
| Command | Description | Blind Spots Handled |
|---------|-------------|---------------------|
| `/customize` | Personalize AI behavior | Communication style |
| `/next` | Get suggestions when stuck | Direction guidance |
| `/ak-update` | Update AntiKit | System updates |

---

## 🔥 Vibe Coder Blind Spots - Fully Handled

### 📐 When Planning (`/plan`)
| Blind Spot | AI Asks |
|------------|---------|
| Database Design | "Do you have existing data? What to manage?" |
| Auth/Login | "Need login? OAuth? Roles?" |
| File Upload | "Need image upload? Size limit?" |
| Notifications | "Need to send notifications?" |
| Payment | "Accept online payments?" |
| Search | "Need search? Fuzzy?" |
| Scheduled Tasks | "Need daily auto-runs?" |
| Charts | "Need graphs?" |
| PDF/Print | "Need invoice printing?" |
| Maps | "Need maps?" |
| Real-time | "Need live updates?" |

### 🎨 When Designing UI (`/visualize`)
| Blind Spot | AI Handles |
|------------|------------|
| Loading States | Skeleton, Spinner, Progress bar |
| Error States | Toast, Modal, Inline error |
| Empty States | Illustration + Call-to-action |
| Accessibility | Color contrast, ARIA, Keyboard nav |
| Mobile | Responsive, Touch-friendly |
| Dark Mode | Dual theme design |

### 🚀 When Deploying (`/deploy`)
| Blind Spot | AI Handles |
|------------|------------|
| SEO | Meta tags, Sitemap, robots.txt |
| Analytics | Google Analytics / Plausible |
| Legal | Privacy Policy, Terms, Cookie consent |
| Backup | Database backup strategy |
| Monitoring | Uptime + Error tracking |
| SSL | Auto HTTPS |

---

## 🚀 Auto Workflow Features

### 1. `/plan` - Auto Phase Generation
```
/plan "Order management"
    ↓
[AUTO] Create folder: plans/260117-1430-order-management/
    ↓
[AUTO] Create files:
├── plan.md (Overview + Progress tracker)
├── phase-01-setup.md
├── phase-02-database.md
├── phase-03-backend.md
├── phase-04-frontend.md
└── phase-05-testing.md
```

### 2. `/code` - Auto Test Loop
```
/code phase-01
    ↓
[AUTO] Load tasks from phase file
    ↓
[AUTO] Code each task
    ↓
[AUTO] Run tests
    ↓
├── PASS → Continue to next task
└── FAIL → Fix loop (max 3x) → Ask user if still failing
    ↓
[AUTO] Update progress in plan.md
```

### 3. `/next` - Phase Progress Display
```
📊 Progress:
████████░░░░░░░░░░░░ 40% (2/5 phases)

| Phase | Status |
|-------|--------|
| 01 Setup | ✅ Done |
| 02 Database | 🟡 In Progress |
| 03 Backend | ⬜ Pending |
```

---

## 🧠 Structured Context

### File Organization
```
.brain/                            # LOCAL (per-project)
├── brain.json                     # 🧠 Static knowledge
├── session.json                   # 📍 Dynamic session
└── preferences.json               # ⚙️ Local preferences

~/.gemini/antigravity/             # GLOBAL (all projects)
├── preferences.json               # Default AI preferences
└── ...
```

### brain.json (Static - rarely changes)
- `project`: Name, type, status
- `tech_stack`: Frontend, Backend, DB
- `database_schema`: Tables, Relationships
- `api_endpoints`: Routes with auth info
- `features`: Features and status

### session.json (Dynamic - changes frequently)
- `working_on`: Current feature, task, files
- `pending_tasks`: Todo items
- `recent_changes`: Recent modifications
- `decisions_made`: Session decisions

---

## 🛡️ Resilience Patterns

### Auto-Retry (Hidden)
```
On transient errors (network, rate limit):
1. Retry 1 (wait 1s)
2. Retry 2 (wait 2s)
3. Retry 3 (wait 4s)
4. If still failing → Report to user in simple language
```

### Error Messages (Simplified)
```
❌ Old: "Error: ECONNREFUSED 127.0.0.1:5432"

✅ New: "Can't connect to database 😅
        Please check if PostgreSQL is running!
        Type /debug if you need help."
```

---

## 🎮 Recommended Workflows

### 📦 New Project
```
/init → /plan → /visualize → /code → /run → /test → /deploy → /save-brain
```

### 🌅 Starting a New Day
```
/recap → /code → /run → /test → /save-brain
```

### 🐛 When Facing Bugs
```
/debug → /test → (if broken) /rollback
```

### 🚀 Before Release
```
/audit → /test → /deploy → /save-brain
```

---

## 📊 System Stats

| Metric | Value |
|--------|-------|
| Workflows | 20 |
| Agents | 16 |
| Skills | 40 |
| Blind spots covered | 50+ |

---

## 💡 Tips for Vibe Coders

1. **Just speak naturally** - AI will ask if something is missing
2. **Don't fear mistakes** - There's `/rollback`
3. **End of day: `/save-brain`** - Don't lose context tomorrow
4. **Regular `/audit`** - Prevention is better than cure
5. **Before release: `/deploy`** - Full SEO, Analytics, Legal

---

*AntiKit v1.0 - The Vibe Coding Kit for Google Antigravity*
