use mysqldb;

-- テーブル作成

create table M_CYCLES (
    cycle_id binary(16) primary key default (UUID_TO_BIN(UUID(), 1)),
    name varchar(100) not null,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

create table T_REMINDERS (
    reminder_id binary(16) primary key default (UUID_TO_BIN(UUID(), 1)),
    cycle_id binary(16) not null references M_CYCLES(cycle_id),
    cycle_x int,
    slack_to_user_name varchar(100) not null,
    slack_from_user_name varchar(100) not null,
    detail varchar(1000) not null,
    is_deleted boolean not null default false,
    reminded_at datetime not null default current_timestamp(),
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

-- ダミーデータ作成

insert into M_CYCLES(cycle_id, name) values
    (UUID_TO_BIN('d96cae55-3c90-504c-9d7c-d46469567fef', 1), '毎日'),
    (UUID_TO_BIN('96daef1b-6295-52ad-805b-98cb46a308f1', 1), 'X日おき'),
    (UUID_TO_BIN('fadd5842-c54a-56af-90d1-70d4db4a81cf', 1), '毎週X曜日'),
    (UUID_TO_BIN('78db889f-138c-5e8a-bc6c-572a2abf4ccd', 1), '毎月X日');

insert into T_REMINDERS(cycle_id, cycle_x, slack_to_user_name, slack_from_user_name, detail, reminded_at) values
    (UUID_TO_BIN('d96cae55-3c90-504c-9d7c-d46469567fef', 1), null, 'garrettmiles', 'mariemoody', 'リマインドです（抽出１）', DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)),
    (UUID_TO_BIN('d96cae55-3c90-504c-9d7c-d46469567fef', 1), null, 'minawatson', 'angelbriggs', 'リマインドです', DATE_SUB(CURRENT_DATE(), INTERVAL 1 HOUR)),
    (UUID_TO_BIN('d96cae55-3c90-504c-9d7c-d46469567fef', 1), null, 'myrtiemyers', 'charlottefields', 'リマインドです', DATE_SUB(CURRENT_DATE(), INTERVAL 12 HOUR)),
    (UUID_TO_BIN('d96cae55-3c90-504c-9d7c-d46469567fef', 1), null, 'patrickcarter', 'beulahrodriquez', 'リマインドです', DATE_SUB(CURRENT_DATE(), INTERVAL 10 HOUR)),
    (UUID_TO_BIN('d96cae55-3c90-504c-9d7c-d46469567fef', 1), null, 'carloshayes', 'vernonhardy', 'リマインドです', DATE_SUB(CURRENT_DATE(), INTERVAL 11 HOUR)),
    (UUID_TO_BIN('96daef1b-6295-52ad-805b-98cb46a308f1', 1), 3, 'hermanquinn', 'lizziewarner', 'リマインドです', DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)),
    (UUID_TO_BIN('96daef1b-6295-52ad-805b-98cb46a308f1', 1), 2, 'edgarferguson', 'fanniebrewer', 'リマインドです', DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)),
    (UUID_TO_BIN('96daef1b-6295-52ad-805b-98cb46a308f1', 1), 2, 'stevereese', 'amycollier', 'リマインドです（抽出２）', DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY)),
    (UUID_TO_BIN('fadd5842-c54a-56af-90d1-70d4db4a81cf', 1), 0, 'geraldhayes', 'bettypotter', 'リマインドです（月）', DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)),
    (UUID_TO_BIN('fadd5842-c54a-56af-90d1-70d4db4a81cf', 1), 1, 'mathildasilva', 'raymondjordan', 'リマインドです（火）', DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)),
    (UUID_TO_BIN('fadd5842-c54a-56af-90d1-70d4db4a81cf', 1), 2, 'josephineholland', 'patrickcarter', 'リマインドです（水）', DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)),
    (UUID_TO_BIN('fadd5842-c54a-56af-90d1-70d4db4a81cf', 1), 3, 'josephineholland', 'patrickcarter', 'リマインドです（木）', DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)),
    (UUID_TO_BIN('fadd5842-c54a-56af-90d1-70d4db4a81cf', 1), 4, 'josephineholland', 'patrickcarter', 'リマインドです（金）', DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)),
    (UUID_TO_BIN('fadd5842-c54a-56af-90d1-70d4db4a81cf', 1), 5, 'josephineholland', 'patrickcarter', 'リマインドです（土）', DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)),
    (UUID_TO_BIN('fadd5842-c54a-56af-90d1-70d4db4a81cf', 1), 6, 'josephineholland', 'patrickcarter', 'リマインドです（日）', DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)),
    (UUID_TO_BIN('78db889f-138c-5e8a-bc6c-572a2abf4ccd', 1), 11, 'josephineholland', 'patrickcarter', 'リマインドです（抽出３）', DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY));
