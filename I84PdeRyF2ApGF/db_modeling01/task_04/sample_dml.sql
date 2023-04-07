-- 月毎の売り上げを集計する
SELECT
	DATE_FORMAT(ordered_at, '%Y-%m') as order_month,
	SUM(subtotal_price) as total
FROM 
	orders
GROUP BY
	DATE_FORMAT(ordered_at, '%Y-%m')
;

-- 顧客・ゲスト別の売り上げを集計する
SELECT
	'顧客' as customer_genre,
	SUM(subtotal_price) as total
FROM
	orders
WHERE
	registered_customer_id IS NOT NULL
UNION 
SELECT
	'ゲスト客' as customer_genre,
	SUM(subtotal_price) as total
FROM
	orders
WHERE
	guest_customer_id is NOT NULL;

-- 4月中に注文された寿司ネタ（セットの寿司も含む）を降順で表示する
SELECT
	wrk.name as sushi_name,
	SUM(wrk.quantity) as total_count
FROM
((SELECT
   op.`product_id` as product_id,
	p.`name` as name,
	op.`quantity`
FROM
	orders o
INNER JOIN
	order_products op
ON o.id = op.order_id
INNER JOIN
	products p
ON op.product_id = p.id
INNER JOIN
	product_categories pc
ON p.id = pc.product_id
AND pc.category_id = 7
WHERE
	MONTH(o.ordered_at) = 4)
UNION ALL
(SELECT
   s_p.`id` as product_id,
	s_p.`name` as name,
	op.`quantity`
FROM
	orders o
INNER JOIN
	order_products op
ON o.id = op.order_id
INNER JOIN
	products p
ON op.product_id = p.id
INNER JOIN
	set_details sd
ON	p.`id` = sd.`set_id`
INNER JOIN
	product_categories pc
ON sd.`sushi_id` = pc.`product_id`
AND pc.`category_id` = 7
INNER JOIN
	products s_p
ON sd.`sushi_id` = s_p.`id`
WHERE
	MONTH(o.ordered_at) = 4)) wrk
GROUP BY name
ORDER BY total_count DESC;

-- すし・セットメニュー・サイドメニューの販売数量
SELECT
	c.name as name,
	SUM(o_p.quantity) as total_sales
FROM
	orders o
LEFT JOIN
	order_products o_p
ON o.id = o_p.order_id
LEFT JOIN
	product_categories p_c
ON o_p.product_id = p_c.product_id
INNER JOIN 
	categories c
ON p_c.category_id = c.id
AND c.name IN ('お好みすし', 'セットメニュー', 'サイドメニュー')
GROUP BY c.name