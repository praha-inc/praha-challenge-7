-- 各ユーザーが現在参加しているワークスペース一覧ビュー
CREATE VIEW current_join_workspaces_view(
  user_id, user_displayname, workspace_id, workspace_name, joined_at)
AS SELECT
  u.id AS user_id,
  u.display_name AS user_displayname,
  j_w.workspace_id AS workspace_id,
  w.name AS workspace_name,
  j_w.joined_at AS joined_at
FROM users u
INNER JOIN join_workspace j_w ON u.id = j_w.user_id
LEFT JOIN leave_workspace l_w ON u.id = l_W.user_id
	  AND j_w.workspace_id = l_w.workspace_id
INNER JOIN workspaces w ON j_w.workspace_id = w.id
WHERE j_w.joined_at > COALESCE(l_w.left_at, 0)
ORDER BY user_id;

-- 各ユーザーが現在参加しているチャンネル一覧ビュー
CREATE VIEW current_join_channels_view(
  user_id, user_displayname, channel_id, channel_name, joined_at)
AS SELECT
   u.id AS user_id,
   u.display_name AS user_displayname,
   j_c.channel_id AS channel_id,
   c.name AS channel_name,
   j_c.joined_at AS joined_at
FROM users u 
INNER JOIN  join_channel j_c ON u.id = j_c.user_id
LEFT JOIN  leave_channel l_c ON u.id = l_c.user_id
      AND  j_c.channel_id = l_c.channel_id
INNER JOIN channels c ON j_c.channel_id = c.id 
WHERE j_c.joined_at > COALESCE(l_c.left_at,0)
ORDER BY user_id;

-- 削除されていないチャンネルメッセージ一覧ビュー
CREATE VIEW displayed_channel_messages_view(channel_message_id, content, user_id, channel_id, posted_at, edited_at) AS
SELECT
  c_m.`id`,
  c_m.`content`,
  p_c_m.`user_id`,
  p_c_m.`channel_id`,
  p_c_m.`posted_at`,
  e_c_m.`edited_at`
FROM channel_messages c_m
INNER JOIN post_channel_message p_c_m ON c_m.id = p_c_m.channel_message_id
LEFT JOIN edit_channel_message e_c_m ON c_m.id = e_c_m.channel_message_id
LEFT JOIN delete_channel_message d_c_m ON c_m.id = d_c_m.channel_message_id
WHERE NOT EXISTS(
	SELECT 'X' FROM `delete_channel_message` d_c_m
	 WHERE d_c_m.`channel_message_id` = c_m.`id`
	 AND d_c_m.`deleted_at` IS NOT NULL
	 AND d_c_m.`deleted_at` >= COALESCE(e_c_m.`edited_at`, 0)
	)
ORDER BY `posted_at`, `channel_id`;

-- 削除されていないスレッドメッセージ一覧ビュー
CREATE VIEW displayed_thread_messages_view(thread_message_id, channel_id, channel_message_id, content, user_id, posted_at, edited_at) AS
SELECT
  t_m.`id`,
  p_c_m.`channel_id`,
  t_m.`channel_message_id`,
  t_m.`content`,
  p_t_m.user_id,
  p_t_m.`posted_at`,
  e_t_m.`edited_at`
FROM thread_messages t_m
INNER JOIN `post_thread_message` p_t_m ON t_m.`id` = p_t_m.`thread_message_id`
INNER JOIN `channel_messages` c_m ON t_m.`channel_message_id` = c_m.`id`
INNER JOIN `post_channel_message` p_c_m ON c_m.`id` = p_c_m.`channel_message_id`
LEFT JOIN `edit_thread_message` e_t_m ON t_m.`id` = e_t_m.`thread_message_id`
LEFT JOIN `delete_thread_message` d_t_m ON t_m.`id` = d_t_m.`thread_message_id`
LEFT JOIN `delete_channel_message` d_c_m ON t_m.`channel_message_id` = d_c_m.`channel_message_id`
WHERE NOT EXISTS(
	SELECT 'X' FROM `delete_thread_message` d_t_m
	 WHERE d_t_m.`thread_message_id` = t_m.`id`
	 AND d_t_m.`deleted_at` IS NOT NULL
	 AND d_t_m.`deleted_at` >= COALESCE(e_t_m.`edited_at`, 0)
	)
AND d_c_m.`deleted_at` IS NULL
ORDER BY `posted_at`, `channel_message_id`;

-- 「Team-1」チャンネルのメッセージやり取りを取得する
SELECT
  d_c_m_v.`channel_message_id` AS channel_message_id,
  d_c_m_v.content AS content,
  u.`display_name` AS username,
  d_c_m_v.`posted_at` AS posted_at,
  d_c_m_v.`edited_at` AS edited_at
FROM displayed_channel_messages_view d_c_m_v
INNER JOIN users u ON d_c_m_v.`user_id` = u.`id`
WHERE channel_id = 1
ORDER BY posted_at;

-- 「よろしく」が含まれているとメッセージを横断検索
-- ユーザーID：１のユーザーが所属しているチャンネルにあるメッセージ
SELECT
  messages.`channel_message_id`,
  messages.`thread_message_id`,
  messages.content
FROM
  ((SELECT
      d_c_m.`channel_message_id`,
      NULL AS thread_message_id,
      d_c_m.content
    FROM `displayed_channel_messages_view` d_c_m
    WHERE d_c_m.`channel_id` IN (
            SELECT channel_id
    		  FROM `current_join_channels_view`ß
    		  WHERE `user_id` = 1))
    UNION ALL
   (SELECT
      NULL AS channel_message_id,
	    d_t_m.`thread_message_id`,
	    d_t_m.content
    FROM `displayed_thread_messages_view` d_t_m
    WHERE d_t_m.`channel_id` IN (
            SELECT channel_id
    		FROM `current_join_channels_view`
    		WHERE `user_id` = 1)
    )) messages
WHERE content LIKE '%よろしく%';

-- ユーザーID：２のユーザー所属している各チャンネル内のユーザーを取得する
SELECT
  channel_id,
  channel_name,
  user_id,
  `user_displayname`
FROM`current_join_channels_view` cjcv
WHERE channel_id IN(
	   SELECT channel_id
	   FROM current_join_channels_view
	   WHERE user_id = 2)
ORDER BY channel_id;