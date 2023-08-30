-- 新しいリマインダーの登録
-- 「/penpen @Kenta 新人教育の資料準備してね every day」
START TRANSACTION;

INSERT INTO reminders (id, created_by, message, frequency_pattern, nortification_day_interval, nortification_weekday, nortification_date, nortification_time, created_at, updated_at)
VALUES
  (DEFAULT, 'JY7D3V', '@Kenta 新人教育の資料準備してね every day', 'DAYS', 1, NULL, NULL, '10:00:00', '2023-06-17 08:00:00', '2023-06-17 08:00:00');

INSERT INTO user_reminders (id, user_id, reminder_id, status)
VALUES
  (DEFAULT, 'AS2145', (SELECT CURRVAL('reminders_id_seq')), DEFAULT);

INSERT INTO will_send_reminder (user_id, reminder_id, will_send_at)
VALUES
  ('AS2145', (SELECT CURRVAL('reminders_id_seq')), '2023-06-17 10:00');

COMMIT;

-- 自分(Kenta)に設定されているリマインダー一覧を表示
START TRANSACTION;

SELECT 
   u_r.user_id
  ,r.id
  ,r.created_by
  ,r.message
FROM user_reminders u_r
INNER JOIN reminders r ON u_r.status = 'UNCOMPLETED'
	   AND u_r.reminder_id = r.id
	   AND u_r.user_id = 'AS2145';

COMMIT;

-- 自分(Kenta)が設定しているリマインダー一覧を表示
START TRANSACTION;

SELECT
    u_r.user_id
   ,r.message
   ,r.created_at
FROM user_reminders u_r
INNER JOIN reminders r ON u_r.status = 'UNCOMPLETED'
       AND u_r.reminder_id = r.id
	   AND r.created_by = 'AS2145'
ORDER BY r.created_at ASC; 

COMMIT;
