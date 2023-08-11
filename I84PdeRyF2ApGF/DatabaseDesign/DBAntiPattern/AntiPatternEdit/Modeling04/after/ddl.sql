-- DB作成
CREATE DATABASE modeling04;

\c modeling04;

-- テーブル作成
-- ユーザー
DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users (
  id VARCHAR(255),
  name VARCHAR(255) NOT NULL,
  channel_id VARCHAR(255) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id)
);

-- チーム（ワークスペース）
DROP TABLE IF EXISTS teams CASCADE;
CREATE TABLE teams (
  id VARCHAR(255),
  name VARCHAR(255) NOT NULL,
  access_token VARCHAR(255) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id)
);

-- [FIX]リマインダー
DROP TABLE IF EXISTS reminders CASCADE;
CREATE TABLE reminders (
  id SERIAL,
  created_by VARCHAR(255) NOT NULL,
  message VARCHAR(255) NOT NULL,
  frequency_pattern_id SERIAL NOT NULL,
  nortification_day_interval INT NOT NULL,
  nortification_time TIME NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id),
  FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE,
  CHECK (nortification_day_interval > 0)
);

-- [ADD]頻度
DROP TABLE IF EXISTS frequecy_patterns CASCADE;
CREATE TABLE frequency_patterns (
  id SERIAL,
  frequency VARCHAR(255) NOT NULL
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id) 
);

-- [FIX]ユーザーに設定されているリマインダー
DROP TABLE IF EXISTS user_reminders CASCADE;
CREATE TABLE user_reminders(
  id SERIAL,
  user_id VARCHAR(255) NOT NULL,
  reminder_id SERIAL NOT NULL,
  completed_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (reminder_id) REFERENCES reminders(id) ON DELETE CASCADE,
  UNIQUE (user_id, reminder_id),
);

-- リマインダー通知
DROP TABLE IF EXISTS send_reminder CASCADE;
CREATE TABLE send_reminder(
  id SERIAL,
  user_id VARCHAR(255) NOT NULL,
  reminder_id SERIAL NOT NULL,
  sent_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (reminder_id) REFERENCES reminders(id) ON DELETE CASCADE
);

-- リマインダー通知予定
DROP TABLE IF EXISTS will_send_reminder CASCADE;
CREATE TABLE will_send_reminder(
  user_id VARCHAR(255),
  reminder_id SERIAL,
  will_send_at TIMESTAMP WITH TIME ZONE NOT NULL,
  PRIMARY KEY(user_id, reminder_id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (reminder_id) REFERENCES reminders(id) ON DELETE CASCADE
);