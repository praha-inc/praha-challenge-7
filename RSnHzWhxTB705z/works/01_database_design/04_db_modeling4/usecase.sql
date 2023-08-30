# noinspection SqlResolveForFile
# ↑IDEAでエラーを出さないための記述です。


# \! echo 'USECASE実行'

-- マネージャーがリマインドを登録する

SET @date = '2023-04-01 12:00:00';

-- 毎日
INSERT INTO t_reminders (send_user_id, frequency_id, frequency_value, content, reminded_at, created_at, updated_at) VALUES
    ('manager', 2, 1,  '退勤時に完了ボタンを押してください。', @date, @date, @date);
SET @reminder_id = (SELECT id FROM t_reminders ORDER BY id DESC LIMIT 1);
INSERT INTO t_target_users (reminder_id, target_user_id, created_at, updated_at) VALUES ( @reminder_id, 'engineer', @date, @date );
INSERT INTO t_target_users (reminder_id, target_user_id, created_at, updated_at) VALUES ( @reminder_id, 'designer', @date, @date );

-- X日おき
INSERT INTO t_reminders (send_user_id, frequency_id, frequency_value, content, reminded_at, created_at, updated_at) VALUES
    ('manager', 3, 14, 'エンジニアさん、今スプリントの共有をお願いします。', @date, @date, @date);
SET @reminder_id = (SELECT id FROM t_reminders ORDER BY id DESC LIMIT 1);
INSERT INTO t_target_users (reminder_id, target_user_id, created_at, updated_at) VALUES ( @reminder_id, 'engineer', @date, @date );

-- 毎週木曜日
INSERT INTO t_reminders (send_user_id, frequency_id, frequency_value, content, reminded_at, created_at, updated_at) VALUES
    ('manager', 4, 4,  'デザイナーさん、今週の勉強会の共有をお願いします。', @date, @date, @date);
SET @reminder_id = (SELECT id FROM t_reminders ORDER BY id DESC LIMIT 1);
INSERT INTO t_target_users (reminder_id, target_user_id, created_at, updated_at) VALUES ( @reminder_id, 'designer', @date, @date );

-- 毎月25日
INSERT INTO t_reminders (send_user_id, frequency_id, frequency_value, content, reminded_at, created_at, updated_at) VALUES
    ('manager', 5, 25, '25日は工数の締め日です。申請を忘れずにお願いします。', @date, @date, @date);
SET @reminder_id = (SELECT id FROM t_reminders ORDER BY id DESC LIMIT 1);
INSERT INTO t_target_users (reminder_id, target_user_id, created_at, updated_at) VALUES ( @reminder_id, 'engineer', @date, @date );
INSERT INTO t_target_users (reminder_id, target_user_id, created_at, updated_at) VALUES ( @reminder_id, 'designer', @date, @date );

SELECT * FROM t_reminders;
SELECT * FROM t_target_users;
