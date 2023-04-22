USE store_development;

/*
  論理設計のレビュー時には、crpyted_passwordとsaltというカラムがありましたが、
  アプリケーション側でcrypted_passwordとsaltを生成するのが一般的なのかなと思ったので、
  今回は外しました。
*/
CREATE TABLE users (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  phone VARCHAR(11) NOT NULL UNIQUE,
  email VARCHAR(255) NOT NULL UNIQUE,
  PRIMARY KEY(id)
) COMMENT="ログインユーザー";

ALTER TABLE users RENAME INDEX phone TO index_users_on_phone;
ALTER TABLE users RENAME INDEX email TO index_users_on_email;

CREATE TABLE guest_users(
  id BIGINT UNSIGNED AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  phone VARCHAR(11) NOT NULL UNIQUE,
  email VARCHAR(255) NOT NULL UNIQUE,
  PRIMARY KEY(id)
) COMMENT="ゲストユーザー";

ALTER TABLE guest_users RENAME INDEX phone TO index_guest_users_on_phone;
ALTER TABLE guest_users RENAME INDEX email TO index_guest_users_on_email;

/*
  guest_user_idを新しく追加した
  guest_userとアドレスは一対一の関係なので、ユニーク制約をつけた
*/
CREATE TABLE user_addresses (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  user_id BIGINT UNSIGNED,
  guest_user_id BIGINT UNSIGNED UNIQUE,
  name VARCHAR(255) NOT NULL,
  zip_code VARCHAR(7) NOT NULL,
  region VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  address_line_1 VARCHAR(255) NOT NULL,
  address_line_2 VARCHAR(255),
  PRIMARY KEY(id),
  FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY(guest_user_id) REFERENCES guest_users(id) ON DELETE CASCADE,
  CHECK (user_id IS NOT NULL OR guest_user_id IS NOT NULL)
) COMMENT="ユーザーの住所";

ALTER TABLE user_addresses RENAME INDEX guest_user_id TO index_user_addresses_on_guest_user_id;

CREATE TABLE card_brands (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY(id)
) COMMENT="カードブランド";

/*
  guest_user_idを新しく追加した
  guest_userとカード情報は一対一の関係なので、ユニーク制約をつけた
*/
CREATE TABLE user_credit_cards (
  id BIGINT UNSIGNED AUTO_INCREMENT,
  user_id BIGINT UNSIGNED,
  guest_user_id BIGINT UNSIGNED UNIQUE,
  card_brand_id BIGINT UNSIGNED NOT NULL,
  card_number VARCHAR(255) NOT NULL,
  card_validation_code VARCHAR(255) NOT NULL,
  expires_at DATETIME NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY(card_brand_id) REFERENCES card_brands(id) ON DELETE CASCADE,
  FOREIGN KEY(guest_user_id) REFERENCES guest_users(id) ON DELETE CASCADE,
  CHECK (user_id IS NOT NULL OR guest_user_id IS NOT NULL)
) COMMENT="ユーザーのカード情報";

ALTER TABLE user_credit_cards RENAME INDEX guest_user_id TO index_user_credit_cards_on_guest_user_id;

CREATE TABLE payment_kinds(
  id BIGINT UNSIGNED AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY(id)
) COMMENT="支払いの種類";

/*
  guest_user_idを新しく追加した
  guest_userと支払い方法は一対一の関係なので、ユニーク制約をつけた
*/
CREATE TABLE payment_methods(
  id BIGINT UNSIGNED AUTO_INCREMENT,
  user_id BIGINT UNSIGNED,
  guest_user_id BIGINT UNSIGNED UNIQUE,
  payment_kind_id BIGINT UNSIGNED,
  user_credit_card_id BIGINT UNSIGNED,
  PRIMARY KEY(id),
  FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY(user_credit_card_id) REFERENCES user_credit_cards(id) ON DELETE CASCADE,
  FOREIGN KEY(guest_user_id) REFERENCES guest_users(id) ON DELETE CASCADE,
  FOREIGN KEY(payment_kind_id) REFERENCES payment_kinds(id) ON DELETE SET NULL,
  CHECK (user_id IS NOT NULL OR guest_user_id IS NOT NULL)
) COMMENT="ユーザーの支払い方法";

ALTER TABLE payment_methods RENAME INDEX guest_user_id TO index_payment_methods_on_guest_user_id;

CREATE TABLE payment_statuses(
  id BIGINT UNSIGNED AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY(id)
) COMMENT="支払のステータス";

CREATE TABLE packagings(
  id BIGINT UNSIGNED AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  price INT UNSIGNED NOT NULL,
  PRIMARY KEY(id)
) COMMENT="梱包情報";

CREATE TABLE provide_methods(
  id BIGINT UNSIGNED AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY(id)
) COMMENT="商品の提供方法";

CREATE TABLE tax_rates(
  id BIGINT UNSIGNED AUTO_INCREMENT,
  tax_percentage INT NOT NULL,
  PRIMARY KEY(id)
) COMMENT="税率";

/*
  guest_user_idを新しく追加した
  guest_userと注文は一対一の関係なので、ユニーク制約をつけた
*/
CREATE TABLE orders(
  id BIGINT UNSIGNED AUTO_INCREMENT,
  total_quantity INT UNSIGNED NOT NULL,
  sub_total_price INT UNSIGNED NOT NULL,
  total_price INT UNSIGNED NOT NULL,
  ordered_at DATETIME,
  payment_completed_at DATETIME,
  user_id BIGINT UNSIGNED,
  guest_user_id BIGINT UNSIGNED,
  user_address_id BIGINT UNSIGNED,
  payment_method_id BIGINT UNSIGNED,
  provide_method_id BIGINT UNSIGNED,
  payment_status_id BIGINT UNSIGNED,
  tax_rate_id BIGINT UNSIGNED,
  packaging_id BIGINT UNSIGNED,
  PRIMARY KEY(id),
  FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY(guest_user_id) REFERENCES guest_users(id) ON DELETE CASCADE,
  FOREIGN KEY(user_address_id) REFERENCES user_addresses(id) ON DELETE CASCADE,
  FOREIGN KEY(payment_method_id) REFERENCES payment_methods(id) ON DELETE CASCADE,
  FOREIGN KEY(provide_method_id) REFERENCES provide_methods(id) ON DELETE CASCADE,
  FOREIGN KEY(payment_status_id) REFERENCES payment_statuses(id) ON DELETE CASCADE,
  FOREIGN KEY(tax_rate_id) REFERENCES tax_rates(id) ON DELETE CASCADE,
  FOREIGN KEY(packaging_id) REFERENCES packagings(id) ON DELETE CASCADE,
  CHECK (user_id IS NOT NULL OR guest_user_id IS NOT NULL)
) COMMENT="注文";

ALTER TABLE orders RENAME INDEX guest_user_id TO index_orders_on_guest_user_id;

CREATE TABLE products(
  id BIGINT UNSIGNED AUTO_INCREMENT,
  PRIMARY KEY(id)
) COMMENT="商品";

-- product_idを追加した
CREATE TABLE order_items(
  id BIGINT UNSIGNED AUTO_INCREMENT,
  quantity INT NOT NULL,
  cancel_quantity INT NOT NULL DEFAULT 0,
  sub_total_price INT NOT NULL,
  total_price INT NOT NULL,
  order_id BIGINT UNSIGNED,
  product_id BIGINT UNSIGNED,
  PRIMARY KEY(id),
  FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE CASCADE,
  FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE SET NULL
) COMMENT="注文商品";

CREATE TABLE optional_menus(
  id BIGINT UNSIGNED AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY(id)
) COMMENT="オプションのメニュー";

CREATE TABLE order_item_optional_menus(
  id BIGINT UNSIGNED AUTO_INCREMENT,
  order_item_id BIGINT UNSIGNED,
  optional_menu_id BIGINT UNSIGNED,
  PRIMARY KEY(id),
  FOREIGN KEY(order_item_id) REFERENCES order_items(id) ON DELETE CASCADE,
  FOREIGN KEY(optional_menu_id) REFERENCES optional_menus(id) ON DELETE SET NULL,
  UNIQUE composite_index_order_item_optional_menus (order_item_id, optional_menu_id)
) COMMENT="注文商品に何のオプションをつけるかを管理するテーブル";

CREATE TABLE product_logs(
  id BIGINT UNSIGNED AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  price INT UNSIGNED NOT NULL,
  tax_rate_id BIGINT UNSIGNED,
  product_id BIGINT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id),
  FOREIGN KEY(tax_rate_id) REFERENCES tax_rates(id) ON DELETE SET NULL,
  FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE
) COMMENT="商品ログ";

CREATE TABLE product_log_families(
  id BIGINT UNSIGNED AUTO_INCREMENT,
  parent_id BIGINT UNSIGNED,
  child_id BIGINT UNSIGNED,
  PRIMARY KEY(id),
  FOREIGN KEY(parent_id) REFERENCES product_logs(id) ON DELETE CASCADE,
  FOREIGN KEY(child_id) REFERENCES product_logs(id) ON DELETE CASCADE,
  UNIQUE composite_index_product_log_families (parent_id, child_id)
) COMMENT="セット商品と寿司の関係性を管理するテーブル";

CREATE TABLE categories(
  id BIGINT UNSIGNED AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY(id)
) COMMENT="カテゴリー";

CREATE TABLE product_log_categories(
  id BIGINT UNSIGNED AUTO_INCREMENT,
  product_log_id BIGINT UNSIGNED,
  category_id BIGINT UNSIGNED,
  PRIMARY KEY(id),
  FOREIGN KEY(product_log_id) REFERENCES product_logs(id) ON DELETE CASCADE,
  FOREIGN KEY(category_id) REFERENCES categories(id) ON DELETE SET NULL,
  UNIQUE composite_index_product_log_categories (product_log_id, category_id)
) COMMENT="商品ログとカテゴリーの関係性を管理するテーブル";

CREATE TABLE product_log_provide_methods(
  id BIGINT UNSIGNED AUTO_INCREMENT,
  product_log_id BIGINT UNSIGNED,
  provide_method_id BIGINT UNSIGNED,
  PRIMARY KEY(id),
  FOREIGN KEY(product_log_id) REFERENCES product_logs(id) ON DELETE CASCADE,
  FOREIGN KEY(provide_method_id) REFERENCES provide_methods(id) ON DELETE SET NULL,
  UNIQUE composite_index_product_log_provide_methods (product_log_id, provide_method_id)
) COMMENT="商品の提供方法を管理するテーブル";

CREATE TABLE coupon_types(
  id BIGINT UNSIGNED AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY(id)
) COMMENT="クーポンのタイプ";

CREATE TABLE coupons(
  id BIGINT UNSIGNED AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  coupon_code VARCHAR(255) NOT NULL,
  discount_price INT,
  coupon_type_id BIGINT UNSIGNED,
  starts_at DATETIME,
  ends_at DATETIME,
  PRIMARY KEY(id),
  FOREIGN KEY(coupon_type_id) REFERENCES coupon_types(id) ON DELETE SET NULL
) COMMENT="クーポン";

CREATE TABLE user_coupons(
  id BIGINT UNSIGNED AUTO_INCREMENT,
  user_id BIGINT UNSIGNED,
  coupon_id BIGINT UNSIGNED,
  used_at DATETIME,
  PRIMARY KEY(id),
  FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY(coupon_id) REFERENCES coupons(id) ON DELETE SET NULL,
  UNIQUE composite_index_user_coupons (user_id, coupon_id)
) COMMENT="ユーザーがどのクーポンを持っているのか、いつ使ったのかを管理している";

CREATE TABLE guest_user_coupons(
  id BIGINT UNSIGNED AUTO_INCREMENT,
  guest_user_id BIGINT UNSIGNED,
  coupon_id BIGINT UNSIGNED,
  used_at DATETIME,
  PRIMARY KEY(id),
  FOREIGN KEY(guest_user_id) REFERENCES guest_users(id) ON DELETE CASCADE,
  FOREIGN KEY(coupon_id) REFERENCES coupons(id) ON DELETE SET NULL,
  UNIQUE composite_index_guest_user_coupons (guest_user_id, coupon_id)
) COMMENT="ゲストユーザーはどのクーポンをいつ使ったのかを管理している";

CREATE TABLE order_coupons(
  id BIGINT UNSIGNED AUTO_INCREMENT,
  order_id BIGINT UNSIGNED NOT NULL,
  coupon_id BIGINT UNSIGNED,
  PRIMARY KEY(id),
  FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE CASCADE,
  FOREIGN KEY(coupon_id) REFERENCES coupons(id) ON DELETE SET NULL,
  UNIQUE composite_index_order_coupons (order_id, coupon_id)
) COMMENT="注文でどのクーポンを使ったかを管理している";
