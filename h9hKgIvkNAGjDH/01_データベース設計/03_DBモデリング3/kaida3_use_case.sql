-- ユースケース1
-- 「篠原りょうこ」(id=1)ユーザが持つすべてのディレクトリを取得する
-- user_idで検索する場合
SELECT * FROM directories WHERE user_id = 1;

-- 「篠原りょうこ」のルートノード(id=1)で検索する場合
WITH RECURSIVE r AS (
	SELECT * FROM directories WHERE id=1
UNION ALL
	SELECT directories.* FROM directories, r
	WHERE directories.parent_directory_id = r.id
)
SELECT * FROM r;

-- ユースケース2
-- 「旅行の思い出」(id=3)ディレクトリの直下のディレクトリをすべて取得する
SELECT * FROM directories
	WHERE parent_directory_id  =3;
-- 「旅行の思い出」(id=3)ディレクトリの直下のドキュメントをすべて取得する
SELECT * FROM documents
	WHERE directory_id = 3;

-- ユースケース3
-- 「海外旅行」ディレクトリ(id=6)に、「イギリス旅行」ディレクトリを作成し、「イギリスの思い出」ドキュメントを作成する
INSERT INTO directories (name,parent_directory_id,user_id) VALUES ('イギリス旅行',6,1);
-- PHPの場合、PDO::lastInsertIdで「イギリス旅行」のID(13)を得る
INSERT INTO documents (directory_id,title,content,user_id) VALUES (13,'イギリス旅行の思い出','バッキンガム宮殿に言ってきた',1);


-- ユースケース4
-- 指定したディレクトリを別のディレクトリの下に移動する
-- 「海外旅行」直下の「アメリカ旅行」ディレクトリ(id=7)を「旅行の思い出」(id=3)直下に移動する
-- a.ディレクトリの移動
UPDATE directories SET parent_directory_id = 3 WHERE id = 7;
-- b.ドキュメントの移動
UPDATE documents SET directory_id = 3 WHERE directory_id = 7;


-- ユースケース5
-- 特定のディレクトリを削除する（そこの保存されているファイル、また下にあるディレクトリとファイルも削除される）
-- 「海外旅行」ディレクトリ(id=6)を削除する
-- a.ディレクトリの削除
DELETE FROM directories WHERE id IN (
WITH RECURSIVE r AS (
	SELECT * FROM directories WHERE id=6
UNION ALL 
	SELECT directories.* FROM directories,r
	WHERE directories.parent_directory_id =r.id
)
SELECT id FROM r
);
-- b.ドキュメントの削除
DELETE FROM documents WHERE directory_id  IN (
WITH RECURSIVE r AS (
	SELECT * FROM directories WHERE id=6
UNION ALL 
	SELECT directories.* FROM directories,r
	WHERE directories.parent_directory_id =r.id
)
SELECT id FROM r
);



