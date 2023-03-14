-- DML：データ登録

-- カテゴリー
INSERT INTO category (id, name, is_combo)
VALUES 
  (1, '盛り込み', true),
  (2, 'にぎり', true),
  (3, '鮨屋の丼＆おすすめ', true),
  (4, '地元に生まれた味', true),
  (6, 'お好みすし', false);

-- menu 盛り込みと1皿100円
INSERT INTO combo_menu (id, name, price, can_takeaway, category_id)
VALUES 
  (1, 'はな', 8650, true, 1), 
  (2, 'わだつみ', 5680, true, 1), 
  (3, 'あさなぎ', 4440, false, 1),
  (4, 'ゆうなぎ', 3830, true, 1), 
  (5, 'くろしお', 2830, false, 1), 
  (6, 'いさりび', 2180, false, 1), 
  (7, 'みさき', 1940, true, 2), 
  (8, 'みなと', 1490, false, 2), 
  (9, 'しおん', 1060, true, 2),
  (10, 'なぎさ', 800, true, 2), 
  (11, '海鮮ちらし', 2830, false, 3), 
  (12, '鉄火丼', 2180, true, 3), 
  (13, '鮨八方宝巻', 1280, true, 4), 
  (14, '鮨八方宝巻（化粧箱入り）', 1480, true, 4);
  
INSERT INTO single_menu (id, name, price, can_takeaway, category_id)
VALUES 
  -- 100円
  (1, '玉子', 100, true, 6), 
  (2, 'いなり', 100, true, 6), 
  (3, '納豆軍艦', 100, true, 6), 
  (4, 'ツナサラダ', 100, true, 6), 
  (5, 'コーン', 100, true, 6), 
  (6, 'カニサラダ', 100, true, 6),
  (7, 'オクラ軍艦', 100, true, 6),
  -- 150円
  (8, 'ゆでげそ', 150, true, 6), 
  (9, 'とびっこ', 150, true, 6), 
  (10, '明太子サラダ', 150, true, 6), 
  (11, 'いかの塩辛', 150, true, 6), 
  (12, 'オクラ納豆', 150, true, 6), 
  (13, 'かんぴょう巻', 150, true, 6),
  (14, 'なっとう巻', 150, true, 6),
  (15, 'かっぱ巻', 150, true, 6), 
  (16, 'おしんこ巻', 150, true, 6),
  (17, '梅しそ巻き', 150, true, 6),
  -- 180円
  (18, 'えび', 180, true, 6), 
  (19, '赤いか', 180, true, 6), 
  (20, 'かにみそ軍艦', 180, true, 6), 
  -- 220円
  (21, '生サーモン', 220, true, 6), 
  (22, 'オニオンサーモン', 220, true, 6), 
  (23, 'マグロ赤身', 220, true, 6),
  (24, 'ゆでだこ', 220, true, 6),
  -- 260円
  (25, 'あじ', 260, true, 6), 
  (26, '赤えび', 260, true, 6),
  (27, '生たこ', 260, true, 6),
  (28, 'えんがわ', 260, true, 6), 
  (29, '炙りえんがわ', 260, true, 6), 
  (30, 'まぐろの塩だれ焼', 260, true, 6), 
  (31, '焼えび', 260, true, 6), 
  (32, 'ねぎとろ', 260, true, 6), 
  (33, '炙りサーモン', 260, true, 6),
  (34, '鉄火巻', 260, true, 6),
  (35, 'まぐろわさび巻', 260, true, 6), 
  -- 360円
  (36, 'いくら', 360, true, 6),
  (37, 'ホタテ貝', 360, false, 6),
  (38, '穴子', 360, true, 6), 
  (39, '真鯛', 360, true, 6), 
  -- 400円
  (40, '活ヒラメ', 400, true, 6), 
  (41, '数の子', 400, true, 6), 
  (42, 'ずわいがに', 400, true, 6), 
  (43, 'トロタク巻き', 400, true, 6),
  (44, 'すじこ巻', 400, true, 6),
  -- 460円
  (45, '中トロ', 460, true, 6), 
  (46, '特大海老', 460, true, 6),
  -- 520円
  (47, 'あなご一本すし', 520, true, 6),
  (48, 'まぐろづくし', 520, true, 6), 
  (49, '白身づくし', 520, true, 6), 
  -- 600円
  (50, 'うに', 600, true, 6), 
  (51, 'インドまぐろ大トロ', 600, true, 6);
-- アレルゲン
INSERT INTO allergen (id, name)
VALUES 
  (1, 'えび'),
  (2, 'たまご');
-- メニューアレルゲン詳細
INSERT INTO menu_allergen_detail (id, single_menu_id, allergen_id)
VALUES 
  (1, 1, 2),
  (2, 18, 1),
  (3, 46, 1);
-- セットメニュー詳細
-- 不明なため省略 --
-- オプション
INSERT INTO `option` (id, name, price)
VALUES 
  (1, 'わさび抜き', 0),
  (2, 'シャリ半分', 0);
-- お客さん
INSERT INTO customer (id, name, phone_number)
VALUES (1, '山崎友輔', '080-0000-0000');
-- 注文
INSERT INTO `order` (id, customer_id, paid, request)
VALUES (1, 1, true, null);
-- クーポン
INSERT INTO coupon (id, discount_price, start_at, end_at, is_exclusive)
VALUES (1, 1000, '2023-03-14 12:00:00', '2023-04-14 12:00:00', true);
-- 使用クーポン
INSERT INTO order_coupon_detail (id, order_id, coupon_id)
VALUES (1, 1, 1);
-- 注文詳細
INSERT INTO order_detail (id, order_id, single_menu_id, combo_menu_id, number, price)
VALUES 
  (1, 1, null, 1, 1, 8650),
  (2, 1, null, 4, 1, 3830),
  (3, 1, 1, null, 1, 100),
  (4, 1, 18, null, 4, 180);
-- オプション追加可能メニュー
INSERT INTO single_menu_option (id, single_menu_id, option_id)
VALUES 
  (1, 18, 1),
  (2, 19, 1),
  (3, 21, 1),
  (4, 22, 1),
  (5, 23, 1),
  (6, 24, 1);

-- 注文詳細オプション内容
INSERT INTO order_menu_option (id, order_detail_id, option_id)
VALUES 
  (1, 4, 1);

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

