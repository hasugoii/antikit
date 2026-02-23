---
description: エージェントとプロジェクトの状態を表示。進捗追跡とステータスボード。
---

# /status - ステータス表示

$ARGUMENTS

---

## タスク

現在のプロジェクトとエージェントの状態を表示。

### 表示内容

1. **プロジェクト情報**
   - プロジェクト名とパス
   - 技術スタック
   - 現在の機能

2. **エージェントステータスボード**
   - 実行中のエージェント
   - 完了したタスク
   - 保留中の作業

3. **ファイル統計**
   - 作成されたファイル数
   - 変更されたファイル数

4. **プレビュー状態**
   - サーバーが稼働中か
   - URL
   - ヘルスチェック

---

## 出力例

```
=== プロジェクトステータス ===

📁 プロジェクト: my-ecommerce
📂 パス: /projects/my-ecommerce
🏷️ タイプ: nextjs-ecommerce
📊 ステータス: アクティブ

🔧 技術スタック:
   フレームワーク: next.js
   データベース: postgresql
   認証: clerk
   決済: stripe

✅ 機能 (5):
   • product-listing
   • cart
   • checkout
   • user-auth
   • order-history

⏳ 保留中 (2):
   • admin-panel
   • email-notifications

📄 ファイル: 73 作成, 12 変更

=== エージェントステータス ===

✅ database-architect → 完了
✅ backend-specialist → 完了
🔄 frontend-specialist → ダッシュボードコンポーネント (60%)
⏳ test-engineer → 待機中

=== プレビュー ===

🌐 URL: http://localhost:3000
💚 ヘルス: OK
```

---

## 技術情報

ステータスは以下のスクリプトを使用:
- `python .agent/scripts/session_manager.py status`
- `python .agent/scripts/auto_preview.py status`
