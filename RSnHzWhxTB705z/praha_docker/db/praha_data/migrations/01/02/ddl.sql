-- DBを作成
CREATE DATABASE IF NOT EXISTS praha_slack CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE praha_slack;

-- テーブルを作成
CREATE TABLE `users` (
    id CHAR(36) NOT NULL,
    name VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

CREATE TABLE `workspaces` (
    id CHAR(36) NOT NULL,
    name VARCHAR(255) NOT NULL,
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

CREATE TABLE `users_workspaces` (
    id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    workspace_id CHAR(36) NOT NULL,
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),

    FOREIGN KEY (user_id)
        REFERENCES users(id),

    FOREIGN KEY (workspace_id)
        REFERENCES workspaces(id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

CREATE TABLE `channels` (
    id CHAR(36) NOT NULL,
    workspace_id CHAR(36) NOT NULL,
    name VARCHAR(255) NOT NULL,
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),

    FOREIGN KEY (workspace_id)
        REFERENCES workspaces(id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

CREATE TABLE `users_channels` (
    id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    channel_id CHAR(36) NOT NULL,
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),

    FOREIGN KEY (user_id)
        REFERENCES users(id),

    FOREIGN KEY (channel_id)
        REFERENCES channels(id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

CREATE TABLE `messages` (
    id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    channel_id CHAR(36) NOT NULL,
    content VARCHAR(2000) NOT NULL,
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),

    FOREIGN KEY (user_id)
        REFERENCES users(id),

    FOREIGN KEY (channel_id)
        REFERENCES channels(id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

CREATE TABLE `thread_messages` (
    id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    message_id CHAR(36) NOT NULL,
    content VARCHAR(2000) NOT NULL,
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),

    FOREIGN KEY (user_id)
        REFERENCES users(id),

    FOREIGN KEY (message_id)
        REFERENCES messages(id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
