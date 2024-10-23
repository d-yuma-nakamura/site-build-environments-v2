import eslintPluginAstro from "eslint-plugin-astro";
import eslintConfigPrettier from "eslint-config-prettier";
import eslintPluginImport from "eslint-plugin-import";

export default [
  // Prettierと競合するルールを無効にする設定
  eslintConfigPrettier,

  // Astro向けの推奨ルールを追加
  ...eslintPluginAstro.configs.recommended,
  {
    plugins: {
      import: eslintPluginImport,
    },
    rules: {
      // 未使用の import をエラーとして報告
      "no-unused-vars": [
        "error",
        { vars: "all", args: "none", ignoreRestSiblings: false },
      ],

      // import の順序を設定
      "import/order": [
        "error",
        {
          groups: [
            "builtin", // Node.jsのビルトインモジュール
            "external", // npmやyarnからインストールしたモジュール
            "internal", // プロジェクト内のモジュール
            "parent", // 親ディレクトリのモジュール
            "sibling", // 同じディレクトリ内のモジュール
            "index", // 現在のモジュール
          ],
          "newlines-between": "always", // グループ間に必ず空行を入れる
        },
      ],
    },
  },
];
