import { sql } from "drizzle-orm";
import {
    check,
    integer,
    pgTable,
    serial,
    timestamp,
} from "drizzle-orm/pg-core";
import { users } from "./users.schema.ts";

export const user_logs = pgTable("user_logs", {
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
},
    (table) => [
        check("logout_after_login_check", sql`${table.logout} IS NULL OR ${table.logout} >= ${table.login}`),
    ]
);