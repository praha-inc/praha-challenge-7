
-- ドキュメント
-- いつ、誰が、どんなテキスト情報を保存したのか管理する。 ドキュメントは必ず何らかのディレクトリに属する
-- ディレクトリ
-- 一つ以上のドキュメントを含む階層構造。ディレクトリは無制限にサブディレクトリを持つことができる

-- ⇒　ディレクトリ一覧の取得。何度も使うのでViewにしておく
CREATE VIEW DocumentListView AS
  SELECT Document.*, UserPermittedDocument.Permission
  FROM Document 
  INNER JOIN UserPermittedDocument ON Document.ID = UserPermittedDocument.DocumentId 
  WHERE UserPermittedDocument.UserId = 1 AND Permission > 0
  ORDER BY Document.Path, DocumentType DESC, Document.Order;


-- ディレクトリ構造は柔軟に変更可能。ディレクトリが移動してサブディレクトリになることもあり得る
-- ⇒　旅行ディレクトリを趣味ディレクトリの下に変更。
START TRANSACTION;
  UPDATE Document SET Path = REPLACE(Path,'/1/2/', '/1/6/2/')
  WHERE Path Like '/1/2/%' ;
COMMIT;

-- ⇒ 一覧の再取得
SELECT * FROM DocumentListView;

-- ユーザはドキュメントをCRUD（作成、参照、更新、削除）できる
-- ⇒ 仕事フォルダの下に議事録.txtを作成
START TRANSACTION;
  -- ⇒ 生成予定のIDを変数に格納
  SET @new_id = (SELECT MAX(ID) + 1 FROM Document);
  SET @Max_order = (SELECT IFNULL(Document.Order,0) + 1 FROM Document WHERE Path = '/1/12/' AND DocumentType = 'FILE');

  -- ⇒ 仕事フォルダの下に議事録.txtを作成
  INSERT INTO Document (
    ID, Name, Path, CreateAt, UpdateAt, DocumentType, CreateUserId, UpdateUserId, Document.Order)
  VALUES (
    @new_id, '議事録.txt', '/1/12/', now(), now(), 'FILE', 1, 1, @Max_order);
  -- ⇒ パーミッションの管理の設定
  INSERT INTO UserPermittedDocument (UserId, DocumentId, Permission)
  VALUES ( 1, @new_id, 6);
COMMIT;

-- ⇒ 一覧の再取得
SELECT * FROM DocumentListView;

-- ディレクトリをCRUDできる
-- ⇒ ディレクトリの作成。アウトドアのディレクトリの下に「マップ」ディレクトリを作成し、その下に「登山道マップ.pdf」を移動
START TRANSACTION;
  -- ⇒ 生成予定のIDを変数に格納
  SET @new_id = (SELECT MAX(ID) + 1 FROM Document);
  SET @new_path = (SELECT CONCAT('/1/6/9/',@new_id, '/'));
  -- ⇒ マップディレクトリの作成
  INSERT INTO Document (
    ID, Name, Path, CreateAt, UpdateAt, DocumentType, CreateUserId, UpdateUserId, Document.Order)
  VALUES (
    @new_id, 'マップ', @new_path, now(), now(), 'DIRECTORY', 1, 1, 1);
  -- ⇒ パーミッションの管理の設定
  INSERT INTO UserPermittedDocument (UserId, DocumentId, Permission)
  VALUES ( 1, @new_id, 6);

  -- ⇒ マップの下に「登山道マップ.pdf」を移動
  UPDATE Document SET Path = @new_path WHERE ID = 11 ;
COMMIT;

-- ⇒ 一覧の再取得
SELECT * FROM DocumentListView;


-- ディレクトリの削除
-- ⇒ マップディレクトリを中のファイルごと削除。UserPermittedDocumentはカスケードDELETE
START TRANSACTION;
  DELETE FROM Document
  WHERE Path Like '/1/6/9/15/%';
COMMIT;


-- ⇒ 一覧の再取得
SELECT * FROM DocumentListView;

-- 課題２

-- ディレクトリ内のドキュメントの順番を変更できる

-- ⇒浮動小数点で対応する方法を選択
ALTER TABLE Document MODIFY Document.Order FLOAT;

-- ⇒　料理ディレクトリを趣味ディレクトリの下に入れて、旅行とアウトドアディレクトリの間に挿入
START TRANSACTION;
  -- 2番目に入れたいため、1番目と2番目を取得
  SET @TOP1 = (SELECT Document.Order FROM Document WHERE DocumentType = 'DIRECTORY' AND Path Like '/1/3/6/%' ORDER BY Document.Order LIMIT 1);
  SET @TOP2 = (SELECT Document.Order FROM Document WHERE DocumentType = 'DIRECTORY' AND Path Like '/1/3/6/%' ORDER BY Document.Order DESC LIMIT 1);
  SET @new_order = (SELECT (@TOP1 + @TOP2) / 2);
  UPDATE Document SET Path = REPLACE(Path,'/1/3/', '/1/3/6/2/3/'), Document.Order = @new_order WHERE Path Like '/1/3/%' ;
COMMIT;

-- ⇒ 一覧の再取得
SELECT * FROM DocumentListView;