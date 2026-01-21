---
description: 🌐 Cloudflare Tunnelを管理
---

# Cloudflare Tunnel 設定

> **Context:** Agent `@devops`
> **Required Skills:** `server-management`, `deployment-procedures`
> **Key Behaviors:**
> - 既存のトンネルを使用、新規作成しない
> - ホスト名追加後にDNSルーティングを確認
> - 設定変更後にトンネルを再起動

## ⚠️ 重要 - 変更前にお読みください

システムは複数のサービスに**1つのトンネル**を使用します。新しいトンネルを作成せず、既存の設定にホスト名を追加するだけです。

---

## 📋 現在の状態

### アクティブトンネル
| プロパティ | 値 |
|-----------|-----|
| **Tunnel ID** | `aa304557-6390-44bd-a052-7d7fe2a6e7d6` |
| **Tunnel名** | `revenue-bot` |
| **ドメイン** | `ebebot.click` |

### 設定済みホスト名
| ホスト名 | サービス（ポート） | 説明 |
|----------|-------------------|------|
| `webhook.ebebot.click` | `http://localhost:39412` | LINE Bot webhook |
| `pg.ebebot.click` | `http://localhost:8888` | Erablue App |

---

## 🔧 新しいホスト名の追加方法

### ステップ1: config.ymlを更新
`- service: http_status:404` 行の**前**に新しいホスト名を追加:

```yaml
ingress:
  - hostname: new-service.ebebot.click
    service: http://localhost:XXXX
  - service: http_status:404  # <-- 常に最後に保持
```

### ステップ2: DNSルートを追加
```powershell
cloudflared tunnel route dns aa304557-... new-service.ebebot.click
```

### ステップ3: トンネルを再起動

### ステップ4: 確認
```powershell
curl https://new-service.ebebot.click
```

---

## 🚫 やってはいけないこと

1. ❌ 新しいトンネルを作成しない
2. ❌ `.json` 認証ファイルを削除しない
3. ❌ cloudflaredを手動で実行しない
