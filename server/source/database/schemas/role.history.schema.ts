import { index, integer, pgTable, serial, timestamp } from "drizzle-orm/pg-core";
import { users } from "./users.schema.ts";

export const role_history = pgTable("role_history", {
  id: serial("id").primaryKey().notNull(),
  user_id: integer("user_id")
    .notNull()
    .references(() => users.id, { onDelete: "restrict" }),
  new_role_id: integer("new_role_id")
      .notNull()
      .references(() => users.id, { onDelete: "restrict" }),
  updated_at: timestamp("updated_at", { withTimezone: true })
    .defaultNow()
    .notNull(),
  permit_user_id: integer("permit_user_id")
    .notNull()
    .references(() => users.id, { onDelete: "restrict" }),
}, (table) => [
  index("idx_role_history_user_id").on(table.user_id),
]);
