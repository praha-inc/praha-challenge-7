USE document_management;

-- サンプルデータ
-- users
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`)
VALUES
	(1, 'Taro', 'Tanaka', 'taro@email.com'),
	(2, 'Jiro', 'Suzuki', 'jiro@email.com'),
	(3, 'Hiroshi', 'Yamada', 'hiroshi@email.com');

-- directories
INSERT INTO `directories` (`id`, `name`)
VALUES
	(1, 'プロジェクトA'),
	(2, 'プライベート'),
	(3, '旅行'),
	(4, '要件定義'),
	(5, 'プロジェクトB'),
	(6, '家計簿'),
	(7, '国内'),
	(8, '海外');

-- directory_tree_paths
INSERT INTO `directory_tree_paths` (`ancestor_directory_id`, `descendant_directory_id`)
VALUES
    (1, 1),
    (2, 2),
    (2, 3),
    (3, 3),
    (1, 4),
    (4, 4),
    (5, 5),
    (2, 6),
    (6, 6),
    (3, 7),
    (7, 7),
    (3, 8),
    (8, 8);

-- create_directory
INSERT INTO `create_directory` (`id`, `created_by`, `directory_id`, `created_at`)
VALUES
    (1, 1, 1, '2023-05-28 19:22:56'),
    (2, 2, 2, '2023-05-28 19:23:24'),
    (3, 1, 4, '2023-05-28 19:23:38'),
    (4, 3, 5, '2023-05-28 19:23:59'),
    (5, 2, 3, '2023-05-28 19:24:45');

-- documents
INSERT INTO `documents` (`id`, `title`, `content`, `directory_id`)
VALUES
    (1, 'プロジェクト概要', 'このプロジェクトは、A社のECサイトを作成するプロジェクトです。', 1),
    (2, 'システム要件', '1.ユーザー管理機能 2.商品一覧画面の表示 3.ショッピングカート機能 4.注文情報の処理 5.支払い方法の選択', 4),
    (3, '大阪旅行計画', 'USJ・かに道楽・道頓堀・太陽の塔・海遊館', 7),
    (4, '韓国旅行計画', '2泊3日韓国旅行 いきたい場所… ', 8),
    (5, 'ハワイ旅行計画', '7月の3週目に4泊6日で。マラサダ食べたい。', 3),
    (6, '社内資料A', 'プロジェクトAに関する資料です。', 1),
    (7, 'プロジェクトメンバー資料', 'プロジェクトAのプロジェクトメンバー構成に関する資料です。', 1);

-- create_document
INSERT INTO `create_document` (`id`, `created_by`, `document_id`, `created_at`)
VALUES
	(1, 1, 1, '2023-05-29 23:42:44'),
	(2, 2, 2, '2023-05-31 00:00:54'),
	(3, 3, 3, '2023-05-31 00:01:16'),
	(4, 3, 4, '2023-05-31 00:44:08'),
    (5, 3, 5, '2023-05-31 00:50:08'),
    (6, 2, 6, '2023-06-01 00:50:08'),
    (7, 2, 7, '2023-06-01 00:51:08');

-- document_order
INSERT INTO `document_order` (`directory_id`, `document_id`, `position`)
VALUES
    (1, 1, 1),
    (1, 6, 2),
    (1, 7, 3),
    (4, 2, 1),
    (7, 3, 1),
    (8, 4, 1);

-- delete_directory
INSERT INTO `delete_directory` (`id`, `deleted_by`, `directory_id`, `deleted_at`)
VALUES
	(1, 3, 5, '2023-06-02 00:17:55');

-- delete_document
INSERT INTO `delete_document` (`id`, `deleted_by`, `document_id`, `deleted_at`)
VALUES
	(1, 3, 5, '2023-05-31 00:45:33');

-- update_directory
INSERT INTO `update_directory` (`id`, `updated_by`, `directory_id`, `before_update_name`, `before_update_ancestor_directory_id`, `updated_at`)
VALUES
	(1, 2, 3, '趣味', 5, '2023-06-02 00:02:59');

-- update_document
INSERT INTO `update_document` (`id`, `updated_by`, `document_id`, `before_update_title`, `before_update_content`, `before_update_ancestor_directory_id`, `before_update_position`, `updated_at`)
VALUES
	(1, 3, 3, '大阪旅行計画（仮）', '大阪旅行でどこに行くか…', 3, 1, '2023-06-02 00:12:29');
