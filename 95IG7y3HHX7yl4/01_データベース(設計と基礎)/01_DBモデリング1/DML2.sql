-- DML：課題4

-- 1オーダーの合計金額金額 (order_id 1の場合)
SELECT total_before_discount AS '割引前金額', discount_value AS '割引額', total_before_discount - discount_value AS '支払金額'
FROM `order`
WHERE `order`.id = 1

-- 1オーダーの合計皿枚数 (order_id 1の場合)
SELECT SUM(order_detail.`number`) AS '合計皿枚数'
FROM order_detail
WHERE order_detail.order_id = 1
GROUP BY order_detail.order_id 

-- すべてのオーダーの売上合計金額
SELECT SUM(total_before_discount) AS '合計割引前金額', SUM(discount_value) AS '合計割引額', SUM(total_before_discount) - SUM(discount_value) AS '合計支払金額'
FROM `order`

-- 単品メニュー金額ごとの注文数, 単品メニュー金額ごとの売上
SELECT order_detail.single_menu_id,
        single_menu.name AS '名前',
        single_menu.price AS '1個あたりの料金',
        SUM(order_detail.number) AS '1個あたりの値段',
        single_menu.price * SUM(order_detail.number) AS '売上'
FROM order_detail
LEFT JOIN single_menu ON single_menu.id = order_detail.single_menu_id
WHERE order_detail.single_menu_id IS NOT NULL
GROUP BY order_detail.single_menu_id

-- サビ抜きの割合
SELECT 
    (SELECT SUM(order_detail.`number`) FROM order_detail) AS '注文数',
    SUM(order_detail.`number`) AS 'わさび抜き注文数'
FROM order_detail
LEFT JOIN order_menu_option ON order_detail.id = order_menu_option.order_detail_id
LEFT JOIN `option` ON  `option`.id = order_menu_option.option_id
WHERE `option`.name = 'わさび抜き'

-- セットメニューとお好みすしそれぞれの売上合計金額
SELECT 
    SUM(order_detail.price) AS '単品合計売上',
    (SELECT SUM(order_detail.price) FROM order_detail) - SUM(order_detail.price) AS 'セット合計売上',
    (SELECT SUM(order_detail.price) FROM order_detail) AS '合計売上'
FROM order_detail
WHERE order_detail.single_menu_id IS NOT NULL
