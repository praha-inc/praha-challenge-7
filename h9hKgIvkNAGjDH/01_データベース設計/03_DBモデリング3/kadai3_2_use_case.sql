-- ユースケース1
-- 「チーム1」(id=1)ユーザが持つすべてのディレクトリを取得する
-- user_group_idで検索する場合
SELECT * FROM directories WHERE user_group_id = 1;

-- 「チーム1」のルートノード(id=1)で検索する場合
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
-- 「チーム1」の「海外旅行」ディレクトリ(id=6)に、「イギリス旅行」ディレクトリを作成し、「イギリスの思い出」ドキュメントを作成する
INSERT INTO directories (name,parent_directory_id,user_group_id) VALUES ('イギリス旅行',6,1);
-- PHPの場合、PDO::lastInsertIdで「イギリス旅行」のID(12)を得る
INSERT INTO documents (directory_id,title,content,user_group_id) VALUES (12,'イギリス旅行の思い出','バッキンガム宮殿に言ってきた',1);


-- ユースケース4
-- 指定したディレクトリを別のディレクトリの下に移動する
-- 「旅行の思い出」直下の「沖縄旅行」ディレクトリ(id=5)を「レシピ」(id=2)直下に移動する
UPDATE directories SET parent_directory_id = 2 WHERE id = 5;


-- ユースケース5
-- 特定のディレクトリを削除する（そこの保存されているファイル、また下にあるディレクトリとファイルも削除される）
-- 前回は、再帰クエリを用いて削除した。今回、付与するのを忘れていたSTRICTで外部キー制約を付けたら、削除の時に制約違反になってしまった。
-- そのため、外部キー制約をON CASCADEで付与した。このため、参照元のレコードを削除すれば、それを参照するレコードも削除されるため、再帰クエリは不要
-- あるディレクトリを削除すると、その配下のディレクトリが削除される。さらに、削除された複数のディレクトリの属していた各ファイルも削除される
-- この方法は、SQLはすごくシンプルになるが、下記の一文でディレクトリだけでなく、ファイルまで消えてしまうのは、ちょっと危ないかもしれない（挙動が予測しにくい）
-- 外部キー制約をもっと適切に運用する方法があるかもしれない
-- 「海外旅行」ディレクトリ(id=6)とその配下にあるディレクトリとファイルをすべて削除する
DELETE FROM directories WHERE id = 6;

-- ユースケース6
-- 北海道旅行(id=4)の下にあるファイルを並び順通りに取得する
SELECT * FROM documents WHERE directory_id = 4 ORDER BY sort_order ASC;
-- 北海道旅行(id=4)の下にあるファイルを以下の順番に並び替える
-- 変更前：上から「函館山から見た夜景の話」「海鮮丼がうますぎる」「五稜郭に行ってきた」
-- 変更後：上から「海鮮丼がうますぎる」「五稜郭に行ってきた」「函館山から見た夜景の話」
-- フロントエンド側から、[['sort_order'=>'id'],...]配列を受け取り、バックエンドで処理する
-- 上記であれば、[[1=>4],[2=>3],[3=>2]]の配列を受け取り、以下のようなSQLを発行する
UPDATE documents SET sort_order=1 WHERE id = 4;
UPDATE documents SET sort_order=2 WHERE id = 3;
UPDATE documents SET sort_order=3 WHERE id = 2;
-- UPDATE実行後、再び、下記SELECT文で順番が変わっていることが分かる
SELECT * FROM documents WHERE directory_id = 4 ORDER BY sort_order ASC;
