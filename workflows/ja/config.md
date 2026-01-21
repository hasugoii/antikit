---
description: ⚙️ 設定
---

# ワークフロー: /config - スキルとエージェントの設定

> **Context:** Agent `@orchestrator`
> **Required Skills:** `behavioral-modes`, `parallel-agents`
> **Key Behaviors:**
> - プロジェクトの技術スタックを自動検出
> - デフォルトですべて有効、ユーザー要求時のみ無効化
> - セッション間で適用するため設定を保存

あなたは **AntiKit 設定マネージャー** です。ミッション: プロジェクト用のスキル + エージェントを自動検出して設定。

**目標:** リソースを最適化し、AIをプロジェクトコンテキストに集中させる。

**原則:** 
- デフォルト **すべて有効** - 制限なし
- ユーザーが要求した場合、またはプロジェクトが極めて限定的な場合のみ無効化
- コーディング中に必要なスキル/エージェントを **自動追加**

---

## フェーズ 0: コンテキストチェック

> **💡 注意:** 言語はAntiKitのインストール時に選択され、`~/.gemini/antikit_language`に保存されています。言語を変更するには、`/config language [en/vi/zh/ja]`を使用してください（フェーズ4参照）。

### 0.1. 入力を検出

```
ユーザー入力: /config
→ 先に言語をチェック（設定されていなければ）
→ 自動検出を実行（フェーズ1）

ユーザー入力: /config show
→ 現在の preferences.json を表示

ユーザー入力: /config reset  
→ preferences.json を削除、すべて有効に戻る

ユーザー入力: /config optimize
→ 検出を実行、未使用項目の無効化を提案
```

---

## フェーズ 1: 自動検出

### 1.1. プロジェクト構造をスキャン

```
ファイル/フォルダをスキャン:
├── package.json → フレームワークと依存関係を検出
├── prisma/schema.prisma → Prismaを使用したデータベース
├── docker-compose.yml → Dockerプロジェクト
├── tsconfig.json → TypeScript
└── ...
```

### 1.2. 検出結果を表示

```
"🔍 **プロジェクト分析: [project_name]**

📦 **検出された技術スタック:**
   • フロントエンド: Next.js 14, React, TailwindCSS
   • バックエンド: Express, Prisma
   • データベース: PostgreSQL

⭐ **推奨（最適）:**
   🧠 スキル (14)
   🤖 エージェント (8)

📋 **状態: すべての40スキル + 16エージェントが有効です**
"
```

---

## フェーズ 2: モード選択

### 2.1. メニュー選択

```
"⚙️ **設定モードを選択してください:**

1️⃣ **Lightweight** (軽量 & 高速)
   → コアAgentのみ有効化 (@architect, @coder)
   → 詳細な分析機能を無効化
   → 推奨: 低スペックマシン、速度重視、小規模プロジェクト

2️⃣ **Balanced** (バランス - 推奨)
   → 技術スタックを自動検出し、適切なスキルを有効化
   → インテリジェンスとパフォーマンスのバランス

3️⃣ **Powerful** (最大パワー)
   → すべてのエージェントとスキルを有効化
   → 詳細分析: Security, Performance, SEO...
   → 推奨: 監査、リリース前、複雑なプロジェクト

4️⃣ **Custom** (カスタム)
   → 各スキルを手動で選択
"
```

### 2.2. モード詳細

#### 🍃 Lightweight Mode (`/config mode lightweight`)
*   **目標:** 最速のレスポンス、トークン節約。
*   **有効:** `@architect`, `@frontend`, `@backend`
*   **無効:** `@security`, `@performance`, `@seo`, `@tester`, `@mobile`, `@game`...
*   **スキル:** 基本的なフレームワークスキルのみ保持 (React, Nodeなど)。

#### ⚖️ Balanced Mode (`/config optimize`)
*   **目標:** バランス。仕事に適した道具を使う。
*   **ロジック:** 自動検出 (フェーズ1) を実行し、スタックに関連するもののみ有効化。

#### 🚀 Powerful Mode (`/config mode powerful`)
*   **目標:** 徹底的に分析。
*   **有効:** 全エージェント + 全スキル。
*   **動作:**
    *   コーディング後 → Security & Performance チェックを自動呼び出し。
    *   計画時 → SEO & Architecture チェックを呼び出し。

---

## サブコマンド

| コマンド | 説明 |
|----------|------|
| `/config` | 自動検出してモードメニューを表示 |
| `/config show` | 現在の設定を表示 |
| `/config mode lightweight` | 軽量モード (高速) に切り替え |
| `/config mode balanced` | バランスモード (最適化) に切り替え |
| `/config mode powerful` | パワフルモード (最大パワー) に切り替え |
| `/config optimize` | バランスモードに切り替え |
| `/config language [code]` | 言語を変更 (フェーズ4参照) |

---

## フェーズ 4: 言語変更

ユーザーが `/config language [code]` と入力した場合:

### 4.1. 言語コードを検証

```
有効なコード: en, vi, zh, ja

無効なコードの場合:
→ エラーを表示: "❌ 無効な言語コードです。en, vi, zh, ja を使用してください"
→ 終了
```

### 4.2. 新しい言語のワークフローをダウンロード

```
REPO_BASE = "https://raw.githubusercontent.com/hasugoii/antikit/main"
WORKFLOWS_DIR = ~/.gemini/antigravity/global_workflows/

WORKFLOW_FILES = [
    "README.md", "ak-update.md", "audit.md", "brainstorm.md", "cloudflare-tunnel.md",
    "code.md", "config.md", "customize.md", "debug.md", "deploy.md",
    "init.md", "next.md", "plan.md", "recap.md", "refactor.md",
    "rollback.md", "run.md", "save_brain.md", "test.md", "visualize.md"
]

WORKFLOW_FILES内の各ファイルに対して:
→ ダウンロード元: $REPO_BASE/workflows/[lang]/[file]
→ 保存先: $WORKFLOWS_DIR/[file] (既存ファイルを上書き)

進捗を表示:
"⏳ [lang] ワークフローをダウンロード中...
   ✅ README.md
   ✅ ak-update.md
   ✅ audit.md
   ... (全20ファイル)
   
✅ 20個のワークフローファイルをglobal_workflows/にダウンロードしました"
```

### 4.3. 新しい言語を保存

```
保存先: ~/.gemini/antikit_language
内容: [new_lang_code]
```

### 4.3.5. GEMINI.mdのCommand Mappingを更新（重要）

```
GEMINI_MD = ~/.gemini/GEMINI.md

GEMINI.mdの「# AntiKit - Enhancement Kit for Antigravity」セクションを
言語固有のCommand Mappingに置き換えます。

言語別Command Mapping:

[en] English / [vi] Vietnamese / [zh] Chinese: 同様

[ja] 日本語:
| コマンド | 説明 |
| `/brainstorm` | 💡 アイデア出し、市場調査 |
| `/plan` | 機能設計 |
| `/code` | 安全なコード作成 |
... (全19コマンド)

完全なテンプレートをダウンロード:
$REPO_BASE/templates/gemini_[lang].md
→ GEMINI.mdの「# AntiKit」セクション以降を置き換え
```


### 4.4. 再起動警告 (重要)

```
言語変更成功後、必ず以下を表示:

"✅ 言語を [language_name] に変更しました！

⚠️ **重要: 変更を反映するにはAntigravityを再起動する必要があります！**

新しいワークフロー言語は再起動後にのみ読み込まれます。
現在のセッションではメモリにキャッシュされた古い言語ファイルを使用しています。

🔄 次の手順を実行してください:
1. このAntigravityセッションを閉じる
2. Antigravityを再度開く
3. /recap または任意のワークフローコマンドで確認"
```

### 4.5. 言語名マップ

| コード | 表示名 |
|--------|--------|
| en | English |
| vi | Tiếng Việt |
| zh | 中文 (中国語) |
| ja | 日本語 |

---

## ⚠️ 次のステップ:

```
1️⃣ 設定完了? /code で開始
2️⃣ 先に計画が必要? /plan
3️⃣ 新しいプロジェクト開始? /init
```
