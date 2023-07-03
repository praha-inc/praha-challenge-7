CREATE SCHEMA modeling05;

-- テーブル作成
-- 筆者
DROP TABLE IF EXISTS modeling05.authors CASCADE;
CREATE TABLE modeling05.authors (
  id SERIAL,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id)
);

-- 記事の投稿
DROP TABLE IF EXISTS modeling05.post_article CASCADE;
CREATE TABLE modeling05.post_article (
  id SERIAL,
  posted_by SERIAL NOT NULL,
  title VARCHAR(255),
  content TEXT,
  posted_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id),  
  FOREIGN KEY(posted_by) REFERENCES modeling05.authors(id) ON DELETE RESTRICT
);

-- 記事
DROP TABLE IF EXISTS modeling05.articles CASCADE;
CREATE TABLE modeling05.articles (
  id SERIAL,
  post_article_id SERIAL NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY(post_article_id) REFERENCES modeling05.post_article(id) ON DELETE RESTRICT
);

-- 記事の編集
DROP TABLE IF EXISTS modeling05.edit_article CASCADE;
CREATE TABLE modeling05.edit_article (
  id SERIAL,
  article_id SERIAL NOT NULL,
  edited_by SERIAL NOT NULL,
  title VARCHAR(255),
  content TEXT,
  edited_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id),
  FOREIGN KEY(article_id) REFERENCES modeling05.articles(id) ON DELETE RESTRICT,
  FOREIGN KEY(edited_by) REFERENCES modeling05.authors(id) ON DELETE RESTRICT
);

-- 記事の削除
DROP TABLE IF EXISTS modeling05.delete_article CASCADE;
CREATE TABLE modeling05.delete_article (
  id SERIAL,
  article_id SERIAL NOT NULL,
  deleted_by SERIAL NOT NULL,
  deleted_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id),
  FOREIGN KEY(article_id) REFERENCES modeling05.articles(id) ON DELETE RESTRICT,
  FOREIGN KEY(deleted_by) REFERENCES modeling05.authors(id) ON DELETE RESTRICT
);