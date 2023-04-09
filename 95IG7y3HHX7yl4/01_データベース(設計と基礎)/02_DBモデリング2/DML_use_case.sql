--- CREATE, DELETE, UPDATE
-- Userの作成
INSERT INTO users (id, username, email, password, display_name, profile_image_url) VALUES
(100, 'Yamazaki Yusuke', 'yusuke@example.com', 'password_yusuke', 'ゆうすけ', 'https://picsum.photos/200');
-- Userの編集
UPDATE users
SET email = 'yusuke@gmail.com'
WHERE id = 100;
-- Userの削除
DELETE FROM users
WHERE id = 100;

-- ワークスペースの作成
INSERT INTO workspaces (id, name) VALUES
(100, 'プラハチャレンジ');
-- ワークスペースの編集
UPDATE workspaces
SET name = 'プラハチャレンジ(7期)'
WHERE id = 100;
-- ワークスペースの削除
DELETE FROM workspaces
WHERE id = 100;

-- チャンネルの作成
INSERT INTO channels (id, workspace_id, name, description, is_private) VALUES
(100, 1, '_review', '', false);
-- チャンネルの編集
UPDATE channels
SET name = '# _review'
WHERE id = 100;
-- チャンネルの削除
DELETE FROM channels
WHERE id = 100;

-- ワークスペースメンバーの追加
INSERT INTO workspace_members (id, user_id, workspace_id, role) VALUES
(100, 2, 3, 0);
-- ワークスペースメンバーの編集
UPDATE workspace_members
SET role = 1
WHERE id = 100;
-- ワークスペースメンバーの削除
DELETE FROM workspace_members
WHERE id = 100;

-- チャンネルメンバーの追加
INSERT INTO channel_members (id, user_id, channel_id) VALUES
(100, 4, 5);
-- チャンネルメンバーの削除
DELETE FROM channel_members
WHERE id = 100;

-- メッセージの作成
INSERT INTO messages (id, user_id, channel_id, content) VALUES
(100, 1, 1, 'サンプルメッセージです！');
-- メッセージの編集
UPDATE messages
SET content = 'サンプルメッセージです！/n 編集しました！'
WHERE id = 100;
-- メッセージの削除
DELETE FROM messages
WHERE id = 100;

-- スレットメッセージの作成
INSERT INTO threads (id, parent_message_id, user_id, content) VALUES
(100, 1, 2, 'サンプルスレットメッセージです！');
-- スレットメッセージの編集
UPDATE threads
SET content = 'サンプルスレットメッセージです！/n 編集しました！'
WHERE id = 100;
-- スレットメッセージの削除
DELETE FROM threads
WHERE id = 100;

---- SELECT
-- messagesとthreadsの横断検索（文字）
SELECT
    *
FROM
    (
        SELECT
            'message' as type,
            m.id,
            m.user_id,
            m.channel_id,
            m.content,
            m.created_at
        FROM
            messages m
        UNION ALL
        SELECT
            'thread' as type,
            t.id,
            t.user_id,
            parent_msg.channel_id,
            t.content,
            t.created_at
        FROM
            threads t
            JOIN
                messages parent_msg
            ON  t.parent_message_id = parent_msg.id
    ) AS combined_data
WHERE
    channel_id IN(
        SELECT
            channel_id
        FROM
            channel_members
        WHERE
            user_id = 4
    )
AND content LIKE '%hello%'
ORDER BY
    created_at ASC
;

-- messagesとthreadsの横断検索（送信者）
SELECT
    *
FROM
    (
        SELECT
            'message' as type,
            m.id,
            m.user_id,
            m.channel_id,
            m.content,
            m.created_at
        FROM
            messages m
        UNION ALL
        SELECT
            'thread' as type,
            t.id,
            t.user_id,
            parent_msg.channel_id,
            t.content,
            t.created_at
        FROM
            threads t
            JOIN
                messages parent_msg
            ON  t.parent_message_id = parent_msg.id
    ) AS combined_data
WHERE
    channel_id IN(
        SELECT
            channel_id
        FROM
            channel_members
        WHERE
            user_id = 4
    )
AND user_id = 1
ORDER BY
    created_at ASC
;

-- messagesとthreadsの横断検索（チャンネル）
SELECT
    *
FROM
    (
        SELECT
            'message' as type,
            m.id,
            m.user_id,
            m.channel_id,
            m.content,
            m.created_at
        FROM
            messages m
        UNION ALL
        SELECT
            'thread' as type,
            t.id,
            t.user_id,
            parent_msg.channel_id,
            t.content,
            t.created_at
        FROM
            threads t
            JOIN
                messages parent_msg
            ON  t.parent_message_id = parent_msg.id
    ) AS combined_data
WHERE
    channel_id IN(
        SELECT
            channel_id
        FROM
            channel_members
        WHERE
            user_id = 4
    )
AND channel_id = 1
ORDER BY
    created_at ASC
;

-- messagesとthreadsの横断検索（日時）
SELECT
    *
FROM
    (
        SELECT
            'message' as type,
            m.id,
            m.user_id,
            m.channel_id,
            m.content,
            m.created_at
        FROM
            messages m
        UNION ALL
        SELECT
            'thread' as type,
            t.id,
            t.user_id,
            parent_msg.channel_id,
            t.content,
            t.created_at
        FROM
            threads t
            JOIN
                messages parent_msg
            ON  t.parent_message_id = parent_msg.id
    ) AS combined_data
WHERE
    channel_id IN(
        SELECT
            channel_id
        FROM
            channel_members
        WHERE
            user_id = 4
    )
AND created_at >= '2019-01-19 12:30:00'
AND created_at <= '2020-03-02 09:15:00'
ORDER BY
    created_at ASC
;

-- messagesとthreadsの横断検索（文字 & 送信者 & チャンネル & 日時）
SELECT
    *
FROM
    (
        SELECT
            'message' as type,
            m.id,
            m.user_id,
            m.channel_id,
            m.content,
            m.created_at
        FROM
            messages m
        UNION ALL
        SELECT
            'thread' as type,
            t.id,
            t.user_id,
            parent_msg.channel_id,
            t.content,
            t.created_at
        FROM
            threads t
            JOIN
                messages parent_msg
            ON  t.parent_message_id = parent_msg.id
    ) AS combined_data
WHERE
    channel_id IN(
        SELECT
            channel_id
        FROM
            channel_members
        WHERE
            user_id = 4
    )
AND content LIKE '%hello%'
AND user_id = 2
AND channel_id = 1
AND created_at >= '2019-01-19 12:30:00'
AND created_at <= '2020-03-02 09:15:00'
ORDER BY
    created_at ASC
;

-- 特定のmessageよりthreadのメッセージを取得
SELECT * 
FROM threads
WHERE parent_message_id = 1
ORDER BY created_at ASC;

-- 特定のユーザーを想定して
    -- 表示するworkspaceの取得
    SELECT w.name
    FROM workspaces w 
    JOIN workspace_members members ON w.id = members.workspace_id
    WHERE members.user_id = 1;

    -- 特定のワークスペースを選択した際に表示するchannelの取得
    SELECT c.name
    FROM channels c 
    JOIN channel_members members ON c.id = members.channel_id
    WHERE members.user_id = 1
    AND c.workspace_id = 1;

-- チャネルを開いた際を想定して
    -- 表示するメッセージの取得
    SELECT *
    FROM messages
    WHERE channel_id = 1
    ORDER BY created_at ASC;
