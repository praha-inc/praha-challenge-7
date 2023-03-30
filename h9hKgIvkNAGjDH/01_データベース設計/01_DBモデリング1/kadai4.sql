1. 人気の寿司ネタを特定したいので、「はな」「わだつみ」などのセット商品の売り上げとは別に、寿司ネタが毎月何個売れているのかを求めるSQL
SELECT c.name,SUM(b.order_quantity) FROM m_menus AS a
	JOIN t_order_details AS b
    	ON b.order_id = a.id
    JOIN m_menus AS c
    	ON c.id = b.menu_id
    JOIN m_parent_categories AS d
    	ON d.id = c.parent_category_id
WHERE d.name = 'お好みすし'
GROUP BY c.name
ORDER BY SUM(b.order_quantity) DESC;

2.ネタの在庫管理をしたいので、すべての売り上げた商品から、使ったネタの数（そのネタを何貫握ったか？）を求めるSQL
※ネタの数＝Σ（売り上げた数量）＊（一皿あたりの握りの数）

また、GROUP BY で集計してしまうと、一皿も売れていないネタが「0」と取得できてないです。

SELECT d.name,SUM(b.order_quantity * d.sushi_piece) FROM m_menus AS a
	JOIN t_order_details AS b
    	ON b.order_id = a.id
    LEFT JOIN m_menus AS c
    	ON c.id = b.menu_id
    LEFT JOIN m_sushi_materials AS d
    	ON d.menu_id = c.id
    LEFT JOIN m_parent_categories AS e
    	ON e.id = c.parent_category_id
GROUP BY d.name
ORDER BY SUM(b.order_quantity * d.sushi_piece) DESC;


3.商品ごとに含まれているアレルゲンの内訳を求めるSQL
SELECT a.name AS '商品名', c.name AS 'アレルゲン名' FROM m_menus AS a
 JOIN m_allergy_information AS b
 ON b.menu_id = a.id
 JOIN m_allergens AS c
 ON b.allergen_id = c.id


