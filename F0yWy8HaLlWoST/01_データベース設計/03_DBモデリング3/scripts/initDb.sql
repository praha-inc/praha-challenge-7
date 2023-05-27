use mysqldb;

-- テーブル作成

create table M_USERS (
    user_id binary(16) primary key default (UUID_TO_BIN(UUID(), 1)),
    name varchar(100) not null,
    is_deleted boolean not null default false,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

create table M_DIRECTORIES (
    directory_id binary(16) primary key default (UUID_TO_BIN(UUID(), 1)),
    user_id binary(16) not null references M_USERS(user_id),
    parent_directory_id binary(16) references M_DIRECTORIES(directory_id),
    name varchar(100) not null,
    is_deleted boolean not null default false,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

create table M_DOCUMENTS (
    document_id binary(16) primary key default (UUID_TO_BIN(UUID(), 1)),
    created_user_id binary(16) not null references M_USERS(user_id),
    updated_user_id binary(16) not null references M_USERS(user_id),
    directory_id binary(16) not null references M_DIRECTORIES(directory_id),
    name varchar(100) not null,
    detail varchar(1000) not null,
    index_in_directory int not null,
    is_deleted boolean not null default false,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

-- ダミーデータ作成

insert into M_USERS(user_id, name) values
    (UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), 'Harvey Alvarado'),
    (UUID_TO_BIN('88dd50b4-5644-5ed8-ae7d-50157923fd70', 1), 'Adam Webster'),
    (UUID_TO_BIN('d7ee2310-0642-56ba-9824-d23144b0cf3f', 1), 'Dennis Spencer'),
    (UUID_TO_BIN('d02b0cd0-2e95-50ff-93cb-f41cc22aa639', 1), 'Mary Hines'),
    (UUID_TO_BIN('530c7220-e65d-596b-aa0d-9d80ea5d26c2', 1), 'Matilda Crawford'),
    (UUID_TO_BIN('f3ea110d-ecb3-5a5c-910c-92e4e710ba81', 1), 'Gary Jordan'),
    (UUID_TO_BIN('cf2d74dd-b255-5966-b6f9-5af1397a19b8', 1), 'Bertha Welch'),
    (UUID_TO_BIN('de02349a-f87f-5b4e-a7ed-2d0861f98bf0', 1), 'Aaron Poole'),
    (UUID_TO_BIN('4e200eb3-5146-56c1-880f-f2706c6f65f3', 1), 'Gene Walters'),
    (UUID_TO_BIN('1b43927e-1905-5f27-83b3-0ba301c5341a', 1), 'Mathilda Silva');

insert into M_DIRECTORIES(directory_id, user_id, parent_directory_id, name) values
    (UUID_TO_BIN('c0b0b0a0-0000-0000-0000-000000000000', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), null, 'root'),
    (UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368b6', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('c0b0b0a0-0000-0000-0000-000000000000', 1), 'ディレクトリ1'),
    (UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368b7', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('c0b0b0a0-0000-0000-0000-000000000000', 1), 'ディレクトリ2'),
    (UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368b8', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('c0b0b0a0-0000-0000-0000-000000000000', 1), 'ディレクトリ3'),
    (UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368b9', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('c0b0b0a0-0000-0000-0000-000000000000', 1), 'ディレクトリ4'),
    (UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368ba', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('c0b0b0a0-0000-0000-0000-000000000000', 1), 'ディレクトリ5'),
    (UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368bb', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('c0b0b0a0-0000-0000-0000-000000000000', 1), 'ディレクトリ6'),
    (UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368bc', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('c0b0b0a0-0000-0000-0000-000000000000', 1), 'ディレクトリ7'),
    (UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368bd', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('c0b0b0a0-0000-0000-0000-000000000000', 1), 'ディレクトリ8'),
    (UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368be', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368b6', 1), 'ディレクトリ9'),
    (UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368bf', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368b6', 1), 'ディレクトリ10'),
    (UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368c0', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368b6', 1), 'ディレクトリ11'),
    (UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368c1', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368b6', 1), 'ディレクトリ12'),
    (UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368c2', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368b6', 1), 'ディレクトリ13'),
    (UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368c3', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368b6', 1), 'ディレクトリ14'),
    (UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368c4', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368b6', 1), 'ディレクトリ15'),
    (UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368c5', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368b6', 1), 'ディレクトリ16'),
    (UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368c6', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368b6', 1), 'ディレクトリ17'),
    (UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368c7', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368b6', 1), 'ディレクトリ18'),
    (UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368c8', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368b6', 1), 'ディレクトリ19');

insert into M_DOCUMENTS(document_id, created_user_id, updated_user_id, directory_id, name, detail, index_in_directory) values
    (UUID_TO_BIN('2280a86b-ad8b-5121-bcb8-1bcc8c82b2ab', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368b6', 1), 'ファイル1', 'ファイル1の詳細', 0),
    (UUID_TO_BIN('2280a86b-ad8b-5121-bcb8-1bcc8c82b2ac', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368b6', 1), 'ファイル2', 'ファイル2の詳細', 1),
    (UUID_TO_BIN('2280a86b-ad8b-5121-bcb8-1bcc8c82b2ad', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368b6', 1), 'ファイル3', 'ファイル3の詳細', 2),
    (UUID_TO_BIN('2280a86b-ad8b-5121-bcb8-1bcc8c82b2ae', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368b6', 1), 'ファイル4', 'ファイル4の詳細', 3),
    (UUID_TO_BIN('2280a86b-ad8b-5121-bcb8-1bcc8c82b2af', 1), UUID_TO_BIN('530c7220-e65d-596b-aa0d-9d80ea5d26c2', 1), UUID_TO_BIN('530c7220-e65d-596b-aa0d-9d80ea5d26c2', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368ba', 1), 'ファイル5', 'ファイル5の詳細', 0),
    (UUID_TO_BIN('2280a86b-ad8b-5121-bcb8-1bcc8c82b2b0', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368ba', 1), 'ファイル6', 'ファイル6の詳細', 1),
    (UUID_TO_BIN('2280a86b-ad8b-5121-bcb8-1bcc8c82b2b1', 1), UUID_TO_BIN('530c7220-e65d-596b-aa0d-9d80ea5d26c2', 1), UUID_TO_BIN('530c7220-e65d-596b-aa0d-9d80ea5d26c2', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368ba', 1), 'ファイル7', 'ファイル7の詳細', 2),
    (UUID_TO_BIN('2280a86b-ad8b-5121-bcb8-1bcc8c82b2b2', 1), UUID_TO_BIN('530c7220-e65d-596b-aa0d-9d80ea5d26c2', 1), UUID_TO_BIN('530c7220-e65d-596b-aa0d-9d80ea5d26c2', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368ba', 1), 'ファイル8', 'ファイル8の詳細', 3),
    (UUID_TO_BIN('2280a86b-ad8b-5121-bcb8-1bcc8c82b2b3', 1), UUID_TO_BIN('530c7220-e65d-596b-aa0d-9d80ea5d26c2', 1), UUID_TO_BIN('530c7220-e65d-596b-aa0d-9d80ea5d26c2', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368ba', 1), 'ファイル9', 'ファイル9の詳細', 4),
    (UUID_TO_BIN('2280a86b-ad8b-5121-bcb8-1bcc8c82b2b4', 1), UUID_TO_BIN('530c7220-e65d-596b-aa0d-9d80ea5d26c2', 1), UUID_TO_BIN('530c7220-e65d-596b-aa0d-9d80ea5d26c2', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368bf', 1), 'ファイル10', 'ファイル10の詳細', 0),
    (UUID_TO_BIN('2280a86b-ad8b-5121-bcb8-1bcc8c82b2b5', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368c0', 1), 'ファイル11', 'ファイル11の詳細', 0),
    (UUID_TO_BIN('2280a86b-ad8b-5121-bcb8-1bcc8c82b2b6', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368c1', 1), 'ファイル12', 'ファイル12の詳細', 0),
    (UUID_TO_BIN('2280a86b-ad8b-5121-bcb8-1bcc8c82b2b7', 1), UUID_TO_BIN('de02349a-f87f-5b4e-a7ed-2d0861f98bf0', 1), UUID_TO_BIN('de02349a-f87f-5b4e-a7ed-2d0861f98bf0', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368c2', 1), 'ファイル13', 'ファイル13の詳細', 0),
    (UUID_TO_BIN('bb767201-9f23-51ea-98f2-46a4bd1cef30', 1), UUID_TO_BIN('de02349a-f87f-5b4e-a7ed-2d0861f98bf0', 1), UUID_TO_BIN('de02349a-f87f-5b4e-a7ed-2d0861f98bf0', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368c2', 1), 'ファイル13', 'ファイル13の詳細', 1),
    (UUID_TO_BIN('648c8107-d559-553a-b409-eab8c801431c', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368c2', 1), 'ファイル13', 'ファイル13の詳細', 2),
    (UUID_TO_BIN('f1d0a7b8-27a1-5e2d-9c8c-8d62391da8fb', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368c2', 1), 'ファイル13', 'ファイル13の詳細', 3),
    (UUID_TO_BIN('059d280e-8564-524b-8b6f-91d747ae46d6', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368c2', 1), 'ファイル13', 'ファイル13の詳細', 4),
    (UUID_TO_BIN('60463016-e078-5c38-86fe-937a066dca61', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('e4fc0e58-674c-5683-8c81-ddff02f368c2', 1), 'ファイル13', 'ファイル13の詳細', 5);
