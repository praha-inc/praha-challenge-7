USE store_development;

-- 税率
INSERT INTO tax_rates (id, tax_percentage) VALUES
(DEFAULT, 10), (DEFAULT, 8);

-- 商品
INSERT INTO products (id) VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
(11), (12), (13), (14), (15), (16), (17), (18), (19), (20),
(21), (22), (23), (24), (25), (26), (27), (28), (29), (30),
(31), (32), (33), (34), (35), (36), (37), (38), (39), (40),
(41), (42), (43), (44), (45), (46), (47), (48), (49), (50),
(51), (52), (53), (54), (55), (56), (57), (58), (59), (60),
(61), (62), (63), (64), (65), (66), (67);

-- 商品ログ
INSERT INTO product_logs (id, name, price, tax_rate_id, product_id, created_at) VALUES
-- セット
(DEFAULT, 'はな', 8650, 2, 1, NOW()),
(DEFAULT, 'わだつみ', 5680, 2, 2, NOW()),
(DEFAULT, 'あさなぎ', 4440, 2, 3, NOW()),
(DEFAULT, 'ゆうなぎ', 3830, 2, 4, NOW()),
(DEFAULT, 'くろしお', 2830, 2, 5, NOW()),
(DEFAULT, 'いさりび', 2180, 2, 6, NOW()),
(DEFAULT, 'みさき', 1940, 2, 7, NOW()),
(DEFAULT, 'みなと', 1490, 2, 8, NOW()),
(DEFAULT, 'しおん', 1060, 2, 9, NOW()),
(DEFAULT, 'なぎさ', 800, 2, 10, NOW()),
(DEFAULT, '海鮮ちらし', 2830, 2, 11, NOW()),
(DEFAULT, '鉄火丼', 2180, 2, 12, NOW()),
(DEFAULT, '鮨八方宝巻', 1280, 2, 13, NOW()),
-- 寿司
(DEFAULT, '玉子', 100, 2, 14, NOW()),
(DEFAULT, 'いなり', 100, 2, 15, NOW()),
(DEFAULT, '納豆軍艦', 100, 2, 16, NOW()),
(DEFAULT, 'ツナサラダ', 100, 2, 17, NOW()),
(DEFAULT, 'コーン', 100, 2, 18, NOW()),
(DEFAULT, 'カニサラダ', 100, 2, 19, NOW()),
(DEFAULT, 'オクラ軍艦', 100, 2, 20, NOW()),
(DEFAULT, 'ゆでげそ', 150, 2, 21, NOW()),
(DEFAULT, 'とびっこ', 150, 2, 22, NOW()),
(DEFAULT, '明太子サラダ', 150, 2, 23, NOW()),
(DEFAULT, 'いかの塩辛', 150, 2, 24, NOW()),
(DEFAULT, 'オクラ納豆', 150, 2, 25, NOW()),
(DEFAULT, '干瓢巻き', 150, 2, 26, NOW()),
(DEFAULT, 'なっとう巻', 150, 2, 27, NOW()),
(DEFAULT, 'かっぱ巻', 150, 2, 28, NOW()),
(DEFAULT, 'おしんこ巻', 150, 2, 29, NOW()),
(DEFAULT, '梅しそ巻', 150, 2, 30, NOW()),
(DEFAULT, 'えび', 180, 2, 31, NOW()),
(DEFAULT, '赤いか', 180, 2, 32, NOW()),
(DEFAULT, 'かにみそ軍艦', 180, 2, 33, NOW()),
-- 生サーモンに対して価格変更が発生
(DEFAULT, '生サーモン', 220, 2, 34, NOW()),
(DEFAULT, 'オニオンサーモン', 220, 2, 35, NOW()),
(DEFAULT, 'まぐろ赤身', 220, 2, 36, NOW()),
(DEFAULT, 'ゆでたこ', 220, 2, 37, NOW()),
(DEFAULT, 'あじ', 260, 2, 38, NOW()),
(DEFAULT, '赤えび', 260, 2, 39, NOW()),
(DEFAULT, '生たこ', 260, 2, 40, NOW()),
(DEFAULT, 'えんがわ', 260, 2, 41, NOW()),
(DEFAULT, '炙りえんがわ', 260, 2, 42, NOW()),
(DEFAULT, 'まぐろ塩だれ焼', 260, 2, 43, NOW()),
(DEFAULT, '焼きえび', 260, 2, 44, NOW()),
(DEFAULT, 'ネギトロ', 260, 2, 45, NOW()),
(DEFAULT, '炙りサーモン', 260, 2, 46, NOW()),
(DEFAULT, '鉄火巻', 260, 2, 47, NOW()),
(DEFAULT, 'まぐろワサビ巻', 260, 2, 48, NOW()),
(DEFAULT, 'いくら', 360, 2, 49, NOW()),
(DEFAULT, 'ホタテ貝', 360, 2, 50, NOW()),
(DEFAULT, '穴子', 360, 2, 51, NOW()),
(DEFAULT, '真鯛', 360, 2, 52, NOW()),
(DEFAULT, '活ヒラメ', 400, 2, 53, NOW()),
(DEFAULT, '数の子', 400, 2, 54, NOW()),
(DEFAULT, 'ずわいがに', 400, 2, 55, NOW()),
(DEFAULT, 'トロタク巻', 400, 2, 56, NOW()),
(DEFAULT, 'すじこ巻', 400, 2, 57, NOW()),
(DEFAULT, '中トロ', 460, 2, 58, NOW()),
(DEFAULT, '特大海老', 460, 2, 59, NOW()),
(DEFAULT, 'あなご一本すし', 520, 2, 60, NOW()),
(DEFAULT, 'まぐろづくし', 520, 2, 61, NOW()),
(DEFAULT, '白身づくし', 520, 2, 62, NOW()),
(DEFAULT, 'うに', 600, 2, 63, NOW()),
(DEFAULT, 'インドまぐろ大トロ', 600, 2, 64, NOW()),
-- サイドメニュー
(DEFAULT, '唐揚げ', 650, 2, 65, NOW()),
(DEFAULT, '茶碗蒸し', 450, 2, 66, NOW()),
(DEFAULT, '赤だし', 300, 2, 67, NOW());

-- カテゴリ
INSERT INTO categories (id, name) VALUES
(DEFAULT, "セットメニュー"), (DEFAULT, "盛り込み"), (DEFAULT, "にぎり"),
(DEFAULT, "鮨屋の丼"), (DEFAULT, "おすすめ"), (DEFAULT, "地元に生まれた味"),
(DEFAULT, "お好みすし"), (DEFAULT, "サイドメニュー");

-- 商品ログカテゴリ
INSERT INTO product_log_categories (id, product_log_id, category_id) VALUES
-- セット
(DEFAULT, 1, 1), (DEFAULT, 1, 2),
(DEFAULT, 2, 1), (DEFAULT, 2, 2),
(DEFAULT, 3, 1), (DEFAULT, 3, 2),
(DEFAULT, 4, 1), (DEFAULT, 4, 2),
(DEFAULT, 5, 1), (DEFAULT, 5, 2),
(DEFAULT, 6, 1), (DEFAULT, 6, 2),
(DEFAULT, 7, 1), (DEFAULT, 7, 3),
(DEFAULT, 8, 1), (DEFAULT, 8, 3),
(DEFAULT, 9, 1), (DEFAULT, 9, 3),
(DEFAULT, 10, 1), (DEFAULT, 10, 3),
(DEFAULT, 11, 1), (DEFAULT, 11, 4), (DEFAULT, 11, 5),
(DEFAULT, 12, 1), (DEFAULT, 12, 4), (DEFAULT, 12, 5),
(DEFAULT, 13, 1), (DEFAULT,13, 6),
-- 寿司
(DEFAULT, 14, 7), (DEFAULT, 15, 7), (DEFAULT, 16, 7), (DEFAULT, 17, 7),
(DEFAULT, 18, 7), (DEFAULT, 19, 7), (DEFAULT, 20, 7), (DEFAULT, 21, 7),
(DEFAULT, 22, 7), (DEFAULT, 23, 7), (DEFAULT, 24, 7), (DEFAULT, 25, 7),
(DEFAULT, 26, 7), (DEFAULT, 27, 7), (DEFAULT, 28, 7), (DEFAULT, 29, 7),
(DEFAULT, 30, 7), (DEFAULT, 31, 7), (DEFAULT, 32, 7), (DEFAULT, 33, 7),
(DEFAULT, 34, 7), (DEFAULT, 35, 7), (DEFAULT, 36, 7), (DEFAULT, 37, 7),
(DEFAULT, 38, 7), (DEFAULT, 39, 7), (DEFAULT, 40, 7), (DEFAULT, 41, 7),
(DEFAULT, 42, 7), (DEFAULT, 43, 7), (DEFAULT, 44, 7), (DEFAULT, 45, 7),
(DEFAULT, 46, 7), (DEFAULT, 47, 7), (DEFAULT, 48, 7), (DEFAULT, 49, 7),
(DEFAULT, 50, 7), (DEFAULT, 51, 7), (DEFAULT, 52, 7), (DEFAULT, 53, 7),
(DEFAULT, 54, 7), (DEFAULT, 55, 7), (DEFAULT, 56, 7), (DEFAULT, 57, 7),
(DEFAULT, 58, 7), (DEFAULT, 59, 7), (DEFAULT, 60, 7), (DEFAULT, 61, 7),
(DEFAULT, 62, 7), (DEFAULT, 63, 7), (DEFAULT, 64, 7), (DEFAULT, 65, 8),
(DEFAULT, 66, 8), (DEFAULT, 67, 8);

-- 商品または注文の提供方法
INSERT INTO provide_methods (id, name) VALUES
(DEFAULT, "店舗"), (DEFAULT, "出前"), (DEFAULT, "EC");

/*
  商品ログテーブルに同じ商品(はな)をインサートする(値段を更新している)
  ログを更新する場合、ログに関係するレコードを再度インサートしないといけない(そこは本来アプリケーション側でどうにかする)
  カテゴリを再インサートする必要がある。さらにセット商品の場合、どの寿司で構成されているかも再度インサートする
  提供方法も再インサートが必要。
  イミュータブルデータモデリングは、一つのインサートに応じて複数のテーブルにインサートしないといけないケースには使わない方が良いかも
  一つの関連するテーブルを追加するごとに、アプリケーション側にインサート処理を追加しないといけないので、一つの変更に対して
  二つ変更する必要がある。なので、保守性が悪く,変更を忘れると不整合なデータを作ってしまいそうな予感がする。
*/
INSERT INTO product_logs (id, name, price, tax_rate_id, product_id, created_at) VALUES
(68, 'はな', 70000, 2, 1, DATE_ADD(NOW(), INTERVAL 1 DAY));

INSERT INTO product_log_categories (id, product_log_id, category_id) VALUES
(DEFAULT, 68, 1), (DEFAULT, 68, 2);

INSERT INTO product_log_families (id, parent_id, child_id) VALUES
(DEFAULT, 68, 46), (DEFAULT, 68, 47), (DEFAULT, 68, 48), (DEFAULT, 68, 49),
(DEFAULT, 68, 50), (DEFAULT, 68, 51), (DEFAULT, 68, 52), (DEFAULT, 68, 53),
(DEFAULT, 68, 54), (DEFAULT, 68, 55), (DEFAULT, 68, 56), (DEFAULT, 68, 57),
(DEFAULT, 68, 58), (DEFAULT, 68, 59);

INSERT INTO product_log_provide_methods (id, product_log_id, provide_method_id) VALUES
(DEFAULT, 68, 1), (DEFAULT, 68, 3);

-- セットメニュー(はな)がどんな寿司で構成されているかをインサートする
INSERT INTO product_log_families (id, parent_id, child_id) VALUES
(DEFAULT, 1, 46), (DEFAULT, 1, 47), (DEFAULT, 1, 48), (DEFAULT, 1, 49),
(DEFAULT, 1, 50), (DEFAULT, 1, 51), (DEFAULT, 1, 52), (DEFAULT, 1, 53),
(DEFAULT, 1, 54), (DEFAULT, 1, 55), (DEFAULT, 1, 56), (DEFAULT, 1, 57),
(DEFAULT, 1, 58), (DEFAULT, 1, 59);

-- ログインユーザー
INSERT INTO users (id, name, phone, email) VALUES
(DEFAULT, "プラハ太郎", "09033334444", "sample1@gmail.com");

-- ゲストユーザー
INSERT INTO guest_users (id, name, phone, email) VALUES
(DEFAULT, "プラハゲスト太郎", "09022224444", "sample2@gmail.com");

-- クーポンタイプ
INSERT INTO coupon_types (id, name) VALUES
(DEFAULT, "一般"), (DEFAULT, "会員限定");

-- クーポン
INSERT INTO coupons (id, name, coupon_code, discount_price, coupon_type_id, starts_at, ends_at) VALUES
(DEFAULT, "春の新生活応援クーポン", "43xfcd", 400, 1, NOW(), NULL),
(DEFAULT, "会員限定400円OFFクーポン", "43xfcd", 400, 2, NOW(), NULL);

-- ユーザーのアドレス(ゲストユーザーの分もインサートする)
INSERT INTO user_addresses (id, user_id, guest_user_id, name, zip_code, region, city, address_line_1, address_line_2) VALUES
(DEFAULT, 1, NULL, "プラハ太郎", "1540002", "東京都", "世田谷区", "下馬2-12-7", NULL),
(DEFAULT, NULL, 1, "プラハゲスト太郎", "1540002", "東京都", "世田谷区", "下馬2-12-8", NULL);

-- カードブランド
INSERT INTO card_brands (id, name) VALUES
(DEFAULT, "VISA"), (DEFAULT, "JCB"), (DEFAULT, "MasterCard");

-- ユーザーのクレジットカード(ゲストユーザーの分もインサートする)
INSERT INTO user_credit_cards (id, user_id, guest_user_id, card_brand_id, card_number, card_validation_code, expires_at) VALUES
(DEFAULT, 1, NULL, 1, "4242424242424242", "453", DATE_ADD(NOW(), INTERVAL 1 YEAR)),
(DEFAULT, NULL, 1, 3, "5555555555554444", "403", DATE_ADD(NOW(), INTERVAL 1 YEAR));

INSERT INTO payment_kinds (id, name) VALUES
(DEFAULT, "cash"), (DEFAULT, "credit_card"), (DEFAULT, "PayPay");

-- 支払い方法(ゲストユーザーの分もインサートする)
INSERT INTO payment_methods (id, user_id, guest_user_id, payment_kind_id, user_credit_card_id) VALUES
(DEFAULT, 1, NULL, 2, 1), (DEFAULT, NULL, 1, 2, 2);

-- 支払いのステータス
INSERT INTO payment_statuses (id, name) VALUES
(DEFAULT, "未払い"), (DEFAULT, "支払済"), (DEFAULT, "保留中");

-- 梱包情報
INSERT INTO packagings (id, name, price) VALUES
(DEFAULT, "化粧箱", 400);

-- 商品と商品の提供方法を管理
INSERT INTO product_log_provide_methods (id, product_log_id, provide_method_id) VALUES
(DEFAULT, 1, 1), (DEFAULT, 1, 3);

-- 注文(ゲストユーザーの分もインサートする)　どちらの注文もはなとたまごを注文した。ゲストユーザーは400円オフクーポンを使った
INSERT INTO orders (
  id, total_quantity, sub_total_price, total_price, ordered_at, payment_completed_at, user_id,
  guest_user_id, user_address_id, payment_method_id, provide_method_id, payment_status_id, tax_rate_id, packaging_id
) VALUES
(DEFAULT, 2, 8750, 9450, DEFAULT, DATE_ADD(NOW(), INTERVAL 5 SECOND), 1, NULL, 1, 1, 3, 2, 2, NULL),
(DEFAULT, 2, 8750, 9050, DEFAULT, DATE_ADD(NOW(), INTERVAL 5 SECOND), NULL, 1, 2, 2, 3, 2, 2, NULL);

-- 注文商品
INSERT INTO order_items (id, quantity, cancel_quantity, sub_total_price, total_price, order_id, product_id) VALUES
(DEFAULT, 1, 0, 8650, 9342, 1, 1), (DEFAULT, 1, 0, 100, 108, 1, 14),
(DEFAULT, 1, 0, 8650, 9342, 2, 1), (DEFAULT, 1, 0, 100, 108, 2, 14);

-- オプションのメニュー
INSERT INTO optional_menus (id, name) VALUES
(DEFAULT, "わさび"), (DEFAULT, "シャリ大"), (DEFAULT, "シャリ中"),
(DEFAULT, "シャリ小"), (DEFAULT, "割り箸"), (DEFAULT, "ガリ");


-- 注文商品とオプションの紐付け
INSERT INTO order_item_optional_menus (id, order_item_id, optional_menu_id) VALUES
(DEFAULT, 1, 1);

-- 注文とクーポンの紐付け(ゲストユーザーがクーポンを使った)
INSERT INTO order_coupons (id, order_id, coupon_id) VALUES
(DEFAULT, 2, 1);

-- ユーザークーポン(保持していたらインサートされる。あと使ったらused_atがアップデートされる)
INSERT INTO user_coupons (id, user_id, coupon_id, used_at) VALUES
(DEFAULT, 1, 2, NULL);

-- ゲストユーザークーポン(使ったらインサートされる)
INSERT INTO guest_user_coupons (id, guest_user_id, coupon_id, used_at) VALUES
(DEFAULT, 1, 1, DATE_ADD(NOW(), INTERVAL 10 DAY));
