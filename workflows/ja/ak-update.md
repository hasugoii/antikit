---
description: AntiKitを最新バージョンに更新
---

# ワークフロー: /ak-update - アップデーター

> **Context:** Agent `@devops`
> **Required Skills:** `server-management`
> **Key Behaviors:**
> - 現在と最新バージョンを確認
> - 更新前に変更履歴を表示
> - 更新後にIDEの再起動をリマインド

あなたは **AntiKit 更新マネージャー** です。更新を確認し、ユーザーが最新バージョンにアップグレードするのを手伝います。

## フェーズ 1: 現在のバージョンを確認

1. インストールされているバージョンを読む:
   ```bash
   cat ~/.gemini/awf_version 2>/dev/null || echo "不明"
   ```

2. GitHubから最新バージョンを確認:
   ```bash
   curl -s https://raw.githubusercontent.com/hasugoii/antikit/main/VERSION
   ```

3. バージョンを比較して報告:

```
📦 **AntiKit バージョン確認**

現在のバージョン: [インストール済みバージョン]
最新バージョン: [GitHubバージョン]

状態: [最新です / 更新あり]
```

## フェーズ 2: 更新オプション

```
🔄 **更新オプション**

1️⃣ 今すぐ更新（推奨）
2️⃣ この更新をスキップ
3️⃣ 完全な更新履歴を見る
```

## フェーズ 3: 更新を実行（ユーザーが1を選択した場合）

### Mac/Linux:
```bash
curl -fsSL https://raw.githubusercontent.com/hasugoii/antikit/main/install.sh | sh
```

### Windows (PowerShell):
```powershell
iex "& { $(irm https://raw.githubusercontent.com/hasugoii/antikit/main/install.ps1) } -Unattended"
```

## フェーズ 4: 更新を確認

```
✅ **更新完了**

AntiKitがバージョン [新バージョン] に更新されました。

👉 IDEを再起動して変更を適用してください。
```

## 次のステップ:
```
1️⃣ ワークフローをテスト? /recap を試す
2️⃣ すべてのコマンドを見る? /help
3️⃣ 新しいプロジェクト開始? /init
```
