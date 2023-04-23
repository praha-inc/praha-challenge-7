USE chat_development;

-- ログインユーザー
INSERT INTO users (id, name, email, avatar_url) VALUES
(DEFAULT, "プラハ太郎", "sample1@gmail.com", "https://chat.s3.amazonaws.com/uploads/user/avatar/1/sample.png"),
(DEFAULT, "田中プラハ", "sample2@gmail.com", "https://chat.s3.amazonaws.com/uploads/user/avatar/2/sample2.png"),
(DEFAULT, "佐藤プラハ", "sample3@gmail.com", "https://chat.s3.amazonaws.com/uploads/user/avatar/3/sample3.png"),
(DEFAULT, "Gopherさん", "sample4@gmail.com", "https://chat.s3.amazonaws.com/uploads/user/avatar/4/sample4.png");

-- ワークスペース
INSERT INTO work_spaces (id, name, created_at, created_by) VALUES
(DEFAULT, "プラハアカデミー", DEFAULT, 1),
(DEFAULT, "朝会", DEFAULT, 2),
(DEFAULT, "Go道場", DEFAULT, 4);

-- ユーザーが所属しているワークスペース
INSERT INTO user_work_spaces (id, user_id, work_space_id) VALUES
-- プラハアカデミーに所属しているユーザー
(DEFAULT, 1, 1), (DEFAULT, 2, 1), (DEFAULT, 3, 1),
-- 朝会に所属しているユーザー
(DEFAULT, 2, 2), (DEFAULT, 3, 2),
-- Go道場に所属しているユーザー
(DEFAULT, 4, 3), (DEFAULT, 2, 3);

-- チャンネル
INSERT INTO chat_channels (id, name, created_at, is_public, created_by, work_space_id) VALUES
-- プラハアカデミーのチャンネル
(DEFAULT, "general", DEFAULT, DEFAULT, 1, 1),
(DEFAULT, "notice_github", DEFAULT, DEFAULT, 1, 1),
(DEFAULT, "times_praha", DEFAULT, DEFAULT, 1, 1),
(DEFAULT, "times_tanaka", DEFAULT, DEFAULT, 1, 1),
(DEFAULT, "times_sato", DEFAULT, DEFAULT, 1, 1),
-- 朝会のチャンネル
(DEFAULT, "general", DEFAULT, DEFAULT, 2, 2),
(DEFAULT, "輪読会", DEFAULT, DEFAULT, 2, 2),
(DEFAULT, "競プロ部屋", DEFAULT, DEFAULT, 2, 2),
(DEFAULT, "times_tanka", DEFAULT, DEFAULT, 2, 2),
(DEFAULT, "times_sato", DEFAULT, DEFAULT, 2, 2),
-- Go道場のチャンネル
(DEFAULT, "general", DEFAULT, DEFAULT, 4, 3),
(DEFAULT, "notice_github", DEFAULT, DEFAULT, 4, 3),
(DEFAULT, "times_gopher", DEFAULT, DEFAULT, 4, 3),
(DEFAULT, "times_tanaka", DEFAULT, DEFAULT, 4, 3);

-- ユーザーが所属しているチャンネル
INSERT INTO user_chat_channels (id, user_id, chat_channel_id) VALUES
-- プラハアカデミー
-- general
(DEFAULT, 1, 1), (DEFAULT, 2, 1), (DEFAULT, 3, 1),
-- notice_github
(DEFAULT, 1, 2), (DEFAULT, 2, 2), (DEFAULT, 3, 2),
-- times_praha
(DEFAULT, 1, 3), (DEFAULT, 2, 3), (DEFAULT, 3, 3),
-- times_tana3a
(DEFAULT, 1, 4), (DEFAULT, 2, 4), (DEFAULT, 3, 4),
-- times_sato
(DEFAULT, 1, 5), (DEFAULT, 2, 5), (DEFAULT, 3, 5),
-- 朝会
-- general
(DEFAULT, 2, 6), (DEFAULT, 3, 6),
-- 輪読会
(DEFAULT, 2, 7), (DEFAULT, 3, 7),
-- 競プロ部屋
(DEFAULT, 2, 8), (DEFAULT, 3, 8),
-- times_tana3a
(DEFAULT, 2, 9), (DEFAULT, 3, 9),
-- times_sato
(DEFAULT, 2, 10), (DEFAULT, 3, 10),
-- Go道場
-- general
(DEFAULT, 4, 11), (DEFAULT, 2, 11),
-- notice_github
(DEFAULT, 4, 12), (DEFAULT, 2, 12),
-- times_gopher
(DEFAULT, 4, 13), (DEFAULT, 2, 13),
-- times_tanaka
(DEFAULT, 4, 14), (DEFAULT, 2, 14);

-- スレッド
INSERT INTO chat_threads (id, created_at) VALUES
-- プラハアカデミー
-- 登場人物が一人だけのスレッド
(DEFAULT, DEFAULT),
-- 登場人物が三人のスレッド
(DEFAULT, DEFAULT);

-- ユーザーが含まれているスレッド
INSERT INTO user_chat_threads (id, user_id, chat_thread_id) VALUES
-- プラハアカデミー
-- 登場人物が一人だけのスレッド
(DEFAULT, 1, 1),
-- 登場人物が三人のスレッド
(DEFAULT, 1, 2), (DEFAULT, 2, 2), (DEFAULT, 3, 2);

-- チャットメッセージ
INSERT INTO chat_messages (id, body, send_at, user_id, chat_channel_id, chat_thread_id) VALUES
-- プラハアカデミー
-- times_satoで発生した登場人物一人のスレッド
(DEFAULT, "仕事したくねえー", DEFAULT, 3, 5, 1),
(DEFAULT, "どうやったらサボれるかを追求したい", ADDTIME(NOW(), "00:10:00"), 3, 5, 1),
(DEFAULT, "3時間の労働で8時間分のパフォーマンスが出せれば最高。", ADDTIME(NOW(), "00:20:00"), 3, 5, 1),
(DEFAULT, "経験と自己研磨を重ねて早くその状態に到達したい。あとは自動化するか誰かを雇うか", ADDTIME(NOW(), "00:30:00"), 3, 5, 1),
-- generalで発生した登場人物が三人のスレッド
(DEFAULT, "仕事したくねえー", DEFAULT, 3, 1, 2),
(DEFAULT, "わかるわー", ADDTIME(NOW(), "00:10:00"), 2, 1, 2),
(DEFAULT, "コラ！サボってないで働きなさい！", ADDTIME(NOW(), "00:20:00"), 1, 1, 2),
-- Goアカデミー
-- times_tanakaで発生した一人つぶやき
(DEFAULT, "Goでわかんねえとこあるな。どうしよ", DEFAULT, 3, 14, NULL),
(DEFAULT, "てかGopherニキに聞けばええやん", ADDTIME(NOW(), "00:10:00"), 2, 14, NULL),
(DEFAULT, "今日有給取ってたわ！チクショー", ADDTIME(NOW(), "00:20:00"), 1, 14, NULL);

-- チャットメッセージの親子関係を表すテーブル
INSERT INTO chat_message_families (id, parent_id, child_id) VALUES
-- プラハアカデミー
-- times_satoで発生した登場人物一人のスレッド
(DEFAULT, 1, 2),
(DEFAULT, 2, 3),
(DEFAULT, 3, 4),
-- generalで発生した登場人物が三人のスレッド
(DEFAULT, 5, 6),
(DEFAULT, 6, 7);