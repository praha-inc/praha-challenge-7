START TRANSACTION;

SET foreign_key_checks = 0;

CREATE TABLE `Task` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `interval_type` ENUM ('HOURLY', 'DAILY', 'MONTHLY', 'YEARLY') NOT NULL COMMENT '期間',
  `interval_value` Int NOT NULL,
  `done` boolean DEFAULT false,
  `start_at` timestamp DEFAULT now(),
  `last_sent_at` timestamp DEFAULT now()
);

CREATE TABLE `CommandLog` (
  `task_id` bigint PRIMARY KEY AUTO_INCREMENT,
  `command` varchar(255),
  `text` varchar(255),
  `user_id` varchar(255),
  `user_name` varchar(255),
  `channel_id` varchar(255),
  `channel_name` varchar(255),
  `team_id` varchar(255),
  `team_name` varchar(255),
  `team_domain` varchar(255),
  `enterprise_id` varchar(255),
  `enterprise_name` varchar(255)
);

CREATE TABLE `WillSendTask` (
  `task_id` bigint,
  `will_send_at` timestamp DEFAULT now()
);

CREATE TABLE `SentTask` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `task_id` bigint,
  `sent_at` timestamp DEFAULT now()
);

ALTER TABLE `CommandLog` ADD FOREIGN KEY (`task_id`) REFERENCES `Task` (`id`);

ALTER TABLE `WillSendTask` ADD FOREIGN KEY (`task_id`) REFERENCES `Task` (`id`);

ALTER TABLE `SentTask` ADD FOREIGN KEY (`task_id`) REFERENCES `Task` (`id`);


SET foreign_key_checks = 1;
COMMIT;