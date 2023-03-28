--- CREATE, DELETE, UPDATE
-- Userの作成
INSERT INTO users (username, email, password, display_name, profile_image_url) VALUES
('Yamazaki Yusuke', 'yusuke@example.com', 'password_yusuke', 'ゆうすけ', 'https://picsum.photos/200');
-- Userの編集
UPDATE users
SET email = 'yusuke@gmail.com'
WHERE id = :user_id
-- Userの削除
DELETE FROM users
WHERE id = :user_id

-- ワークスペースの作成
INSERT INTO workspaces (name) VALUES
('プラハチャレンジ');
-- ワークスペースの編集
UPDATE workspaces
SET name = 'プラハチャレンジ(7期)'
WHERE id = :workspace_id
-- ワークスペースの削除
DELETE FROM workspaces
WHERE id = :workspace_id

-- チャンネルの作成
INSERT INTO channels (workspace_id, name, description, is_private) VALUES
(:workspace_id, '_review', '', false);
-- チャンネルの編集
UPDATE channels
SET name = '# _review'
WHERE id = :channel_id
-- チャンネルの削除
DELETE FROM channels
WHERE id = :channel_id

-- ワークスペースメンバーの追加
INSERT INTO workspace_members (user_id, workspace_id, role) VALUES
(:user_id, :workspace_id, 0);
-- ワークスペースメンバーの編集
UPDATE workspace_members
SET role = 1
WHERE id = :workspace_member_id
-- ワークスペースメンバーの削除
DELETE FROM workspace_members
WHERE id = :workspace_member_id

-- チャンネルメンバーの追加
INSERT INTO channel_members (user_id, channel_id) VALUES
(:user_id, :channel_id);
-- チャンネルメンバーの削除
DELETE FROM channel_members
WHERE id = :channel_member_id

-- メッセージの作成
INSERT INTO messages (user_id, channel_id, content) VALUES
(:user_id, :channel_id, 'サンプルメッセージです！');
-- メッセージの編集
UPDATE messages
SET content = 'サンプルメッセージです！/n 編集しました！'
WHERE id = :message_id
-- メッセージの削除
DELETE FROM messages
WHERE id = :message_id

-- スレットメッセージの作成
INSERT INTO threads (parent_message_id, user_id, content) VALUES
(:parent_message_id, :user_id, 'サンプルスレットメッセージです！');
-- スレットメッセージの編集
UPDATE threads
SET content = 'サンプルスレットメッセージです！/n 編集しました！'
WHERE id = :thread_id
-- スレットメッセージの削除
DELETE FROM threads
WHERE id = :thread_id

---- SELECT
-- messagesとthreadsの横断検索
-- threadのメッセージを取得
-- 特定のユーザーを想定して
    -- 表示するworkspaceの取得
    -- 表示するchannelの取得
-- チャネルを開いた際を想定して
    -- 表示するメッセージの取得
-- スレットを開いた際を想定して
    -- 表示するスレットメッセージのの取得