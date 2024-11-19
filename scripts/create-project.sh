#!/bin/bash

# プロジェクト名の取得と確認
PROJECT="$1"
if [ -z "$PROJECT" ]; then
  echo "エラー: プロジェクト名が指定されていません。"
  exit 1
fi

# プロジェクトディレクトリの設定と存在確認
PROJECT_DIR="sites/$PROJECT"
if [ -d "$PROJECT_DIR" ]; then
  echo "エラー: '$PROJECT_DIR' は既に存在しています。別のプロジェクト名を指定してください。"
  exit 1
fi

# Astroプロジェクトの作成
echo "プロジェクト '$PROJECT' を作成しています..."
if ! npm create astro@latest "$PROJECT_DIR" -- --no-git --typescript strict --install; then
  echo "エラー: Astroプロジェクトの作成に失敗しました。"
  exit 1
fi
echo "Astroプロジェクト '$PROJECT' が正常に作成されました。"

# astro設定ファイルのコピー
CONFIG_SRC="astro.example.config.mjs"
CONFIG_DEST="$PROJECT_DIR/astro.config.mjs"
echo "設定ファイルをコピーしています: $CONFIG_SRC -> $CONFIG_DEST"
if ! cp "$CONFIG_SRC" "$CONFIG_DEST"; then
  echo "エラー: 設定ファイルのコピーに失敗しました。"
  exit 1
fi
echo "設定ファイルが正常にコピーされました。"

# 開発サーバーの起動
echo "開発サーバーを起動しています..."
if ! npm run dev -w "$PROJECT_DIR"; then
  echo "エラー: 開発サーバーの起動に失敗しました。"
  exit 1
fi
