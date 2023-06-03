USE document_management;

-- ユーザー
DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  PRIMARY KEY(id)
) comment 'ユーザー';

-- ディレクトリ
DROP TABLE IF EXISTS directories CASCADE;
CREATE TABLE directories (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY(id)
) comment 'ディレクトリ';

-- ドキュメント
DROP TABLE IF EXISTS documents CASCADE;
CREATE TABLE documents (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL ,
  content TEXT,
  directory_id BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY (directory_id) REFERENCES directories(id) ON DELETE CASCADE
) comment 'ドキュメント';

-- ディレクトリとサブディレクトリの閉包テーブル
DROP TABLE IF EXISTS directory_tree_paths CASCADE;
CREATE TABLE directory_tree_paths (
  ancestor_directory_id BIGINT UNSIGNED,
  descendant_directory_id BIGINT UNSIGNED,
  PRIMARY KEY(ancestor_directory_id, descendant_directory_id),
  FOREIGN KEY (ancestor_directory_id) REFERENCES directories(id) ON DELETE CASCADE,
  FOREIGN KEY (descendant_directory_id) REFERENCES directories(id) ON DELETE CASCADE
) comment 'ディレクトリとサブディレクトリの閉包テーブル';

-- ディレクトリ作成
DROP TABLE IF EXISTS create_directory CASCADE;
CREATE TABLE create_directory (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  created_by BIGINT UNSIGNED NOT NULL,
  directory_id BIGINT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY(id),
  FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (directory_id) REFERENCES directories(id) ON DELETE CASCADE
) comment 'ディレクトリ作成';

-- ディレクトリ削除
DROP TABLE IF EXISTS delete_directory CASCADE;
CREATE TABLE delete_directory (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  deleted_by BIGINT UNSIGNED NOT NULL,
  directory_id BIGINT UNSIGNED NOT NULL,
  deleted_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY(id),
  FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (directory_id) REFERENCES directories(id) ON DELETE CASCADE
) comment 'ディレクトリ削除';

-- ディレクトリ更新
DROP TABLE IF EXISTS update_directory CASCADE;
CREATE TABLE update_directory (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  updated_by BIGINT UNSIGNED NOT NULL,
  directory_id BIGINT UNSIGNED NOT NULL,
  before_update_name VARCHAR(255) NOT NULL,
  before_update_ancestor_directory_id BIGINT UNSIGNED NOT NULL,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY(id),
  FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (directory_id) REFERENCES directories(id) ON DELETE CASCADE
) comment 'ディレクトリ更新';

-- ドキュメント作成
DROP TABLE IF EXISTS create_document CASCADE;
CREATE TABLE create_document (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  created_by BIGINT UNSIGNED NOT NULL,
  document_id BIGINT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY(id),
  FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (document_id) REFERENCES documents(id) ON DELETE CASCADE
) comment 'ドキュメント作成';

-- ドキュメント削除
DROP TABLE IF EXISTS delete_document CASCADE;
CREATE TABLE delete_document (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  deleted_by BIGINT UNSIGNED NOT NULL,
  document_id BIGINT UNSIGNED NOT NULL,
  deleted_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY(id),
  FOREIGN KEY (deleted_by) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (document_id) REFERENCES documents(id) ON DELETE CASCADE
) comment 'ドキュメント削除';

-- ドキュメント更新
DROP TABLE IF EXISTS update_document CASCADE;
CREATE TABLE update_document (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  updated_by BIGINT UNSIGNED NOT NULL,
  document_id BIGINT UNSIGNED NOT NULL,
  before_update_title VARCHAR(255) NOT NULL,
  before_update_content TEXT,
  before_update_ancestor_directory_id BIGINT UNSIGNED NOT NULL,
  before_update_position DOUBLE NOT NULL,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY(id),
  FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (document_id) REFERENCES documents(id) ON DELETE CASCADE
) comment 'ドキュメント更新';

-- ドキュメントの順番管理テーブル
DROP TABLE IF EXISTS document_order CASCADE;
CREATE TABLE document_order (
  directory_id BIGINT UNSIGNED NOT NULL,
  document_id BIGINT UNSIGNED NOT NULL,
  position DOUBLE NOT NULL,
  PRIMARY KEY(directory_id, document_id),
  FOREIGN KEY (directory_id) REFERENCES directories(id) ON DELETE CASCADE,
  FOREIGN KEY (document_id) REFERENCES documents(id) ON DELETE CASCADE
) comment 'ドキュメント順番管理テーブル';