import { drizzle } from "drizzle-orm/node-postgres";
import { Pool } from "pg";
import * as schema from "./schemas/schemas.ts";

const connectionString = Deno.env.get("DATABASE_URL");

if (!connectionString) {
    throw new Error("A variável de ambiente DATABASE_URL não está configurada.");
}

export const client = new Pool({ connectionString });

export const db = drizzle(client, { schema });