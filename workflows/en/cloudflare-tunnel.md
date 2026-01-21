---
description: 🌐 Manage Cloudflare Tunnel
---

# Cloudflare Tunnel Configuration

> **Context:** Agent `@devops`
> **Required Skills:** `server-management`, `deployment-procedures`
> **Key Behaviors:**
> - Use existing tunnel, don't create new
> - Verify DNS routing after adding hostname
> - Restart tunnel after config changes

## ⚠️ IMPORTANT - READ BEFORE MAKING CHANGES

The system uses **ONE single tunnel** for multiple services. DO NOT create new tunnels, only add hostnames to existing config.

---

## 📋 Current Status (Updated: 2026-01-13)

### Active Tunnel
| Property | Value |
|----------|-------|
| **Tunnel ID** | `aa304557-6390-44bd-a052-7d7fe2a6e7d6` |
| **Tunnel Name** | `revenue-bot` |
| **Domain** | `ebebot.click` |
| **Runs as** | Windows Scheduled Task (`CloudflaredTunnel`) under SYSTEM account |

### Scheduled Tasks (run at startup)
| Task Name | Executable | Description |
|-----------|------------|-------------|
| `CloudflaredTunnel` | `cloudflared.exe tunnel run` | Cloudflare Tunnel daemon |
| `WebhookServer` | `node.exe D:\revenue-bot\webhook-server.js` | LINE Bot webhook server (port 39412) |

### Configured Hostnames
| Hostname | Service (Port) | Description |
|----------|----------------|-------------|
| `webhook.ebebot.click` | `http://localhost:39412` | LINE Bot webhook server |
| `pg.ebebot.click` | `http://localhost:8888` | Erablue App (Docker production) |

### Config file locations
| User | Path |
|------|------|
| **SYSTEM (production)** | `C:\Windows\System32\config\systemprofile\.cloudflared\config.yml` |
| **Backend user** | `C:\Users\15931 - Backend\.cloudflared\config.yml` |

---

## 🔧 How to Add New Hostname

### Step 1: Update config.yml
Add new hostname **BEFORE** the line `- service: http_status:404`:

```yaml
tunnel: aa304557-6390-44bd-a052-7d7fe2a6e7d6
credentials-file: C:\Windows\System32\config\systemprofile\.cloudflared\aa304557-6390-44bd-a052-7d7fe2a6e7d6.json
ingress:
  - hostname: webhook.ebebot.click
    service: http://localhost:39412
  - hostname: pg.ebebot.click
    service: http://localhost:8888
  # === ADD NEW HOSTNAME HERE ===
  - hostname: new-service.ebebot.click
    service: http://localhost:XXXX
  # =============================
  - service: http_status:404  # <-- ALWAYS KEEP LAST
```

### Step 2: Add DNS route
```powershell
cloudflared tunnel route dns aa304557-6390-44bd-a052-7d7fe2a6e7d6 new-service.ebebot.click
```

### Step 3: Restart tunnel (PowerShell Admin)
```powershell
Stop-ScheduledTask -TaskName "CloudflaredTunnel"
Start-Sleep 2
Start-ScheduledTask -TaskName "CloudflaredTunnel"
```

### Step 4: Verify
```powershell
curl https://new-service.ebebot.click
```

---

## ⚠️ Common Errors

### Error 1033 - Tunnel not connected
**Cause**: Cloudflared not running or wrong credentials
**Solution**:
```powershell
# Check process
tasklist /FI "IMAGENAME eq cloudflared.exe"

# If not running, restart task
Start-ScheduledTask -TaskName "CloudflaredTunnel"
```

### Error 502 - Bad Gateway
**Cause**: Backend service not running or wrong port
**Solution**: Check if port is correct
```powershell
netstat -ano | findstr ":PORT_NUMBER"
```

### Error "Failed to add route: record already exists"
**Cause**: DNS record already exists
**Solution**: Go to Cloudflare Dashboard → DNS → delete old record → run command again

---

## 📁 Credentials & Files

| File | Description |
|------|-------------|
| `aa304557-...7d6.json` | Tunnel credentials (DO NOT DELETE!) |
| `cert.pem` | Account certificate |
| `config.yml` | Ingress rules |

---

## 🚫 DON'T DO

1. ❌ DON'T create new tunnels - only add hostnames to existing tunnel
2. ❌ DON'T delete `.json` credentials file
3. ❌ DON'T run cloudflared manually (use Scheduled Task)
4. ❌ DON'T use old tunnel `d164e5de-...` (broken)

---

## ✅ Checklist When Adding New Service

- [ ] Is service running at localhost:PORT?
- [ ] Is port confirmed with `netstat`?
- [ ] Added hostname to config.yml (SYSTEM path)?
- [ ] Ran `cloudflared tunnel route dns`?
- [ ] Restarted Scheduled Task?
- [ ] Tested with curl/browser?
- [ ] Updated "Configured Hostnames" table in this file?
