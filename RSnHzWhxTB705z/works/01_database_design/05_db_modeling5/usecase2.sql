# noinspection SqlResolveForFile
# ↑IDEAでエラーを出さないための記述です。

\! echo '記事「ひらがな」の履歴一覧'
-- 記事「ひらがな」の履歴一覧
SELECT * FROM t_article_histories;

\! echo '最新記事一案'
-- 最新記事一案
SELECT * FROM t_articles;
