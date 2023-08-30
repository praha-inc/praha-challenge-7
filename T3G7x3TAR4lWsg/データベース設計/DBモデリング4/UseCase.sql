--- 新いスラッシュコマンドが届き、それをアプリケーション側で解析して新しくテーブルの行として挿入する

START TRANSACTION;
  INSERT INTO Task 
  ( id, interval_type, interval_value, done, start_at, last_sent_at )
  VALUES ( DEFAULT,'DAILY', 1, DEFAULT, now(), now());

  INSERT INTO CommandLog 
  (task_id, command, text, user_id, user_name, channel_id, channel_name, team_id, team_name, team_domain, enterprise_id, enterprise_name) 
  VALUES (LAST_INSERT_ID(), '/penpen', '取引先のミーティング資料の準備', 'U1404', '佐藤六郎', 'U1404', 'team3', 'T1044', 'チーム佐藤', 'team-domain5', 'E1314', 'エンタープライズ佐藤');

COMMIT;

--- 参考：次回送信予定日時を取得するSELECT
SELECT id,
interval_type,
interval_value,
last_sent_at,
  CASE interval_type
    WHEN 'HOURLY'   THEN DATE_ADD(last_sent_at, INTERVAL interval_value HOUR)
    WHEN 'DAILY'    THEN DATE_ADD(last_sent_at, INTERVAL interval_value DAY)
    WHEN 'MONTHLY'  THEN DATE_ADD(last_sent_at, INTERVAL interval_value MONTH)
    WHEN 'YEARLY'   THEN DATE_ADD(last_sent_at, INTERVAL interval_value YEAR)
    ELSE NULL
  END as will_send_at
FROM Task
WHERE done = FALSE;

--- 上記SELECTを応用して、1時間に1回のバッチ実行時に、1時間後の次回の送信予定をWillSendTaskにINSERTを行う
START TRANSACTION;
  INSERT INTO WillSendTask
  SELECT * FROM 
    (
      SELECT id,
      CASE interval_type
        WHEN 'HOURLY'   THEN DATE_ADD(last_sent_at, INTERVAL interval_value HOUR)
        WHEN 'DAILY'    THEN DATE_ADD(last_sent_at, INTERVAL interval_value DAY)
        WHEN 'MONTHLY'  THEN DATE_ADD(last_sent_at, INTERVAL interval_value MONTH)
        WHEN 'YEARLY'   THEN DATE_ADD(last_sent_at, INTERVAL interval_value YEAR)
        ELSE NULL
      END as will_send_at
    FROM Task
    WHERE done = FALSE
    )
    AS T_WillSendList
  WHERE T_WillSendList.will_send_at <= DATE_ADD(now(), INTERVAL 1 HOUR);

COMMIT;


--- 次回送信予定のタスク一覧
SELECT * FROM `WillSendTask`;

--- 送信成功したらWillSendTaskは削除し、SentTaskにログとしてINSERT。Taskのlast_sent_atを更新する
--- 厳密に言えばアプリケーション側でキューを作成して一行ずつ処理するのが妥当なやり方だと思う。
START TRANSACTION;
  INSERT INTO SentTask
  (id, task_id, sent_at)
  SELECT null, task_id, will_send_at FROM WillSendTask;
  
  UPDATE Task
  INNER JOIN WillSendTask ON WillSendTask.task_id = Task.id
  SET Task.last_sent_at = WillSendTask.will_send_at;

  DELETE FROM WillSendTask;

COMMIT;