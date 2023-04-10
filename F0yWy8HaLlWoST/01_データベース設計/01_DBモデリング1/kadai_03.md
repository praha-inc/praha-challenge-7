# 課題3

追加仕様

* 自分
  * 全体価格が10/20/30％オフになるクーポンが発行される
  * 特定商品が安くなるキャンペーンが開催される
* tanakas-2021
  * メニューが廃止された場合→商品.is_deletedで対応
* digarashi91
  * ランチ実施
    * 平日11:00-14:00はランチ実施（注文した時間）
    * 「にぎり」「丼」のメニューが税別の価格から10%オフ→クーポンで対応
    * 今後セット区分としての「ランチ」とその中の商品が追加される可能性がある→セットタイプで対応
  * 電話注文だけでなく、アプリからの注文も対応→注文.payment_methodで対応
    * 可能なのは注文のみで、配達などはなし、取りに来てもらう想定
    * アプリ利用の場合、支払いは注文時に必ず済ませるものとする（支払いは外部サービスを使う1択として支払い手段は考慮しない）

```mermaid
erDiagram

  "お客さん" {
    uuid customer_id PK "お客さんID"
    int phone "電話番号"
    string name "名前"
    date created_at "作成日"
    date updated_at "更新日"
  }

  "商品" {
    uuid item_id PK "商品ID"
    uuid sushi_id FK "お好みすしID"
    uuid set_id FK "セットメニュID"
    boolean is_deleted "削除されたか"
    date created_at "作成日"
    date updated_at "更新日"
  }

  "お好みすし" {
    uuid sushi_id PK "お好みすしID"
    string name "お好みすし名"
    int price "値段"
    date created_at "作成日"
    date updated_at "更新日"
  }

  "セットメニュ" {
    uuid set_id PK "セットメニュID"
    uuid set_type_id FK "セットメニュ区分ID"
    string name "セットメニュ名"
    int price "値段"
    date created_at "作成日"
    date updated_at "更新日"
  }

  "お好みすし_セットメニュ_中間テーブル" {
    uuid sushi_set_id PK "お好みすし_セットメニュ_中間テーブルID"
    uuid sushi_id FK "お好みすしID"
    uuid set_id FK "セットメニュID"
    int sushi_count "お好みすしが1セットに何個入っているか" 
    date created_at "作成日"
    date updated_at "更新日"
  }

  "注文" {
    uuid order_id PK "注文ID"
    uuid customer_id FK "お客さんID"
    uuid total_coupon_id FK "全体割引クーポンID"
    int payment_method "注文方法（0:電話、1:アプリ）"
    boolean is_paid "支払い済みか"
    date created_at "作成日"
    date updated_at "更新日"
  }

  "注文詳細" {
    uuid order_detail_id PK "注文詳細ID"
    uuid order_id FK "注文ID"
    uuid item_id FK "商品ID"
    uuid shari_size_id FK "シャリサイズID"
    uuid item_coupon_id FK "商品割引クーポンID"
    int count "個数"
    boolean is_without_wasabi "さびぬきか"
    date created_at "作成日"
    date updated_at "更新日"
  }

  "シャリサイズ区分" {
    uuid shari_size_id PK "シャリサイズID"
    string name "シャリサイズ名"
    date created_at "作成日"
    date updated_at "更新日"
  }

  "セットタイプ" {
    uuid set_type_id PK "セットメニュ区分ID"
    string name "セットタイプ名"
    date created_at "作成日"
    date updated_at "更新日"
  }

  "全体割引クーポン" {
    uuid total_coupon_id PK "全体割引クーポンID"
    string name "クーポン名"
    int discount_rate "割引率"
    date available_from "有効期限開始日"
    date expired_at "有効期限終了日"
    date created_at "作成日"
    date updated_at "更新日"
  }

  "商品割引クーポン" {
    uuid item_coupon_id PK "商品割引クーポンID"
    string name "クーポン名"
    int discount_rate "割引率"
    date available_from "有効期限開始日"
    date expired_at "有効期限終了日"
    date created_at "作成日"
    date updated_at "更新日"
  }

  "お客さん" ||--|{ "注文": "1人のお客さんは1つ以上の注文をもつ"
  "注文" ||--|{ "注文詳細": "1つの注文は1つ以上の注文詳細をもつ"
  "注文詳細" ||--|| "商品": "1つの注文詳細は1つの商品をもつ"
  "商品" ||--o| "お好みすし": "1つの商品は0または1つのお好みすしをもつ"
  "商品" ||--o| "セットメニュ": "1つの商品は0または1つのセットメニュをもつ"
  "お好みすし" ||--o{ "お好みすし_セットメニュ_中間テーブル": ""
  "セットメニュ" ||--o{ "お好みすし_セットメニュ_中間テーブル": ""
  "注文詳細" ||--|| "シャリサイズ区分": "1つの注文詳細は1つのシャリサイズをもつ"
  "セットメニュ" ||--|| "セットタイプ": "1つのセットメニュは1つのセットメニュタイプをもつ"
  "注文" ||--o{ "全体割引クーポン": "1つの注文は0以上の全体割引クーポンをもつ"
  "注文詳細" ||--o{ "商品割引クーポン": "1つの注文詳細は0以上の商品割引クーポンをもつ"
```

## 疑問点メモ

- クーポンの金額への反映はどうする？