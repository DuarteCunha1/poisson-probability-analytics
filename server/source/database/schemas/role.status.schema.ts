import {
    integer,
    pgTable,
    serial,
    timestamp,
} from "drizzle-orm/pg-core";
import { users } from "./users.schema.ts";

export const role_status = pgTable("role_status", {
    id: serial("id").primaryKey().notNull(),
    user_id: integer("user_id")
        .notNull()
        .references(() => users.id, { onDelete: "restrict" }),
    new_role: integer("new_role")
        .notNull()
        .references(() => users.id, { onDelete: "restrict" }),
    new_date: timestamp("new_date", { withTimezone: true })
        .defaultNow()
        .notNull(),
    permit_user_id: integer("permit_user_id")
        .notNull()
        .references(() => users.id, { onDelete: "restrict" }),
});