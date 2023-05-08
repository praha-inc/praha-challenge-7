-- ユーザー
DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE users (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  display_name VARCHAR(255) NOT NULL,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  PRIMARY KEY(id)
) comment 'ユーザー';

-- ワークスペース
DROP TABLE IF EXISTS workspaces CASCADE;

CREATE TABLE workspaces (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY(id)
) comment 'ワークスペース';

-- チャンネル
DROP TABLE IF EXISTS channels CASCADE;

CREATE TABLE channels (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  workspace_id BIGINT UNSIGNED NOT NULL ,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY (workspace_id) REFERENCES workspaces(id) ON DELETE CASCADE
) comment 'チャンネル';

-- ワークスペース参加
DROP TABLE IF EXISTS join_workspace CASCADE;

CREATE TABLE join_workspace (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  user_id BIGINT UNSIGNED NOT NULL,
  workspace_id BIGINT UNSIGNED NOT NULL,
  joined_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY(id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (workspace_id) REFERENCES workspaces(id) ON DELETE CASCADE
) comment 'ワークスペース参加';

-- ワークスペース脱退
DROP TABLE IF EXISTS leave_workspace CASCADE;

CREATE TABLE leave_workspace (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  user_id BIGINT UNSIGNED NOT NULL,
  workspace_id BIGINT UNSIGNED NOT NULL,
  left_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY(id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (workspace_id) REFERENCES workspaces(id) ON DELETE CASCADE
) comment 'ワークスペース脱退';

-- チャンネル参加
DROP TABLE IF EXISTS join_channel CASCADE;

CREATE TABLE join_channel (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  user_id BIGINT UNSIGNED NOT NULL,
  channel_id BIGINT UNSIGNED NOT NULL,
  joined_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY(id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (channel_id) REFERENCES channels(id) ON DELETE CASCADE
) comment 'チャンネル参加';

-- チャンネル脱退
DROP TABLE IF EXISTS leave_channel CASCADE;

CREATE TABLE leave_channel (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  user_id BIGINT UNSIGNED NOT NULL,
  channel_id BIGINT UNSIGNED NOT NULL,
  left_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY(id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (channel_id) REFERENCES channels(id) ON DELETE CASCADE
) comment 'チャンネル脱退';

-- チャンネルメッセージ
DROP TABLE IF EXISTS channel_messages CASCADE;

CREATE TABLE channel_messages (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  post_channel_message_id BIGINT UNSIGNED NOT NULL UNIQUE,
  content VARCHAR(255) NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY (post_channel_message_id) REFERENCES post_channel_message (id) ON DELETE CASCADE,
  INDEX index_channel_messages_on_content (content)
) comment 'チャンネルメッセージ';

-- スレッドメッセージ
DROP TABLE IF EXISTS thread_messages CASCADE;

CREATE TABLE thread_messages (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  channel_message_id BIGINT UNSIGNED NOT NULL,
  post_thread_message_id BIGINT UNSIGNED NOT NULL UNIQUE,
  content VARCHAR(255) NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY (channel_message_id) REFERENCES channel_messages(id) ON DELETE CASCADE,
  FOREIGN KEY (post_thread_message_id) REFERENCES post_thread_message (id) ON DELETE CASCADE,
  INDEX index_thread_messages_on_content (content)
) comment 'スレッドメッセージ';

-- チャンネルメッセージ投稿
DROP TABLE IF EXISTS post_channel_message CASCADE;

CREATE TABLE post_channel_message (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  user_id BIGINT UNSIGNED,
  channel_id BIGINT UNSIGNED,
  posted_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id, user_id, channel_id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (channel_id) REFERENCES channels(id) ON DELETE CASCADE,
  INDEX index_post_channel_message_on_posted_at (posted_at)
) comment 'チャンネルメッセージ投稿';

-- チャンネルメッセージ削除
DROP TABLE IF EXISTS delete_channel_message CASCADE;

CREATE TABLE delete_channel_message (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  channel_message_id BIGINT UNSIGNED,
  deleted_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id, channel_message_id),
  FOREIGN KEY (channel_message_id) REFERENCES channel_messages(id) ON DELETE CASCADE,
  INDEX index_delete_channel_message_on_deleted_at (deleted_at)
) comment 'チャンネルメッセージ削除';

-- チャンネルメッセージ編集
DROP TABLE IF EXISTS edit_channel_message CASCADE;

CREATE TABLE edit_channel_message (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  channel_message_id BIGINT UNSIGNED,
  before_edit_content VARCHAR(255) NOT NULL,
  edited_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id, channel_message_id),
  FOREIGN KEY (channel_message_id) REFERENCES channel_messages(id) ON DELETE CASCADE,
  INDEX index_edit_channel_message_on_edited_at (edited_at)
) comment 'チャンネルメッセージ編集';

-- スレッドメッセージ投稿
DROP TABLE IF EXISTS post_thread_message CASCADE;

CREATE TABLE post_thread_message (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  user_id BIGINT UNSIGNED,
  posted_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id, user_id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX index_post_thread_message_on_posted_at (posted_at)
) comment 'スレッドメッセージ投稿';

-- スレッドメッセージ削除
DROP TABLE IF EXISTS delete_thread_message CASCADE;

CREATE TABLE delete_thread_message (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  thread_message_id BIGINT UNSIGNED,
  deleted_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id, thread_message_id),
  FOREIGN KEY (thread_message_id) REFERENCES thread_messages(id) ON DELETE CASCADE,
  INDEX index_delete_thread_message_on_deleted_at (deleted_at)
) comment 'スレッドメッセージ削除';

-- スレッドメッセージ編集
DROP TABLE IF EXISTS edit_thread_message CASCADE;

CREATE TABLE edit_thread_message (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  thread_message_id BIGINT UNSIGNED,
  before_edit_content VARCHAR(255) NOT NULL,
  edited_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id, thread_message_id),
  FOREIGN KEY (thread_message_id) REFERENCES thread_messages(id) ON DELETE CASCADE,
  INDEX index_edit_thread_message_on_edited_at (edited_at)
) comment 'スレッドメッセージ編集';
