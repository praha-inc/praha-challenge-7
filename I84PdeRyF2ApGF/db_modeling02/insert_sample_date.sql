-- ユーザー 
INSERT INTO `users` (`id`, `display_name`, `first_name`, `last_name`, `email`)
VALUES
	(DEFAULT, 'Kenta', 'Kenta', 'Hirakata', 'kenta@gmail.com'),
	(DEFAULT, 'Ichiro', 'Ichiro', 'Suzuki', 'ichiro51@gmail.com'),
	(DEFAULT, 'Taro.Y', 'Taro', 'Yamada', 'taro@gmail.com'),
	(DEFAULT, 'Kouji', 'Kouji', 'Yamamoto', 'kouji@gmail.com');

-- ワークスペース
INSERT INTO `workspaces` (`id`, `name`)
VALUES
	(DEFAULT, 'PrahaA'),
	(DEFAULT, 'PrahaB'),
	(DEFAULT, 'PrahaC');

-- チャンネル
INSERT INTO `channels` (`id`, `workspace_id`, `name`)
VALUES
	(DEFAULT, 1, 'Team-1'),
	(DEFAULT, 1, 'Team-2'),
	(DEFAULT, 2, 'Team-A'),
	(DEFAULT, 2, 'Team-B');

-- チャンネルメッセージ
INSERT INTO `channel_messages` (`id`, `content`)
VALUES
	(DEFAULT, 'こんにちは！'),
	(DEFAULT, 'いい天気ですね！'),
	(DEFAULT, 'お元気ですか？'),
	(DEFAULT, '初めまして！よろしくお願いいたします。'),
	(DEFAULT, 'こちらこそよろしくお願いいたします。'),
	(DEFAULT, '好きな食べ物はなんですか？'),
	(DEFAULT, '教えません。'),
	(DEFAULT, 'それは残念です。'),
	(DEFAULT, 'これからよろしくおねがいします！');

-- スレッドメッセージ
INSERT INTO `thread_messages` (`id`, `channel_message_id`, `content`)
VALUES
	(DEFAULT, 1, '曇りですけどね。'),
	(DEFAULT, 1, 'そうですね。ごめんなさい。'),
	(DEFAULT, 1, '大丈夫です'),
	(DEFAULT, 9, 'よろしくです！');

-- ワークスペース参加
INSERT INTO `join_workspace` (`id`, `user_id`, `workspace_id`, `joined_at`)
VALUES
	(DEFAULT, 1, 1, '2023-04-21 23:52:32'),
	(DEFAULT, 2, 1, '2023-04-21 23:53:56'),
	(DEFAULT, 3, 1, '2023-04-21 23:54:10'),
	(DEFAULT, 2, 2, '2023-04-21 23:54:22'),
	(DEFAULT, 4, 2, '2023-04-21 23:54:33'),
	(DEFAULT, 3, 2, '2023-04-21 23:55:11'),
	(DEFAULT, 1, 2, '2023-04-21 23:55:23'),
	(DEFAULT, 2, 3, '2023-04-21 23:55:34'),
	(DEFAULT, 3, 3, '2023-04-21 23:55:42'),
	(DEFAULT, 4, 3, '2023-04-22 00:05:31');

--　ワークスペース脱退
INSERT INTO `leave_workspace` (`id`, `user_id`, `workspace_id`, `left_at`)
VALUES
	(DEFAULT, 1, 2, '2023-04-22 00:01:39');

-- チャンネル参加
INSERT INTO `join_channel` (`id`, `user_id`, `channel_id`, `joined_at`)
VALUES
	(DEFAULT, 1, 1, '2023-04-22 00:00:17'),
	(DEFAULT, 2, 1, '2023-04-22 00:00:45'),
	(DEFAULT, 1, 2, '2023-04-22 00:00:57'),
	(DEFAULT, 3, 2, '2023-04-22 00:01:18'),
	(DEFAULT, 1, 3, '2023-04-22 00:03:23'),
	(DEFAULT, 2, 3, '2023-04-22 00:03:40'),
	(DEFAULT, 3, 3, '2023-04-22 00:03:49'),
	(DEFAULT, 4, 3, '2023-04-22 00:04:06'),
	(DEFAULT, 2, 4, '2023-04-22 00:04:31'),
	(DEFAULT, 3, 4, '2023-04-22 00:04:41');

-- チャンネル脱退
INSERT INTO `leave_channel` (`id`, `user_id`, `channel_id`, `left_at`)
VALUES
	(DEFAULT, 4, 3, '2023-04-22 00:06:00');

-- チャンネルメッセージ投稿
INSERT INTO `post_channel_message` (`id`, `user_id`, `channel_id`, `channel_message_id`, `posted_at`)
VALUES
	(DEFAULT, 1, 1, 1, '2023-04-22 00:09:08'),
	(DEFAULT, 2, 1, 2, '2023-04-22 00:12:13'),
	(DEFAULT, 1, 1, 3, '2023-04-22 00:12:32'),
	(DEFAULT, 2, 3, 4, '2023-04-22 00:22:54'),
	(DEFAULT, 3, 3, 5, '2023-04-22 00:25:43'),
	(DEFAULT, 4, 3, 6, '2023-04-22 00:26:24'),
	(DEFAULT, 2, 3, 7, '2023-04-22 00:26:38'),
	(DEFAULT, 4, 3, 8, '2023-04-24 15:16:32'),
	(DEFAULT, 1, 1, 9, '2023-04-24 17:13:44');

-- チャンネルメッセージ削除
INSERT INTO `delete_channel_message` (`id`, `channel_message_id`, `deleted_at`)
VALUES
	(DEFAULT, 3, '2023-04-22 09:49:47'),
	(DEFAULT, 8, '2023-04-24 15:57:14');

-- チャンネルメッセージ編集
INSERT INTO `edit_channel_message` (`id`, `channel_message_id`, `before_edit_content`, `edited_at`)
VALUES
	(DEFAULT, 1, 'Hello!', '2023-04-22 09:48:45');

-- スレッドメッセージ投稿
INSERT INTO `post_thread_message` (`id`, `user_id`, `thread_message_id`, `posted_at`)
VALUES
	(DEFAULT, 1, 1, '2023-04-22 00:29:06'),
	(DEFAULT, 2, 2, '2023-04-22 00:29:13'),
	(DEFAULT, 2, 3, '2023-04-24 17:16:03'),
	(DEFAULT, 2, 4, '2023-04-24 17:15:07');

-- スレッドメッセージ削除
INSERT INTO `delete_thread_message` (`id`, `thread_message_id`, `deleted_at`)
VALUES
	(DEFAULT, 3, '2023-04-24 23:07:11');

-- スレッドメッセージ編集
INSERT INTO `edit_thread_message` (`id`, `thread_message_id`, `before_edit_content`, `edited_at`)
VALUES
	(DEFAULT, 1, '晴れですね。', '2023-04-22 09:59:10');
