import { pgTable, serial, varchar } from 'drizzle-orm/pg-core';

export const accounts = pgTable("accounts", {
    id: serial("id").primaryKey().notNull(),
    account: varchar("full_name", { length: 50 }).notNull().unique(),
    description: varchar("description", { length: 255 }),
});
