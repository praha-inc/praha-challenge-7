-- 顧客
CREATE TABLE customers(
    id BINARY(16) DEFAULT (UUID_TO_BIN(UUID()),
    last_name VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(16) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    customer_type_id NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (customer_type_id) REFERENCES customer_types(id) ON DELETE CASCADE
);

-- 顧客種別
CREATE TABLE customer_types(
    id INT UNSIGNED AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

-- 顧客住所
CREATE TABLE customer_addresses(
    id BIGINT UNSIGNED AUTO_INCREMENT,
    customer_id BINARY(16) NOT NULL,
    postal_code VARCHAR(7) NOT NULL,
    address1 VARCHAR(255) NOT NULL,
    address2 VARCHAR(255),
    PRIMARY KEY (id),
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

-- クーポンマスタ
CREATE TABLE coupons(
    id INT UNSIGNED AUTOINCREMENT,
    name VARCHAR(255) NOT NULL,
    discount_price INT NOT NULL,
    starts_at DATETIME NOT NULL,
    ends_at DATETIME DEFAULT NULL,
    PRIMARY KEY (id)
);

-- 顧客保有クーポン
CREATE TABLE customer_coupons(
    id BIGINT UNSIGNED AUTOINCREMENT,
    customer_id BINARY(16) NOT NULL,
    coupon_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,
    FOREIGN KEY (coupon_id) REFERENCES coupons(id) ON DELETE CASCADE
);

-- 消費税マスタ
CREATE TABLE tax_rate(
    id INT UNSIGNED AUTO_INCREMENT,
    tax_rate DECIMAL(6, 3) NOT NULL,
    starts_date DATE NOT NULL,
    PRIMARY KEY (id)
);

-- 決済方法
CREATE TABLE payment_methods(
    id INT UNSIGNED AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

-- 注文票
CREATE TABLE orders(
    id BIGINT UNSIGNED AUTO_INCREMENT,
    customer_id BINARY(16),
    tax_rate_id INT NOT NULL,
    coupon_id INT DEFAULT NULL,
    subtotal_price INT NOT NULL,
    total_price INT NOT NULL, 
    order_method VARCHAR(255) NOT NULL,
    postal_code VARCHAR(7),
    address1 VARCHAR(255),
    address2 VARCHAR(255),
    payment_method_id INT NOT NULL,
    ordered_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    payed_at DATETIME DEFAULT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE SET NULL,
    FOREIGN KEY (tax_rate_id) REFERENCES tax_rate(id) ON DELETE NO ACTION,
    FOREIGN KEY (coupon_id) REFERENCES coupons(id) ON DELETE SET NULL,
    FOREIGN KEY (payment_method_id) REFERENCES payment_methods(id) ON DELETE NO ACTION
);

-- 梱包マスタ
CREATE TABLE packages(
    id INT UNSIGNED AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    price INT NOT NULL,
    PRIMARY KEY (id)
);

-- 商品マスタ
CREATE TABLE products(
    id INT UNSIGNED AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    price INT NOT NULL,
    sales_status_id INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (tax_rate_id) REFERENCES tax_rate(id) ON DELETE NO ACTION,
    FOREIGN KEY (sales_status_id) REFERENCES sales_status(id) ON DELETE NO ACTION
);

-- 販売状況
CREATE TABLE sales_status(
    id INT UNSIGNED AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

-- 注文商品
CREATE TABLE order_products(
    order_id BIGINT UNSIGNED,
    order_branch_number INT UNSIGNED,
    product_id INT NOT NULL,
    product_price INT NOT NULL,
    package_id INT,
    package_price INT, 
    quantity INT NOT NULL DEFAULT 0,
    PRIMARY KEY (order_id, order_branch_number),
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE NO ACTION,
    FOREIGN KEY (package_id) REFERENCES packages(id) ON DELETE NO ACTION
);

-- オプションマスタ
CREATE TABLE options(
    id INT UNSIGNED AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);

-- 注文オプション
CREATE TABLE order_options(
    id INT UNSIGNED AUTO_INCREMENT,
    order_id INT NOT NULL,
    order_branch_number INT NOT NULL,
    option_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (order_id, order_branch_number) REFERENCES order_products(order_id, order_branch_number) ON DELETE CASCADE,
    FOREIGN KEY (option_id) REFERENCES options(id)
);

-- 商品変更履歴
CREATE TABLE product_update_histories(
    id INT UNSIGNED AUTO_INCREMENT,
    product_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    price INT NOT NULL,
    sales_status_id INT NOT NULL,
    product_created_at DATETIME NOT NULL,
    product_updated_at DATETIME NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (sales_status_id) REFERENCES sales_status(id) ON SET NULL
);

-- カテゴリー
CREATE TABLE categories(
    id INT UNSIGNED AUTO_INCREMENT,  
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

-- 商品カテゴリー
CREATE TABLE product_categories(
    id INT UNSIGNED AUTO_INCREMENT,
    product_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE NO ACTION
);

-- セット詳細
CREATE TABLE set_details(
    id INT UNSIGNED AUTO_INCREMENT,
    set_id INT NOT NULL,
    sushi_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (set_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (sushi_id) REFERENCES products(id) ON DELETE NO ACTION
);