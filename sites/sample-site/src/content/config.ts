// src/content/config.ts
import { defineCollection, z } from "astro:content";

const newsCollection = defineCollection({
  type: "content",
  schema: z.object({
    title: z.string(),
    pubDate: z.date(),
    description: z.string().optional(),
    author: z.string().optional(),
    image: z
      .object({
        url: z.string(),
        alt: z.string(),
      })
      .optional(),
    tags: z.array(z.string()).optional(),
  }),
});

export const collections = {
  news: newsCollection,
};
