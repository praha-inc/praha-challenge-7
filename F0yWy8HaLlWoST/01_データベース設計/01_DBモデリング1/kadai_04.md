# 課題4

- ユースケースクエリ

```sql
// お客さんが会計をする際の最終的な支払金額を計算する
// 今回の例では注文IDが'11EDDC0217FBB916A8CF0242AC160002'のものですが、これは私の環境固有のものになるため、
// SELECT * FROM T_ORDERS;を実行して、対象のorder_id（0x以外の部分）をコピペして使用してください。


SELECT
	SUM(IFNULL(M_SUSHI_MENUS.price, 0) * (1 - IFNULL(M_ITEM_COUPONS.discount_rate, 0) / 100) * T_ORDER_DETAILS.count - IFNULL(M_ITEM_COUPONS.discount_amount, 0)) 
		+ SUM(IFNULL(M_SET_MENUS.price, 0) * (1 - IFNULL(M_ITEM_COUPONS.discount_rate, 0) / 100) * T_ORDER_DETAILS.count - IFNULL(M_ITEM_COUPONS.discount_amount, 0))
		as total_amount FROM T_ORDERS 
	JOIN T_ORDER_DETAILS ON T_ORDERS.order_id = T_ORDER_DETAILS.order_id
    JOIN M_ITEMS ON T_ORDER_DETAILS.item_id = M_ITEMS.item_id
    LEFT JOIN M_SUSHI_MENUS ON M_ITEMS.sushi_id = M_SUSHI_MENUS.sushi_id
    LEFT JOIN M_SET_MENUS ON M_ITEMS.set_id = M_SET_MENUS.set_id
    LEFT JOIN M_ITEM_COUPONS on T_ORDER_DETAILS.item_coupon_id = M_ITEM_COUPONS.item_coupon_id
    WHERE T_ORDERS.order_id = UNHEX('11EDE1A071A82FE295020242AC120002');
```
