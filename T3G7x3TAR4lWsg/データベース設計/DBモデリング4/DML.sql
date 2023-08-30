START TRANSACTION;
INSERT INTO Task 
( id, interval_type, interval_value, done, start_at, last_sent_at )
VALUES ( 1,'DAILY', 2, false, now(), now()),
( 2,'MONTHLY', 1, false, now(), now()),
( 3,'HOURLY', 1, false, now(), now()),
( 4,'DAILY', 1, false, now(), now()),
( 5,'DAILY', 1, false, now(), now());

INSERT INTO CommandLog 
(task_id, command, text, user_id, user_name, channel_id, channel_name, team_id, team_name, team_domain, enterprise_id, enterprise_name) 
VALUES 
(1, '/penpen', '会議資料の準備をお願いします @hirakawa', 'U0123', '佐藤一郎', 'C1234', 'general', 'T0123', 'チーム山田', 'team-domain1', 'E0123', 'エンタープライズ鈴木'),
(2, '/penpen', '明日のプレゼンの練習をしてください', 'U4567', '田中二郎', 'C5678', 'random', 'T4567', 'チーム佐藤', 'team-domain2', 'E4567', 'エンタープライズ田中'),
(3, '/penpen', 'クライアントへの報告書を作成してください', 'U8910', '山田三郎', 'C9101', '楽しい', 'T8910', 'チーム田中', 'team-domain3', 'E8910', 'エンタープライズ山田'),
(4, '/penpen', '@teamB 月次レポートの作成をお願いします', 'U1112', '鈴木四郎', 'C1213', 'general', 'T1112', 'チーム鈴木', 'team-domain4', 'E1112', 'エンタープライズ鈴木'),
(5, '/penpen', 'プロジェクトの進行状況を共有してください', 'U1314', '加藤五郎', 'C1415', 'random', 'T1314', 'チーム加藤', 'team-domain5', 'E1314', 'エンタープライズ加藤');

COMMIT;