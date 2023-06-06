# noinspection SqlResolveForFile
# ↑IDEAでエラーを出さないための記述です。

-- ドキュメントを削除「高橋_階層0_ドキュメント2」
UPDATE t_documents
SET is_deleted = 1
WHERE directory_id =
      (SELECT directory_id FROM t_directories WHERE name = '高橋_階層0')
  AND name = '高橋_階層0_ドキュメント2';

-- ディレクトリを削除「高橋_階層2」
UPDATE
    t_documents AS doc1,
    t_directories AS dir1
SET
    doc1.is_deleted = 1,
    dir1.is_deleted = 1
WHERE doc1.directory_id IN (
    WITH RECURSIVE tree(dir_id, depth) AS (
    SELECT
    dir.id AS dir_id,
    0
    FROM t_directories AS dir
    LEFT JOIN t_directories AS childDir ON dir.id = childDir.parent_directory_id
    WHERE dir.id = (SELECT id FROM t_directories WHERE name = '高橋_階層2')
  AND dir.is_deleted = 0

    UNION

    SELECT
    dir.id AS dir_id,
    tree.depth + 1
    FROM t_directories AS dir
    LEFT JOIN t_directories AS childDir ON dir.id = childDir.parent_directory_id
    , tree
    WHERE dir.parent_directory_id = tree.dir_id
  AND dir.is_deleted = 0
    )
    SELECT
    dir_id
    FROM tree)
  AND dir1.id IN (
    WITH RECURSIVE tree(dir_id, depth) AS (
    SELECT
    dir.id AS dir_id,
    0
    FROM t_directories AS dir
    LEFT JOIN t_directories AS childDir ON dir.id = childDir.parent_directory_id
    WHERE dir.id = (SELECT id FROM t_directories WHERE name = '高橋_階層2')
  AND dir.is_deleted = 0

    UNION

    SELECT
    dir.id AS dir_id,
    tree.depth + 1
    FROM t_directories AS dir
    LEFT JOIN t_directories AS childDir ON dir.id = childDir.parent_directory_id
    , tree
    WHERE dir.parent_directory_id = tree.dir_id
  AND dir.is_deleted = 0
    )
    SELECT
    dir_id
    FROM tree);

-- ドキュメント「加藤_階層0_ドキュメント2」を「加藤_階層0」から「加藤_階層2」に移動し、「加藤_階層2_ドキュメント2」にリネーム
UPDATE t_documents
SET
    directory_id = (SELECT id FROM t_directories WHERE name = '加藤_階層2'),
    name = '加藤_階層2_ドキュメント2',
    update_user_id = (SELECT id FROM m_users WHERE family_name = '加藤')
WHERE name = '加藤_階層0_ドキュメント2';

-- 中村がドキュメントを作成し、山田が編集
INSERT INTO t_documents (directory_id, create_user_id, name, content) VALUES
(
    (SELECT id FROM t_directories WHERE name = '中村_階層0'),
    (SELECT id FROM m_users WHERE family_name = '中村'),
    '中村_階層0_ドキュメント3',
    '中村_階層0_本文3'
);
UPDATE t_documents
SET
    update_user_id = (SELECT id FROM m_users WHERE family_name = '山田'),
    content = '中村_階層0_本文3→山田が更新'
WHERE name = '中村_階層0_ドキュメント3';

-- ルートからディレクトリを移動
UPDATE t_directories
SET parent_directory_id = (
    SELECT id FROM (
                       SELECT id FROM t_directories WHERE name = '中村_階層0'
                   ) AS sub
)
WHERE name = '山田_階層0';
