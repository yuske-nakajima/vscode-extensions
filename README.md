# vscode 拡張機能管理
- ディレクトリごとに拡張機能を管理
- 一括削除
- 一括インストール

## ディレクトリ構造
```bash
project_root/
├── basic/
│    └── extensions.txt
└── install_extensions.sh
```
- ルートディレクトリ直下に管理したい名前をつけてディレクトリを作成する
- 作成したディレクトリ内に extensions.txt を作成する
- extensions.txt 内に一括インストールしたい拡張機能のコードを記述

## 使い方
```bash
sh install_extensions.sh <設定名>
# 例
# sh install_extensions.sh basic
```

## 各環境説明
### basic
- 開発に必要な最低限の拡張

