import { index, integer, pgTable, serial, timestamp } from "drizzle-orm/pg-core";
import { users } from "./users.schema.ts";

export const account_history = pgTable("account_history", {
  id: serial("id").primaryKey().notNull(),
  user_id: integer("user_id")
    .notNull()
    .references(() => users.id, { onDelete: "restrict" }),
  new_account: integer("new_account")
    .notNull()
    .references(() => users.id, { onDelete: "restrict" }),
  updated_at: timestamp("updated_at", { withTimezone: true })
    .defaultNow()
    .notNull(),
  permit_user_id: integer("permit_user_id")
    .notNull()
    .references(() => users.id, { onDelete: "restrict" }),
}, (table) => [
  index("idx_account_history_user_id").on(table.user_id),
]);
