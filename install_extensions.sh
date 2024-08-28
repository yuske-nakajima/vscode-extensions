#!/bin/bash

set -e  # コマンドがエラーで終了した場合、即座にスクリプトを終了

# 使用方法を表示する関数
print_usage() {
    echo "使用方法: $0 [-u] <ディレクトリ名>"
    echo "オプション:"
    echo "  -u    既存の拡張機能をアンインストールする"
    echo "例: $0 basic"
    echo "    $0 -u python"
}

# デフォルトでアンインストールしない
UNINSTALL=false

# オプション引数の処理
while getopts ":u" opt; do
  case ${opt} in
    u )
      UNINSTALL=true
      ;;
    \? )
      echo "無効なオプション: $OPTARG" 1>&2
      print_usage
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))

# ディレクトリ名が提供されているか確認
if [ $# -eq 0 ]; then
    print_usage
    exit 1
fi

DIR_NAME=$1
VSCODE_DIR="$DIR_NAME"
EXTENSIONS_FILE="$VSCODE_DIR/extensions.txt"

echo "$EXTENSIONS_FILE を確認中"

# extensions.txtファイルが存在するか確認
if [ ! -f "$EXTENSIONS_FILE" ]; then
    echo "エラー: $EXTENSIONS_FILE が見つかりません。"
    exit 1
fi

echo "$EXTENSIONS_FILE が見つかりました"

# extensions.txtの内容を表示
echo "$EXTENSIONS_FILE の内容:"
cat "$EXTENSIONS_FILE"

# アンインストールオプションが指定されている場合のみアンインストールを実行
if [ "$UNINSTALL" = true ]; then
    echo "現在インストールされている全ての拡張機能をアンインストールしています..."
    code --list-extensions | xargs -L 1 code --uninstall-extension
fi

# extensions.txtファイルから拡張機能を抽出
EXTENSIONS=$(awk -F ' // ' '{print $1}' "$EXTENSIONS_FILE" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

echo "抽出された拡張機能:"
echo "$EXTENSIONS"

# 各拡張機能をインストール（0.5秒の待ち時間付き）
echo "$EXTENSIONS" | while read -r EXT
do
    if [ -n "$EXT" ]; then
        echo "拡張機能をインストール中: $EXT"
        if code --install-extension "$EXT"; then
            echo "拡張機能 $EXT のインストールに成功しました。"
        else
            echo "警告: 拡張機能 $EXT のインストールに失敗しました。スキップして続行します。"
        fi
        sleep 0.5  # 0.5秒待機
    fi
done

echo "$DIR_NAME の拡張機能の処理が完了しました"
