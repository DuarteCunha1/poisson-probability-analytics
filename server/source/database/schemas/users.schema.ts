import { sql } from "drizzle-orm";
import {
  check,
  integer,
  pgTable,
  serial,
  timestamp,
  varchar,
} from "drizzle-orm/pg-core";
import { roles } from "./role.schema.ts";
import { accounts } from "./account.schema.ts";

export const users = pgTable("users", {
  id: serial("id").primaryKey().notNull(),
  name: varchar("name", { length: 100 }).notNull(),
  email: varchar("email", { length: 255 }).notNull().unique(),
  password: varchar("password", { length: 255 }).notNull(),
  role: integer("role")
      .notNull()
      .references(() => roles.id, { onDelete: "restrict" }),
  account: integer("account")
      .notNull()
      .references(() => accounts.id, { onDelete: "restrict" }),
  created_at: timestamp("created_at", { withTimezone: true })
    .defaultNow()
    .notNull(),
  updated_at: timestamp("updated_at", { withTimezone: true }).defaultNow().notNull(),
  deleted_at: timestamp("deleted_at", { withTimezone: true }),
}, (table) => [
  check("name_min_length_check", sql`length(trim(${table.name})) >= 3`),
  check("name_uppercase_check", sql`${table.name} = upper(${table.name})`),
  check(
    "name_no_surrounding_spaces_check",
    sql`${table.name} = trim(${table.name})`,
  ),
  check("name_valid_chars_check", sql`${table.name} ~* '^[A-ZÀ-ÖØ-ß ]+$'`),
  check(
    "email_format_check",
    sql`${table.email} ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'`,
  ),
  check("email_lowercase_check", sql`${table.email} = lower(${table.email})`),
  check(
    "email_no_surrounding_spaces_check",
    sql`${table.email} = trim(${table.email})`,
  ),
  check("password_hash_min_length_check", sql`length(${table.password}) >= 60`),
  check("password_no_whitespace_check", sql`${table.password} !~ '\\s'`),
]);
