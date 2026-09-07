import { drizzle } from "drizzle-orm/node-postgres";
import { Pool } from "pg";
import * as schema from "./schemas/schemas.ts";

const connectionString = Deno.env.get("DATABASE_URL");

export const client = new Pool({ connectionString });

export const db = drizzle(client, { schema });
