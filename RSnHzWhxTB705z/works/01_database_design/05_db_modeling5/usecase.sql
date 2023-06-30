# noinspection SqlResolveForFile
# ↑IDEAでエラーを出さないための記述です。

\! echo 'USECASE'

-- 更新
-- かきくけこ
INSERT INTO t_article_histories (article_id, user_id, title, content, post_date, update_date) VALUES
(
    1,
    (SELECT user_id FROM t_articles WHERE id = 1),
    (SELECT t_articles.title FROM t_articles WHERE id = 1),
    (SELECT t_articles.content FROM t_articles WHERE id = 1),
    (SELECT t_articles.post_date FROM t_articles WHERE id = 1),
    (SELECT t_articles.updated_at FROM t_articles WHERE id = 1)
);
UPDATE t_articles SET
                      content = 'かきくけこ',
                      archived_updated_date = NULL
WHERE id = 1;

-- 更新
-- さしすせそ
INSERT INTO t_article_histories (article_id, user_id, title, content, post_date, update_date) VALUES
(
    1,
    (SELECT user_id FROM t_articles WHERE id = 1),
    (SELECT t_articles.title FROM t_articles WHERE id = 1),
    (SELECT t_articles.content FROM t_articles WHERE id = 1),
    (SELECT t_articles.post_date FROM t_articles WHERE id = 1),
    (SELECT t_articles.updated_at FROM t_articles WHERE id = 1)
);
UPDATE t_articles SET
                      content = 'さしすせそ',
                      archived_updated_date = NULL
WHERE id = 1;

-- 戻す
-- かきくけこ
SET @archive_id = 2;
INSERT INTO t_article_histories (article_id, user_id, title, content, post_date, update_date) VALUES
(
    1,
    (SELECT t_articles.user_id FROM t_articles WHERE id = 1),
    (SELECT t_articles.title FROM t_articles WHERE id = 1),
    (SELECT t_articles.content FROM t_articles WHERE id = 1),
    (SELECT t_articles.post_date FROM t_articles WHERE id = 1),
    (SELECT t_articles.updated_at FROM t_articles WHERE id = 1)
);
UPDATE t_articles SET
                      user_id = (SELECT t_article_histories.user_id FROM t_article_histories WHERE id = @archive_id),
                      title = (SELECT t_article_histories.title FROM t_article_histories WHERE id = @archive_id),
                      content = (SELECT t_article_histories.content FROM t_article_histories WHERE id = @archive_id),
                      post_date = (SELECT t_article_histories.post_date FROM t_article_histories WHERE id = @archive_id),
                      archived_updated_date = (SELECT t_article_histories.update_date FROM t_article_histories WHERE id = @archive_id)
WHERE id = 1;

-- 更新
-- たちつてと
INSERT INTO t_article_histories (article_id, user_id, title, content, post_date, update_date) VALUES
(
    1,
    (SELECT user_id FROM t_articles WHERE id = 1),
    (SELECT t_articles.title FROM t_articles WHERE id = 1),
    (SELECT t_articles.content FROM t_articles WHERE id = 1),
    (SELECT t_articles.post_date FROM t_articles WHERE id = 1),
    (SELECT t_articles.updated_at FROM t_articles WHERE id = 1)
);
UPDATE t_articles SET
                      content = 'たちつてと',
                      archived_updated_date = NULL
WHERE id = 1;

-- 戻す
-- かきくけこ
SET @archive_id = 4;
INSERT INTO t_article_histories (article_id, user_id, title, content, post_date, update_date) VALUES
(
    1,
    (SELECT t_articles.user_id FROM t_articles WHERE id = 1),
    (SELECT t_articles.title FROM t_articles WHERE id = 1),
    (SELECT t_articles.content FROM t_articles WHERE id = 1),
    (SELECT t_articles.post_date FROM t_articles WHERE id = 1),
    (SELECT t_articles.updated_at FROM t_articles WHERE id = 1)
);
UPDATE t_articles SET
                      user_id = (SELECT t_article_histories.user_id FROM t_article_histories WHERE id = @archive_id),
                      title = (SELECT t_article_histories.title FROM t_article_histories WHERE id = @archive_id),
                      content = (SELECT t_article_histories.content FROM t_article_histories WHERE id = @archive_id),
                      post_date = (SELECT t_article_histories.post_date FROM t_article_histories WHERE id = @archive_id),
                      archived_updated_date = (SELECT t_article_histories.update_date FROM t_article_histories WHERE id = @archive_id)
WHERE id = 1;
