import { pgTable, serial, varchar } from "drizzle-orm/pg-core";

export const roles = pgTable("roles", {
    id: serial("id").primaryKey().notNull(),
    role: varchar("role", { length: 50 }).notNull().unique(),
    description: varchar("description", { length: 255 }),
});
