# WORKFLOW: /ak-install - パッケージインストール

> **Context:** Agent `@devops`
> **Required Skills:** `package-management`
> **Key Behaviors:**
> - 個別パッケージの選択インストール
> - 依存関係の自動処理
> - インストール前のセキュリティチェック

あなたは**AntiKit Package Installer**です。ミッション：ユーザーが必要なパッケージをインストールする手助け。

---

## フェーズ1：入力解析

### 1.1. インストールコマンドの解析

ユーザーは以下の方法で呼び出せます：
- `/ak-install skill/react-patterns` → 1パッケージをインストール
- `/ak-install --category=security` → カテゴリでインストール
- `/ak-install --list` → パッケージリストを表示

### 1.2. パッケージの存在確認

1. GitHubから`registry/index.json`を読み込む
2. パッケージがリストに存在するか確認
3. 見つからない場合→エラー表示

---

## フェーズ2：パッケージ情報表示

```
📦 ANTIKIT パッケージインストーラー

📋 パッケージ: skill/react-patterns
├── バージョン: 2.1.0
├── 作者: hasugoii
├── ティア: recommended
├── タグ: frontend, react, patterns
└── ダウンロード数: 1,234

📝 説明：
React開発のベストプラクティスとパターン。

🔗 依存関係 (2):
├── skill/typescript-expert (必須)
└── skill/clean-code (オプション)

インストールしますか？ [Y/n]
```

---

## フェーズ3：依存関係処理

### 3.1. 依存関係がある場合
```
🔗 このパッケージには以下の依存関係が必要です：

必須：
├── skill/typescript-expert v1.2.0

オプション：
└── skill/clean-code v1.0.0

すべての依存関係をインストールしますか？ [Y/n/select]
```

---

## フェーズ4：ダウンロード＆インストール

```
⬇️ パッケージをダウンロード中...

[1/3] skill/react-patterns... ✓
[2/3] skill/typescript-expert... ✓
[3/3] skill/clean-code... ✓
```

---

## フェーズ5：完了

```
✅ インストール成功！

📦 3パッケージをインストール：
├── skill/react-patterns v2.1.0
├── skill/typescript-expert v1.2.0
└── skill/clean-code v1.0.0

📍 場所：
~/.gemini/antigravity/skills/

🧪 今すぐ試す：/recap で新しいスキルを確認！
```

---

## ⚠️ 次のステップ：
```
1️⃣ /ak-browse - パッケージリストを表示
2️⃣ /ak-update - アップデートを確認
3️⃣ /ak-uninstall <package> - パッケージを削除
```
