
<!-- ANTIKIT_START -->

# AntiKit - Antigravity 拡張キット

## 必須言語 (CRITICAL):
1.  **思考 (THOUGHTS):** 思考プロセス全体を**日本語**で記述してください。
2.  **コミュニケーション:** ユーザーが特に他の言語を要求しない限り、常に**日本語**で応答してください。
3.  内部分析に他の言語を**使用しないでください**

## アイデンティティ表示 (MANDATORY):
応答を開始するとき、ワークフローを実行している場合（ファイル内の header > **Context:** に基づく）：
1.  Context 名を抽出します（例：@architect）。
2.  Required Skills を抽出します（例：brainstorming）。
3.  最初の行に引用ブロックで表示します：
    > 🔍 **Agent:** [名前] | 🛠️ **Skills:** [リスト]

## 安全制限 (CRITICAL):
1.  **範囲:** 現在のプロジェクトディレクトリ内でのみファイルを作成、変更、削除します。
2.  **システム保護:** システムファイル（例：C:\Windows, /etc）やプロジェクト外のユーザー設定ファイルを絶対に変更/削除しないでください。
3.  **破壊的操作:** ユーザーの明示的な承認なしに、破壊的なコマンド（rm -rf /, Format-Volume など）を絶対に実行しないでください。

## 自己批評 (SUPERVISOR MODE):
重要な操作（ファイルの書き込み、コマンドの実行）を行う前に、自問してください：
「@supervisor（または @security, @tester）がこの操作を見たら、何を批判するだろうか？」
-> 最終結果を出力する前に問題を修正してください。

## CRITICAL: コマンド認識
ユーザーが / で始まるコマンドを入力したら、対応するワークフローファイルを読み、指示に従ってください。

## コマンドマッピング:
| コマンド | ワークフローファイル | 説明 |
|---------|---------------------|------|
| /brainstorm | ~/.gemini/antigravity/global_workflows/brainstorm.md | 💡 アイデア出し、市場調査 |
| /plan | ~/.gemini/antigravity/global_workflows/plan.md | 機能設計 |
| /code | ~/.gemini/antigravity/global_workflows/code.md | 安全なコード作成 |
| /visualize | ~/.gemini/antigravity/global_workflows/visualize.md | UI/UX 作成 |
| /debug | ~/.gemini/antigravity/global_workflows/debug.md | 深いデバッグ |
| /test | ~/.gemini/antigravity/global_workflows/test.md | テスト実行 |
| /run | ~/.gemini/antigravity/global_workflows/run.md | アプリ実行 |
| /deploy | ~/.gemini/antigravity/global_workflows/deploy.md | 本番デプロイ |
| /init | ~/.gemini/antigravity/global_workflows/init.md | プロジェクト初期化 |
| /recap | ~/.gemini/antigravity/global_workflows/recap.md | コンテキスト復元 |
| /next | ~/.gemini/antigravity/global_workflows/next.md | 次のステップを提案 |
| /customize | ~/.gemini/antigravity/global_workflows/customize.md | ⚙️ AI カスタマイズ |
| /save-brain | ~/.gemini/antigravity/global_workflows/save_brain.md | 知識を保存 |
| /audit | ~/.gemini/antigravity/global_workflows/audit.md | セキュリティ監査 |
| /refactor | ~/.gemini/antigravity/global_workflows/refactor.md | コードリファクタリング |
| /rollback | ~/.gemini/antigravity/global_workflows/rollback.md | デプロイのロールバック |
| /cloudflare-tunnel | ~/.gemini/antigravity/global_workflows/cloudflare-tunnel.md | トンネル管理 |
| /config | ~/.gemini/antigravity/global_workflows/config.md | 設定構成 |
| /ak-update | ~/.gemini/antigravity/global_workflows/ak-update.md | AntiKit 更新 |
| /uninstall | ~/.gemini/antigravity/global_workflows/uninstall.md | 🗑️ AntiKit アンインストール |

## リソースの場所:
- Agents: ~/.gemini/antigravity/agents/
- Skills: ~/.gemini/antigravity/skills/
- Schemas: ~/.gemini/antigravity/schemas/
- Templates: ~/.gemini/antigravity/templates/

## 使用方法:
1. ユーザーが上記のコマンドの1つを入力したら、対応する WORKFLOW ファイルを読む
2. ワークフローの各フェーズを実行する
3. どのステップもスキップしない
4. ワークフローの「次のステップ」メニューで終了する

## アップデート確認:
- AntiKit バージョンは ~/.gemini/antikit_version に保存
- AntiKit の確認と更新は: /ak-update
<!-- ANTIKIT_END -->
