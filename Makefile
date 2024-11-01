# 依存関係のインストール
install:
	npm install

# 開発サーバーを起動
# 使用方法: make dev PROJECT=<プロジェクト名>
dev: install
	npm run dev -w sites/$(PROJECT)

# ビルド
# 使用方法: make build PROJECT=<プロジェクト名>
build: install
	npm run build -w sites/$(PROJECT)

# プレビュー
# 使用方法: make preview PROJECT=<プロジェクト名>
preview: build
	npm run preview -w sites/$(PROJECT)

# フォーマッタ
format:
	npx prettier . --write

# リンタ
lint:
	npx eslint "sites/**/src/**/*.{js,astro}" --fix && \
	npx stylelint "**/*.css" --allow-empty-input --fix

# テスト
test:
	npm test -- --passWithNoTests

# ＝＝＝＝＝プロジェクト作成時に使用するコマンド＝＝＝＝＝

# 新規プロジェクトを作成
# 使用方法: make create PROJECT=<プロジェクト名>
create:
	bash scripts/create-project.sh $(PROJECT)
