// @ts-check
import { defineConfig } from "astro/config";

// https://astro.build/config
export default defineConfig({
  // `astro dev` と `astro preview`実行時の開発用サーバー設定
  server: {
    host: "127.0.0.1",
  },
});
