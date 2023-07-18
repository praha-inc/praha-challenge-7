# データベース設計のアンチパターンを学ぶ3

## 課題1

- belongs_to_id カラム、 type カラムに外部キー制約をつけられない
- type カラムに入る値にアプリ側で制約を付けているとして、扱うジャンルが増えた場合に制約にも修正を加えなければいけない（'manga', 'novel' で制約を付けていて雑誌（'magazine'）を増やしたときにアプリで修正をするなど）

## 課題2

- er_diagram.puml
- er_diagram.svg

## 課題3

- ECサイトを開発していると仮定する
    - 商品、出品者、配送業者に対して評価ができるとする
        - products テーブル、 sellers テーブル、 deliveries テーブルに対してコメントをつける場合