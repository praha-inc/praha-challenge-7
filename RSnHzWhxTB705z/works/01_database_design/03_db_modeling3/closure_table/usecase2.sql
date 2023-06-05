# noinspection SqlResolveForFile
# ↑IDEAでエラーを出さないための記述です。

-- ドキュメントを並べ替える
UPDATE t_documents
SET display_order =
    case id
        WHEN 13 THEN 2
        WHEN 14 THEN 1
    END,
    update_user_id = (SELECT id FROM m_users WHERE family_name = '中村')
WHERE id IN (13, 14);
