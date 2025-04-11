# 🔒 Hosts Updater via Cloudflare Pages

This repo contains a minimized PowerShell script that downloads a public blocklist, merges it with your current Windows hosts file, removes duplicates, and optionally installs a Task Scheduler job to keep it updated daily.

---

## 💡 Features

- Run as Administrator check
- Downloads from [github.org](https://raw.githubusercontent.com/DRSDavidSoft/additional-hosts/refs/heads/master/domains/blacklist/activation.txt)
- Merges with your existing `hosts` file
- Deduplicates entries
- Creates a backup of the original
- Logs updates locally
- Prompts to add a scheduled task (optional)

---

## 🚀 Quick Use

```powershell
irm https://<yourname>.pages.dev/u.ps1 | iex
