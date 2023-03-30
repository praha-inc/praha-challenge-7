# テーブル構造

## customers : 顧客テーブル

| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | UNSIGNED INT | ※ | AUTO INCREMENT | NOT NULL | 自動付与 | ※ |  |  |  |
| family_name | 氏 | VARCHAR(255) |  |  | NOT NULL |  |  |  |  |  |
| first_name | 名 | VARCHAR(255) |  |  | NOT NULL |  |  |  |  |  |
| tel | 電話番号 | VARCHAR(20) |  |  | NOT NULL |  | ※ |  |  |  |
| app_user_id | アプリのユーザーid | CHAR(36) |  |  | NULL |  | ※ |  |  |  |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |

## channels : 注文経路テーブル

| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | UNSIGNED INT | ※ | AUTO INCREMENT | NOT NULL | 自動付与 | ※ |  |  |  |
| channel_name | 注文経路名 | VARCHAR(100) |  |  | NOT NULL |  |  |  |  | 「来店」「電話」「アプリ」 |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |

## order_statuses : 注文状態テーブル

| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | UNSIGNED INT | ※ | AUTO INCREMENT | NOT NULL | 自動付与 | ※ |  |  |  |
| status | 注文状態 | VARCHAR(100) |  |  | NOT NULL |  |  |  |  | 「注文受付」「支払い済み」「受け渡し済み」 |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |

## orders : 注文テーブル

| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | UNSIGNED INT | ※ | AUTO INCREMENT | NOT NULL | 自動付与 | ※ |  |  |  |
| customer_id | 注文経路id | UNSIGNED INT |  | FOREIGN KEY | NOT NULL |  |  |  |  |  |
| channel_id | 注文経路id | UNSIGNED INT |  | FOREIGN KEY | NOT NULL |  |  |  |  |  |
| order_status_id | 注文状態id | UNSIGNED INT |  | FOREIGN KEY | NOT NULL |  |  |  |  |  |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |

## menu_groups : メニューグループテーブル

| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | UNSIGNED INT | ※ | AUTO INCREMENT | NOT NULL | 自動付与 | ※ |  |  |  |
| menu_group_name | メニューグループ名 | VARCHAR(100) |  |  | NOT NULL |  |  |  |  | 「セットメニュー」「お好みすし」など |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |

## menu_categories : メニューカテゴリーテーブル

| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | UNSIGNED INT | ※ | AUTO INCREMENT | NOT NULL | 自動付与 | ※ |  |  |  |
| menu_category_name | メニューカテゴリー名 | VARCHAR(100) |  |  | NOT NULL |  |  |  |  | 「盛り込み」「にぎり」「丼」「お好み」「ランチ」など |
| is_lunch_discounted | ランチタイムの割引対象かどうか | TINYINT(1) |  |  | NOT NULL | 0 |  |  |  |  |
| menu_group_id | メニューグループid | UNSIGNED INT |  | FOREIGN KEY | NOT NULL |  |  |  |  |  |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |

## prices : 価格テーブル

| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | UNSIGNED INT | ※ | AUTO INCREMENT | NOT NULL | 自動付与 | ※ |  |  |  |
| price | 税抜価格 | INT |  |  | NOT NULL |  |  |  |  | 「8650」「1940」「100」「150」など<br> 「○円引きクーポン」みたいな場合に使うかも...？ |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |

## boxes : 化粧箱テーブル

| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | UNSIGNED INT | ※ | AUTO INCREMENT | NOT NULL | 自動付与 | ※ |  |  |  |
| price_id | 価格id | UNSIGNED INT |  | FOREIGN KEY | NOT NULL |  |  |  |  |  |
| box_name | 箱の名前 | VARCHAR(100) |  |  | NOT NULL |  |  |  |  |  |
| box_description | 箱の説明 | VARCHAR(255) |  |  | NULL |  |  |  |  |  |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |

## products : 商品テーブル

| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | UNSIGNED INT | ※ | AUTO INCREMENT | NOT NULL | 自動付与 | ※ |  |  |  |
| menu_category_id | メニューカテゴリーid | UNSIGNED INT |  | FOREIGN KEY | NOT NULL |  |  |  |  |  |
| price_id | 価格id | UNSIGNED INT |  | FOREIGN KEY | NOT NULL |  |  |  |  |  |
| box_id | 化粧箱id | UNSIGNED INT |  | FOREIGN KEY | NULL |  |  |  |  |  |
| discount_id | 割引id | UNSIGNED INT |  | FOREIGN KEY | NULL |  |  |  |  |  |
| product_name | 商品名 | VARCHAR(255) |  |  | NOT NULL |  |  |  |  | 「はな」「みさき」「海鮮ちらし」「鮨八宝巻」「玉子」「まぐろ赤身」「ランチセットA」など |
| product_description | 商品説明 | VARCHAR(1000) |  |  | NULL |  |  |  |  |  |
| is_available | 商品を提供中かどうか | TINYINT(1) |  |  | NOT NULL | 1 |  |  |  |  |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |

## discounts : 割引テーブル

| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | UNSIGNED INT | ※ | AUTO INCREMENT | NOT NULL | 自動付与 | ※ |  |  |  |
| discount_value | 割引価格 | UNSIGNED INT |  |  | NULL | NULL |  |  | discount_value もしくは discount_rate　のどちらかに値が入っていないといけない　| 「50」「100」など |
| discount_rate | 割引割合 | UNSIGNED FLOAT(6, 3) |  |  | NULL | NULL |  |  | discount_value もしくは discount_rate　のどちらかに値が入っていないといけない | 「5.0」「10.0」など |
| discount_reason | 割引理由 | VARCHAR(255) |  |  | NOT NULL |  |  |  |  | 「ランチ」「10%オフクーポン」「すしの日セール」「〇〇キャンペーン」など |
| begin_at | 開始日時 | DATETIME |  |  | NOT NULL |  |  |  |  | 開始時期を入れる（定期的に実施する割引も含め） |
| end_at | 終了日時 | DATETIME |  |  | NULL | NULL |  |  |  | 定期的に実施しない割引の場合、終了時期を入れる <br> 定期的に実施する割引の場合、もう使用しなくなったときにここの値を入れる |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |

## products_discounts : 商品割引中間テーブル（特定の商品の割引の際に、このテーブルを使用する）

| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | UNSIGNED INT | ※ | AUTO INCREMENT | NOT NULL | 自動付与 | ※ |  |  |  |
| product_id | 商品id | UNSIGNED INT |  |  | NULL | NULL |  |  |  | 特定の商品の割引の際、該当する商品のidを入れる |
| discount_id | 割引id | UNSIGNED INT |  |  | NULL | NULL |  |  |  | 特定の商品の割引の際、該当する割引のidを入れる |
| is_deleted | 論理削除フラグ | TINYINT(1) |  |  | NOT NULL | 0 |  |  |  | 特定の商品の割引が終了した際、1を入れる |
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

## product_foods : 商品食材テーブル（商品につかう食材を格納するテーブル）

| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | UNSIGNED INT | ※ | AUTO INCREMENT | NOT NULL | 自動付与 | ※ |  |  |  |
| product_id | 商品id | UNSIGNED INT |  | FOREIGN KEY | NOT NULL |  |  |  |  | 商品が「はな」の場合「はな」のproduct_id <br> 商品が「まぐろ赤身」の場合「まぐろ赤身」の商品id|
| food_id | 食材id | UNSIGNED INT |  | FOREIGN KEY | NOT NULL |  |  |  |  | 商品が「はな」の場合「はな」に含まれる食材の食材id（10貫セットなら10レコード） <br> 商品が「まぐろ赤身」の場合「まぐろ赤身」の食材id |
| food_quantity | 食材量 | INT |  |  | NOT NULL | 1 |  |  |  | 商品に含まれる食材の量 |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |

## order_details : 注文詳細テーブル

| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | UNSIGNED INT | ※ | AUTO INCREMENT | NOT NULL | 自動付与 | ※ |  |  |  |
| order_id | 注文id | UNSIGNED INT |  | FOREIGN KEY | NOT NULL |  |  |  |  |  |
| product_id | 商品id | UNSIGNED INT |  | FOREIGN KEY | NOT NULL |  |  |  |  |  |
| discount_id | 割引id | UNSIGNED INT |  | FOREIGN KEY | NULL | NULL |  |  |  | 割引がなにもない場合はNULLを入れ、割引がある場合に割引idを入れる |
| is_without_wasabi | さび抜きかどうか | TINYINT(1) |  |  | NOT NULL | 0 |  |  |  |  |
| is_less_rice | シャリ小かどうか | TINYINT(1) |  |  | NOT NULL | 0 |  |  |  |  |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
