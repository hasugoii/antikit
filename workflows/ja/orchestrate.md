---
description: 複雑なタスクに複数のエージェントを調整。マルチパースペクティブ分析、包括的レビュー、異なるドメイン専門知識が必要なタスクに使用。
---

# マルチエージェント・オーケストレーション

あなたは **オーケストレーションモード** です。タスク: 専門エージェントを調整してこの複雑な問題を解決。

## オーケストレーション対象タスク
$ARGUMENTS

---

## 🔴 重要: 最低エージェント要件

> ⚠️ **オーケストレーション = 最低3つの異なるエージェント**
>
> 3つ未満 → オーケストレーションではなく単なる委任です。
>
> **完了前の検証:**
> - 呼び出したエージェント数をカウント
> - `agent_count < 3` の場合 → 停止してエージェントを追加
> - 単一エージェント = オーケストレーション失敗

### エージェント選択マトリックス

| タスクタイプ | 必須エージェント (最低) |
|-------------|----------------------|
| **Webアプリ** | frontend-specialist, backend-specialist, test-engineer |
| **API** | backend-specialist, security-auditor, test-engineer |
| **UI/デザイン** | frontend-specialist, seo-specialist, performance-optimizer |
| **データベース** | database-architect, backend-specialist, security-auditor |
| **フルスタック** | project-planner, frontend-specialist, backend-specialist, devops-engineer |
| **デバッグ** | debugger, explorer-agent, test-engineer |
| **セキュリティ** | security-auditor, penetration-tester, devops-engineer |

---

## 🔴 厳格な2フェーズ・オーケストレーション

### フェーズ1: 計画（順次実行 - 並列エージェントなし）

| ステップ | エージェント | アクション |
|---------|------------|----------|
| 1 | `project-planner` | docs/PLAN.md を作成 |
| 2 | (任意) `explorer-agent` | 必要に応じてコードベース調査 |

> 🔴 **計画中は他のエージェント禁止!**

### ⏸️ チェックポイント: ユーザー承認

```
PLAN.md完了後、確認:

「✅ 計画を作成しました: docs/PLAN.md

承認しますか? (Y/N)
- Y: 実装を開始
- N: 計画を修正します」
```

> 🔴 **明示的なユーザー承認なしにフェーズ2に進まないこと!**

### フェーズ2: 実装（承認後 - 並列エージェント）

| 並列グループ | エージェント |
|-------------|-----------|
| 基盤 | `database-architect`, `security-auditor` |
| コア | `backend-specialist`, `frontend-specialist` |
| 仕上げ | `test-engineer`, `devops-engineer` |

---

## 出力フォーマット

```markdown
## 🎼 オーケストレーションレポート

### タスク
[元のタスク概要]

### 呼び出したエージェント (最低3)
| # | エージェント | 担当領域 | ステータス |
|---|------------|---------|----------|
| 1 | project-planner | タスク分解 | ✅ |
| 2 | frontend-specialist | UI実装 | ✅ |
| 3 | test-engineer | 検証 | ✅ |

### まとめ
[全エージェント作業の統合概要]
```

---

## 🔴 終了ゲート

完了前に確認:
1. ✅ **エージェント数:** `invoked_agents >= 3`
2. ✅ **検証実行:** 少なくとも `security_scan.py` を実行
3. ✅ **レポート生成:** 全エージェントを含むレポート

**今すぐオーケストレーションを開始。3+エージェントを選択、実行、結果を統合。**
