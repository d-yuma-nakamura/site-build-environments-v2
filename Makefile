# 開発サーバーを起動
dev:
	npm run dev

# ビルド
build:
	npm run build

# プレビュー
preview: build
	npm run preview

# フォーマッタ
format:
	npx prettier . --write

# リンタ
lint:
	npx eslint "src/**/*.{js,astro}" --fix && \
	npx stylelint "**/*.css" --allow-empty-input --fix

# テスト
test:
	npm test -- --passWithNoTests
