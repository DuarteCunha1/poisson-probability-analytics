CREATE TYPE "public"."user_account" AS ENUM('active', 'suspended', 'cancelled');--> statement-breakpoint
CREATE TYPE "public"."user_role" AS ENUM('guest', 'user', 'admin');--> statement-breakpoint
CREATE TABLE "account_status" (
	"id" serial PRIMARY KEY NOT NULL,
	"user_id" integer NOT NULL,
	"new_account" integer NOT NULL,
	"new_date" timestamp with time zone DEFAULT now() NOT NULL,
	"permit_user_id" integer NOT NULL
);
--> statement-breakpoint
CREATE TABLE "user_logs" (
	"id" serial PRIMARY KEY NOT NULL,
	"user_id" integer NOT NULL,
	"role" integer NOT NULL,
	"login" timestamp with time zone DEFAULT now() NOT NULL,
	"logout" timestamp with time zone,
	CONSTRAINT "logout_after_login_check" CHECK ("user_logs"."logout" IS NULL OR "user_logs"."logout" >= "user_logs"."login")
);
--> statement-breakpoint
CREATE TABLE "role_status" (
	"id" serial PRIMARY KEY NOT NULL,
	"user_id" integer NOT NULL,
	"new_role" integer NOT NULL,
	"new_date" timestamp with time zone DEFAULT now() NOT NULL,
	"permit_user_id" integer NOT NULL
);
--> statement-breakpoint
CREATE TABLE "users" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" varchar(100) NOT NULL,
	"email" varchar(255) NOT NULL,
	"password" varchar(255) NOT NULL,
	"role" "user_role" DEFAULT 'user' NOT NULL,
	"account" "user_account" DEFAULT 'active' NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "users_email_unique" UNIQUE("email"),
	CONSTRAINT "name_min_length_check" CHECK (length(trim("users"."name")) >= 3),
	CONSTRAINT "name_uppercase_check" CHECK ("users"."name" = upper("users"."name")),
	CONSTRAINT "name_no_surrounding_spaces_check" CHECK ("users"."name" = trim("users"."name")),
	CONSTRAINT "name_valid_chars_check" CHECK ("users"."name" ~* '^[A-ZÀ-ÖØ-ß ]+$'),
	CONSTRAINT "email_format_check" CHECK ("users"."email" ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
	CONSTRAINT "email_lowercase_check" CHECK ("users"."email" = lower("users"."email")),
	CONSTRAINT "email_no_surrounding_spaces_check" CHECK ("users"."email" = trim("users"."email")),
	CONSTRAINT "password_hash_min_length_check" CHECK (length("users"."password") >= 60),
	CONSTRAINT "password_no_whitespace_check" CHECK ("users"."password" !~ '\s')
);
--> statement-breakpoint
ALTER TABLE "account_status" ADD CONSTRAINT "account_status_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE restrict ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "account_status" ADD CONSTRAINT "account_status_new_account_users_role_fk" FOREIGN KEY ("new_account") REFERENCES "public"."users"("role") ON DELETE restrict ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "account_status" ADD CONSTRAINT "account_status_permit_user_id_users_id_fk" FOREIGN KEY ("permit_user_id") REFERENCES "public"."users"("id") ON DELETE restrict ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_logs" ADD CONSTRAINT "user_logs_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE restrict ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_logs" ADD CONSTRAINT "user_logs_role_users_role_fk" FOREIGN KEY ("role") REFERENCES "public"."users"("role") ON DELETE restrict ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "role_status" ADD CONSTRAINT "role_status_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE restrict ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "role_status" ADD CONSTRAINT "role_status_new_role_users_id_fk" FOREIGN KEY ("new_role") REFERENCES "public"."users"("id") ON DELETE restrict ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "role_status" ADD CONSTRAINT "role_status_permit_user_id_users_id_fk" FOREIGN KEY ("permit_user_id") REFERENCES "public"."users"("id") ON DELETE restrict ON UPDATE no action;