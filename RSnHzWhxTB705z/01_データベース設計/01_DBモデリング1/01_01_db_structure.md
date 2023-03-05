# テーブル構造

## orders : 注文テーブル

| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | UNSIGNED INT | ※ | AUTO INCREMENT | NOT NULL | 自動付与 | ※ |  |  |  |
| customer_id | 注文経路id | UNSIGNED INT |  | FOREIGN KEY | NOT NULL |  |  |  |  |  |
| order_status_id | 注文状態id | UNSIGNED INT |  | FOREIGN KEY | NOT NULL |  |  |  |  |  |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |

## customers : 顧客テーブル

| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | UNSIGNED INT | ※ | AUTO INCREMENT | NOT NULL | 自動付与 | ※ |  |  |  |
| family_name | 氏 | VARCHAR(255) |  |  | NOT NULL |  |  |  |  |  |
| first_name | 名 | VARCHAR(255) |  |  | NOT NULL |  |  |  |  |  |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |

## channels : 注文経路テーブル

| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | UNSIGNED INT | ※ | AUTO INCREMENT | NOT NULL | 自動付与 | ※ |  |  |  |
| channel_name | 注文経路名 | VARCHAR(100) |  |  | NOT NULL |  |  |  |  | 「来店」「電話」 |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |

## order_statuses : 注文状態テーブル

| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | UNSIGNED INT | ※ | AUTO INCREMENT | NOT NULL | 自動付与 | ※ |  |  |  |
| status | 注文状態 | VARCHAR(100) |  |  | NOT NULL |  |  |  |  | 「注文受付」「支払い済み」「受け渡し済み」 |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |

## order_details : 注文詳細テーブル

| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | UNSIGNED INT | ※ | AUTO INCREMENT | NOT NULL | 自動付与 | ※ |  |  |  |
| order_id | 注文id | UNSIGNED INT |  | FOREIGN KEY | NOT NULL |  |  |  |  |  |
| product_id | 商品id | UNSIGNED INT |  | FOREIGN KEY | NOT NULL |  |  |  |  |  |
| is_without_wasabi | さび抜きかどうか | TINYINT(1) |  |  | NOT NULL | 0 |  |  |  |  |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |

## products : 商品テーブル

| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | UNSIGNED INT | ※ | AUTO INCREMENT | NOT NULL | 自動付与 | ※ |  |  |  |
| product_name | 商品名 | VARCHAR(255) |  |  | NOT NULL |  |  |  |  | 「はな」「みさき」「海鮮ちらし」「鮨八宝巻」「玉子」「まぐろ赤身」など |
| product_description | 商品説明 | VARCHAR(1000) |  |  | NULL |  |  |  |  |  |
| menu_category_id | メニューカテゴリーid | UNSIGNED INT |  | FOREIGN KEY | NOT NULL |  |  |  |  |  |
| price_id | 価格id | UNSIGNED INT |  | FOREIGN KEY | NOT NULL |  |  |  |  |  |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |

## menu_categories : メニューカテゴリーテーブル

| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | UNSIGNED INT | ※ | AUTO INCREMENT | NOT NULL | 自動付与 | ※ |  |  |  |
| menu_category_name | メニューカテゴリー名 | VARCHAR(100) |  |  | NOT NULL |  |  |  |  | 「盛り込み」「にぎり」「丼」「お好み」など |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |

## prices : 価格テーブル

| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | UNSIGNED INT | ※ | AUTO INCREMENT | NOT NULL | 自動付与 | ※ |  |  |  |
| price | 税抜価格 | INT |  |  | NOT NULL |  |  |  |  | 「8650」「1940」「100」「150」など<br> 「○円引きクーポン」みたいな場合に使うかも...？ |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |

## product_foods : 商品食材テーブル（商品につかう食材を格納するテーブル）

| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | UNSIGNED INT | ※ | AUTO INCREMENT | NOT NULL | 自動付与 | ※ |  |  |  |
| product_id | 商品id | UNSIGNED INT |  | FOREIGN KEY | NOT NULL |  |  |  |  | 商品が「はな」の場合「はな」のproduct_id <br> 商品が「まぐろ赤身」の場合「まぐろ赤身」の商品id|
| food_id | 食材id | UNSIGNED INT |  | FOREIGN KEY | NOT NULL |  |  |  |  | 商品が「はな」の場合「はな」に含まれる食材の食材id（10貫セットなら10レコード） <br> 商品が「まぐろ赤身」の場合「まぐろ赤身」の食材id |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |

## foods : 食材テーブル（食材を格納するテーブル（原材料ではなく、玉子すし1貫、まぐろ赤身すし1貫など、提供する上での最小単位））

| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | UNSIGNED INT | ※ | AUTO INCREMENT | NOT NULL | 自動付与 | ※ |  |  |  |
| food_name | 食材名 | VARCHAR(255) |  |  | NOT NULL |  |  |  |  | 「玉子」「まぐろ赤身」「いくら」など |
| stock | 在庫数 | INT|  |  | NOT NULL |  |  |  |  |  |
| expiration_date | 消費期限 | DATETIME|  |  | NOT NULL |  |  |  |  |  |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
