use mysqldb;

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
    sushi_id binary(16) references M_SUSHI_MENUS(sushi_id),
    set_id binary(16) references M_SET_MENUS(set_id),
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