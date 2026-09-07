CREATE TABLE "accounts" (
	"id" serial PRIMARY KEY NOT NULL,
	"full_name" varchar(50) NOT NULL,
	"description" varchar(255),
	CONSTRAINT "accounts_full_name_unique" UNIQUE("full_name")
);
--> statement-breakpoint
CREATE TABLE "roles" (
	"id" serial PRIMARY KEY NOT NULL,
	"role" varchar(50) NOT NULL,
	"description" varchar(255),
	CONSTRAINT "roles_role_unique" UNIQUE("role")
);
--> statement-breakpoint
ALTER TABLE "account_status" RENAME TO "account_history";--> statement-breakpoint
ALTER TABLE "user_logs" RENAME TO "logins_history";--> statement-breakpoint
ALTER TABLE "role_status" RENAME TO "role_history";--> statement-breakpoint
ALTER TABLE "account_history" RENAME COLUMN "new_date" TO "updated_at";--> statement-breakpoint
ALTER TABLE "role_history" RENAME COLUMN "new_role" TO "new_role_id";--> statement-breakpoint
ALTER TABLE "role_history" RENAME COLUMN "new_date" TO "updated_at";--> statement-breakpoint
ALTER TABLE "logins_history" DROP CONSTRAINT "logout_after_login_check";--> statement-breakpoint
ALTER TABLE "account_history" DROP CONSTRAINT "account_status_user_id_users_id_fk";
--> statement-breakpoint
ALTER TABLE "account_history" DROP CONSTRAINT "account_status_new_account_users_role_fk";
--> statement-breakpoint
ALTER TABLE "account_history" DROP CONSTRAINT "account_status_permit_user_id_users_id_fk";
--> statement-breakpoint
ALTER TABLE "logins_history" DROP CONSTRAINT "user_logs_user_id_users_id_fk";
--> statement-breakpoint
ALTER TABLE "logins_history" DROP CONSTRAINT "user_logs_role_users_role_fk";
--> statement-breakpoint
ALTER TABLE "role_history" DROP CONSTRAINT "role_status_user_id_users_id_fk";
--> statement-breakpoint
ALTER TABLE "role_history" DROP CONSTRAINT "role_status_new_role_users_id_fk";
--> statement-breakpoint
ALTER TABLE "role_history" DROP CONSTRAINT "role_status_permit_user_id_users_id_fk";
--> statement-breakpoint
ALTER TABLE "users" ALTER COLUMN "role" SET DATA TYPE integer;--> statement-breakpoint
ALTER TABLE "users" ALTER COLUMN "role" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "users" ALTER COLUMN "account" SET DATA TYPE integer;--> statement-breakpoint
ALTER TABLE "users" ALTER COLUMN "account" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "users" ADD COLUMN "updated_at" timestamp with time zone DEFAULT now() NOT NULL;--> statement-breakpoint
ALTER TABLE "users" ADD COLUMN "deleted_at" timestamp with time zone;--> statement-breakpoint
ALTER TABLE "account_history" ADD CONSTRAINT "account_history_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE restrict ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "account_history" ADD CONSTRAINT "account_history_new_account_accounts_id_fk" FOREIGN KEY ("new_account") REFERENCES "public"."accounts"("id") ON DELETE restrict ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "account_history" ADD CONSTRAINT "account_history_permit_user_id_users_id_fk" FOREIGN KEY ("permit_user_id") REFERENCES "public"."users"("id") ON DELETE restrict ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "logins_history" ADD CONSTRAINT "logins_history_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE restrict ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "logins_history" ADD CONSTRAINT "logins_history_role_roles_id_fk" FOREIGN KEY ("role") REFERENCES "public"."roles"("id") ON DELETE restrict ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "role_history" ADD CONSTRAINT "role_history_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE restrict ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "role_history" ADD CONSTRAINT "role_history_new_role_id_roles_id_fk" FOREIGN KEY ("new_role_id") REFERENCES "public"."roles"("id") ON DELETE restrict ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "role_history" ADD CONSTRAINT "role_history_permit_user_id_users_id_fk" FOREIGN KEY ("permit_user_id") REFERENCES "public"."users"("id") ON DELETE restrict ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "users" ADD CONSTRAINT "users_role_roles_id_fk" FOREIGN KEY ("role") REFERENCES "public"."roles"("id") ON DELETE restrict ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "users" ADD CONSTRAINT "users_account_accounts_id_fk" FOREIGN KEY ("account") REFERENCES "public"."accounts"("id") ON DELETE restrict ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "idx_account_history_user_id" ON "account_history" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "user_logs_user_id_idx" ON "logins_history" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "idx_role_history_user_id" ON "role_history" USING btree ("user_id");--> statement-breakpoint
ALTER TABLE "logins_history" ADD CONSTRAINT "logout_after_login_check" CHECK ("logins_history"."logout" IS NULL OR "logins_history"."logout" >= "logins_history"."login");--> statement-breakpoint
DROP TYPE "public"."user_account";--> statement-breakpoint
DROP TYPE "public"."user_role";