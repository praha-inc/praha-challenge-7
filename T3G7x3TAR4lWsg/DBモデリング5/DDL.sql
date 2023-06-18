BEGIN TRANSACTION;

INSERT INTO "Author" ("ID", "name")
VALUES 
(1, '平川知秀'),
(2, '田中秀樹');

INSERT INTO "Post" ("ID", "Title", "Content", "Author", "Created_At", "Update_At" ,"Delete_At")
VALUES 
(1, '初めてのブログ投稿', 'これは私の初めてのブログ投稿です。よろしくお願いします。', 1, '2023-06-18 10:00:00', NULL, NULL),
(2, 'データベース設計について', 'データベース設計はとても重要なスキルです。この投稿では基本的な設計方法について説明します。', 2, '2023-06-18 11:00:00', NULL, NULL);

COMMIT;