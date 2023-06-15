-- ディレクトリを追加する
-- Tanakaさん(id：1)が「プロジェクトC」ディレクトリを「プロジェクトA」(id:1)配下に作成
INSERT INTO `directories` (`id`, `name`)
VALUES 
  (DEFAULT, 'プロジェクトC');
SET @directory_id := LAST_INSERT_ID();

INSERT INTO `create_directory` (`id`, `created_by`, `directory_id`, `created_at`)
VALUES
  (DEFAULT, 1, @directory_id, DEFAULT);

INSERT INTO `directory_tree_paths` (`ancestor_directory_id`, `descendant_directory_id`)
VALUES
   (@directory_id, @directory_id)
  ,(1, @directory_id);

-- ディレクトリを移動する
-- 「プロジェクトC」ディレクトリ(id:9)を「要件定義」(id:4)配下に移動
INSERT INTO `update_directory` (`id`, `updated_by`, `directory_id`, `before_update_name`, `before_update_ancestor_directory_id`, `updated_at`)
VALUES
  (DEFAULT, 1, 9, 'プロジェクトC', 1, DEFAULT);

UPDATE `directory_tree_paths`
SET `ancestor_directory_id` = 4
WHERE `descendant_directory_id` = 9
  AND `ancestor_directory_id` = 1; 
  
-- ディレクトリを削除する
-- 「プロジェクトC」ディレクトリ(id:9)を削除
--   ※「プロジェクトC」配下にディレクトリやドキュメントがあった場合は、delete_〇〇テーブルにそれぞれレコードを追加する
INSERT INTO `delete_directory` (`id`, `deleted_by`, `directory_id`, `deleted_at`)
VALUES
  (DEFAULT, 1, 9, DEFAULT);

DELETE FROM `directory_tree_paths`
WHERE `ancestor_directory_id` = 9
   OR `descendant_directory_id` = 9;

-- ドキュメントを作成する
-- Suzikiさんがプライベート(id:2)に「5月収支」ドキュメントを作成
INSERT INTO `documents` (`id`, `title`, `content`, `directory_id`)
VALUES
  (DEFAULT, '5月収支', '収入：200,000 支出：180,000 20,000プラスで終えました！', 2);
SET @document_id := LAST_INSERT_ID();

INSERT INTO `create_document` (`id`, `created_by`, `document_id`, `created_at`)
VALUES
  (DEFAULT, 2, @document_id, DEFAULT);

-- SET @position := SELECT COALESCE(MAX(`position`),0) + 1 
--                    FROM `document_order`
--                   WHERE `directory_id` = 2;

-- 変数の代入誤りを修正
SELECT @position := COALESCE(MAX(`position`), 0) + 1 FROM `document_order` WHERE `directory_id` = 2;

INSERT INTO `document_order` (`directory_id`, `document_id`, `position`)
VALUES
  (2, @document_id, @position);

-- ドキュメントを編集する（内容を編集し、別ディレクトリへ移動）
-- 「5月収支」(id:8)を編集し、「家計簿」ディレクトリ(id:6)に移動
INSERT INTO `update_document` (`id`, `updated_by`, `document_id`, `before_update_title`, `before_update_content`, `before_update_ancestor_directory_id`, `before_update_position`, `updated_at`)
VALUES
  (DEFAULT, 2, 8, '5月収支', '収入：200,000 支出：180,000 20,000プラスで終えました！', 2, 1, DEFAULT);

UPDATE `documents`
SET `title` = '5月収支',
    `content` = '収入：200,000 支出：230,000 本当は30,000マイナスで終えました…',
    `directory_id` = 6
WHERE id = 8;

-- ドキュメント編集に伴うドキュメントの順番更新処理等の追加
DELETE FROM `document_order`
WHERE `document_id` = 8;

SELECT @position := COALESCE(MAX(`position`), 0) + 1 FROM `document_order` WHERE `directory_id` = 6;

INSERT INTO `document_order` (`directory_id`, `document_id`, `position`)
VALUES
  (6, 8, @position);

-- 「プライベート」ディレクトリ(id:2)の中身を閲覧する
-- （ディレクトリ構造の取得）
-- SELECT
--    d_d.`id` AS id
--   ,d_d.name AS name
-- FROM `directory_tree_paths` dtp
-- LEFT JOIN `directories` d_a ON dtp.`ancestor_directory_id` = d_a.`id`
-- LEFT JOIN `directories` d_d ON dtp.`descendant_directory_id` = d_d.`id`
-- WHERE dtp.`ancestor_directory_id` = 2

-- 削除されていないディレクトリを参照できるようにビューと結合するように修正 
SELECT 
   edv_d.`directory_id` AS id
  ,edv_d.`name` AS name
FROM `directory_tree_paths` dtp
LEFT JOIN `enabled_directories_view` edv_a ON dtp.`ancestor_directory_id` = edv_a.`directory_id`
LEFT JOIN `enabled_directories_view` edv_d ON dtp.`descendant_directory_id` = edv_d.`directory_id`
WHERE dtp.`ancestor_directory_id` = 2;

-- 「プロジェクトA」ディレクトリ(id:1)内のドキュメントを取得する
-- SELECT
--    d.`id`
--   ,d.`title`
--   ,d.`content`
--   ,do.`position`
-- FROM documents d
-- LEFT JOIN `document_order` do ON d.`id` = do.`document_id`
-- WHERE d.`directory_id` = 1
-- ORDER BY do.`position` ASC;

-- 削除されていないドキュメントを参照できるようにビューと結合するように修正
SELECT
   d.`document_id`
  ,d.`title`
  ,d.`content`
  ,do.`position`
FROM `enabled_documents_view` d
LEFT JOIN `document_order` do ON d.`document_id` = do.`document_id`
WHERE d.`directory_id` = 1
ORDER BY do.`position` ASC;

-- 「プロジェクトA」ディレクトリ内のドキュメントの順番を入れ替える
-- 上のクエリにより以下の順番でレコードが取得できる
-- |id |     title            | content | position
-- |1  | プロジェクト概要 　　　　| ......  | 1
-- |6  | 社内資料A　　　　　　　　| ......  | 2
-- |7  | プロジェクトメンバー資料 | ......  | 3
-- 
-- id:7のドキュメントをid:1とid:6の間に並べ替える
SELECT @prev_position := `position` FROM `document_order` WHERE `document_id` = 1;

SELECT @next_position := `position` FROM `document_order` WHERE `document_id` = 6;

SET @new_position := (@prev_position + @next_position) / 2;

INSERT INTO `update_document` (`id`, `updated_by`, `document_id`, `before_update_title`, `before_update_content`, `before_update_ancestor_directory_id`, `before_update_position`, `updated_at`)
VALUES
	(DEFAULT, 2, 7, 'プロジェクトメンバー資料', 'プロジェクトAのプロジェクトメンバー構成に関する資料です。', 1, 3, DEFAULT);

UPDATE `document_order`
SET `position` = @new_position
WHERE `document_id` = 7;