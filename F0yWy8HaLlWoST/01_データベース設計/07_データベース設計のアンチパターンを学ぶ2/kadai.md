# 課題1

- 生じる問題
  - 4つ以上の場合
  - 1〜３が埋まっている状態で、1が削除された場合
  - 特定のタグでの検索が複数カラムを対象にする必要がある

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
    varchar name "<Not null> タグ名"
    boolean is_deleted "<Not null> 削除されたか"
    date created_at "<Not null> 作成日"
    date updated_at "更新日"
  }

  R_POSTS_TAGS {
    uuid post_tag_id PK "ID"
    uuid post_id FK "ポストID"
    uuid tag_id FK "タグID"
    boolean is_deleted "<Not null> 削除されたか"
    date created_at "<Not null> 作成日"
    date updated_at "更新日"
  }

  T_POSTS ||--o{ R_POSTS_TAGS: ""
  T_TAGS ||--o{ R_POSTS_TAGS: ""
```

# 課題3

1対1の関係だと想定していたものが、1対多や多対多になったときにテーブル増やすのはきついしってこうしそう。紐付ける対象がユーザなどのマスタデータの方が起きやすそう。

- 記事の執筆者は一人の想定だったが、共同執筆が可能になって複数を許容しなければならなくなった
- ブログのカテゴリは一つと想定していたが、あとから複数つけられるようになった
