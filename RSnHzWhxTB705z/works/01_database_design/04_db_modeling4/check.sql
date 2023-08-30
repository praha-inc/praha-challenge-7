# noinspection SqlResolveForFile
# ↑IDEAでエラーを出さないための記述です。

USE praha_igarashi_reminder_app;

DELIMITER //
DROP PROCEDURE IF EXISTS check_remind//
CREATE PROCEDURE check_remind (
    IN reminder_id INT UNSIGNED,
    IN ref_date DATETIME
)
    DETERMINISTIC
BEGIN

    SELECT
        CASE r.is_done
            WHEN 0 THEN '未実行'
            WHEN 1 THEN '実行済（確認用に出力）'
        END AS '実行済みか',
        CASE f.id
            WHEN 2 THEN
                CASE r.is_done = 0 AND r.reminded_at + INTERVAL 1 DAY <= ref_date AND HOUR(r.reminded_at) = HOUR(ref_date)
                    WHEN 1 THEN 'する'
                    ELSE 'しない'
                END
            WHEN 3 THEN
                CASE r.is_done = 0 AND r.reminded_at + INTERVAL 14 DAY <= ref_date AND HOUR(r.reminded_at) = HOUR(ref_date)
                    WHEN 1 THEN 'する'
                    ELSE 'しない'
                END
            WHEN 4 THEN
                CASE r.is_done = 0 AND (DAYOFWEEK(ref_date) - 1) = 4 AND HOUR(r.reminded_at) = HOUR(ref_date)
                    WHEN 1 THEN 'する'
                    ELSE 'しない'
                END
            WHEN 5 THEN
                CASE r.is_done = 0 AND DAY(ref_date) = 25 AND HOUR(r.reminded_at) = HOUR(ref_date)
                    WHEN 1 THEN 'する'
                    ELSE 'しない'
                END
        END AS '実行するか',
        r.id,
        r.send_user_id AS '送信者',
        r.content AS '内容',
        t.target_user_id AS '対象者',
        r.reminded_at AS '前回リマインド日時',
        ref_date AS 'バッチ日時',
        CASE f.id
            WHEN 2 THEN '毎日'
            WHEN 3 THEN 'X日おき'
            WHEN 4 THEN '毎週X曜日'
            WHEN 5 THEN '毎月X日'
        END AS '頻度'
    FROM t_reminders AS r
             LEFT JOIN t_target_users t on r.id = t.reminder_id
             LEFT JOIN m_frequencies f on r.frequency_id = f.id
    WHERE r.id = reminder_id
    ;
END//
DELIMITER ;

-- 毎日 --
SELECT ('毎日のリマインダーのチェック');

-- 1日経っていないため実行しない
CALL check_remind(1, '2023-04-02 11:00:00');

-- 1日経っているため実行する
CALL check_remind(1, '2023-04-02 12:00:00');

-- 2日経っていない（1日+1時間, 1日+23時間）ため実行しない
CALL check_remind(1, '2023-04-02 13:00:00');
CALL check_remind(1, '2023-04-03 11:00:00');

-- 2日経っているため実行する
CALL check_remind(1, '2023-04-03 12:00:00');

-- リマインダーを確認済みにする
UPDATE t_reminders SET is_done = 1 WHERE id = 1;

-- 2日経っているが、実行済みのため実行しない
CALL check_remind(1, '2023-04-03 12:00:00');

-- X日おき --
SELECT ('X日おきのリマインダーのチェック');

-- 14日経っていないため実行しない
CALL check_remind(2, '2023-04-14 12:00:00');
CALL check_remind(2, '2023-04-15 11:00:00');

-- 14日経っているため実行する
CALL check_remind(2, '2023-04-15 12:00:00');

-- リマインダーを確認済みにする
UPDATE t_reminders SET is_done = 1 WHERE id = 2;

-- 14日経っているが、実行済みのため実行しない
CALL check_remind(2, '2023-04-15 12:00:00');

-- 14日以上（X日以上）の場合はSQL文に渡す条件の値を変更する（今回は関数でまとめているためしない）

-- 毎週X曜日--
SELECT ('毎週X曜日のリマインダーのチェック');

-- 木曜日ではないため実行しない
CALL check_remind(3, '2023-04-05 12:00:00');

-- 木曜日だが、時間が実行する時間ではないため実行しない
CALL check_remind(3, '2023-04-06 11:00:00');

-- 木曜日のため実行する
CALL check_remind(3, '2023-04-06 12:00:00');

-- リマインダーを確認済みにする
UPDATE t_reminders SET is_done = 1 WHERE id = 3;

-- 木曜日だが、実行済みのため実行しない
CALL check_remind(3, '2023-04-06 12:00:00');

-- 毎月X日
SELECT ('毎月X日のリマインダーのチェック');

-- 25日ではないため実行しない
CALL check_remind(4, '2023-04-24 12:00:00');

-- 25日のため実行する
CALL check_remind(4, '2023-04-25 12:00:00');

-- 25日のため実行する
CALL check_remind(4, '2023-05-25 12:00:00');

-- リマインダーを確認済みにする
UPDATE t_reminders SET is_done = 1 WHERE id = 4;

-- 25日だが、実行済みのため実行しない
CALL check_remind(4, '2023-05-25 12:00:00');
