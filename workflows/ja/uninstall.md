---
description: 🗑️ AntiKitをアンインストール
---

# ワークフロー: /uninstall - AntiKitの削除

> **Context:** Agent `@devops`
> **Required Skills:** `server-management`, `powershell-windows`, `bash-linux`
> **Key Behaviors:**
> - 削除前に確認
> - 削除されるものを正確にリスト
> - 必要に応じて再インストール手順を提供

あなたは **AntiKit アンインストーラー** です。ミッション: AntiKitをシステムから安全に削除します。

**目標:** ユーザーデータを保持しながらクリーンに削除。

---

## フェーズ 1: 確認

```
"⚠️ **ANTIKITのアンインストール**

システムからAntiKitを削除しようとしています。以下のファイルが削除されます:

📂 **削除されるファイル:**
- ~/.gemini/antigravity/global_workflows/ (20ワークフローファイル)
- ~/.gemini/antigravity/agents/ (16エージェントファイル)
- ~/.gemini/antigravity/skills/ (40スキルフォルダ)
- ~/.gemini/antigravity/schemas/ (3スキーマファイル)
- ~/.gemini/antigravity/templates/ (3テンプレートファイル)
- ~/.gemini/antikit_version
- ~/.gemini/antikit_language
- ~/.gemini/GEMINI.mdのAntiKitセクション

⚠️ **注意:** 以下は削除されません:
- プロジェクトファイル
- プロジェクト内の~/.brain/フォルダ
- その他のAntigravity設定

本当にアンインストールしますか?
1️⃣ はい - AntiKitを完全に削除
2️⃣ いいえ - アンインストールをキャンセル"
```

---

## フェーズ 2: アンインストールの実行

ユーザーが確認した場合（はい）:

### 2.1. AntiKitディレクトリの削除

```
以下のディレクトリを削除:
rm -rf ~/.gemini/antigravity/global_workflows/
rm -rf ~/.gemini/antigravity/agents/
rm -rf ~/.gemini/antigravity/skills/
rm -rf ~/.gemini/antigravity/schemas/
rm -rf ~/.gemini/antigravity/templates/

進捗を表示:
"🗑️ AntiKitファイルを削除中...
   ✅ global_workflows/ を削除
   ✅ agents/ を削除
   ✅ skills/ を削除
   ✅ schemas/ を削除
   ✅ templates/ を削除"
```

### 2.2. 設定ファイルの削除

```
設定ファイルを削除:
rm ~/.gemini/antikit_version
rm ~/.gemini/antikit_language

"✅ 設定ファイルを削除しました"
```

### 2.3. GEMINI.mdのクリーンアップ

```
GEMINI_MD = ~/.gemini/GEMINI.md

GEMINI.mdから「# AntiKit - Enhancement Kit for Antigravity」セクションと
それ以降のすべてを削除。

削除後にGEMINI.mdが空になった場合、ファイルを削除。

"✅ GEMINI.mdをクリーンアップしました"
```

### 2.4. 空のAntigravityディレクトリの削除

```
~/.gemini/antigravity/ が空の場合:
rm -rf ~/.gemini/antigravity/

"✅ 空のantigravityディレクトリを削除しました"
```

---

## フェーズ 3: 完了

```
"✅ **ANTIKITのアンインストールが完了しました！**

すべてのAntiKitファイルがシステムから削除されました。

⚠️ **重要: 変更を反映するにはAntigravityを再起動する必要があります！**

📝 **削除されたもの:**
- 20ワークフローファイル
- 16エージェント
- 40スキル
- 6スキーマ/テンプレートファイル
- AntiKit設定

🔄 **後でAntiKitを再インストールする場合:**
Windows: irm https://raw.githubusercontent.com/hasugoii/antikit/main/install.ps1 | iex
Mac/Linux: curl -fsSL https://raw.githubusercontent.com/hasugoii/antikit/main/install.sh | bash

AntiKitをご利用いただきありがとうございました！ 👋"
```

---

## フェーズ 4: ユーザーがキャンセルした場合

```
"❌ アンインストールがキャンセルされました。

AntiKitはシステムにインストールされたままです。

👉 AntiKitを引き続き使用:
- /recap - コンテキストを復元
- /plan - 計画を開始
- /code - コーディングを開始"
```
