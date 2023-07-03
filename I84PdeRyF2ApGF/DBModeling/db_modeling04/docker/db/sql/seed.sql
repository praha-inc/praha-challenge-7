-- サンプルデータ
-- リマインダー登録や通知の時系列の関係上、日付カラムには指定した値を入れています。
-- 実際は、CURRENT_TIMESTAMPで値が入る想定です。

-- ユーザー
INSERT INTO users (id, name, channel_id, created_at)
VALUES
  ('AS2145', 'Kenta', 'D069C7QFK', '2023-06-01 10:00:00'),
  ('JY7D3V', 'Taro',  'S063CH4YJ', '2023-06-01 11:00:00'),
  ('4QE7L2', 'John',  '5769T7QFL', '2023-06-02 13:00:00');

-- リマインダー
INSERT INTO reminders (id, created_by, message, frequency_pattern, nortification_day_interval, nortification_weekday, nortification_date, nortification_time, created_at, updated_at)
VALUES
  (DEFAULT, 'JY7D3V', '@Kenta @John 明日は週の振り返りMTGです every Thursday', 'WEEKDAY', NULL, 'THU', NULL, '17:00:00', '2023-06-02 13:00:00', '2023-06-02 13:00:00'),
  (DEFAULT, '4QE7L2', '交通費・立替経費の申請をしてください！ @Kenta @Taro every month 28th', 'MONTH', NULL, NULL, 28, '15:00:00', '2023-06-05 09:00:00', '2023-06-05 09:00:00'),
  (DEFAULT, 'AS2145', '@Taro 昨日のあれ、やっといてくださーい every 2 days', 'DAYS', 2, NULL, NULL, '09:00:00', '2023-06-10 16:00:00', '2023-06-10 16:00:00'),
  (DEFAULT, 'AS2145', '@Taro @John 研修資料の作成をお願いします！ every day', 'DAYS', 1, NULL, NULL, '10:00:00','2023-06-13 09:00:00' , '2023-06-13 09:00:00');

-- ユーザーに設定されているリマインダー
INSERT INTO user_reminders (id, user_id, reminder_id, status)
VALUES
  (DEFAULT, 'AS2145', 1, 'UNCOMPLETED'),
  (DEFAULT, '4QE7L2', 1, 'UNCOMPLETED'),
  (DEFAULT, 'AS2145', 2, 'UNCOMPLETED'),
  (DEFAULT, 'JY7D3V', 2, 'UNCOMPLETED'),
  (DEFAULT, 'JY7D3V', 3, 'UNCOMPLETED'),
  (DEFAULT, 'JY7D3V', 4, 'UNCOMPLETED'),
  (DEFAULT, '4QE7L2', 4, 'UNCOMPLETED');

-- リマインダー通知
INSERT INTO send_reminder (id, user_id, reminder_id, sent_at)
VALUES
  (DEFAULT, 'AS2145', 1, '2023-06-08 17:00:00'),
  (DEFAULT, '4QE7L2', 1, '2023-06-08 17:00:00'),
  (DEFAULT, 'JY7D3V', 3, '2023-06-12 09:00:00'),
  (DEFAULT, 'JY7D3V', 4, '2023-06-13 10:00:00'),
  (DEFAULT, '4QE7L2', 4, '2023-06-13 10:00:00'),
  (DEFAULT, 'JY7D3V', 3, '2023-06-14 09:00:00'),
  (DEFAULT, 'JY7D3V', 4, '2023-06-14 10:00:00'),
  (DEFAULT, '4QE7L2', 4, '2023-06-14 10:00:00'),
  (DEFAULT, 'JY7D3V', 4, '2023-06-15 10:00:00'),
  (DEFAULT, '4QE7L2', 4, '2023-06-15 10:00:00'),
  (DEFAULT, 'AS2145', 1, '2023-06-15 17:00:00'),
  (DEFAULT, '4QE7L2', 1, '2023-06-15 17:00:00');

-- リマインダー通知予定
INSERT INTO will_send_reminder (user_id, reminder_id, will_send_at)
VALUES
  ('AS2145', 1, '2023-06-22 17:00:00'),
  ('4QE7L2', 1, '2023-06-22 17:00:00'),
  ('AS2145', 2, '2023-06-28 15:00:00'),
  ('JY7D3V', 2, '2023-06-28 15:00:00'),
  ('JY7D3V', 3, '2023-06-16 09:00:00'),
  ('JY7D3V', 4, '2023-06-16 10:00:00'),
  ('4QE7L2', 4, '2023-06-16 10:00:00');
