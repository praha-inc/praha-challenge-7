# noinspection SqlResolveForFile
# ↑IDEAでエラーを出さないための記述です。

-- ユーザーを作成
INSERT INTO m_users (family_name, first_name, email) VALUES
('高橋', '真弓', 'takahashi.mayumi@mail.mail'),
('加藤', '花子', 'kato.hanako@mail.mail'),
('山田', '宏治', 'yamada.hiroji@mail.mail'),
('中村', '美和', 'nakamura.miwa@mail.mail')
;

SET @takahashi_id = (SELECT id FROM m_users WHERE family_name = '高橋');
SET @kato_id = (SELECT id FROM m_users WHERE family_name = '加藤');
SET @yamada_id = (SELECT id FROM m_users WHERE family_name = '山田');
SET @nakamura_id = (SELECT id FROM m_users WHERE family_name = '中村');

-- ディレクトリを作成
INSERT INTO t_directories (create_user_id, name) VALUES ( @takahashi_id, '高橋_階層0' );
INSERT INTO t_documents (directory_id, create_user_id, name, content) VALUES ((SELECT id FROM t_directories WHERE name = '高橋_階層0'), @takahashi_id, '高橋_階層0_ドキュメント1', '高橋_階層0_本文1' );
INSERT INTO t_directory_closures VALUES ((SELECT id FROM t_directories WHERE name = '高橋_階層0'), (SELECT id FROM t_directories WHERE name = '高橋_階層0'));

INSERT INTO t_directories (create_user_id, name) VALUES ( @takahashi_id, '高橋_階層1' );
INSERT INTO t_documents (directory_id, create_user_id, name, content) VALUES ((SELECT id FROM t_directories WHERE name = '高橋_階層1'), @takahashi_id, '高橋_階層1_ドキュメント1', '高橋_階層1_本文1' );
INSERT INTO t_directory_closures VALUES ((SELECT id FROM t_directories WHERE name = '高橋_階層0'), (SELECT id FROM t_directories WHERE name = '高橋_階層1'));
INSERT INTO t_directory_closures VALUES ((SELECT id FROM t_directories WHERE name = '高橋_階層1'), (SELECT id FROM t_directories WHERE name = '高橋_階層1'));

INSERT INTO t_directories (create_user_id, name) VALUES ( @takahashi_id, '高橋_階層2' );
INSERT INTO t_documents (directory_id, create_user_id, name, content) VALUES ((SELECT id FROM t_directories WHERE name = '高橋_階層2'), @takahashi_id, '高橋_階層2_ドキュメント1', '高橋_階層2_本文1' );
INSERT INTO t_directory_closures VALUES ((SELECT id FROM t_directories WHERE name = '高橋_階層0'), (SELECT id FROM t_directories WHERE name = '高橋_階層2'));
INSERT INTO t_directory_closures VALUES ((SELECT id FROM t_directories WHERE name = '高橋_階層1'), (SELECT id FROM t_directories WHERE name = '高橋_階層2'));
INSERT INTO t_directory_closures VALUES ((SELECT id FROM t_directories WHERE name = '高橋_階層2'), (SELECT id FROM t_directories WHERE name = '高橋_階層2'));

INSERT INTO t_directories (create_user_id, name) VALUES ( @takahashi_id, '高橋_階層3' );
INSERT INTO t_documents (directory_id, create_user_id, name, content) VALUES ((SELECT id FROM t_directories WHERE name = '高橋_階層3'), @takahashi_id, '高橋_階層3_ドキュメント1', '高橋_階層3_本文1' );
INSERT INTO t_directory_closures VALUES ((SELECT id FROM t_directories WHERE name = '高橋_階層0'), (SELECT id FROM t_directories WHERE name = '高橋_階層3'));
INSERT INTO t_directory_closures VALUES ((SELECT id FROM t_directories WHERE name = '高橋_階層1'), (SELECT id FROM t_directories WHERE name = '高橋_階層3'));
INSERT INTO t_directory_closures VALUES ((SELECT id FROM t_directories WHERE name = '高橋_階層2'), (SELECT id FROM t_directories WHERE name = '高橋_階層3'));
INSERT INTO t_directory_closures VALUES ((SELECT id FROM t_directories WHERE name = '高橋_階層3'), (SELECT id FROM t_directories WHERE name = '高橋_階層3'));

INSERT INTO t_directories (create_user_id, name) VALUES ( @kato_id, '加藤_階層0' );
INSERT INTO t_documents (directory_id, create_user_id, name, content) VALUES ((SELECT id FROM t_directories WHERE name = '加藤_階層0'), @kato_id, '加藤_階層0_ドキュメント1', '加藤_階層0_本文1' );
INSERT INTO t_directory_closures VALUES ((SELECT id FROM t_directories WHERE name = '加藤_階層0'), (SELECT id FROM t_directories WHERE name = '加藤_階層0'));

INSERT INTO t_directories (create_user_id, name) VALUES ( @kato_id, '加藤_階層1' );
INSERT INTO t_documents (directory_id, create_user_id, name, content) VALUES ((SELECT id FROM t_directories WHERE name = '加藤_階層1'), @kato_id, '加藤_階層1_ドキュメント1', '加藤_階層1_本文1' );
INSERT INTO t_directory_closures VALUES ((SELECT id FROM t_directories WHERE name = '加藤_階層0'), (SELECT id FROM t_directories WHERE name = '加藤_階層1'));
INSERT INTO t_directory_closures VALUES ((SELECT id FROM t_directories WHERE name = '加藤_階層1'), (SELECT id FROM t_directories WHERE name = '加藤_階層1'));

INSERT INTO t_directories (create_user_id, name) VALUES ( @kato_id, '加藤_階層2' );
INSERT INTO t_documents (directory_id, create_user_id, name, content) VALUES ((SELECT id FROM t_directories WHERE name = '加藤_階層2'), @kato_id, '加藤_階層2_ドキュメント1', '加藤_階層2_本文1' );
INSERT INTO t_directory_closures VALUES ((SELECT id FROM t_directories WHERE name = '加藤_階層0'), (SELECT id FROM t_directories WHERE name = '加藤_階層2'));
INSERT INTO t_directory_closures VALUES ((SELECT id FROM t_directories WHERE name = '加藤_階層1'), (SELECT id FROM t_directories WHERE name = '加藤_階層2'));
INSERT INTO t_directory_closures VALUES ((SELECT id FROM t_directories WHERE name = '加藤_階層2'), (SELECT id FROM t_directories WHERE name = '加藤_階層2'));

INSERT INTO t_directories (create_user_id, name) VALUES ( @yamada_id, '山田_階層0' );
INSERT INTO t_documents (directory_id, create_user_id, name, content) VALUES ((SELECT id FROM t_directories WHERE name = '山田_階層0'), @yamada_id, '山田_階層0_ドキュメント1', '山田_階層0_本文1' );
INSERT INTO t_directory_closures VALUES ((SELECT id FROM t_directories WHERE name = '山田_階層0'), (SELECT id FROM t_directories WHERE name = '山田_階層0'));

INSERT INTO t_directories (create_user_id, name) VALUES ( @nakamura_id, '中村_階層0' );
INSERT INTO t_documents (directory_id, create_user_id, name, content) VALUES ((SELECT id FROM t_directories WHERE name = '中村_階層0'), @nakamura_id, '中村_階層0_ドキュメント1', '中村_階層0_本文1' );
INSERT INTO t_directory_closures VALUES ((SELECT id FROM t_directories WHERE name = '中村_階層0'), (SELECT id FROM t_directories WHERE name = '中村_階層0'));

-- ドキュメントを作成
INSERT INTO t_documents (directory_id, create_user_id, name, content) VALUES ((SELECT id FROM t_directories WHERE name = '高橋_階層0'), @takahashi_id, '高橋_階層0_ドキュメント2', '高橋_階層0_本文2' );
INSERT INTO t_documents (directory_id, create_user_id, name, content) VALUES ((SELECT id FROM t_directories WHERE name = '加藤_階層0'), @kato_id, '加藤_階層0_ドキュメント2', '高橋_階層0_本文2' );
INSERT INTO t_documents (directory_id, create_user_id, name, content) VALUES ((SELECT id FROM t_directories WHERE name = '山田_階層0'), @yamada_id, '山田_階層0_ドキュメント2', '山田_階層0_本文2' );
INSERT INTO t_documents (directory_id, create_user_id, name, content) VALUES ((SELECT id FROM t_directories WHERE name = '中村_階層0'), @nakamura_id, '中村_階層0_ドキュメント2', '中村_階層0_本文2' );
