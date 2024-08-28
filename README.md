# vscode 拡張機能管理

- ディレクトリごとに拡張機能を管理
- 一括削除
- 一括インストール

## ディレクトリ構造

```bash
.
├── .vscode
│   └── settings.json // このプロジェクト自体のvscode設定
├── .gitignore
├── README.md
├── <設定名>
│   ├── .vscode
│   │   └── settings.json
│   └── extensions.txt
└── install_extensions.sh
```

- ルートディレクトリ直下に管理したい名前をつけてディレクトリを作成する
- 作成したディレクトリ内に extensions.txt を作成する
- extensions.txt 内に一括インストールしたい拡張機能のコードを記述
- .vscode/settings.json 内に拡張機能に必要な設定を記述

## 使い方
- 一括アンイストール は ```-u```オプションをつける
```bash
# 一括アンインストールする
sh install_extensions.sh -u <設定名>

# 一括アンインストールしない
sh install_extensions.sh <設定名>
```

## 各環境説明
- 各環境の.vscode/settings.json は各環境での最低限のものを記述
- 組み合わせて使う

### basic
- 開発に必要な最低限の拡張

### web-basic
- HTML・CSS・JS
- フォーマッターをPrettier

### web-deno
- フォーマッターをdeno
