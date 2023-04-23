USE store_development;

CREATE TABLE users (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  avatar_url VARCHAR(255),
  PRIMARY KEY(id)
) COMMENT="ログインユーザー";

ALTER TABLE users RENAME INDEX email TO index_users_on_email;

CREATE TABLE work_spaces (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  created_by BIGINT UNSIGNED,
  PRIMARY KEY(id),
  FOREIGN KEY(created_by) REFERENCES users(id) ON DELETE SET NULL
) COMMENT="ワークスペース";

CREATE TABLE user_work_spaces (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  user_id BIGINT UNSIGNED,
  work_space_id BIGINT UNSIGNED,
  PRIMARY KEY(id),
  FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY(work_space_id) REFERENCES work_spaces(id) ON DELETE CASCADE,
  UNIQUE composite_index_user_work_spaces (user_id, work_space_id)
) COMMENT="ユーザーが所属しているワークスペース";

CREATE TABLE chat_channels (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  is_public BOOLEAN NOT NULL DEFAULT 1,
  user_id BIGINT UNSIGNED,
  created_by BIGINT UNSIGNED,
  work_space_id BIGINT UNSIGNED,
  PRIMARY KEY(id),
  FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY(created_by) REFERENCES users(id) ON DELETE SET NULL,
  FOREIGN KEY(work_space_id) REFERENCES work_spaces(id) ON DELETE CASCADE
) COMMENT="チャンネル";

CREATE TABLE user_chat_channels (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  user_id BIGINT UNSIGNED,
  chat_channel_id BIGINT UNSIGNED,
  PRIMARY KEY(id),
  FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY(chat_channel_id) REFERENCES chat_channels(id) ON DELETE CASCADE,
  UNIQUE composite_index_user_chat_channels (user_id, chat_channel_id)
) COMMENT="ユーザーが所属しているチャンネル";

CREATE TABLE chat_threads (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id)
) COMMENT="スレッド";

CREATE TABLE user_chat_threads (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  user_id BIGINT UNSIGNED,
  chat_thread_id BIGINT UNSIGNED,
  PRIMARY KEY(id),
  FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY(chat_thread_id) REFERENCES chat_threads(id) ON DELETE CASCADE,
  UNIQUE composite_index_user_chat_threads (user_id, chat_thread_id)
) COMMENT="ユーザーが含まれているスレッド";

-- スレッドがないなら、chat_thread_idはNULL
CREATE TABLE chat_messages (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  body VARCHAR(255) NOT NULL,
  send_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  user_id BIGINT UNSIGNED,
  chat_channel_id BIGINT UNSIGNED,
  chat_thread_id BIGINT UNSIGNED,
  PRIMARY KEY(id),
  FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY(chat_channel_id) REFERENCES chat_channels(id) ON DELETE CASCADE,
  FOREIGN KEY(chat_thread_id) REFERENCES chat_threads(id) ON DELETE CASCADE
) COMMENT="チャットメッセージ";

CREATE TABLE chat_message_families (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  parent_id BIGINT UNSIGNED,
  child_id BIGINT UNSIGNED,
  PRIMARY KEY(id),
  FOREIGN KEY(parent_id) REFERENCES chat_messages(id) ON DELETE CASCADE,
  FOREIGN KEY(child_id) REFERENCES chat_messages(id) ON DELETE CASCADE,
  UNIQUE composite_index_chat_message_families (parent_id, child_id)
) COMMENT="チャットメッセージの親子関係を表すテーブル";