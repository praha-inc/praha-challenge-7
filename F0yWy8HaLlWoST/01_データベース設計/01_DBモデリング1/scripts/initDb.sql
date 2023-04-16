use mysqldb;

-- テーブル作成

create table M_CUSTOMERS(
    customer_id binary(16) primary key default (UUID_TO_BIN(UUID(), 1)),
    phone text not null,
    name text not null,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

create table M_ITEMS (
    item_id binary(16) primary key default (UUID_TO_BIN(UUID(), 1)),
    sushi_id binary(16) references M_SUSHI_MENUS(sushi_id),
    set_id binary(16) references M_SET_MENUS(set_id),
    is_deleted boolean default false,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp(),
    check (sushi_id is not null or set_id is not null)
);

create table M_SUSHI_MENUS (
    sushi_id binary(16) primary key default (UUID_TO_BIN(UUID(), 1)),
    name text not null,
    price int unsigned not null,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

create table M_SET_MENUS (
    set_id  binary(16) primary key default (UUID_TO_BIN(UUID(), 1)),
    set_type_id binary(16) references M_SET_TYPES(set_type_id),
    name text not null,
    price int unsigned not null,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

create table R_SUSHI_MENUS_AND_SET_MENUS (
    sushi_set_id  binary(16) primary key default (UUID_TO_BIN(UUID(), 1)),
    sushi_id binary(16) not null references M_SUSHI_MENUS(sushi_id),
    set_id binary(16) not null references M_SET_MENUS(set_id),
    sushi_count int unsigned not null,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

create table T_ORDERS (
    order_id binary(16) primary key default (UUID_TO_BIN(UUID(), 1)),
    customer_id binary(16) references M_ORDERS(customer_id),
    total_coupon_id binary(16) references M_TOTAL_COUPONS(total_coupon_id),
    payment_method int unsigned not null,
    is_paid boolean default false,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

create table T_ORDER_DETAILS (
    order_detail_id binary(16) primary key default (UUID_TO_BIN(UUID(), 1)),
    order_id binary(16) references M_ORDER_DETAILS(order_id),
    item_id binary(16) references M_ITEMS(item_id),
    shari_size_id binary(16) references M_SHARI_SIZES(shari_size_id),
    item_coupon_id binary(16) references M_ITEM_COUPONS(item_coupon_id),
    count int unsigned not null,
    is_without_wasabi boolean default false,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

create table M_SHARI_SIZES (
    shari_size_id binary(16) primary key default (UUID_TO_BIN(UUID(), 1)),
    name text not null,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

create table M_SET_TYPES (
    set_type_id binary(16) primary key default (UUID_TO_BIN(UUID(), 1)),
    name text not null,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

create table M_TOTAL_COUPONS (
    total_coupon_id binary(16) primary key default (UUID_TO_BIN(UUID(), 1)),
    name text not null,
    discount_rate int unsigned,
    discount_amount int unsigned,
    available_from datetime not null,
    expired_at datetime not null,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp(),
    check (discount_rate is not null or discount_amount is not null)
);

create table M_ITEM_COUPONS (
    item_coupon_id binary(16) primary key default (UUID_TO_BIN(UUID(), 1)),
    name text not null,
    discount_rate int unsigned,
    discount_amount int unsigned,
    available_from datetime not null,
    expired_at datetime not null,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp(),
    check (discount_rate is not null or discount_amount is not null)
);

-- ダミーデータ作成

insert into M_CUSTOMERS(phone, name) values
    ('(583) 466-7351', 'Evelyn French'),
    ('(755) 421-7462', 'Edna May'),
    ('(278) 260-9508', 'Ian Pope'),
    ('(582) 504-2881', 'Bobby Barton'),
    ('(776) 284-9793', 'Kevin Burke'),
    ('(356) 710-4042', 'Antonio Pope'),
    ('(985) 695-1983', 'Derek Pena'),
    ('(885) 665-3757', 'Alta Fuller'),
    ('(332) 842-1470', 'Dean Allison'),
    ('(982) 763-1311', 'Dylan Payne'),
    ('(974) 289-5308', 'Sophia George'),
    ('(736) 664-8246', 'Amelia Lambert'),
    ('(974) 762-5816', 'Madge Young'),
    ('(556) 396-4418', 'Emilie Stone'),
    ('(356) 984-2157', 'Vincent Scott'),
    ('(857) 456-3231', 'Alberta Evans'),
    ('(201) 444-3664', 'Ora Martinez'),
    ('(541) 710-5913', 'Alta Anderson'),
    ('(519) 231-7065', 'Brent Powers'),
    ('(644) 422-5059', 'Milton Williamson'),
    ('(835) 422-6495', 'Christian Walton'),
    ('(727) 884-4143', 'Evelyn Larson');

insert into M_SUSHI_MENUS(name, price) values
    ('玉子', 100),
    ('いなり', 100),
    ('かんぴょう巻', 150),
    ('なっとう巻', 150),
    ('えび', 180),
    ('赤いか', 180),
    ('生サーモン', 220),
    ('まぐろ赤身', 220),
    ('あじ', 260),
    ('えんがわ', 260),
    ('いくら', 360),
    ('ホタテ貝', 360),
    ('活ヒラメ', 400),
    ('数の子', 400),
    ('中トロ', 460),
    ('あなご一本すし', 520),
    ('うに', 600);

insert into M_SET_TYPES(name) values
    ('盛り込み'),
    ('にぎり'),
    ('鮨やの丼＆おすすめ'),
    ('地元に生まれた味');

insert into M_SET_MENUS(set_type_id, name, price) values
    ((select set_type_id from M_SET_TYPES where name='盛り込み'), 'はな', 8650),
    ((select set_type_id from M_SET_TYPES where name='盛り込み'), 'わだつみ', 5680),
    ((select set_type_id from M_SET_TYPES where name='盛り込み'), 'あさなぎ', 4440),
    ((select set_type_id from M_SET_TYPES where name='盛り込み'), 'ゆうなぎ', 3830),
    ((select set_type_id from M_SET_TYPES where name='盛り込み'), 'くろしお', 2830),
    ((select set_type_id from M_SET_TYPES where name='盛り込み'), 'いさりび', 2180),
    ((select set_type_id from M_SET_TYPES where name='にぎり'), 'みさき', 1940),
    ((select set_type_id from M_SET_TYPES where name='にぎり'), 'みなと', 1490),
    ((select set_type_id from M_SET_TYPES where name='にぎり'), 'しおん', 1060),
    ((select set_type_id from M_SET_TYPES where name='にぎり'), 'なぎさ', 800),
    ((select set_type_id from M_SET_TYPES where name='鮨やの丼＆おすすめ'), '海鮮ちらし', 1280),
    ((select set_type_id from M_SET_TYPES where name='鮨やの丼＆おすすめ'), '鉄火丼', 1000),
    ((select set_type_id from M_SET_TYPES where name='地元に生まれた味'), '鮨八宝巻', 1280),
    ((select set_type_id from M_SET_TYPES where name='地元に生まれた味'), '鮨八宝巻 化粧箱入り', 1480);

insert into M_ITEMS(sushi_id, set_id) values
    ((select sushi_id from M_SUSHI_MENUS where name='玉子'), NULL),
    ((select sushi_id from M_SUSHI_MENUS where name='いなり'), NULL),
    ((select sushi_id from M_SUSHI_MENUS where name='かんぴょう巻'), NULL),
    ((select sushi_id from M_SUSHI_MENUS where name='なっとう巻'), NULL),
    ((select sushi_id from M_SUSHI_MENUS where name='えび'), NULL),
    ((select sushi_id from M_SUSHI_MENUS where name='赤いか'), NULL),
    ((select sushi_id from M_SUSHI_MENUS where name='生サーモン'), NULL),
    ((select sushi_id from M_SUSHI_MENUS where name='まぐろ赤身'), NULL),
    ((select sushi_id from M_SUSHI_MENUS where name='あじ'), NULL),
    ((select sushi_id from M_SUSHI_MENUS where name='えんがわ'), NULL),
    ((select sushi_id from M_SUSHI_MENUS where name='いくら'), NULL),
    ((select sushi_id from M_SUSHI_MENUS where name='ホタテ貝'), NULL),
    ((select sushi_id from M_SUSHI_MENUS where name='活ヒラメ'), NULL),
    ((select sushi_id from M_SUSHI_MENUS where name='数の子'), NULL),
    ((select sushi_id from M_SUSHI_MENUS where name='中トロ'), NULL),
    ((select sushi_id from M_SUSHI_MENUS where name='あなご一本すし'), NULL),
    ((select sushi_id from M_SUSHI_MENUS where name='うに'), NULL),
    (NULL, (select set_id from M_SET_MENUS where name='はな')),
    (NULL, (select set_id from M_SET_MENUS where name='わだつみ')),
    (NULL, (select set_id from M_SET_MENUS where name='あさなぎ')),
    (NULL, (select set_id from M_SET_MENUS where name='ゆうなぎ')),
    (NULL, (select set_id from M_SET_MENUS where name='くろしお')),
    (NULL, (select set_id from M_SET_MENUS where name='いさりび')),
    (NULL, (select set_id from M_SET_MENUS where name='みさき')),
    (NULL, (select set_id from M_SET_MENUS where name='みなと')),
    (NULL, (select set_id from M_SET_MENUS where name='しおん')),
    (NULL, (select set_id from M_SET_MENUS where name='なぎさ')),
    (NULL, (select set_id from M_SET_MENUS where name='海鮮ちらし')),
    (NULL, (select set_id from M_SET_MENUS where name='鉄火丼')),
    (NULL, (select set_id from M_SET_MENUS where name='鮨八宝巻')),
    (NULL, (select set_id from M_SET_MENUS where name='鮨八宝巻 化粧箱入り'));

insert into R_SUSHI_MENUS_AND_SET_MENUS(sushi_id, set_id, sushi_count) values
    ((select sushi_id from M_SUSHI_MENUS where name='玉子'), (select set_id from M_SET_MENUS where name='はな'), 1),
    ((select sushi_id from M_SUSHI_MENUS where name='いなり'), (select set_id from M_SET_MENUS where name='はな'), 1),
    ((select sushi_id from M_SUSHI_MENUS where name='かんぴょう巻'), (select set_id from M_SET_MENUS where name='はな'), 1),
    ((select sushi_id from M_SUSHI_MENUS where name='なっとう巻'), (select set_id from M_SET_MENUS where name='はな'), 1),
    ((select sushi_id from M_SUSHI_MENUS where name='えび'), (select set_id from M_SET_MENUS where name='はな'), 1),
    ((select sushi_id from M_SUSHI_MENUS where name='赤いか'), (select set_id from M_SET_MENUS where name='はな'), 1),
    ((select sushi_id from M_SUSHI_MENUS where name='生サーモン'), (select set_id from M_SET_MENUS where name='はな'), 1),
    ((select sushi_id from M_SUSHI_MENUS where name='まぐろ赤身'), (select set_id from M_SET_MENUS where name='わだつみ'), 1),
    ((select sushi_id from M_SUSHI_MENUS where name='あじ'), (select set_id from M_SET_MENUS where name='わだつみ'), 1),
    ((select sushi_id from M_SUSHI_MENUS where name='えんがわ'), (select set_id from M_SET_MENUS where name='わだつみ'), 1),
    ((select sushi_id from M_SUSHI_MENUS where name='いくら'), (select set_id from M_SET_MENUS where name='わだつみ'), 1),
    ((select sushi_id from M_SUSHI_MENUS where name='ホタテ貝'), (select set_id from M_SET_MENUS where name='いさりび'), 1),
    ((select sushi_id from M_SUSHI_MENUS where name='活ヒラメ'), (select set_id from M_SET_MENUS where name='いさりび'), 1),
    ((select sushi_id from M_SUSHI_MENUS where name='数の子'), (select set_id from M_SET_MENUS where name='いさりび'), 1),
    ((select sushi_id from M_SUSHI_MENUS where name='中トロ'), (select set_id from M_SET_MENUS where name='いさりび'), 1),
    ((select sushi_id from M_SUSHI_MENUS where name='あなご一本すし'), (select set_id from M_SET_MENUS where name='みさき'), 1),
    ((select sushi_id from M_SUSHI_MENUS where name='うに'), (select set_id from M_SET_MENUS where name='みさき'), 1);

insert into M_TOTAL_COUPONS(name, discount_rate, discount_amount, available_from, expired_at) values
    ('10%割り引き', 10, NULL, '2019-01-01', '2019-12-31'),
    ('20%割り引き', 20, NULL, '2019-01-01', '2019-12-31'),
    ('30%割り引き', 30, NULL, '2019-01-01', '2019-12-31'),
    ('100円引き', NULL, 100, '2019-01-01', '2019-12-31'),
    ('500円引き', NULL, 500, '2019-01-01', '2019-12-31'),
    ('1000円引き', NULL, 1000, '2019-01-01', '2019-12-31');

insert into T_ORDERS(customer_id, total_coupon_id, payment_method) values 
    ((select customer_id from M_CUSTOMERS where phone='(583) 466-7351'), NULL, 0),
    ((select customer_id from M_CUSTOMERS where phone='(755) 421-7462'), NULL, 0),
    ((select customer_id from M_CUSTOMERS where phone='(278) 260-9508'), (select total_coupon_id from M_TOTAL_COUPONS where name='10%割り引き'), 0),
    ((select customer_id from M_CUSTOMERS where phone='(582) 504-2881'), (select total_coupon_id from M_TOTAL_COUPONS where name='100円引き'), 0),
    ((select customer_id from M_CUSTOMERS where phone='(776) 284-9793'), NULL, 0),
    ((select customer_id from M_CUSTOMERS where phone='(356) 710-4042'), NULL, 0),
    ((select customer_id from M_CUSTOMERS where phone='(985) 695-1983'), NULL, 0);

insert into M_SHARI_SIZES(name) values
    ('小'),
    ('中'),
    ('大');

insert into T_ORDER_DETAILS(order_id, item_id, shari_size_id, item_coupon_id, count) values
    (
        (select order_id from T_ORDERS where customer_id=(select customer_id from M_CUSTOMERS where phone='(583) 466-7351')),
        (select item_id from M_ITEMS where sushi_id=(select sushi_id from M_SUSHI_MENUS where name='うに')),
        (select shari_size_id from M_SHARI_SIZES where name='小'),
        NULL,
        1
    ),
    (
        (select order_id from T_ORDERS where customer_id=(select customer_id from M_CUSTOMERS where phone='(583) 466-7351')),
        (select item_id from M_ITEMS where sushi_id=(select sushi_id from M_SUSHI_MENUS where name='生サーモン')),
        (select shari_size_id from M_SHARI_SIZES where name='小'),
        NULL,
        1
    ),
    (
        (select order_id from T_ORDERS where customer_id=(select customer_id from M_CUSTOMERS where phone='(583) 466-7351')),
        (select item_id from M_ITEMS where sushi_id=(select sushi_id from M_SUSHI_MENUS where name='まぐろ赤身')),
        (select shari_size_id from M_SHARI_SIZES where name='小'),
        NULL,
        1
    ),
    (
        (select order_id from T_ORDERS where customer_id=(select customer_id from M_CUSTOMERS where phone='(583) 466-7351')),
        (select item_id from M_ITEMS where sushi_id=(select sushi_id from M_SUSHI_MENUS where name='あじ')),
        (select shari_size_id from M_SHARI_SIZES where name='小'),
        NULL,
        1
    ),
    (
        (select order_id from T_ORDERS where customer_id=(select customer_id from M_CUSTOMERS where phone='(755) 421-7462')),
        (select item_id from M_ITEMS where sushi_id=(select sushi_id from M_SUSHI_MENUS where name='ホタテ貝')),
        (select shari_size_id from M_SHARI_SIZES where name='小'),
        NULL,
        1
    ),
    (
        (select order_id from T_ORDERS where customer_id=(select customer_id from M_CUSTOMERS where phone='(755) 421-7462')),
        (select item_id from M_ITEMS where sushi_id=(select sushi_id from M_SUSHI_MENUS where name='数の子')),
        (select shari_size_id from M_SHARI_SIZES where name='小'),
        NULL,
        1
    ),
    (
        (select order_id from T_ORDERS where customer_id=(select customer_id from M_CUSTOMERS where phone='(755) 421-7462')),
        (select item_id from M_ITEMS where sushi_id=(select sushi_id from M_SUSHI_MENUS where name='玉子')),
        (select shari_size_id from M_SHARI_SIZES where name='小'),
        NULL,
        1
    ),
    (
        (select order_id from T_ORDERS where customer_id=(select customer_id from M_CUSTOMERS where phone='(755) 421-7462')),
        (select item_id from M_ITEMS where sushi_id=(select sushi_id from M_SUSHI_MENUS where name='玉子')),
        (select shari_size_id from M_SHARI_SIZES where name='小'),
        NULL,
        1
    ),
    (
        (select order_id from T_ORDERS where customer_id=(select customer_id from M_CUSTOMERS where phone='(278) 260-9508')),
        (select item_id from M_ITEMS where sushi_id=(select sushi_id from M_SUSHI_MENUS where name='かんぴょう巻')),
        (select shari_size_id from M_SHARI_SIZES where name='小'),
        NULL,
        1
    ),
    (
        (select order_id from T_ORDERS where customer_id=(select customer_id from M_CUSTOMERS where phone='(278) 260-9508')),
        (select item_id from M_ITEMS where sushi_id=(select sushi_id from M_SUSHI_MENUS where name='玉子')),
        (select shari_size_id from M_SHARI_SIZES where name='小'),
        NULL,
        2
    ),
    (
        (select order_id from T_ORDERS where customer_id=(select customer_id from M_CUSTOMERS where phone='(278) 260-9508')),
        (select item_id from M_ITEMS where set_id=(select set_id from M_SET_MENUS where name='いさりび')),
        (select shari_size_id from M_SHARI_SIZES where name='小'),
        NULL,
        1
    ),
    (
        (select order_id from T_ORDERS where customer_id=(select customer_id from M_CUSTOMERS where phone='(278) 260-9508')),
        (select item_id from M_ITEMS where sushi_id=(select sushi_id from M_SUSHI_MENUS where name='いなり')),
        (select shari_size_id from M_SHARI_SIZES where name='小'),
        (select item_coupon_id from M_ITEM_COUPONS where name='10%割引'),
        1
    ),
    (
        (select order_id from T_ORDERS where customer_id=(select customer_id from M_CUSTOMERS where phone='(278) 260-9508')),
        (select item_id from M_ITEMS where sushi_id=(select sushi_id from M_SUSHI_MENUS where name='うに')),
        (select shari_size_id from M_SHARI_SIZES where name='小'),
        (select item_coupon_id from M_ITEM_COUPONS where name='100円割引'),
        1
    ),
    (
        (select order_id from T_ORDERS where customer_id=(select customer_id from M_CUSTOMERS where phone='(278) 260-9508')),
        (select item_id from M_ITEMS where sushi_id=(select sushi_id from M_SUSHI_MENUS where name='いくら')),
        (select shari_size_id from M_SHARI_SIZES where name='小'),
        NULL,
        2
    ),
    (
        (select order_id from T_ORDERS where customer_id=(select customer_id from M_CUSTOMERS where phone='(278) 260-9508')),
        (select item_id from M_ITEMS where sushi_id=(select sushi_id from M_SUSHI_MENUS where name='あなご一本すし')),
        (select shari_size_id from M_SHARI_SIZES where name='小'),
        NULL,
        1
    ),
    (
        (select order_id from T_ORDERS where customer_id=(select customer_id from M_CUSTOMERS where phone='(278) 260-9508')),
        (select item_id from M_ITEMS where sushi_id=(select sushi_id from M_SUSHI_MENUS where name='ホタテ貝')),
        (select shari_size_id from M_SHARI_SIZES where name='小'),
        NULL,
        1
    );

insert into M_ITEM_COUPONS(name, discount_rate, discount_amount, available_from, expired_at) values
    ('10%割引', 10, NULL, '2019-01-01', '2019-12-31'),
    ('100円割引', NULL, 100, '2019-01-01', '2019-12-31');