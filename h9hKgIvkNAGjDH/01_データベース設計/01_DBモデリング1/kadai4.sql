-- 1. 人気の寿司ネタを特定したいので、「はな」「わだつみ」などのセット商品の売り上げとは別に、寿司ネタが毎月何個売れているのかを求めるSQL
-- t_ordersを結合して、注文時間で検索できるようにしました
SELECT m_m.name AS '寿司ネタ', SUM(t_od.order_quantity) AS '皿数'
	FROM t_orders AS t_o
    JOIN t_order_details AS t_od
    	ON t_od.order_id = t_o.id
    JOIN m_menus AS m_m
    	ON m_m.id = t_od.menu_id
    JOIN m_parent_categories AS m_pc
    	ON m_pc.id = m_m.parent_category_id
    WHERE
    	m_pc.name = 'お好みすし' AND
		t_o.order_date >= '2023-03-27 00:00:00' AND
    	t_o.order_date <= '2023-03-28 23:59:59' AND
        t_o.deleted_at IS NULL AND
        t_od.deleted_at IS NULL AND	
        m_m.deleted_at IS NULL AND
        m_pc.deleted_at IS NULL
GROUP BY m_m.name
ORDER BY SUM(t_od.order_quantity) DESC;

-- 2.ネタの在庫管理をしたいので、すべての売り上げた商品から、使ったネタの数（そのネタを何貫握ったか？）を求めるSQL
-- ※ネタの数＝Σ（売り上げた数量）＊（一皿あたりの握りの数）

-- また、GROUP BY で集計してしまうと、一皿も売れていないネタが「0」と取得できてないです。

SELECT m_sm.name AS 'ネタ', SUM(t_od.order_quantity * m_sm.sushi_piece) '貫数'
	FROM t_orders AS t_o
    JOIN t_order_details AS t_od
		ON t_od.order_id = t_o.id
    JOIN m_menus AS m_m
		ON m_m.id = t_od.menu_id
    JOIN m_sushi_materials AS m_sm
    	ON m_sm.menu_id = m_m.id
    WHERE t_o.order_date >= '2023-03-27 00:00:00' AND
    	   t_o.order_date <= '2023-03-28 23:59:59' AND
           t_o.deleted_at IS NULL AND
           t_od.deleted_at IS NULL AND
           m_m.deleted_at IS NULL AND
           m_sm.deleted_at IS NULL
GROUP BY m_sm.name
ORDER BY SUM(t_od.order_quantity * m_sm.sushi_piece) DESC;

-- 3.商品ごとに含まれているアレルゲンの内訳を求めるSQL

SELECT m_m.name AS '商品名', m_a.name AS 'アレルゲン名' 
	FROM m_menus AS m_m
 	JOIN m_allergy_information AS m_ai
 		ON m_ai.menu_id = m_m.id
 	JOIN m_allergens AS m_a
 		ON m_ai.allergen_id = m_a.id
    WHERE m_m.deleted_at IS NULL AND
    	m_ai.deleted_at IS NULL AND 
        m_a.deleted_at IS NULL    