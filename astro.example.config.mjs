// @ts-check
import { defineConfig } from "astro/config";
import mdx from "@astrojs/mdx";

// https://astro.build/config
export default defineConfig({
  // `make dev` と `make preview`実行時のサーバー設定
  server: {
    host: "127.0.0.1",
  },
  integrations: [mdx()],
});
