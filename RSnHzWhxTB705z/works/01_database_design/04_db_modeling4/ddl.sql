-- DBを作成
DROP DATABASE IF EXISTS praha_igarashi_reminder_app;
CREATE DATABASE IF NOT EXISTS praha_igarashi_reminder_app CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE praha_igarashi_reminder_app;

# \! echo 'DDL実行'

-- テーブルを作成
CREATE TABLE `m_frequencies`
(
    id INT UNSIGNED NOT NULL CHECK ( id >= 1 AND id <= 5 ),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id)
);

CREATE TABLE `t_reminders`
(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    send_user_id VARCHAR(255) NOT NULL,
    frequency_id INT UNSIGNED NOT NULL,
    frequency_value INT UNSIGNED NOT NULL,
    content VARCHAR(1000) NOT NULL,
    is_done TINYINT(1) NOT NULL DEFAULT 0,
    reminded_at DATETIME NOT NULL DEFAULT (STR_TO_DATE(CONCAT(DATE(CURRENT_TIMESTAMP), ' ', HOUR(CURRENT_TIMESTAMP), ':00:00'), '%Y-%m-%d %H:%i:%s')),
    created_at DATETIME NOT NULL DEFAULT (STR_TO_DATE(CONCAT(DATE(CURRENT_TIMESTAMP), ' ', HOUR(CURRENT_TIMESTAMP), ':00:00'), '%Y-%m-%d %H:%i:%s')),
    updated_at DATETIME NOT NULL DEFAULT (STR_TO_DATE(CONCAT(DATE(CURRENT_TIMESTAMP), ' ', HOUR(CURRENT_TIMESTAMP), ':00:00'), '%Y-%m-%d %H:%i:%s')) ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),

    FOREIGN KEY (frequency_id) REFERENCES m_frequencies(id),

    CONSTRAINT frequency_value_validation CHECK
        (
            (frequency_id = 1 AND (frequency_value >= 1 AND frequency_value <= 168)) OR
            (frequency_id = 2 AND frequency_value = 1) OR
            (frequency_id = 3 AND (frequency_value >= 2 AND frequency_value <= 364)) OR
            (frequency_id = 4 AND (frequency_value >= 0 AND frequency_value <= 6)) OR
            (frequency_id = 5 AND (frequency_value >= 0 AND frequency_value <= 31))
        )
);

CREATE TABLE `t_target_users`
(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    reminder_id INT UNSIGNED NOT NULL,
    target_user_id VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),

    FOREIGN KEY (reminder_id) REFERENCES t_reminders(id)
);

SHOW FULL COLUMNS FROM m_frequencies;
SHOW FULL COLUMNS FROM t_reminders;
SHOW FULL COLUMNS FROM t_target_users;
