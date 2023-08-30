# noinspection SqlResolveForFile
# ↑IDEAでエラーを出さないための記述です。

-- 頻度を作成
-- frequency_value に入る値はアプリでバリデーション想定
INSERT INTO m_frequencies (id) VALUES
(1),
(2),
(3),
(4),
(5);

-- 今回テキストの内容をアプリ側で正規表現で検索し、ユーザーIDを抽出する前提なので、テーブルはありませんが以下のユーザーが存在する想定とします。
-- id: manager
-- id: engineer
-- id: designer

SELECT * FROM m_frequencies;
