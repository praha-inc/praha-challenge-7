use mysqldb;

create table M_CUSTOMERS(
    customer_id binary(16) primary key default (UUID()),
    phone text not null,
    name text not null,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

create table M_ITEMS (
    item_id binary(16) primary key default (UUID()),
    sushi_id binary(16) references M_SUSHI_MENUS(sushi_id),
    set_id binary(16) references M_SET_MENUS(set_id),
    is_deleted boolean default false,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

create table M_SUSHI_MENUS (
    sushi_id binary(16) primary key default (UUID()),
    name text not null,
    price int unsigned not null,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

create table M_SET_MENUS (
    set_id  binary(16) primary key default (UUID()),
    set_type_id binary(16) references M_SET_TYPES(set_type_id),
    name text not null,
    price int unsigned not null,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

create table R_SUSHI_MENUS_AND_SET_MENUS (
    sushi_set_id  binary(16) primary key default (UUID()),
    sushi_id binary(16) references M_SUSHI_MENUS(sushi_id),
    set_id binary(16) references M_SET_MENUS(set_id),
    sushi_count int unsigned not null,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

create table T_ORDERS (
    order_id binary(16) primary key default (UUID()),
    customer_id binary(16) references M_ORDERS(customer_id),
    total_coupon_id binary(16) references M_TOTAL_COUPONS(total_coupon_id),
    payment_method int unsigned not null,
    is_paid boolean default false,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

create table T_ORDER_DETAILS (
    order_detail_id binary(16) primary key default (UUID()),
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
    shari_size_id binary(16) primary key default (UUID()),
    name text not null,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

create table M_SET_TYPES (
    set_type_id binary(16) primary key default (UUID()),
    name text not null,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp()
);

create table M_TOTAL_COUPONS (
    total_coupon_id binary(16) primary key default (UUID()),
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
    item_coupon_id binary(16) primary key default (UUID()),
    name text not null,
    discount_rate int unsigned,
    discount_amount int unsigned,
    available_from datetime not null,
    expired_at datetime not null,
    created_at datetime not null default current_timestamp(),
    updated_at datetime not null default current_timestamp() on update current_timestamp(),
    check (discount_rate is not null or discount_amount is not null)
);
