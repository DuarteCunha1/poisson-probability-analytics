ALTER TABLE "account_history" DROP CONSTRAINT "account_history_new_account_accounts_id_fk";
--> statement-breakpoint
ALTER TABLE "logins_history" DROP CONSTRAINT "logins_history_role_roles_id_fk";
--> statement-breakpoint
ALTER TABLE "role_history" DROP CONSTRAINT "role_history_new_role_id_roles_id_fk";
--> statement-breakpoint
ALTER TABLE "account_history" ADD CONSTRAINT "account_history_new_account_users_id_fk" FOREIGN KEY ("new_account") REFERENCES "public"."users"("id") ON DELETE restrict ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "logins_history" ADD CONSTRAINT "logins_history_role_users_id_fk" FOREIGN KEY ("role") REFERENCES "public"."users"("id") ON DELETE restrict ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "role_history" ADD CONSTRAINT "role_history_new_role_id_users_id_fk" FOREIGN KEY ("new_role_id") REFERENCES "public"."users"("id") ON DELETE restrict ON UPDATE no action;