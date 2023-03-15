# 課題2

```mermaid
erDiagram

  "お客さん" {
    int customer_id PK "お客さんID"
    int phone "電話番号"
    string name "名前"
    date created_at "作成日"
    date updated_at "更新日"
  }

  "商品" {
    int item_id PK "商品ID"
    int sushi_id FK "お好みすしID"
    int set_id FK "セットメニュID"
    int is_deleted "削除されたか"
    date created_at "作成日"
    date updated_at "更新日"
  }

  "お好みすし" {
    int sushi_id PK "お好みすしID"
    string name "お好みすし名"
    int price "値段"
    date created_at "作成日"
    date updated_at "更新日"
  }

  "セットメニュ" {
    int set_id PK "セットメニュID"
    int set_type_id FK "セットメニュ区分（0:盛り込み…）"
    string name "セットメニュ名"
    int price "値段"
    date created_at "作成日"
    date updated_at "更新日"
  }

  "お好みすし_セットメニュ_中間テーブル" {
    int sushi_set_id PK "お好みすし_セットメニュ_中間テーブルID"
    int sushi_id FK "お好みすしID"
    int set_id FK "セットメニュID"
    date created_at "作成日"
    date updated_at "更新日"
  }

  "注文" {
    int order_id PK "注文ID"
    int customer_id FK "お客さんID"
    int isPaid "支払い済みか"
    date created_at "作成日"
    date updated_at "更新日"
  }

  "注文詳細" {
    int order_detail_id PK "注文詳細ID"
    int order_id FK "注文ID"
    int item_id FK "商品ID"
    int shari_size_id FK "シャリサイズID"
    int count "個数"
    int isWithoutWasabi "さびぬきか"
    date created_at "作成日"
    date updated_at "更新日"
  }

  "シャリサイズ" {
    int shari_size_id PK "シャリサイズID"
    string name "シャリサイズ名"
    date created_at "作成日"
    date updated_at "更新日"
  }

  "セットタイプ" {
    int set_type_id PK "セットメニュ区分（0:盛り込み…）"
    string name "セットタイプ名"
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
  "注文詳細" ||--|| "シャリサイズ": "1つの注文詳細は1つのシャリサイズをもつ"
  "セットメニュ" ||--|| "セットタイプ": "1つのセットメニュは1つのセットメニュタイプをもつ"
```

## 疑問点メモ

- 