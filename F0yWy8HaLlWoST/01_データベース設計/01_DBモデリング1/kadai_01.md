# 課題１

```mermaid
erDiagram

  "お客さん" {
    int id PK "お客さんID"
    int phone "電話番号"
    string name "名前"
  }

  "商品" {
    int id PK "商品ID"
    int id FK "お好みすしID"
    int id FK "セットメニュID"
  }

  "お好みすし" {
    int id PK "お好みすしID"
    string name "お好みすし名"
    int price "値段"
  }

  "セットメニュ" {
    int id PK "セットメニュID"
    string name "セットメニュ名"
    int price "値段"
  }

  "お好みすし_セットメニュ_中間テーブル" {
    int id PK "お好みすし_セットメニュ_中間テーブルID"
    int id FK "お好みすしID"
    int id FK "セットメニュID"
  }

  "注文" {
    int id PK "注文ID"
    int id FK "お客さんID"
    int price "合計金額"
    int count "合計皿数"
    int isPaid "支払い済みか"
  }

  "注文詳細" {
    int id PK "注文詳細ID"
    int id FK "注文ID"
    int id FK "商品ID"
    int count "個数"
    int isWithoutWasabi "さびぬきか"
  }

  "お客さん" ||--|{ "注文": "1人のお客さんは1つ以上の注文をもつ"
  "注文" ||--|{ "注文詳細": "1つの注文は1つ以上の注文詳細をもつ"
  "注文詳細" ||--|| "商品": "1つの注文詳細は1つの商品をもつ"
  "商品" ||--|| "お好みすし": "1つの商品は1つのお好みすしをもつ"
  "商品" ||--|| "セットメニュ": "1つの商品は1つのセットメニュをもつ"
  "お好みすし" ||--o{ "お好みすし_セットメニュ_中間テーブル": ""
  "セットメニュ" ||--o{ "お好みすし_セットメニュ_中間テーブル": ""
```

## 疑問点メモ

- 「商品」エンティティは必要なのか
- 主キーは複数のキーを選択できるのか。複数キーにするのと新たにIDを設けるのとどちらがいいのか。
- 「お客さん.電話番号」みたいな指定ができるのか。IDはIDじゃだめなのか。"商品"IDとかつけないといけないのか


# 任意課題

ER図には概念、論理、物理モデルがある。基本的には概念→論理→物理の順に詳細化していく類のもの。ただサイトによって定義が違うよう…[DMBOKというのが元ネタ](http://jp.drinet.co.jp/blog/datamanagement/data_modeling_3minutes)？PMBOKのDB版？

## 概念モデル

「基本的&重要なエンティティのみを対象にしたデータモデルです。これらのデータをどのように実装するかは考慮せずに、企業の現実をそのまま写し取るようにモデル化します(実装独立)。」（[出典](http://jp.drinet.co.jp/blog/datamanagement/data_modeling_3minutes)）とのこと。現実の写像モデル。

![概念モデル](https://rainbow-engine.com/wp-content/uploads/2021/09/RP-IT0455_UI_LogicalDataDesign/RP-IT0455_131_ImageOfGainenER.jpg)

## 論理モデル

「概念データモデルよりもデータの要件が詳細に書かれたデータモデルです。概念データモデルに属性を追加し、正規化という作業を行って作られます。概念データモデルと同じく、実装手段は考慮しません。」（[出典](http://jp.drinet.co.jp/blog/datamanagement/data_modeling_3minutes)）「論理モデルはER図上だけの情報であり、実際のDBとは異なる情報（実体がないエンティティなど）もある」（[出典](https://products.sint.co.jp/ober/blog/logic-physics)）とのこと。おそらく概念と物理の橋渡しであり、現実の写像である概念モデルをテーブル化したものだが、DBの制約は意識していないという理解。
具体的な物理モデルとの違いとしては、下記あたり？（定義にもよりそうだが…）

* カラム名を日本語で表記（テーブルで実際に使う値ではなく、人間がわかりやすい表記）
* 物理テーブル、物理リレーションシップを隠す（多対多リレーションシップをそのまま多対多と表現する。中間テーブルは書かない）

![論理モデル](https://rainbow-engine.com/wp-content/uploads/2021/09/RP-IT0455_UI_LogicalDataDesign/RP-IT0455_111_ImageOfLogicalER.jpg)

## 物理モデル

そのままDBが作れるレベルのものという理解。

* テーブル名/カラム名はDBで使用するものと一致させる
* 型まで書く

![物理モデル](https://rainbow-engine.com/wp-content/uploads/2021/09/RP-IT0455_UI_LogicalDataDesign/RP-IT0455_121_ImageOfPhysicalER.jpg)
