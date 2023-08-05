START TRANSACTION;
DROP TABLE IF EXISTS "Author" CASCADE;
DROP TABLE IF EXISTS "Post" CASCADE;
DROP TABLE IF EXISTS "History" CASCADE;

CREATE TABLE "Author" (
  "ID" SERIAL PRIMARY KEY,
  "name" varchar
);

CREATE TABLE "Post" (
  "ID" SERIAL PRIMARY KEY,
  "Title" varchar,
  "Content" Text,
  "Author" int,
  "Created_At" timestamp with time zone,
  "Update_At" timestamp with time zone,
  "Delete_At" timestamp with time zone
);

CREATE TABLE "History" (
  "ID" SERIAL PRIMARY KEY,
  "PostId" bigint,
  "Title" varchar,
  "Content" Text,
  "Author" int,
  "Update_At" timestamp with time zone
);


ALTER TABLE "Post" ADD FOREIGN KEY ("Author") REFERENCES "Author" ("ID");

ALTER TABLE "History" ADD FOREIGN KEY ("PostId") REFERENCES "Post" ("ID");

ALTER TABLE "History" ADD FOREIGN KEY ("Author") REFERENCES "Author" ("ID");

COMMIT;
