-- 月毎の売り上げを集計するクエリ
SELECT DATE_FORMAT(ordered_at, "%Y-%m") AS month, SUM(total_price) AS monthly_total_price
FROM orders
GROUP BY DATE_FORMAT(ordered_at, "%Y-%m");

-- 今月の顧客・ゲスト別の売り上げを集計するクエリ
SELECT
  DATE_FORMAT(ordered_at, "%Y-%m") AS this_month,
  SUM(CASE WHEN user_id IS NOT NULL THEN total_price ELSE 0 END) AS monthly_user_total_price,
  SUM(CASE WHEN guest_user_id IS NOT NULL THEN total_price ELSE 0 END) AS monthly_guest_user_total_price
FROM orders
WHERE DATE_FORMAT(ordered_at, "%Y-%m") = DATE_FORMAT(NOW(), "%Y-%m")
GROUP BY DATE_FORMAT(ordered_at, "%Y-%m");

-- 全ての注文と紐づく商品ログ(セットと寿司)を取得するビュー
-- where文は商品ログテーブルにある更新データを参照しないようにするために必要
CREATE VIEW ordered_product_logs_view (
 id, name, price, tax_rate_id, product_id, created_at, ordered_at
) AS
SELECT pl.id, pl.name, pl.price, pl.tax_rate_id, pl.product_id, pl.created_at, orders.ordered_at
FROM orders
INNER JOIN order_items
ON orders.id = order_items.order_id
INNER JOIN products
ON order_items.product_id = products.id
INNER JOIN product_logs AS pl
ON products.id = pl.product_id
WHERE orders.ordered_at >= pl.created_at;

-- 全ての注文に紐づく寿司(セットの寿司も含む)の名前、税抜き価格、税率、注文日を取得するビュー
-- 注文日が違うので、同じnameの商品をGROUP BYであえてまとめないようにしている。
CREATE VIEW ordered_sushi_product_logs_view (
 name, tax_excluded_price, tax_percentage, ordered_at
) AS
SELECT
  CASE WHEN parent_id IS NOT NULL THEN pl.name ELSE ordered_product_logs_view.name END AS name,
  CASE WHEN parent_id IS NOT NULL THEN pl.price ELSE ordered_product_logs_view.price END AS tax_excluded_price,
  tax_rates.tax_percentage AS tax_percentage,
  ordered_product_logs_view.ordered_at
FROM ordered_product_logs_view
INNER JOIN tax_rates
ON ordered_product_logs_view.tax_rate_id = tax_rates.id
LEFT JOIN product_log_families
ON ordered_product_logs_view.id = product_log_families.parent_id
LEFT JOIN products
ON product_log_families.child_id = products.id
LEFT JOIN product_logs AS pl
ON products.id = pl.product_id

-- 4月に注文された寿司ネタ(セットの寿司も含む)の名前、販売数、寿司ごとの総売り上げを総売り上げの降順で取得するクエリ
SELECT
  name,
  COUNT(name) AS sales_count,
  FLOOR((SUM(tax_excluded_price * (1 + (tax_percentage * 0.01))))) AS total_tax_included_price
FROM (
  SELECT *
  FROM ordered_sushi_product_logs_view
  WHERE DATE_FORMAT(ordered_at, "%Y-%m") = "2023-04"
) AS april_ordered_sushi_product_logs
GROUP BY name
ORDER BY total_tax_included_price DESC;

-- 4月のカテゴリ(すし・セットメニュー・サイドメニュー)ごとの販売数量と総売り上げを集計するクエリ
SELECT
  menu_categories.name,
  COUNT(*) AS total_sales_count,
  FLOOR((SUM(price * (1 + (tax_rates.tax_percentage * 0.01))))) AS total_tax_included_price
FROM (
  SELECT *
  FROM ordered_product_logs_view
  WHERE DATE_FORMAT(ordered_at, "%Y-%m") = "2023-04"
) AS april_ordered_product_logs
INNER JOIN product_log_categories
ON april_ordered_product_logs.id = product_log_categories.product_log_id
INNER JOIN (
  SELECT *
  FROM categories
  WHERE categories.name IN ("お好みすし", "セットメニュー", "サイドメニュー")
) AS menu_categories
ON product_log_categories.category_id = menu_categories.id
INNER JOIN tax_rates
ON april_ordered_product_logs.tax_rate_id = tax_rates.id
group by menu_categories.name;