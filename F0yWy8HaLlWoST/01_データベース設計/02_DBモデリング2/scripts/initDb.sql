use mysqldb;

-- テーブル作成

create table M_WORKSPACE_CONFIGS (
    workspace_id binary(16) primary key default (UUID_TO_BIN(UUID(), 1)),
    name varchar(100) not null,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

create table M_USERS (
    user_id binary(16) primary key default (UUID_TO_BIN(UUID(), 1)),
    workspace_id binary(16) references M_WORKSPACE_CONFIGS(workspace_id),
    name varchar(100) not null,
    is_deleted boolean not null default false,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

create table M_CHANNELS (
    channel_id binary(16) primary key default (UUID_TO_BIN(UUID(), 1)),
    workspace_id binary(16) references M_WORKSPACE_CONFIGS(workspace_id),
    name varchar(100) not null,
    is_deleted boolean not null default false,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

create table R_USERS_AND_CHANNELS (
    users_and_channels_id  binary(16) primary key default (UUID_TO_BIN(UUID(), 1)),
    user_id binary(16) not null references M_USERS(user_id),
    channel_id binary(16) not null references M_CHANNELS(channel_id),
    is_deleted boolean not null default false,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

create table T_MESSAGES (
    message_id binary(16) primary key default (UUID_TO_BIN(UUID(), 1)),
    user_id binary(16) not null references M_USERS(user_id),
    channel_id binary(16) not null references M_CHANNELS(channel_id),
    message varchar(10000) not null,
    is_deleted boolean not null default false,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

create table T_THREADS (
    thread_id binary(16) primary key default (UUID_TO_BIN(UUID(), 1)),
    user_id binary(16) not null references M_USERS(user_id),
    message_id binary(16) not null references T_MESSAGES(message_id),
    thread_message varchar(10000) not null,
    is_deleted boolean not null default false,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

-- ダミーデータ作成

insert into M_WORKSPACE_CONFIGS(workspace_id, name) values
    (UUID_TO_BIN('4bb8219a-412d-54d1-9031-f378a8f1a891', 1), 'Praha challenge 7期');

insert into M_USERS(user_id, workspace_id, name) values
    (UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('4bb8219a-412d-54d1-9031-f378a8f1a891', 1), 'Harvey Alvarado'),
    (UUID_TO_BIN('88dd50b4-5644-5ed8-ae7d-50157923fd70', 1), UUID_TO_BIN('4bb8219a-412d-54d1-9031-f378a8f1a891', 1), 'Adam Webster'),
    (UUID_TO_BIN('d7ee2310-0642-56ba-9824-d23144b0cf3f', 1), UUID_TO_BIN('4bb8219a-412d-54d1-9031-f378a8f1a891', 1), 'Dennis Spencer'),
    (UUID_TO_BIN('d02b0cd0-2e95-50ff-93cb-f41cc22aa639', 1), UUID_TO_BIN('4bb8219a-412d-54d1-9031-f378a8f1a891', 1), 'Mary Hines'),
    (UUID_TO_BIN('530c7220-e65d-596b-aa0d-9d80ea5d26c2', 1), UUID_TO_BIN('4bb8219a-412d-54d1-9031-f378a8f1a891', 1), 'Matilda Crawford'),
    (UUID_TO_BIN('f3ea110d-ecb3-5a5c-910c-92e4e710ba81', 1), UUID_TO_BIN('4bb8219a-412d-54d1-9031-f378a8f1a891', 1), 'Gary Jordan'),
    (UUID_TO_BIN('cf2d74dd-b255-5966-b6f9-5af1397a19b8', 1), UUID_TO_BIN('4bb8219a-412d-54d1-9031-f378a8f1a891', 1), 'Bertha Welch'),
    (UUID_TO_BIN('de02349a-f87f-5b4e-a7ed-2d0861f98bf0', 1), UUID_TO_BIN('4bb8219a-412d-54d1-9031-f378a8f1a891', 1), 'Aaron Poole'),
    (UUID_TO_BIN('4e200eb3-5146-56c1-880f-f2706c6f65f3', 1), UUID_TO_BIN('4bb8219a-412d-54d1-9031-f378a8f1a891', 1), 'Gene Walters'),
    (UUID_TO_BIN('1b43927e-1905-5f27-83b3-0ba301c5341a', 1), UUID_TO_BIN('4bb8219a-412d-54d1-9031-f378a8f1a891', 1), 'Mathilda Silva');

insert into M_CHANNELS(channel_id, workspace_id, name) values
    (UUID_TO_BIN('10bcb833-3d34-5383-84e1-a9d971e32341', 1), UUID_TO_BIN('4bb8219a-412d-54d1-9031-f378a8f1a891', 1), 'general'),
    (UUID_TO_BIN('0fce2a28-f0fc-5f4c-82e4-b483b58e0466', 1), UUID_TO_BIN('4bb8219a-412d-54d1-9031-f378a8f1a891', 1), 'random'),
    (UUID_TO_BIN('af8b0424-c879-5193-9138-ea6999fdc517', 1), UUID_TO_BIN('4bb8219a-412d-54d1-9031-f378a8f1a891', 1), 'team1'),
    (UUID_TO_BIN('bf316dd9-d747-5ad6-a0a9-197b9f29a4ab', 1), UUID_TO_BIN('4bb8219a-412d-54d1-9031-f378a8f1a891', 1), 'team2'),
    (UUID_TO_BIN('bde48711-062e-5cac-a918-9ae19c6f6bf0', 1), UUID_TO_BIN('4bb8219a-412d-54d1-9031-f378a8f1a891', 1), 'team3');

insert into R_USERS_AND_CHANNELS(user_id, channel_id) values
    (UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('10bcb833-3d34-5383-84e1-a9d971e32341', 1)),
    (UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('0fce2a28-f0fc-5f4c-82e4-b483b58e0466', 1)),
    (UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('af8b0424-c879-5193-9138-ea6999fdc517', 1)),
    (UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('bf316dd9-d747-5ad6-a0a9-197b9f29a4ab', 1)),
    (UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('bde48711-062e-5cac-a918-9ae19c6f6bf0', 1)),
    (UUID_TO_BIN('88dd50b4-5644-5ed8-ae7d-50157923fd70', 1), UUID_TO_BIN('10bcb833-3d34-5383-84e1-a9d971e32341', 1)),
    (UUID_TO_BIN('88dd50b4-5644-5ed8-ae7d-50157923fd70', 1), UUID_TO_BIN('0fce2a28-f0fc-5f4c-82e4-b483b58e0466', 1)),
    (UUID_TO_BIN('88dd50b4-5644-5ed8-ae7d-50157923fd70', 1), UUID_TO_BIN('af8b0424-c879-5193-9138-ea6999fdc517', 1)),
    (UUID_TO_BIN('88dd50b4-5644-5ed8-ae7d-50157923fd70', 1), UUID_TO_BIN('bf316dd9-d747-5ad6-a0a9-197b9f29a4ab', 1)),
    (UUID_TO_BIN('88dd50b4-5644-5ed8-ae7d-50157923fd70', 1), UUID_TO_BIN('bde48711-062e-5cac-a918-9ae19c6f6bf0', 1)),
    (UUID_TO_BIN('f3ea110d-ecb3-5a5c-910c-92e4e710ba81', 1), UUID_TO_BIN('10bcb833-3d34-5383-84e1-a9d971e32341', 1)),
    (UUID_TO_BIN('f3ea110d-ecb3-5a5c-910c-92e4e710ba81', 1), UUID_TO_BIN('0fce2a28-f0fc-5f4c-82e4-b483b58e0466', 1));

insert into T_MESSAGES(message_id, user_id, channel_id, message) values
    (UUID_TO_BIN('fe5af6db-0849-5798-9e7f-66a54508352c', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('10bcb833-3d34-5383-84e1-a9d971e32341', 1), 'Hello, world!'),
    (UUID_TO_BIN('5d589028-4614-5a97-a591-79719f4d15be', 1), UUID_TO_BIN('88dd50b4-5644-5ed8-ae7d-50157923fd70', 1), UUID_TO_BIN('10bcb833-3d34-5383-84e1-a9d971e32341', 1), 'hogehogegasefase'),
    (UUID_TO_BIN('e723fde3-8a9d-514b-abaf-c2f57818d1ed', 1), UUID_TO_BIN('f3ea110d-ecb3-5a5c-910c-92e4e710ba81', 1), UUID_TO_BIN('af8b0424-c879-5193-9138-ea6999fdc517', 1), 'こんにちは');

insert into T_THREADS(user_id, message_id, thread_message) values
    (UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('fe5af6db-0849-5798-9e7f-66a54508352c', 1), 'reply to Hello, world!'),
    (UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), UUID_TO_BIN('fe5af6db-0849-5798-9e7f-66a54508352c', 1), 'reply to Hello, world! hoge'),
    (UUID_TO_BIN('88dd50b4-5644-5ed8-ae7d-50157923fd70', 1), UUID_TO_BIN('5d589028-4614-5a97-a591-79719f4d15be', 1), 'fugagadasdfasd'),
    (UUID_TO_BIN('d02b0cd0-2e95-50ff-93cb-f41cc22aa639', 1), UUID_TO_BIN('e723fde3-8a9d-514b-abaf-c2f57818d1ed', 1), 'こんにちは！！'),
    (UUID_TO_BIN('f3ea110d-ecb3-5a5c-910c-92e4e710ba81', 1), UUID_TO_BIN('e723fde3-8a9d-514b-abaf-c2f57818d1ed', 1), 'いい天気ですね'),
    (UUID_TO_BIN('d02b0cd0-2e95-50ff-93cb-f41cc22aa639', 1), UUID_TO_BIN('e723fde3-8a9d-514b-abaf-c2f57818d1ed', 1), 'そうですね'),
    (UUID_TO_BIN('d02b0cd0-2e95-50ff-93cb-f41cc22aa639', 1), UUID_TO_BIN('e723fde3-8a9d-514b-abaf-c2f57818d1ed', 1), '明日もいい天気みたいです hoge');