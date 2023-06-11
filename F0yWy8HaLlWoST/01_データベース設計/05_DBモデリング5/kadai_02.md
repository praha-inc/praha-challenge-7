# 課題2

- 記事が更新された場合は、旧データをT_ARTICLE_HISTORIESにレコード追加し、T_ARTICLESを更新する

```mermaid
erDiagram

  M_USERS {
    uuid user_id PK "ID"
    varchar name "<Not null> 名前"
    boolean is_deleted "<Not null> 削除されたか"
    date created_at "<Not null> 作成日"
    date updated_at "<Not null> 更新日"
  }

  T_ARTICLES {
    uuid article_id PK "ID"
    uuid parent_article_id FK "親記事ID（最新記事の場合はnull）"
    uuid user_id FK "<Not null> ユーザID"
    varchar title "<Not null><100> 名前"
    varchar detail "<Not null><1000> 詳細"
    boolean is_deleted "<Not null> 削除されたか"
    date created_at "<Not null> 作成日"
    date updated_at "<Not null> 更新日"
  }

  M_USERS ||--o{ T_ARTICLES: "1人のユーザは0以上の記事をもつ"
```

- メリット
  - １と違って最新のレコードの内容をHistoryに移して、新規レコードを追加し、親レコードを更新するということをする必要がない。単純に新規レコードを追加して、親IDを更新すればよい。
  - テーブルの数が減る
- デメリット
  - T_ARTICLESが肥大化し、検索性能が落ちる→インデックスを貼ればよい？
  - （最新のみの）記事一覧取得がワンクッション必要

## 疑問点メモ

- 