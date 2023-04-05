-- ユーザーのワークスペース、チャンネル参加の早見表
-- ワークスペース1
-- 　旅行計画ー1,2,3,4(user_id)
-- チャンネル
-- 　アメリカ旅行計画ー1,2,3（実際に会話しているのは、1,2,3）
-- 　沖縄旅行計画-1,2,3（実際に会話しているのは、1,2,3）

-- ワークスペース2
-- 　スポーツ応援団ー1,2,3,4,
-- チャンネル
-- 　野球 ー2,3,4（実際に会話しているのは、2,3,4)
-- 　サッカー 


-- 1.あるユーザーが参加しているワークスペースを取得する
-- user_id=1の鈴木りょうこが所属しているワークスペースを取得する
-- SQLのクエリパラメータ
-- (1). user_id 検索対象のユーザーのID

SELECT m_users.name, t_workspaces.name FROM t_workspaces AS t_workspaces
	JOIN t_user_belonging_workspaces AS t_ubw
		ON t_ubw.workspace_id = t_workspaces.id
    JOIN m_users AS m_users
    	ON m_users.id = t_ubw.user_id
    WHERE m_users.id = 1;

-- 2.あるユーザーが参加しているチャネルを取得する
-- user_id=1の鈴木りょうこが所属しているチャネルを取得する
-- SQLのクエリパラメータ
-- (1). user_id 検索対象のユーザーのID

SELECT m_users.name, t_channels.name FROM t_channels AS t_channels
	JOIN t_user_belonging_channels AS t_ubc
		ON t_ubc.channel_id = t_channels.id
    JOIN m_users AS m_users
    	ON m_users.id = t_ubc.user_id
    WHERE m_users.id = 1;


-- 3.誰がどのチャンネルに、いつ、どんな内容を投稿したのか取得する(ただし、そのチャネルに所属しているユーザにしか取得できない）
-- user_id=1の鈴木涼子がアプリにログインしているとして、取得する（スレッドメッセージは含まない）
-- SQLのクエリパラメータ
-- (1). user_id 画面にログインしているユーザーのID
-- ※ EXISTS句のSELECT文のWHERE句のt_user_belonging_channels.user_idに使用。この値を変えると、結果が変わります

SELECT m_users.name AS '送信者', t_channels.name AS 'チャネル名', t_messages.content AS '内容', t_messages.created_at AS '送信日時'  
	FROM t_messages AS t_messages
 	JOIN m_users AS m_users
    	ON m_users.id = t_messages.user_id
    JOIN t_channels AS t_channels
    	ON t_channels.id = t_messages.channel_id
   WHERE
--   	入力情報であるuser_idによって閲覧権限があるかチェック（該当のメッセージにチェンネルに斎藤たくみが参加しているかどうかを判定）
   		EXISTS 
        (SELECT 1 FROM t_user_belonging_channels AS t_ubc WHERE t_ubc.channel_id = t_messages.channel_id AND 
         	t_ubc.user_id = 1 AND t_ubc.deleted_at IS NULL) AND
        t_messages.deleted_at IS NULL AND
        m_users.deleted_at IS NULL AND
        t_channels.deleted_at IS NULL 
	ORDER BY t_messages.created_at ASC;
    

-- 4.誰が、どのメッセージに、いつ、どんな内容をスレッドとして投稿したのか分かること
-- message_id=1の「アメリカ旅行について話しましょう。どこに行きたいですか？」に対するスレッドを取得する(ただし、そのチャネルに所属しているユーザにしか取得できない）
-- SQLのクエリパラメータ
-- (1). user_id 画面にログインしているユーザーのID

SELECT m_users.name AS '送信者', t_messages.content AS '親メッセージ', t_tm.content AS 'スレッドの内容', t_tm.created_at AS '送信日時'
	FROM t_thread_msssages AS t_tm
 	JOIN m_users AS m_users
    	ON m_users.id = t_tm.user_id
    JOIN t_messages AS t_messages
    	ON t_messages.id = t_tm.message_id
    WHERE EXISTS
    	(SELECT 1 FROM t_user_belonging_channels AS t_ubc WHERE t_ubc.channel_id = t_messages.channel_id AND
        t_ubc.user_id = 1 AND t_ubc.deleted_at IS NULL) AND
        t_messages.deleted_at IS NULL AND
        m_users.deleted_at IS NULL AND
        t_tm.deleted_at IS NULL
   ORDER BY t_tm.created_at ASC;

-- 5.メッセージとスレッドメッセージを横断的に検索できること
-- 出力結果にメッセージかスレッドメッセージかどうかを判別するフラグを追加する
-- user_id=1の鈴木りょうこが、workspace_id=1の「旅行計画」ワークスペースで、キーワード「アメリカ」で検索する
-- SQLのクエリパラメータ
-- (1). user_id 画面にログインしているユーザーのID
-- (2). workspace_id メッセージの検索対象範囲のワークスペースのID
-- (3). '%アメリカ%' 検索キーワード
-- 方針としては、メッセージ、スレッドメッセージに対して、以下の条件で検索し、UNION ALLで結合しています
-- 条件1.検索対象のワークスペースに属するメッセージかどうか
-- 条件2.そのワークスペースにユーザーが参加しているか
-- 条件3.メッセージ本文に検索キーワードが含まれているか
-- かなりSQLが複雑になってしまいました。これなら、メッセージテーブルとスレッドメッセージテーブルをまとめておいた方が、良かったかもしれません。各々の区別は別途フラグを設けて、判断します。
-- また、論理削除を採用したために、いちいち"deleted_at IS NULL"を付与するのが大変で、見落としやすいなと感じました。

SELECT  t_channels.name AS 'チャンネル名', messages_and_threads.message_type AS 'メッセージタイプ', m_users.name AS '送信者', messages_and_threads.content AS 'メッセージまたはスレッドメッセージの本文',
		messages_and_threads.created_at AS '送信日時'
FROM
-- メッセージテーブルの検索
(SELECT t_messages.channel_id AS channel_id, 'メッセージ' AS message_type, 
 		t_messages.user_id AS user_id, t_messages.content AS content, t_messages.created_at AS created_at
	FROM t_messages AS t_messages
 	WHERE
    -- 条件1
 		EXISTS (SELECT 1 FROM t_channels WHERE t_channels.id = t_messages.channel_id AND t_channels.workspace_id = 1 AND t_channels.deleted_at IS NULL) 
    -- 条件2
 	AND EXISTS (SELECT 1 FROM t_user_belonging_channels WHERE t_user_belonging_channels.channel_id = t_messages.channel_id AND 		
            t_user_belonging_channels.user_id = 1 AND t_user_belonging_channels.deleted_at IS NULL)
    -- 条件3
 	AND t_messages.content LIKE '%アメリカ%'
 	AND t_messages.deleted_at IS NULL
UNION ALL
-- スレッドメッセージテーブルの検索
SELECT t_messages.channel_id AS channel_id,'スレッドメッセージ' AS message_type, 
 		t_tm.user_id AS user_id, t_tm.content AS content, t_tm.created_at AS created_at
	FROM t_messages AS t_messages
   	JOIN t_thread_msssages AS t_tm
    	ON t_tm.message_id = t_messages.id
 	WHERE
    -- 条件1
 		EXISTS (SELECT 1 
            FROM t_channels WHERE t_channels.id = t_messages.channel_id AND t_channels.workspace_id = 1 AND t_channels.deleted_at IS NULL) AND 
    -- 条件2
 	    EXISTS (SELECT 1 FROM t_user_belonging_channels WHERE t_user_belonging_channels.channel_id = t_messages.channel_id AND 		
            t_user_belonging_channels.user_id = 1 AND t_user_belonging_channels.deleted_at IS NULL) AND
			 t_messages.deleted_at IS NULL AND
 			t_tm.deleted_at IS NULL
    -- 条件3
  	AND t_tm.content LIKE '%アメリカ%'
    AND t_tm.deleted_at IS NULL
 ) AS messages_and_threads
	JOIN m_users AS m_users
    	ON m_users.id = messages_and_threads.user_id
    JOIN t_channels AS t_channels
    	ON t_channels.id = messages_and_threads.channel_id
    WHERE m_users.deleted_at IS NULL AND 
    	t_channels.deleted_at IS NULL
 ORDER BY messages_and_threads.created_at ASC;
    
-- 6.あるユーザーがワークスペースに参加する
-- user_id=5の山口まさとが、workspace_id=1の「旅行計画」ワークスペースに参加する
-- SQLのクエリパラメータ
-- (1). user_id チャンネルに参加するユーザーのID
-- (2). workspace_id ユーザーが参加するワークスペースのID

INSERT INTO t_user_belonging_workspaces(user_id,workspace_id) VALUES (5,1)


-- 7.あるユーザーがワークスペースから脱退する
-- user_id=5の山口まさとが、2023/04/05 12:00:00にworkspace_id=1の「旅行計画」ワークスペースから脱退する
-- SQLのクエリパラメータ
-- (1). user_id チャンネルから脱退するユーザーのID
-- (2). workspace_id ユーザーが脱退するワークスペースのID
-- (3). deleted_at ユーザーが脱退する時刻

UPDATE t_user_belonging_workspaces SET deleted_at='2023/04/05 12:00:00' WHERE user_id = 5 AND workspace_id = 1
