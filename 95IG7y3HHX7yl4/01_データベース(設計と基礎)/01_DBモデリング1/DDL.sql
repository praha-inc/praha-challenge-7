-- DDL：テーブル作成
START TRANSACTION;

CREATE TABLE category (
  id INTEGER NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
);
CREATE TABLE menu (
  id INTEGER NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  price INTEGER NOT NULL,
  category_id INTEGER NOT NULL,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE CASCADE
);
CREATE TABLE `option` (
  id INTEGER NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  price INTEGER NOT NULL,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
);
CREATE TABLE customer (
  id INTEGER NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  phone_number VARCHAR(60) NOT NULL,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
);
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
CREATE TABLE order_menu (
  id INTEGER NOT NULL AUTO_INCREMENT,
  order_id INTEGER NOT NULL,
  menu_id INTEGER NOT NULL,
  number INTEGER,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (order_id) REFERENCES `order`(id) ON DELETE CASCADE,
  FOREIGN KEY (menu_id) REFERENCES menu(id) ON DELETE CASCADE
);
CREATE TABLE order_menu_option (
  id INTEGER NOT NULL AUTO_INCREMENT,
  order_menu_id INTEGER NOT NULL,
  option_id INTEGER NOT NULL,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (order_menu_id) REFERENCES order_menu(id) ON DELETE CASCADE,
  FOREIGN KEY (option_id) REFERENCES `option`(id) ON DELETE CASCADE
);

COMMIT;