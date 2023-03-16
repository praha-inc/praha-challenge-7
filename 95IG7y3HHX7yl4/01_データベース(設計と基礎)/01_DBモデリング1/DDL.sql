-- DDL：テーブル作成
START TRANSACTION;

-- カテゴリー
CREATE TABLE category (
  id INTEGER NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  is_combo BOOLEAN NOT NULL,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
);
-- セットメニュー
CREATE TABLE combo_menu (
  id INTEGER NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  can_takeaway BOOLEAN NOT NULL,
  category_id INTEGER NOT NULL,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE CASCADE
);
-- 単品メニュー
CREATE TABLE single_menu (
  id INTEGER NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  can_takeaway BOOLEAN NOT NULL,
  category_id INTEGER NOT NULL,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE CASCADE
);
-- アレルゲン
CREATE TABLE allergen (
  id INTEGER NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
);
-- メニューアレルゲン詳細
CREATE TABLE menu_allergen_detail (
  id INTEGER NOT NULL AUTO_INCREMENT,
  single_menu_id INTEGER NOT NULL,
  allergen_id INTEGER NOT NULL,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (single_menu_id) REFERENCES single_menu(id) ON DELETE CASCADE,
  FOREIGN KEY (allergen_id) REFERENCES allergen(id) ON DELETE CASCADE
);
-- セットメニュー詳細
CREATE TABLE combo_detail (
  id INTEGER NOT NULL AUTO_INCREMENT,
  combo_menu_id INTEGER NOT NULL,
  single_menu_id INTEGER NOT NULL,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (combo_menu_id) REFERENCES combo_menu(id) ON DELETE CASCADE,
  FOREIGN KEY (single_menu_id) REFERENCES single_menu(id) ON DELETE CASCADE
);
-- オプション
CREATE TABLE `option` (
  id INTEGER NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
);
-- お客さん
CREATE TABLE customer (
  id INTEGER NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  phone_number VARCHAR(60) NOT NULL,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
);
-- 注文
CREATE TABLE `order` (
  id INTEGER NOT NULL AUTO_INCREMENT,
  customer_id INTEGER NOT NULL,
  paid BOOLEAN NOT NULL,
  request VARCHAR(255),
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE CASCADE
);
-- クーポン
CREATE TABLE coupon (
  id INTEGER NOT NULL AUTO_INCREMENT,
  code VARCHAR(255) NOT NULL,
  discount_type SMALLINT UNSIGNED NOT NULL,
  discount_value DECIMAL(10, 2) NOT NULL,
  start_at TIMESTAMP NOT NULL,
  end_at TIMESTAMP NOT NULL,
  is_exclusive BOOLEAN NOT NULL,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
);
-- 使用クーポン
CREATE TABLE order_coupon_detail (
  id INTEGER NOT NULL AUTO_INCREMENT,
  order_id INTEGER NOT NULL,
  coupon_id INTEGER NOT NULL,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (order_id) REFERENCES `order`(id) ON DELETE CASCADE,
  FOREIGN KEY (coupon_id) REFERENCES coupon(id) ON DELETE CASCADE
);
-- 注文詳細
CREATE TABLE order_detail (
  id INTEGER NOT NULL AUTO_INCREMENT,
  order_id INTEGER NOT NULL,
  single_menu_id INTEGER,
  combo_menu_id INTEGER,
  number INTEGER NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (order_id) REFERENCES `order`(id) ON DELETE CASCADE,
  FOREIGN KEY (single_menu_id) REFERENCES single_menu(id) ON DELETE CASCADE,
  FOREIGN KEY (combo_menu_id) REFERENCES combo_menu(id) ON DELETE CASCADE
);
-- オプション追加可能メニュー
CREATE TABLE single_menu_option (
  id INTEGER NOT NULL AUTO_INCREMENT,
  single_menu_id INTEGER NOT NULL,
  option_id INTEGER NOT NULL,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (single_menu_id) REFERENCES single_menu(id) ON DELETE CASCADE,
  FOREIGN KEY (option_id) REFERENCES `option`(id) ON DELETE CASCADE
);
-- 注文詳細オプション内容
CREATE TABLE order_menu_option (
  id INTEGER NOT NULL AUTO_INCREMENT,
  order_detail_id INTEGER NOT NULL,
  option_id INTEGER NOT NULL,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (order_detail_id) REFERENCES order_detail(id) ON DELETE CASCADE,
  FOREIGN KEY (option_id) REFERENCES `option`(id) ON DELETE CASCADE
);

COMMIT;