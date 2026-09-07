import { sql } from "drizzle-orm";
import {
  check,
  index,
  integer,
  pgTable,
  serial,
  timestamp,
} from "drizzle-orm/pg-core";
import { users } from "./users.schema.ts";

export const logins_history = pgTable("logins_history", {
  id: serial("id").primaryKey().notNull(),
  user_id: integer("user_id")
    .notNull()
    .references(() => users.id, { onDelete: "restrict" }),
  role: integer("role")
    .notNull()
    .references(() => users.id, { onDelete: "restrict" }),
  login: timestamp("login", { withTimezone: true })
    .defaultNow()
    .notNull(),
  logout: timestamp("logout", { withTimezone: true }),
}, (table) => [
  check(
    "logout_after_login_check",
    sql`${table.logout} IS NULL OR ${table.logout} >= ${table.login}`,
  ),
  index("user_logs_user_id_idx").on(table.user_id),
]);
