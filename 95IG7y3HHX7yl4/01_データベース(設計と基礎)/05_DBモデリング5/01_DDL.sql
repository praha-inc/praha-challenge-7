START TRANSACTION;

DROP TABLE IF EXISTS `content_histories`;
DROP TABLE IF EXISTS `contents`;
DROP TABLE IF EXISTS `accounts`;

CREATE TABLE accounts (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    display_name VARCHAR(255) NOT NULL,
    profile_image_url VARCHAR(255) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE contents (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    account_id INT NULL,
    content_title VARCHAR(255) NOT NULL,
    content_body TEXT,
    delete_at  TIMESTAMP NULL DEFAULT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES accounts(id) ON DELETE SET NULL
);

CREATE TABLE content_histories (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    content_id INT NULL,
    account_id INT NULL,
    content_title VARCHAR(255) NOT NULL,
    content_body TEXT,
    delete_at  TIMESTAMP NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    operation ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    operation_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- -- INSERT操作用のトリガー
DELIMITER ;;
CREATE TRIGGER contents_insert_history
AFTER INSERT ON contents
FOR EACH ROW
BEGIN
    INSERT INTO content_histories
    (content_id, account_id, content_title, content_body, delete_at, created_at, updated_at, operation, operation_date)
    VALUES
    (NEW.id, NEW.account_id, NEW.content_title, NEW.content_body, NEW.delete_at, NEW.created_at, NEW.updated_at, 'INSERT', NOW());
END;;
DELIMITER ;
-- -- UPDATE操作用のトリガー
DELIMITER ;;
CREATE TRIGGER contents_update_history
AFTER UPDATE ON contents
FOR EACH ROW
BEGIN
    INSERT INTO content_histories
    (content_id, account_id, content_title, content_body, delete_at, created_at, updated_at, operation, operation_date)
    VALUES
    (NEW.id, NEW.account_id, NEW.content_title, NEW.content_body, NEW.delete_at, NEW.created_at, NEW.updated_at, 'UPDATE', NOW());
END;;
DELIMITER ;
-- -- DELETE操作用のトリガー
DELIMITER ;;
CREATE TRIGGER contents_delete_history
BEFORE DELETE ON contents
FOR EACH ROW
BEGIN
    INSERT INTO content_histories
    (content_id, account_id, content_title, content_body, delete_at, created_at, updated_at, operation, operation_date)
    VALUES
    (OLD.id, OLD.account_id, OLD.content_title, OLD.content_body, OLD.delete_at, OLD.created_at, OLD.updated_at, 'DELETE', NOW());
END;;
DELIMITER ;

COMMIT;