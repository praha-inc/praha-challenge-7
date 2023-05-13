-- usersテーブルにサンプルデータを追加
INSERT INTO users (id, webhook_url)
VALUES (1, 'https://hooks.slack.com/services/user1'),
        (2, 'https://hooks.slack.com/services/user2'),
        (3, 'https://hooks.slack.com/services/user3');

-- remindersテーブルにサンプルデータを追加
INSERT INTO reminders (id, user_id, message, frequency_type, frequency_value, last_sent_time)
VALUES (1, 1, '@channel 毎日のリマインダーです。', 0, NULL, '2023-04-20 09:00:00'),
        (2, 1, '@user1 毎週金曜日のリマインダーです。', 2, 5, '2023-04-14 9:00:00'),
        (3, 2, '3日ごとのリマインダーです。', 1, 3, '2023-04-18 9:00:00'),
        (4, 2, '毎月15日のリマインダーです。', 3, 15, '2023-03-15 9:00:00');