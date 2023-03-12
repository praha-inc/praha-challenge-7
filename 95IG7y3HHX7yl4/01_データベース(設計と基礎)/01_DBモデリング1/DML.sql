-- DML：データ登録

-- category
INSERT INTO category (id, name)
VALUES 
  (1, 'セットメニュー'),
  (2, 'お好みすし');

-- menu 盛り込みと1皿100円
INSERT INTO menu (id, name, price, category_id)
VALUES 
  (1, 'はな', 8650, 1), 
  (2, 'わだつみ', 5680, 1), 
  (3, 'あさなぎ', 4440, 1),
  (4, 'ゆうなぎ', 3830, 1), 
  (5, 'くろしお', 2830, 1), 
  (6, 'はな', 2180, 1), 
  (7, '玉子', 100, 2), 
  (8, 'いなり', 100, 2), 
  (9, '納豆軍艦', 100, 2), 
  (10, 'ツナサラダ', 100, 2), 
  (11, 'コーン', 100, 2), 
  (12, 'カニサラダ', 100, 2),
  (13, 'オクラ軍艦', 100, 2) 

-- option
INSERT INTO `option` (id, name, price)
VALUES (1, 'わさび抜き', 0) 

-- customer
INSERT INTO customer (id, name, phone_number)
VALUES (1, '山崎友輔', '080-0000-0000') 

-- order
INSERT INTO `order` (id, customer_id, paid, request)
VALUES (1, 1, true, null) 

-- order_menu
INSERT INTO order_menu (id, order_id, menu_id, number, price)
VALUES 
  (1, 1, 1, 1, 8650),
  (2, 1, 4, 1, 3830),
  (3, 1, 7, 1, 100),
  (4, 1, 8, 1, 100),
  (5, 1, 12, 2, 200) 

-- order_menu_option
INSERT INTO order_menu_option (id, order_menu_id, option_id)
VALUES (1, 4, 1) 


-- DML：課題4

-- 1オーダーの合計金額金額
SELECT SUM(order_menu.price) AS total
FROM order_menu
GROUP BY order_menu.order_id 
HAVING order_menu.order_id  = <order_id>

-- 1オーダーの合計皿枚数
SELECT SUM(order_menu.`number`) AS total
FROM order_menu
GROUP BY order_menu.order_id 
HAVING order_menu.order_id  = <order_id>

-- すべてのオーダーの売上合計金額
SELECT SUM(order_menu.price) AS total
FROM order_menu
GROUP BY order_menu.order_id 

-- メニューごとの売上合計金額
SELECT menu.name, SUM(order_menu.price) AS total
FROM order_menu
LEFT JOIN menu ON order_menu.menu_id  = menu.id
GROUP BY menu.name

-- サビ抜きオプションのトータル
SELECT SUM(order_menu.`number`) AS 'わさび抜きtotal'
FROM order_menu
LEFT JOIN order_menu_option ON order_menu.id = order_menu_option.order_menu_id
LEFT JOIN `option` ON order_menu_option.option_id = `option`.id
WHERE `option`.name = 'わさび抜き'
GROUP BY order_menu.order_id

-- セットメニューとお好みすしそれぞれの売上合計金額


-- リピート率の算出

