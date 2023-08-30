# 回答

MySQL利用想定です！

## 課題1

### スケッチ
[ER図（svg）](01_01_01_er_diagram.svg)<br>
[ER図（puml）](01_01_01_er_diagram.puml)

### DB構造
[DB構造（md）](01_01_01_db_structure.md)
  
### 利用想定

#### あらかじめデータを登録しておくテーブル（マスター系）
登録しておくデータの例は [DB構造（md）](01_01_01_db_structure.md) の備考欄に記載しています。
- channels
- order_statuses
- products
- menu_categories
- prices
- product_foods
- foods
#### 使用に伴いデータを登録していくテーブル（トランザクション系）
- orders
- customers
- order_details

#### 処理流れ
1. アプリケーション側であらかじめ以下のテーブルからからレコードをSELECTしておく
   - channels
   - order_statuses
   - products
1. 注文が入ったら、ordersテーブルにレコードを作成
    1. ordersテーブルに紐づく形で、customersテーブルにレコードを作成
    1. ordersテーブルに紐づく形で、商品数の数だけorder_detailsテーブルにレコードを作成
          1. 盛り込みの「はな」、にぎりの「みさき」、お好みの「玉子」、お好みの「まぐろ赤身」の4商品が注文された場合
                1. order_detailsテーブルに「はな」のレコードを追加（product_idはあらかじめSELECTしたものを使用）
                1. order_detailsテーブルに「みさき」のレコードを追加（product_idはあらかじめSELECTしたものを使用）
                1. order_detailsテーブルに「玉子」のレコードを追加（product_idはあらかじめSELECTしたものを使用）
                1. order_detailsテーブルに「まぐろ赤身」のレコードを追加（product_idはあらかじめSELECTしたものを使用）


### 任意課題：物理モデルと論理モデルの違い

#### 論理モデル
- 基本設計工程で作成
- 特定のデータベースに依存しないレベルで具体化した状態
- 必要カラムを書き出したり、カラムに以下の項目を指定したりする
    - 属性
    - 主キー
    - 外部キー
    - リレーション
    
#### 物理モデル
- 詳細設計工程で作成
- 特定のデータベース向けに論理モデルの変換を行う
    - 特定のデータベース : Oracle Database, PostgreSQL, MySQL, など

### 疑問点
- product_foodsテーブルは中間テーブル？products_foodsテーブルに命名変更すべき？
  - ある商品が使用している食材を格納している
  - 商品と食材の関係しか格納していない
  - 商品テーブルと食材テーブルを直接リレーションさせるとしたら、1対1以上になる（多対多ではない）　→　中間テーブルではない？
- DB構造、どこにどうやって書く？（書類管理の問題）
  - スプレッドシートなど、外部の表ソフトを使った方が絶対にわかりやすい
  - 外部のソフトを使うと、書類が色々なところに散らばり、管理が大変
  - mdだと書きづらい
  - ER図に書き込むと、情報が多すぎてわかりにくい
  - ER図に書き込まないと、カラム名や項目名など、2回書かなければいけない
- DBに入れる値の長さ、どう決める？
  - 最長の人の氏名をググったら1000文字以上だったが、極端に長い場合は通称を使うだろうと255文字にした
  - 入りそうな値を考えておいて、あとは大体の感覚値？
- インデックスどういう場合にどういう風に貼る？（あとで調べる）


<hr>

## 課題2

### スケッチ
[ER図（svg）](01_01_02_er_diagram.svg)<br>
[ER図（puml）](01_01_02_er_diagram.puml)

### DB構造
[DB構造（md）](01_01_02_db_structure.md)

#### 処理流れ
1. シャリ小の場合、 order_details.is_less_rice に1を格納する

#### 人気の寿司ネタの特定
- 設計は現状でOK
- order_detailsテーブルのレコード数が商品の販売数と等しいため、order_detailsテーブルから条件を指定したりGROUP BYしたりしてSELECTする
    - SELECTする際に、 order_details.product_id からproductsテーブルのレコードを同時に取得する
        - SELECTする際に、 products.food_id からfoodsテーブルのレコードを同時に取得する
    - 取得したレコードから、 foods.id でGROUP BYしてCOUNT()する

<hr>

## 課題3

### スケッチ
[ER図（svg）](01_01_03_er_diagram.svg)<br>
[ER図（puml）](01_01_03_er_diagram.puml)

### DB構造
[DB構造（md）](01_01_03_db_structure.md)

### 今後発生しそうな追加仕様

#### tanakaさん案
1. メニューが廃止された場合
    - products.is_available カラムを0にUPDATEする

#### okazakiさん案
1. 全体価格が10/20/30％オフになるクーポンが発行される
    - あらかじめアプリケーション側で discounts テーブルをSELECTしておく
      - discounts.begin_at と discounts.end_at が指定期間内のレコードを取得
        - レコードがあれば、 order_details.discount_id に該当のidを入れる
1. 特定商品が安くなるキャンペーンが開催される
    - 特定商品が安くなるキャンペーンの場合、 discounts テーブルに discount_reason = "キャンペーン"、 products_discounts テーブルに discounts.id と 該当商品の products.id を入れておく
    - あらかじめアプリケーション側で products テーブルと products_discounts テーブルと discounts テーブルをSELECTしておく
        - products_discounts テーブルにレコードがある場合、 products_discounts.discount_id から discounts テーブルの該当レコードを取得
        - products_discounts テーブルにレコードがない場合、 他の割引が適用されていないか探索（ランチ、ほか割引など（有効期限をみる））
    - 特定商品が安くなるキャンペーンが終了する場合、 discounts.end_at に日時を格納、 products_discounts.is_deleted に1を格納

#### igarashi案
1. ランチ実施
    1. 平日11:00-14:00はランチ実施（注文した時間）
        - あらかじめアプリケーション側で menu_categories テーブル、 discounts テーブルをSELECTしておく
            - ランチ時間帯の注文は、 menu_categories.is_lunch_discounted = 1 の場合、order_details.discount_id に discounts.discount_reason = "ランチ" のidを入れる
    1. 「にぎり」「丼」のメニューが税別の価格から10%オフ
        - menu_categories.is_lunch_discounted = 1 のレコードを取得
        - 対象のカテゴリーの場合、order_details.discount_id に discounts.discount_reason = "ランチ" のidを入れる
    1. 今後セット区分としての「ランチ」とその中の商品が追加される可能性がある
        - menu_categories テーブルに menu_category_name = "ランチ"、 is_lunch_discounted = 1　のレコードを追加
1. 電話注文だけでなく、アプリからの注文も対応
    1. 可能なのは注文のみで、配達などはなし、取りに来てもらう想定
    1. アプリ利用の場合、支払いは注文時に必ず済ませるものとする（支払いは外部サービスを使う1択として支払い手段は考慮しない）
        - アプリ利用者の場合は、customers.app_user_id に uuid を、 orders.channel_id に channels.channel_name = "アプリ" のidを入れる
