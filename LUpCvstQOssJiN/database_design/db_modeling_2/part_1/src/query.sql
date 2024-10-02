/*
  [ユースケースを想定したクエリ1]
  あるワークスペース({ id: 1, name: プラハアカデミー })のtimesチャンネル({ id: 5, name: times_sato })に投稿したメッセージで
  「MySQL」が含まれているメッセージを全て取得する(スレッドメッセージも検索対象とする)
  EXPLAIN済み(問題なし)
  とはいえ、最初にEXPLAINをしたときは中間一致をしていたので、フルテキストインデックスで書き直した
*/
SELECT specific_chat_messages.id, specific_chat_messages.body
FROM (
  SELECT *
  FROM work_spaces
  WHERE id = 1
) AS specific_work_spaces
INNER JOIN (
  SELECT *
  FROM chat_channels
  WHERE id = 5
) AS specific_chat_channels
ON specific_work_spaces.id = specific_chat_channels.work_space_id
INNER JOIN (
  SELECT *
  FROM chat_messages
  WHERE MATCH(body) AGAINST ("MySQL" IN NATURAL LANGUAGE MODE)
) AS specific_chat_messages
ON specific_chat_channels.id = specific_chat_messages.chat_channel_id;

/*
  [ユースケースを想定したクエリ2]
  あるワークスペース({ id: 1, name: プラハアカデミー })の全チャンネルを横断して「MySQL」が含まれているメッセージを全て取得する
  (スレッドメッセージも検索対象とする)
  EXPLAIN済み(問題あり)
  フルテキストインデックスをbodyに貼ったら、改善された
  日本語というのもあって、検索対象文字列との完璧な一致が保証されるわけではないが、類似性が高いものが取得できる
*/
SELECT specific_chat_messages.id, specific_chat_messages.body
FROM (
  SELECT *
  FROM work_spaces
  WHERE id = 1
) AS specific_work_spaces
INNER JOIN chat_channels
ON specific_work_spaces.id = chat_channels.work_space_id
INNER JOIN (
  SELECT *
  FROM chat_messages
  WHERE MATCH(body) AGAINST ("MySQL" IN NATURAL LANGUAGE MODE)
) AS specific_chat_messages
ON chat_channels.id = specific_chat_messages.chat_channel_id;

/*
  [ユースケースを想定したクエリ3]
  あるワークスペース({ id: 1, name: プラハアカデミー })に所属しているあるユーザー({ id: 3, name: 佐藤プラハ })が発言しているスレッドの一覧を取得できる
  EXPLAIN済み(問題なし)
*/
SELECT chat_threads.*
FROM (
  SELECT *
  FROM work_spaces
  WHERE id = 1
) AS specific_work_spaces
INNER JOIN user_work_spaces
ON specific_work_spaces.id = user_work_spaces.work_space_id
INNER JOIN (
  SELECT *
  FROM users
  WHERE id = 3
) AS specific_users
ON user_work_spaces.user_id = specific_users.id
INNER JOIN user_chat_threads
ON specific_users.id = user_chat_threads.user_id
INNER JOIN chat_threads
ON user_chat_threads.chat_thread_id = chat_threads.id;

/*
  [ユースケースを想定したクエリ5]
  あるワークスペース({ id: 1, name: プラハアカデミー })のtimesチャンネル({ id: 5, name: times_sato })に参加しているユーザーを全て取得する
  EXPLAIN済み(問題なし)
*/
SELECT users.*
FROM (
  SELECT *
  FROM work_spaces
  WHERE id = 1
) AS specific_work_spaces
INNER JOIN (
  SELECT *
  FROM chat_channels
  WHERE id = 5
) AS specific_chat_channels
ON specific_work_spaces.id = specific_chat_channels.work_space_id
INNER JOIN user_chat_channels
on specific_chat_channels.id = user_chat_channels.chat_channel_id
INNER JOIN users
ON user_chat_channels.user_id = users.id;

/*
  [ユースケースを想定したクエリ6]
  あるワークスペース({ id: 1, name: プラハアカデミー })の自分({ id: 3, name: 佐藤プラハ })が参加しているチャンネルを全て取得する
  EXLAIN済み(問題なし)
*/
SELECT cc.*
FROM (
  SELECT *
  FROM work_spaces
  WHERE id = 1
) AS specific_work_spaces
INNER JOIN chat_channels AS cc
ON specific_work_spaces.id = cc.work_space_id
INNER JOIN (
  SELECT *
  FROM user_chat_channels
  WHERE user_id = 3
) AS specific_user_chat_channels
ON cc.id = specific_user_chat_channels.chat_channel_id;

/*
  [ユースケースを想定したクエリ7]
  あるユーザー({ id: 2, name: 田中プラハ })が所属しているワークスペースを全て取得する
  EXLAIN済み(問題なし)
*/
SELECT ws.*
FROM (
  SELECT *
  FROM user_work_spaces
  WHERE user_id = 2
) AS specific_user_work_spaces
INNER JOIN work_spaces AS ws
ON specific_user_work_spaces.work_space_id = ws.id;
