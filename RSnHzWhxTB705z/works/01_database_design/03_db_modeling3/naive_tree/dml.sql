# noinspection SqlResolveForFile
# ↑IDEAでエラーを出さないための記述です。

# \! echo 'DML実行'

/**
  ディレクトリの作成（ディレクトリは必ず1つ以上のドキュメントを含むため、ドキュメントの作成も同時に行う）

  ストアドプロシージャの作成
  メモ： DELIMITER = PHPのヒアドキュメントみたいなもの？
 */
DELIMITER //
CREATE PROCEDURE create_directory (
    IN arg_directory_parent_directory_id INT UNSIGNED,
    IN arg_create_user_id INT UNSIGNED,
    IN arg_directory_name VARCHAR(255),
    IN arg_document_name VARCHAR(255),
    IN arg_document_content VARCHAR(10000)
        )
BEGIN

    DECLARE dir_id INT UNSIGNED;
    DECLARE doc_id INT UNSIGNED;

# ディレクトリの作成
    INSERT INTO t_directories (parent_directory_id, create_user_id, name) VALUES
    (arg_directory_parent_directory_id, arg_create_user_id, arg_directory_name);
# ドキュメントの作成
SET @dir_id = (SELECT id FROM t_directories ORDER BY id DESC LIMIT 1);
    INSERT INTO t_documents (directory_id, create_user_id, name, content) VALUES
    (@dir_id, arg_create_user_id, arg_document_name, arg_document_content);

END//
DELIMITER ;

/**
  ドキュメントを作成する処理
 */
DELIMITER //
CREATE PROCEDURE create_document (
    IN arg_directory_id INT UNSIGNED,
    IN arg_create_user_id INT UNSIGNED,
    IN arg_document_name VARCHAR(255),
    IN arg_document_content VARCHAR(10000)
        )
BEGIN

    DECLARE doc_id INT UNSIGNED;

# ドキュメントの作成
    INSERT INTO t_documents (directory_id, create_user_id, name, content) VALUES
    (arg_directory_id, arg_create_user_id, arg_document_name, arg_document_content);

END//
DELIMITER ;

/**
  各ユーザーがディレクトリを作成する処理
 */
DELIMITER //
CREATE PROCEDURE loop_users_operation (
    IN function_number INT
)
BEGIN

    # カーソルから読み出した値を格納する変数
    DECLARE create_user_id INT UNSIGNED;
    DECLARE directory_name VARCHAR(255);

    # カーソルがデータセットの最後に達したか判定するための変数
    DECLARE done BOOLEAN DEFAULT FALSE;

    # カーソルを定義
    DECLARE users_cursor CURSOR FOR
SELECT id, family_name FROM m_users;

# カーソルがデータセットの最後に達したときに処理を終了するための条件
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    # カーソルをオープン
    OPEN users_cursor;

    # ループで1行ずつ処理
    users_loop: LOOP

        # カーソルから1行読み出し
        FETCH users_cursor INTO create_user_id, directory_name;

        # カーソルからの読み出しが終わっていればループを抜ける
        IF done THEN
            LEAVE users_loop;
END IF ;

        IF function_number = 1 THEN
            CALL create_directory(NULL, create_user_id, CONCAT(directory_name, '_階層0'), CONCAT(directory_name, '_階層0_ドキュメント1'), CONCAT(directory_name, '_階層0', '_本文1'));
        ELSEIF function_number = 2 THEN
            CALL create_document((SELECT t_directories.id FROM t_directories WHERE t_directories.create_user_id = create_user_id), create_user_id, CONCAT(directory_name, '_階層0_ドキュメント2'), CONCAT(directory_name, '_階層0', '_本文2'));
END IF ;

END LOOP ;

    # カーソルをクローズ
    CLOSE users_cursor;

END//
DELIMITER ;

INSERT INTO m_users (family_name, first_name, email) VALUES
('高橋', '真弓', 'takahashi.mayumi@mail.mail'),
('加藤', '花子', 'kato.hanako@mail.mail'),
('山田', '宏治', 'yamada.hiroji@mail.mail'),
('中村', '美和', 'nakamura.miwa@mail.mail')
;

-- 各ユーザーが自分用のディレクトリを作成
CALL loop_users_operation(1);

-- 各ユーザーが自分用のディレクトリに文書を作成
CALL loop_users_operation(2);

-- 高橋 がサブディレクトリを作成
SET @user_id = (SELECT id FROM m_users WHERE email = 'takahashi.mayumi@mail.mail');
CALL create_directory(
        (SELECT id FROM t_directories WHERE create_user_id = @user_id), @user_id, '高橋_階層1', '高橋_階層1_ドキュメント1', '高橋_階層1_本文1'
    );
CALL create_directory(
        (SELECT id FROM t_directories WHERE create_user_id = @user_id AND name = '高橋_階層1'), @user_id, '高橋_階層2', '高橋_階層2_ドキュメント1', '高橋_階層2_本文1'
    );
CALL create_directory(
        (SELECT id FROM t_directories WHERE create_user_id = @user_id AND name = '高橋_階層2'), @user_id, '高橋_階層3', '高橋_階層3_ドキュメント1', '高橋_階層3_本文1'
    );

-- 加藤 がサブディレクトリを作成
SET @user_id1 = (SELECT id FROM m_users WHERE email = 'kato.hanako@mail.mail');
CALL create_directory(
        (SELECT id FROM t_directories WHERE create_user_id = @user_id1), @user_id1, '加藤_階層1', '加藤_階層1_ドキュメント1', '加藤_階層1_本文1'
    );
CALL create_directory(
        (SELECT id FROM t_directories WHERE create_user_id = @user_id1 AND name = '加藤_階層1'), @user_id1, '加藤_階層2', '加藤_階層2_ドキュメント1', '加藤_階層2_本文1'
    );


