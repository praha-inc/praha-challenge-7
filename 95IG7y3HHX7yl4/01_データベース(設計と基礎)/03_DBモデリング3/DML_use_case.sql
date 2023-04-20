-- *** 現状のtree構造: sample_file_tree1.wsd(サンプルデータ投入済みの場合) ***



-- accountの作成
INSERT INTO accounts (id, username, email, password, display_name, profile_image_url)
VALUES
(4, 'ユース ケース', 'usecase@example.com', 'password_4', 'ユース ケース', 'https://example.com/images/usecase.jpg');



-- accountの編集
UPDATE accounts
    SET display_name = 'ケース'
WHERE id = 4;



-- directoryの作成
BEGIN;

-- 1. 最後のcontentを取得 => 今回は3
SELECT contents.*
FROM contents
INNER JOIN content_paths ON contents.id = content_paths.descendant
WHERE content_paths.ancestor = 1
AND content_paths.path_length = 1
AND contents.next_content_id IS NULL;
-- 2. 新しいcontentを追加
INSERT INTO contents (id, account_id, content_type, content_title, content_body, prev_content_id, next_content_id)
VALUES
(10, 4, 1, 'ユースケースディレクトリ', null, 3, null);
-- 3. 最後のcontentのnext_content_idを更新
UPDATE contents
    SET prev_content_id = 2 ,next_content_id = 10
WHERE id = 3;
-- 4. content_pathsテーブルの更新
INSERT INTO content_paths (ancestor, descendant, path_length)
    SELECT content_paths.ancestor, 10, content_paths.path_length + 1
    FROM content_paths
    WHERE content_paths.descendant = 1
UNION ALL
    SELECT 10, 10, 0;

COMMIT;



-- *** 現状のtree構造: sample_file_tree2.wsd ***



-- directoryの更新
UPDATE contents
    SET content_title = 'ユースケースdirectory'
WHERE id = 10;



-- directoryの並び替え (ユースケースdirectory一番上に並び替え)
BEGIN;

UPDATE contents
    SET prev_content_id = null, next_content_id = 2
WHERE id = 10;
UPDATE contents
    SET prev_content_id = 10, next_content_id = 3
WHERE id = 2;
UPDATE contents
    SET prev_content_id = 2 ,next_content_id = null
WHERE id = 3;

COMMIT;



-- *** 現状のtree構造: sample_file_tree3.wsd ***



-- directoryを他のディレクトリに移動 (プロジェクトB詳細設計をユースケースdirectory配下に移動)

BEGIN;

-- 1. 古いパスを削除
DELETE content_paths
    FROM content_paths
WHERE descendant IN (SELECT descendant AS id
                    FROM content_paths
                    WHERE ancestor = 7)
AND ancestor IN (SELECT ancestor AS id
                FROM content_paths
                WHERE descendant = 7
                AND ancestor != descendant);

-- 2. 新しい親へのパスを追加
INSERT INTO content_paths (ancestor, descendant, path_length)
    SELECT supertree.ancestor, subtree.descendant, supertree.path_length + subtree.path_length + 1
    FROM content_paths AS supertree
    CROSS JOIN content_paths AS subtree
    WHERE supertree.descendant = 10
    AND subtree.ancestor = 7;

-- 3. 移動したcontentのprev_content_idとnext_content_idを更新
UPDATE contents
    SET prev_content_id = null, next_content_id = null
    WHERE id = 7;

COMMIT;



-- *** 現状のtree構造: sample_file_tree4.wsd ***



-- fileの作成(ユースケースdirectory配下にユースケースfile1とユースケースfile2を作成)
-- ユースケースfile1作成
BEGIN;

-- 1. 最後のcontentを取得 => 今回は7
SELECT contents.id
FROM content_paths
    INNER JOIN contents ON contents.id = content_paths.descendant
WHERE content_paths.ancestor = 10
AND content_paths.path_length = 1
AND contents.next_content_id IS NULL;

-- 2. 新しいcontentを追加
INSERT INTO contents (id, account_id, content_type, content_title, content_body, prev_content_id, next_content_id)
VALUES
(11, 4, 2, 'ユースケースfile', 'ユースケースfile1の内容', 7, null);
-- 3. 最後のcontentのnext_content_idを更新
UPDATE contents
    SET prev_content_id = null, next_content_id = 11
WHERE id = 7;
-- 4. content_pathsテーブルの更新
INSERT INTO content_paths (ancestor, descendant, path_length)
    SELECT ancestor, 11, path_length + 1
    FROM content_paths
    WHERE descendant = 10
UNION ALL
    SELECT 11, 11, 0;

COMMIT;

-- ユースケースfile2作成
BEGIN;

-- 1. 最後のcontentを取得 => 今回は11

SELECT contents.id
FROM content_paths
    INNER JOIN contents ON contents.id = content_paths.descendant
WHERE content_paths.ancestor = 10
AND content_paths.path_length = 1
AND contents.next_content_id IS NULL;

-- 2. 新しいcontentを追加
INSERT INTO contents (id, account_id, content_type, content_title, content_body, prev_content_id, next_content_id)
VALUES
(12, 4, 2, 'ユースケースfile2', 'ユースケースfile2の内容', 11, null);
-- 3. 最後のcontentのnext_content_idを更新
UPDATE contents
    SET prev_content_id = 7, next_content_id = 12
WHERE id = 11;
-- 4. content_pathsテーブルの更新

INSERT INTO content_paths (ancestor, descendant, path_length)
    SELECT ancestor, 12, path_length + 1
    FROM content_paths
    WHERE descendant = 10
UNION ALL
    SELECT 12, 12, 0;

COMMIT;



-- *** 現状のtree構造: sample_file_tree5.wsd ***



-- fileの更新
UPDATE contents
    SET content_title = 'ユースケースfile1'
WHERE id = 11;



-- fileの並び替え (ユースケースfile2をプロジェクトB詳細設計とユースケースfile1の間に)
BEGIN;

UPDATE contents
    SET prev_content_id = 7, next_content_id = 11
WHERE id = 12;

UPDATE contents
    SET prev_content_id = null, next_content_id = 12
WHERE id = 7;

UPDATE contents
    SET prev_content_id = 12, next_content_id = null
WHERE id = 11;

COMMIT;



-- *** 現状のtree構造: sample_file_tree6.wsd ***



-- fileを他のディレクトリに移動(ユースケースfile1をプロジェクトB配下に移動)

-- 1. 古い親からのパスを削除
DELETE content_paths
    FROM content_paths
WHERE descendant IN (SELECT descendant AS id
                    FROM content_paths
                    WHERE ancestor = 11)
AND ancestor IN (SELECT ancestor AS id
                FROM content_paths
                WHERE descendant = 11
                AND ancestor != descendant);

-- 2. 新しい親へのパスを追加
INSERT INTO content_paths (ancestor, descendant, path_length)
    SELECT supertree.ancestor, subtree.descendant, supertree.path_length + subtree.path_length + 1
    FROM content_paths AS supertree
    CROSS JOIN content_paths AS subtree
    WHERE supertree.descendant = 3
    AND subtree.ancestor = 11;

-- 3. contentのprev_content_idとnext_content_idを更新

UPDATE contents
    SET prev_content_id = 7, next_content_id = null
    WHERE id = 12;

UPDATE contents
    SET prev_content_id = 6, next_content_id = null
    WHERE id = 11;

UPDATE contents
    SET prev_content_id = null, next_content_id = 11
    WHERE id = 6;  

COMMIT;



-- *** 現状のtree構造: sample_file_tree7.wsd ***



-- 特定accountの取得
SELECT *
FROM accounts
WHERE id = 4;



-- 特定directoryの取得
SELECT *
FROM contents
WHERE content_type = 1
AND id = 10;



-- 特定directoryの直下の子要素の取得 (今回はユースケースdirectory直下を取得)
SELECT contents.*
FROM content_paths
    INNER JOIN contents ON contents.id = content_paths.descendant
WHERE content_paths.ancestor = 10
AND content_paths.path_length = 1;



-- 特定fileの取得 (今回はユースケースfile2を取得)
SELECT *
FROM contents
WHERE content_type = 2
AND id = 12;



-- fileの削除 (今回はユースケースfile2を削除)
-- 1. pathの削除
DELETE FROM content_paths
WHERE descendant = 12;
-- 2. contentの削除
DELETE FROM contents
WHERE id = 12;
-- 3. contentのprev_content_idとnext_content_idを更新
UPDATE contents
    SET prev_content_id = null, next_content_id = null
    WHERE id = 7;



-- *** 現状のtree構造: sample_file_tree8.wsd ***



-- directoryの削除 (今回はユースケースdirectoryを削除)
-- 1. 削除するcontentを取得 => 7, 8, 9, 10
SELECT descendant AS id
    FROM content_paths
    WHERE ancestor = 10;
-- 1. pathの削除
DELETE content_paths
FROM content_paths
WHERE descendant IN (7, 8, 9, 10);
-- 2. contentの削除
DELETE FROM contents
WHERE id IN (7, 8, 9, 10);
-- 3. contentのprev_content_idとnext_content_idを更新
UPDATE contents
    SET prev_content_id = null, next_content_id = 3
    WHERE id = 2;


-- *** 現状のtree構造: sample_file_tree9.wsd ***



-- accountの削除 (id=4のアカウントを削除)
DELETE FROM accounts
WHERE id = 4;



-- 削除したaccountが作成した特定のfileを取得 => これは不可能。すべての削除されたアカウントが作成したすべてのcontentsなら取得可能。
SELECT *
FROM contents
WHERE  account_id IS NULL;



-- 特定のfileの編集履歴を取得 (ユースケースfile1の編集履歴を取得)
SELECT content_histories.*
FROM content_histories
WHERE content_id = 11
ORDER BY operation_date