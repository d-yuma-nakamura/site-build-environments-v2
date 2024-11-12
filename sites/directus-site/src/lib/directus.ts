import { createDirectus, rest } from "@directus/sdk";

type News = {
  id: number;
  title: string;
  publish_date: Date;
  description: string;
  subtitle: string;
  content: string;
  tags: string;
};

type Schema = {
  news: News[];
};

const directus = createDirectus<Schema>("http://localhost:8055/").with(rest());

export default directus;
