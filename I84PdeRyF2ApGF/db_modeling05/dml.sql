-- id：1である記事の最新の状態を取得する
-- articleにpost_article,edit_articleを結合して、最新の状態を判定し
-- NOT EXISTS でdelete_article内に存在しないデータかを判定する。
START TRANSACTION;

SELECT
   a.id
  ,CASE WHEN e_a.id IS NULL THEN p_a.title
   ELSE e_a.title END AS title
  ,CASE WHEN e_a.id IS NULL THEN p_a.content
   ELSE e_a.content END AS content
  ,p_a.posted_by
  ,p_a.posted_at
  ,CASE WHEN e_a.id IS NULL THEN p_a.posted_at
   ELSE e_a.edited_at END AS last_edited_at
FROM modeling05.articles a
LEFT JOIN modeling05.post_article p_a ON a.post_article_id = p_a.id 
LEFT JOIN modeling05.edit_article e_a ON a.id = e_a.article_id
      AND e_a.id = (SELECT MAX(id) 
		  	          FROM modeling05.edit_article 
		  	         WHERE article_id = 1)
WHERE a.id = 1
  AND NOT EXISTS (SELECT 'X' 
				    FROM modeling05.delete_article
				   WHERE article_id = 1);

END;

-- id：1である記事の編集履歴一覧を取得する
START TRANSACTION;

SELECT
   a.id
  ,p_a.title
  ,p_a.content
  ,p_a.posted_at
  ,NULL AS edited_at
FROM modeling05.articles a
LEFT JOIN modeling05.post_article p_a ON a.post_article_id = p_a.id
WHERE a.id = 1
UNION ALL
SELECT
   article_id
  ,title
  ,content
  ,NULL as posted_at
  ,edited_at
FROM modeling05.edit_article e_a
WHERE article_id = 1
ORDER BY posted_at ASC, edited_at ASC;

END;

-- 各記事の変更履歴を古いものから順に採番して抽出するビュー
-- article_idごとにグルーピングされているので、article_idとedit_history_numberを指定することで
-- 特定の変更履歴の情報を取得できる
START TRANSACTION;

CREATE VIEW modeling05.article_edit_histories AS SELECT
  ROW_NUMBER() OVER(PARTITION BY article_id ORDER BY edited_at) edit_history_number
 ,article_id
 ,edited_by
 ,title
 ,content
 ,edited_at
FROM
	(SELECT 
	   a.id article_id
	  ,p_a.posted_by edited_by
	  ,p_a.title
	  ,p_a.content
	  ,p_a.posted_at edited_at
	FROM modeling05.articles a
	LEFT JOIN modeling05.post_article p_a ON a.post_article_id = p_a.id
	UNION
	SELECT
	  article_id
	 ,edited_by
	 ,title
	 ,content
	 ,edited_at
	FROM modeling05.edit_article e_a) wk
ORDER BY article_id ASC, edited_at ASC;

END;

-- 変更履歴ビューから取得した特定の変更履歴情報を
-- edit_articleに挿入する
-- article_id:1を2️番目に古い記事情報に戻す
START TRANSACTION;

INSERT INTO modeling05.edit_article(article_id, edited_by, title, content)
SELECT
   article_id
  ,edited_by
  ,title
  ,content
FROM modeling05.article_edit_histories
WHERE article_id = 1
  AND edit_history_number = 2;

END;

