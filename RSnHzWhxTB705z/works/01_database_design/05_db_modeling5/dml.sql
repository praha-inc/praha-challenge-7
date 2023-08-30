# noinspection SqlResolveForFile
# ↑IDEAでエラーを出さないための記述です。

\! echo 'DML実行'

INSERT INTO m_users (user_name) VALUES ('sato');

INSERT INTO t_articles (user_id, title, content, post_date) VALUES
(
    (SELECT id FROM m_users ORDER BY id DESC LIMIT 1),
    'ひらがな',
    'あいうえお',
    NOW()
    );
INSERT INTO t_articles (user_id, title, content, post_date) VALUES
(
    (SELECT id FROM m_users ORDER BY id DESC LIMIT 1),
    'カタカナ',
    'アイウエオ',
    NOW()
    );

SELECT * FROM t_articles;
