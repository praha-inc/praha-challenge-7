--- CREATE, DELETE, UPDATE
-- Userの作成
INSERT INTO users (username, email, password, display_name, profile_image_url) VALUES
('Yamazaki Yusuke', 'yusuke@example.com', 'password_yusuke', 'ゆうすけ', 'https://picsum.photos/200');
-- Userの編集
UPDATE users
SET email = 'yusuke@gmail.com'
WHERE id = :user_id;
-- Userの削除
DELETE FROM users
WHERE id = :user_id;

-- ワークスペースの作成
INSERT INTO workspaces (name) VALUES
('プラハチャレンジ');
-- ワークスペースの編集
UPDATE workspaces
SET name = 'プラハチャレンジ(7期)'
WHERE id = :workspace_id;
-- ワークスペースの削除
DELETE FROM workspaces
WHERE id = :workspace_id;

-- チャンネルの作成
INSERT INTO channels (workspace_id, name, description, is_private) VALUES
(:workspace_id, '_review', '', false);
-- チャンネルの編集
UPDATE channels
SET name = '# _review'
WHERE id = :channel_id;
-- チャンネルの削除
DELETE FROM channels
WHERE id = :channel_id;

-- ワークスペースメンバーの追加
INSERT INTO workspace_members (user_id, workspace_id, role) VALUES
(:user_id, :workspace_id, 0);
-- ワークスペースメンバーの編集
UPDATE workspace_members
SET role = 1
WHERE id = :workspace_member_id;
-- ワークスペースメンバーの削除
DELETE FROM workspace_members
WHERE id = :workspace_member_id;

-- チャンネルメンバーの追加
INSERT INTO channel_members (user_id, channel_id) VALUES
(:user_id, :channel_id);
-- チャンネルメンバーの削除
DELETE FROM channel_members
WHERE id = :channel_member_id;

-- メッセージの作成
INSERT INTO messages (user_id, channel_id, content) VALUES
(:user_id, :channel_id, 'サンプルメッセージです！');
-- メッセージの編集
UPDATE messages
SET content = 'サンプルメッセージです！/n 編集しました！'
WHERE id = :message_id;
-- メッセージの削除
DELETE FROM messages
WHERE id = :message_id;

-- スレットメッセージの作成
INSERT INTO threads (parent_message_id, user_id, content) VALUES
(:parent_message_id, :user_id, 'サンプルスレットメッセージです！');
-- スレットメッセージの編集
UPDATE threads
SET content = 'サンプルスレットメッセージです！/n 編集しました！'
WHERE id = :thread_id;
-- スレットメッセージの削除
DELETE FROM threads
WHERE id = :thread_id;

---- SELECT
-- messagesとthreadsの横断検索（文字）
SELECT'message' as type, m.id, m.user_id, m.channel_id, m.content, m.created_at
FROM messages m
WHERE m.content LIKE '%hello%'
UNION ALL
SELECT 'thread' as type, t.id, t.user_id, c.id, t.content, t.created_at
FROM threads t
JOIN messages parent_msg ON t.parent_message_id = parent_msg.id
JOIN channels c ON parent_msg.channel_id = c.id
WHERE t.content LIKE '%hello%'
ORDER BY created_at ASC;

-- messagesとthreadsの横断検索（送信者）
SELECT'message' as type, m.id, m.user_id, m.channel_id, m.content, m.created_at
FROM messages m
WHERE m.user_id = :user_id
UNION ALL
SELECT 'thread' as type, t.id, t.user_id, c.id, t.content, t.created_at
FROM threads t
JOIN messages parent_msg ON t.parent_message_id = parent_msg.id
JOIN channels c ON parent_msg.channel_id = c.id
WHERE t.user_id = :user_id
ORDER BY created_at ASC;

-- messagesとthreadsの横断検索（チャンネル）
SELECT'message' as type, m.id, m.user_id, m.channel_id, m.content, m.created_at
FROM messages m
WHERE m.channel_id = :channel_id
UNION ALL
SELECT 'thread' as type, t.id, t.user_id, c.id, t.content, t.created_at
FROM threads t
JOIN messages parent_msg ON t.parent_message_id = parent_msg.id
JOIN channels c ON parent_msg.channel_id = c.id
WHERE c.id = :channel_id
ORDER BY created_at ASC;

-- messagesとthreadsの横断検索（日時）
SELECT'message' as type, m.id, m.user_id, m.channel_id, m.content, m.created_at
FROM messages m
WHERE m.created_at >= '2019-01-19 12:30:00'
AND m.created_at <= '2020-03-02 09:15:00'
UNION ALL
SELECT 'thread' as type, t.id, t.user_id, c.id, t.content, t.created_at
FROM threads t
JOIN messages parent_msg ON t.parent_message_id = parent_msg.id
JOIN channels c ON parent_msg.channel_id = c.id
WHERE t.created_at >= '2019-01-19 12:30:00'
AND t.created_at <= '2020-03-02 09:15:00'
ORDER BY created_at ASC;

-- messagesとthreadsの横断検索（文字 & 送信者 & チャンネル & 日時）
SELECT'message' as type, m.id, m.user_id, m.channel_id, m.content, m.created_at
FROM messages m
WHERE m.content LIKE '%hello%'
AND m.user_id = 2
AND m.channel_id = 1
AND m.created_at >= '2019-01-19 12:30:00'
AND m.created_at <= '2020-03-02 09:15:00'
UNION ALL
SELECT 'thread' as type, t.id, t.user_id, c.id, t.content, t.created_at
FROM threads t
JOIN messages parent_msg ON t.parent_message_id = parent_msg.id
JOIN channels c ON parent_msg.channel_id = c.id
WHERE t.content LIKE '%hello%'
AND t.user_id = 2
AND c.id = 1
AND c.created_at >= '2019-01-19 12:30:00'
AND c.created_at <= '2020-03-02 09:15:00'
ORDER BY created_at ASC;

-- 特定のmessageよりthreadのメッセージを取得
SELECT * 
FROM threads
WHERE parent_message_id = :parent_message_id
ORDER BY created_at ASC;

-- 特定のユーザーを想定して
    -- 表示するworkspaceの取得
    SELECT w.name
    FROM workspaces w 
    JOIN workspace_members members ON w.id = members.workspace_id
    WHERE members.user_id = :user_id;

    -- 特定のワークスペースを選択した際に表示するchannelの取得
    SELECT c.name
    FROM channels c 
    JOIN channel_members members ON c.id = members.channel_id
    WHERE members.user_id = :user_id
    AND c.workspace_id = :workspace_id;

-- チャネルを開いた際を想定して
    -- 表示するメッセージの取得
    SELECT *
    FROM messages
    WHERE channel_id = :channel_id
    ORDER BY created_at ASC;
