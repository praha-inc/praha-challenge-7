# noinspection SqlResolveForFile
# ↑IDEAでエラーを出さないための記述です。

SELECT
    dir.id AS dir_id,
    dir.name AS ディレクトリ名,
    doc.name AS ドキュメント名,
    clo.ancestor,
    clo.descendant
FROM t_directories AS dir
         INNER JOIN t_directory_closures AS clo ON dir.id = clo.descendant
         INNER JOIN t_documents AS doc ON dir.id = doc.directory_id
WHERE dir.name LIKE '%高橋%'
  AND doc.is_deleted = 0
ORDER BY dir.id, clo.ancestor
;

SELECT
    dir.id AS dir_id,
    dir.name AS ディレクトリ名,
    doc.name AS ドキュメント名,
    clo.ancestor,
    clo.descendant
FROM t_directories AS dir
         INNER JOIN t_directory_closures AS clo ON dir.id = clo.descendant
         INNER JOIN t_documents AS doc ON dir.id = doc.directory_id
WHERE dir.name LIKE '%加藤%'
  AND doc.is_deleted = 0
ORDER BY dir.id, clo.ancestor
;

SELECT
    dir.id AS dir_id,
    dir.name AS ディレクトリ名,
    doc.name AS ドキュメント名,
    clo.ancestor,
    clo.descendant
FROM t_directories AS dir
         INNER JOIN t_directory_closures AS clo ON dir.id = clo.descendant
         INNER JOIN t_documents AS doc ON dir.id = doc.directory_id
WHERE dir.name LIKE '%山田%'
  AND doc.is_deleted = 0
ORDER BY dir.id, clo.ancestor
;

SELECT
    dir.id AS dir_id,
    dir.name AS ディレクトリ名,
    doc.name AS ドキュメント名,
    clo.ancestor,
    clo.descendant
FROM t_directories AS dir
         INNER JOIN t_directory_closures AS clo ON dir.id = clo.descendant
         INNER JOIN t_documents AS doc ON dir.id = doc.directory_id
WHERE dir.name LIKE '%中村%'
  AND doc.is_deleted = 0
ORDER BY dir.id, clo.ancestor
;
