---
description: プレビューサーバーの起動、停止、状態確認。ローカル開発サーバー管理。
---

# /preview - プレビュー管理

$ARGUMENTS

---

## タスク

プレビューサーバーの管理: 起動、停止、状態確認。

### コマンド

```
/preview           - 現在の状態を表示
/preview start     - サーバー起動
/preview stop      - サーバー停止
/preview restart   - 再起動
/preview check     - ヘルスチェック
```

---

## 使用例

### サーバー起動
```
/preview start

応答:
🚀 プレビューを起動中...
   ポート: 3000
   タイプ: Next.js

✅ プレビュー準備完了!
   URL: http://localhost:3000
```

### 状態確認
```
/preview

応答:
=== プレビュー状態 ===

🌐 URL: http://localhost:3000
📁 プロジェクト: /projects/my-app
🏷️ タイプ: nextjs
💚 ヘルス: OK
```

### ポート競合
```
/preview start

応答:
⚠️ ポート3000は使用中です。

オプション:
1. ポート3001で起動
2. ポート3000のアプリを閉じる
3. 別のポートを指定

どれにしますか？ (デフォルト: 1)
```

---

## 技術情報

自動プレビューは `auto_preview.py` スクリプトを使用:

```bash
python .agent/scripts/auto_preview.py start [port]
python .agent/scripts/auto_preview.py stop
python .agent/scripts/auto_preview.py status
```
