-- DBを選択
USE praha_slack;

-- 全ユーザーを取得
SELECT * FROM users
ORDER BY name;

-- 全ワークスペースを取得
SELECT * FROM workspaces WHERE is_deleted = 0
ORDER BY name;

-- ワークスペース「praha2」から全チャンネルを取得
SELECT * FROM channels
WHERE workspace_id = 'c7c12e0d-9e9e-4c8c-b6d1-b6c4a4e4f008'
    AND is_deleted = 0
ORDER BY name;

-- チャンネル名から特定のチャンネル情報を取得
SELECT * FROM channels
WHERE workspace_id = 'c7c12e0d-9e9e-4c8c-b6d1-b6c4a4e4f008'
    AND name = 'general'
    AND is_deleted = 0;

-- あるユーザーが参加している全チャンネルを取得
SELECT
    c.id AS c_id,
    c.name AS c_name,
    c.created_at AS c_created_at,
    c.updated_at AS c_updated_at,
    uc.user_id AS uc_user_id,
    uc.created_at AS uc_created_at,
    uc.updated_at AS uc_updated_at
FROM channels AS c
    LEFT JOIN users_channels AS uc
        ON c.id = uc.channel_id
WHERE uc.user_id = 'f0cb2f79-9bf9-456e-b74c-1c65412be1df'
    AND c.is_deleted = 0
    AND uc.is_deleted = 0
ORDER BY c.name;

-- ある特定のチャンネルの全メッセージを取得
SELECT
       m.*,
       u.name AS userName,
       c.name as channelName
FROM messages AS m
    LEFT JOIN users AS u
        ON m.user_id = u.id
    LEFT JOIN channels AS c
        ON m.channel_id = c.id
WHERE m.channel_id = '0eef0129-3b18-47d3-9f01-44dc2e682670'
    AND m.is_deleted = 0
ORDER BY m.created_at;

-- ある特定のメッセージに紐づくスレッドメッセージを取得
SELECT tm.*, u.name AS userName FROM thread_messages AS tm
    LEFT JOIN messages AS m
        ON tm.message_id = m.id
    LEFT JOIN users AS u
        ON tm.user_id = u.id
WHERE m.id = '5ae27bb1-8085-442f-8206-49ec17bd4f8d'
    AND m.is_deleted = 0
ORDER BY tm.created_at;

-- 指定したチャンネル内のメッセージからキーワードを検索
SELECT
    m.id,
    m.user_id,
    m.channel_id,
    m.content,
    m.created_at,
    m.updated_at,
    c.name AS channelName,
    u.name AS userName
FROM messages AS m
    LEFT JOIN channels AS c
        ON m.channel_id = c.id
    LEFT JOIN users AS u
        ON m.user_id = u.id
WHERE m.channel_id IN (
    '0eef0129-3b18-47d3-9f01-44dc2e682670',
    '3a8803cc-3083-41b9-9b18-1b13dc7d236e',
    '38e4c77b-ec8b-4a4e-a85d-10a1142e8f52',
    '0cc0c065-7b70-4b1c-81d6-47a54bfa9986',
    'd8b1394a-4c7f-4a37-81d1-57d80ce23108'
    )
AND m.is_deleted = 0
AND m.content LIKE '%PHP%'
ORDER BY m.created_at;


-- 指定したメッセージに紐づくスレッドメッセージからキーワードを検索
SELECT
    tm.id,
    tm.user_id,
    tm.content,
    tm.created_at,
    tm.updated_at,
    c.name AS channelName,
    u.name AS userName
FROM thread_messages AS tm
    LEFT JOIN messages AS m
        ON tm.message_id = m.id
    LEFT JOIN channels AS c
        ON m.channel_id = c.id
    LEFT JOIN users AS u
        ON tm.user_id = u.id
WHERE tm.message_id IN (
    '5ae27bb1-8085-442f-8206-49ec17bd4f8d',
    '9b8268fc-1bb2-47b6-bafa-1b1e9e932e61',
    '16ccd9fe-08e0-460b-a81c-4be37c1638d0'
    )
    AND tm.is_deleted = 0
    AND tm.content LIKE '%PHP%'
ORDER BY tm.created_at;

-- ユーザーがチャンネルにアクセス可能かどうかを判定する
SELECT * FROM users_channels
WHERE channel_id = '0cc0c065-7b70-4b1c-81d6-47a54bfa9986'
    AND user_id = 'f0cb2f79-9bf9-456e-b74c-1c65412be1df'
    AND is_deleted = 0;

