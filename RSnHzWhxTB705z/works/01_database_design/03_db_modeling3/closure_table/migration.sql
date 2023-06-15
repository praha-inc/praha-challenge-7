# noinspection SqlResolveForFile
# ↑IDEAでエラーを出さないための記述です。

ALTER TABLE t_documents ADD display_order INT UNSIGNED NOT NULL DEFAULT 0 AFTER directory_id;

-- プログラム側で番号などは制御する前提で、今回は値をハードコーディングします
UPDATE t_documents
SET display_order =
    CASE id
        WHEN 11 THEN 1
        WHEN 12 THEN 1
        WHEN 13 THEN 1
        WHEN 14 THEN 2
    END
WHERE id IN (11, 12, 13, 14);
