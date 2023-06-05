# noinspection SqlResolveForFile
# ↑IDEAでエラーを出さないための記述です。

-- ドキュメントを削除「高橋_階層0_ドキュメント2」
UPDATE t_documents SET is_deleted = 1
WHERE name = '高橋_階層0_ドキュメント2';

-- ディレクトリを削除「高橋_階層2」
SET @delete_id = (SELECT id FROM t_directories WHERE name = '高橋_階層2');
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM t_directories WHERE name = '高橋_階層2';
DELETE FROM t_directory_closures
WHERE
    ancestor IN (
        SELECT descendant FROM (
           SELECT DISTINCT descendant FROM t_directory_closures WHERE ancestor = @delete_id
       ) AS dc1
    )
   OR descendant IN (
    SELECT descendant FROM (
           SELECT DISTINCT descendant FROM t_directory_closures WHERE ancestor = @delete_id
       ) AS dc2
    )
;
SET FOREIGN_KEY_CHECKS = 1;

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
SET @update_dir_id = (SELECT id FROM t_directories WHERE name = '山田_階層0');
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM t_directory_closures
WHERE
    ancestor IN (
        SELECT descendant FROM (
           SELECT DISTINCT descendant FROM t_directory_closures WHERE ancestor = @update_dir_id
       ) AS dc1
    )
   OR descendant IN (
        SELECT descendant FROM (
           SELECT DISTINCT descendant FROM t_directory_closures WHERE ancestor = @update_dir_id
       ) AS dc2
    )
;
SET FOREIGN_KEY_CHECKS = 1;
INSERT INTO t_directory_closures VALUES ((SELECT id FROM t_directories WHERE name = '中村_階層0'), @update_dir_id);
INSERT INTO t_directory_closures VALUES (@update_dir_id, @update_dir_id);
