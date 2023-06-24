use mysqldb;

-- テーブル作成

create table M_USERS (
    user_id binary(16) primary key default (UUID_TO_BIN(UUID(), 1)),
    name varchar(100) not null,
    is_deleted boolean not null default false,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

create table T_ARTICLES (
    article_id binary(16) primary key default (UUID_TO_BIN(UUID(), 1)),
    user_id binary(16) not null references M_USERS(user_id),
    title varchar(100) not null,
    detail varchar(1000) not null,
    is_deleted boolean not null default false,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

create table T_ARTICLE_HISTORIES (
    article_history_id binary(16) primary key default (UUID_TO_BIN(UUID(), 1)),
    latest_article_id binary(16) not null references T_ARTICLES(article_id),
    title varchar(100) not null,
    detail varchar(1000) not null,
    is_deleted boolean not null default false,
    created_at datetime not null default current_timestamp()
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

insert into T_ARTICLES(article_id, user_id, title, detail) values
    (UUID_TO_BIN('aac008cd-6e75-59b8-9141-fb84b7e03890', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), '記事タイトル1', '記事詳細1'),
    (UUID_TO_BIN('389949d6-83ac-5f16-8e7a-cda7ea205b5b', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), '記事タイトル2', '記事詳細2'),
    (UUID_TO_BIN('6a23e05f-86d7-5dd9-9177-98c6f1bf6d37', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), '記事タイトル3', '記事詳細3'),
    (UUID_TO_BIN('90015c82-5a33-5099-9f67-57d4f938b01e', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), '記事タイトル4', '記事詳細4'),
    (UUID_TO_BIN('c7890808-02c4-5604-af54-fb1aa5b349ae', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), '記事タイトル5', '記事詳細5'),
    (UUID_TO_BIN('bfe8fae1-bc8c-58fc-880c-43b7f51d91a5', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), '記事タイトル6', '記事詳細6'),
    (UUID_TO_BIN('c44ab69b-7bb8-5f28-891a-f4876d9d46d8', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), '記事タイトル7', '記事詳細7'),
    (UUID_TO_BIN('a05517a5-6d9d-5a0b-a30d-e1bef47b1202', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), '記事タイトル8', '記事詳細8'),
    (UUID_TO_BIN('316f95f8-c92f-5220-9bbb-52b3549aa9de', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), '記事タイトル9', '記事詳細9'),
    (UUID_TO_BIN('8f8ad48c-c240-58f8-a571-78c25d6c0415', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), '記事タイトル10', '記事詳細10'),
    (UUID_TO_BIN('552d0277-1543-52fb-9e69-aae2e7cc205a', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), '記事タイトル11', '記事詳細11'),
    (UUID_TO_BIN('85249d8f-9bd8-5eaa-b640-42067ceedbdb', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), '記事タイトル12', '記事詳細12'),
    (UUID_TO_BIN('1cef3377-9dd5-57f0-90e9-9175f408af45', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), '記事タイトル13', '記事詳細13'),
    (UUID_TO_BIN('fc6c5a8e-df28-54ea-bfff-3aa0418ac88f', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), '記事タイトル14', '記事詳細14'),
    (UUID_TO_BIN('d727f586-7c4c-5344-ba8d-18dce7161c0f', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), '記事タイトル15', '記事詳細15'),
    (UUID_TO_BIN('5cee1fd0-c4d9-5b18-9ddc-06f486ab0b0e', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), '記事タイトル16', '記事詳細16'),
    (UUID_TO_BIN('0da90666-221f-5434-94f8-91c20cec01f3', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), '記事タイトル17', '記事詳細17'),
    (UUID_TO_BIN('e4343a5c-855d-5e8c-9185-f53f6d465a9e', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), '記事タイトル18', '記事詳細18'),
    (UUID_TO_BIN('4332cf59-78e3-5a21-81a8-8835f95e14a7', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), '記事タイトル19', '記事詳細19'),
    (UUID_TO_BIN('a512ee21-2d7a-5a8e-81fd-175f96f984b8', 1), UUID_TO_BIN('68f2c671-5792-5bf8-81b9-636bf90054d7', 1), '記事タイトル20', '記事詳細20');

insert into T_ARTICLE_HISTORIES(article_history_id, latest_article_id, title, detail, created_at) values
    (UUID_TO_BIN('ae9b7e8f-beb3-51cc-9b7f-ca5975d503db', 1), UUID_TO_BIN('aac008cd-6e75-59b8-9141-fb84b7e03890', 1), '記事タイトル1-1', '記事詳細1-1', DATE_SUB(CURRENT_DATE(), INTERVAL 1 HOUR)),
    (UUID_TO_BIN('58241611-d556-5566-8203-5d8116db1bc1', 1), UUID_TO_BIN('aac008cd-6e75-59b8-9141-fb84b7e03890', 1), '記事タイトル1-2', '記事詳細1-2', DATE_SUB(CURRENT_DATE(), INTERVAL 2 HOUR)),
    (UUID_TO_BIN('e4e644e8-a312-5b0b-9075-3adb6518e8bf', 1), UUID_TO_BIN('aac008cd-6e75-59b8-9141-fb84b7e03890', 1), '記事タイトル1-3', '記事詳細1-3', DATE_SUB(CURRENT_DATE(), INTERVAL 3 HOUR)),
    (UUID_TO_BIN('30284ab3-330d-5116-a72a-2ef2808fb9fa', 1), UUID_TO_BIN('aac008cd-6e75-59b8-9141-fb84b7e03890', 1), '記事タイトル1-4', '記事詳細1-4', DATE_SUB(CURRENT_DATE(), INTERVAL 4 HOUR)),
    (UUID_TO_BIN('1c67a59e-0142-5308-aa5b-0f135ce060ee', 1), UUID_TO_BIN('aac008cd-6e75-59b8-9141-fb84b7e03890', 1), '記事タイトル1-5', '記事詳細1-5', DATE_SUB(CURRENT_DATE(), INTERVAL 5 HOUR)),
    (UUID_TO_BIN('ce40a72f-1382-50db-9df6-5bbf54bae174', 1), UUID_TO_BIN('aac008cd-6e75-59b8-9141-fb84b7e03890', 1), '記事タイトル1-6', '記事詳細1-6', DATE_SUB(CURRENT_DATE(), INTERVAL 6 HOUR)),
    (UUID_TO_BIN('bbb5f76b-1119-5ef3-9acf-302062a3b7a9', 1), UUID_TO_BIN('aac008cd-6e75-59b8-9141-fb84b7e03890', 1), '記事タイトル1-7', '記事詳細1-7', DATE_SUB(CURRENT_DATE(), INTERVAL 7 HOUR)),
    (UUID_TO_BIN('79bc60ab-8e4d-5375-b9ee-c647ccac9a2d', 1), UUID_TO_BIN('aac008cd-6e75-59b8-9141-fb84b7e03890', 1), '記事タイトル1-8', '記事詳細1-8', DATE_SUB(CURRENT_DATE(), INTERVAL 8 HOUR)),
    (UUID_TO_BIN('bc0ed21d-e62b-5305-b9e0-2a09d788b4ff', 1), UUID_TO_BIN('aac008cd-6e75-59b8-9141-fb84b7e03890', 1), '記事タイトル1-9', '記事詳細1-9', DATE_SUB(CURRENT_DATE(), INTERVAL 9 HOUR)),
    (UUID_TO_BIN('22f9d346-a633-5536-bbea-863027717e67', 1), UUID_TO_BIN('389949d6-83ac-5f16-8e7a-cda7ea205b5b', 1), '記事タイトル2-1', '記事詳細2-1', DATE_SUB(CURRENT_DATE(), INTERVAL 1 HOUR)),
    (UUID_TO_BIN('380331d1-e550-5736-8b2d-0617108afc33', 1), UUID_TO_BIN('389949d6-83ac-5f16-8e7a-cda7ea205b5b', 1), '記事タイトル2-2', '記事詳細2-2', DATE_SUB(CURRENT_DATE(), INTERVAL 2 HOUR)),
    (UUID_TO_BIN('1512f361-e5a3-5b2e-870c-7d32acc707b9', 1), UUID_TO_BIN('389949d6-83ac-5f16-8e7a-cda7ea205b5b', 1), '記事タイトル2-3', '記事詳細2-3', DATE_SUB(CURRENT_DATE(), INTERVAL 3 HOUR)),
    (UUID_TO_BIN('88cf3d70-ea49-521f-ab84-86d01218be1f', 1), UUID_TO_BIN('389949d6-83ac-5f16-8e7a-cda7ea205b5b', 1), '記事タイトル2-4', '記事詳細2-4', DATE_SUB(CURRENT_DATE(), INTERVAL 4 HOUR)),
    (UUID_TO_BIN('6b1e2437-3c29-59ab-94d5-d942505b0385', 1), UUID_TO_BIN('389949d6-83ac-5f16-8e7a-cda7ea205b5b', 1), '記事タイトル2-5', '記事詳細2-5', DATE_SUB(CURRENT_DATE(), INTERVAL 5 HOUR)),
    (UUID_TO_BIN('97284edc-1eb0-52ce-ab29-c6b8c9c1765c', 1), UUID_TO_BIN('389949d6-83ac-5f16-8e7a-cda7ea205b5b', 1), '記事タイトル2-6', '記事詳細2-6', DATE_SUB(CURRENT_DATE(), INTERVAL 6 HOUR)),
    (UUID_TO_BIN('bf807061-76a7-5aa3-938a-1812162d638d', 1), UUID_TO_BIN('90015c82-5a33-5099-9f67-57d4f938b01e', 1), '記事タイトル4-1', '記事詳細4-1', DATE_SUB(CURRENT_DATE(), INTERVAL 1 HOUR)),
    (UUID_TO_BIN('b1273841-681b-540c-8381-bf9c5b4018ef', 1), UUID_TO_BIN('90015c82-5a33-5099-9f67-57d4f938b01e', 1), '記事タイトル4-2', '記事詳細4-2', DATE_SUB(CURRENT_DATE(), INTERVAL 2 HOUR)),
    (UUID_TO_BIN('206b97ed-f5b3-5adc-8ec7-d991420c4259', 1), UUID_TO_BIN('90015c82-5a33-5099-9f67-57d4f938b01e', 1), '記事タイトル4-3', '記事詳細4-3', DATE_SUB(CURRENT_DATE(), INTERVAL 3 HOUR)),
    (UUID_TO_BIN('ecea862e-535d-5f9d-91d0-27dfd2d163f5', 1), UUID_TO_BIN('90015c82-5a33-5099-9f67-57d4f938b01e', 1), '記事タイトル4-4', '記事詳細4-4', DATE_SUB(CURRENT_DATE(), INTERVAL 4 HOUR)),
    (UUID_TO_BIN('76a3fb21-afd4-56f7-a6e1-198e0aa92c81', 1), UUID_TO_BIN('c7890808-02c4-5604-af54-fb1aa5b349ae', 1), '記事タイトル5-1', '記事詳細5-1', DATE_SUB(CURRENT_DATE(), INTERVAL 1 HOUR));
