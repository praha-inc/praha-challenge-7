-- 新しいUserの作成
INSERT INTO users (id, webhook_url)
VALUES (4, 'https://hooks.slack.com/services/user4');
-- Userの削除
DELETE users 
FROM users
WHERE id = 4;

-- 新しいreminderの作成
INSERT INTO reminders (id, user_id, message, frequency_type, frequency_value)
VALUES (5, 1, '@user1 毎日のリマインダーです。', 0, NULL);

-- 自分が作成したreminderの一覧取得　(今回はuser_id 1)
SELECT reminders.*
FROM reminders
WHERE user_id = 1;


-- reminderの完了登録処理 == reminderの削除処理
DELETE reminders
FROM reminders 
WHERE id = 5
