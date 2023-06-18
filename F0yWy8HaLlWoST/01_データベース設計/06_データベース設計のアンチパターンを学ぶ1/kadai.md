# 課題1

タグは選択式ではなく、フリーテキストとする

- 生じる問題
  - カンマのタイポ、カンマ後にスペースを置くかどうかのブレ、カンマがタグ名に必要な場合
  - 特定のタグが使用禁止になった場合、削除がひと手間かかる
  - 特定のタグでの検索がパターンマッチになり複雑化する
  - 文字数制限をかけづらい

# 課題2

```mermaid
erDiagram

  T_POSTS {
    uuid post_id PK "ID"
    varchar detail "<Not null> 詳細"
    boolean is_deleted "<Not null> 削除されたか"
    date created_at "<Not null> 作成日"
    date updated_at "更新日"
  }

  T_TAGS {
    uuid tag_id PK "ID"
    uuid post_id FK "<Not null> ポストID"
    varchar name "<Not null> タグ名"
    boolean is_deleted "<Not null> 削除されたか"
    date created_at "<Not null> 作成日"
    date updated_at "更新日"
  }

  T_POSTS ||--o{ T_TAGS: "1つのポストは0以上のタグをもつ"
```

# 課題3

1対多の関係があるケースはほとんど該当しそう。かつカテゴリなどのメインデータではないケースで安易にやってしまいそう。

- ブログのタグ
- ECサイトでセット商品がある場合
- 複数ユーザに対するリマインダ
