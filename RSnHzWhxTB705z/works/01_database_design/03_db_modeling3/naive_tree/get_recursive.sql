# noinspection SqlResolveForFile
# ↑IDEAでエラーを出さないための記述です。

-- 再帰的に全階層のディレクトリと文書を取得
-- 参考： https://zenn.dev/rescuenow/articles/c7d7291f2deed8
WITH RECURSIVE tree(id, dirName, childDirId, childDirName, docName, depth) AS (
    SELECT
        dir.id,
        dir.name,
        childDir.id AS childDirId,
        childDir.name AS childDirName,
        doc.name AS docName,
        0
    FROM t_directories AS dir
             LEFT JOIN t_directories AS childDir ON dir.id = childDir.parent_directory_id
             LEFT JOIN t_documents AS doc ON dir.id = doc.directory_id
    WHERE dir.parent_directory_id IS NULL
      AND dir.is_deleted = 0
      AND doc.is_deleted = 0

    UNION

    SELECT
        dir.id,
        dir.name AS dirName,
        childDir.id AS childDirId,
        childDir.name AS childDirName,
        doc.name AS docName,
        tree.depth + 1
    FROM t_directories AS dir
             LEFT JOIN t_directories AS childDir ON dir.id = childDir.parent_directory_id
             LEFT JOIN t_documents AS doc ON dir.id = doc.directory_id
       , tree
    WHERE dir.parent_directory_id = tree.id
      AND dir.is_deleted = 0
      AND doc.is_deleted = 0
)
SELECT
    id AS ディレクトリid,
    dirName AS ディレクトリ名,
    docName,
    childDirId AS 子ディレクトリid,
    childDirName AS 子ディレクトリ名,
    depth AS 階層
FROM tree;
