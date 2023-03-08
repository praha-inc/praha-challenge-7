-- DDL：テーブル作成
CREATE TABLE category (
  id INTEGER NOT NULL,
  name TEXT NOT NULL,
  updated_at TIMESTAMP NOT NULL,
  created_at TIMESTAMP NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE menu (
  id INTEGER NOT NULL,
  name TEXT NOT NULL,
  price INTEGER NOT NULL,
  category_id INTEGER NOT NULL,
  updated_at TIMESTAMP NOT NULL,
  created_at TIMESTAMP NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE CASCADE
);
CREATE TABLE `option` (
  id INTEGER NOT NULL,
  name TEXT NOT NULL,
  price INTEGER NOT NULL,
  updated_at TIMESTAMP NOT NULL,
  created_at TIMESTAMP NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE `order` (
  id INTEGER NOT NULL,
  orderer TEXT NOT NULL,
  phone_number VARCHAR(60) NOT NULL,
  paid BOOLEAN NOT NULL,
  checked_number_of_orders INTEGER,
  request TEXT,
  updated_at TIMESTAMP NOT NULL,
  created_at TIMESTAMP NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE order_menu (
  id INTEGER NOT NULL,
  order_id INTEGER NOT NULL,
  menu_id INTEGER NOT NULL,
  number INTEGER,
  updated_at TIMESTAMP NOT NULL,
  created_at TIMESTAMP NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (order_id) REFERENCES `order`(id) ON DELETE CASCADE,
  FOREIGN KEY (menu_id) REFERENCES menu(id) ON DELETE CASCADE
);
CREATE TABLE order_menu_option (
  id INTEGER NOT NULL,
  order_menu_id INTEGER NOT NULL,
  option_id INTEGER NOT NULL,
  updated_at TIMESTAMP NOT NULL,
  created_at TIMESTAMP NOT NULL,
  PRIMARY KEY (id)
);