-- DBを作成
DROP DATABASE IF EXISTS praha_igarashi_confluence_naive;
CREATE DATABASE IF NOT EXISTS praha_igarashi_confluence_naive CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE praha_igarashi_confluence_naive;

# \! echo 'DDL実行'

-- テーブルを作成
CREATE TABLE `m_users` (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    family_name VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    is_deleted VARCHAR(1) NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id)
);

CREATE TABLE `t_directories` (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    parent_directory_id INT UNSIGNED NULL,
    create_user_id INT UNSIGNED NOT NULL,
    update_user_id INT UNSIGNED NULL,
    name VARCHAR(255) NOT NULL,
    is_deleted VARCHAR(1) NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),

    FOREIGN KEY (parent_directory_id) REFERENCES t_directories(id),
    FOREIGN KEY (create_user_id) REFERENCES m_users(id),
    FOREIGN KEY (update_user_id) REFERENCES m_users(id)
);

CREATE TABLE `t_documents` (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    directory_id INT UNSIGNED NOT NULL,
    create_user_id INT UNSIGNED NOT NULL,
    update_user_id INT UNSIGNED NULL,
    name VARCHAR(255) NOT NULL,
    content VARCHAR(10000) NOT NULL,
    is_deleted VARCHAR(1) NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),

    FOREIGN KEY (directory_id) REFERENCES t_directories(id),
    FOREIGN KEY (create_user_id) REFERENCES m_users(id),
    FOREIGN KEY (update_user_id) REFERENCES m_users(id)
);
