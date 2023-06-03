- ワークスペースごとにDBをたてる想定

```mermaid
erDiagram

  M_WORKSPACE_CONFIGS {
    uuid workspace_id PK "ワークスペースID"
    varchar name "<Not null> 名前"
    date created_at "<Not null> 作成日"
    date updated_at "更新日"
  }

  M_USERS {
    uuid user_id PK "ユーザID"
    uuid workspace_id FK "<Not null> ワークスペースID"
    varchar name "<Not null> 名前"
    boolean is_deleted "<Not null> 削除されたか"
    date created_at "<Not null> 作成日"
    date updated_at "更新日"
  }

  M_CHANNELS {
    uuid channel_id PK "チャネルID"
    uuid workspace_id FK "<Not null> ワークスペースID"
    varchar name "<Not null> 名前"
    boolean is_deleted "<Not null> 削除されたか"
    date created_at "<Not null> 作成日"
    date updated_at "更新日"
  }

  R_USERS_AND_CHANNELS {
    uuid users_and_channels_id PK "ユーザ_チャネル_中間テーブルID"
    uuid user_id FK "<Not null> ユーザID"
    uuid channel_id FK "<Not null> チャネルID"
    boolean is_deleted "<Not null> 削除されたか"
    date created_at "<Not null> 作成日"
    date updated_at "更新日"
  }

  T_MESSAGES {
    uuid message_id PK "メッセージID"
    uuid user_id FK "<Not null> ユーザID"
    uuid channel_id FK "<Not null> チャネルID"
    varchar message "<Not null> メッセージ"
    boolean is_deleted "<Not null> 削除されたか"
    date created_at "<Not null> 作成日"
    date updated_at "更新日"
  }

  T_THREADS {
    uuid thread_id PK "スレッドメッセージID"
    uuid user_id FK "<Not null> ユーザID"
    uuid message_id FK "<Not null> メッセージID"
    varchar thread_message "<Not null> スレッドメッセージ"
    boolean is_deleted "<Not null> 削除されたか"
    date created_at "<Not null> 作成日"
    date updated_at "更新日"
  }

  M_WORKSPACE_CONFIGS ||--o{ M_CHANNELS: "1つのワークスペースは0以上のチャネルをもつ"
  M_WORKSPACE_CONFIGS ||--o{ M_USERS: "1つのワークスペースは0以上のユーザをもつ"
  M_USERS ||--o{ R_USERS_AND_CHANNELS: ""
  M_CHANNELS ||--o{ R_USERS_AND_CHANNELS: ""
  M_CHANNELS ||--o{ T_MESSAGES: "1つのチャネルは0以上のメッセージを持つ"
  M_USERS ||--o{ T_MESSAGES: "1人のユーザは0以上のメッセージを持つ"
  T_MESSAGES ||--o{ T_THREADS: "1つのメッセージは0以上のスレッドメッセージを持つ"
  M_USERS ||--o{ T_THREADS: "1人のユーザは0以上のスレッドを持つ"
```

## 疑問点メモ


# ユースケースを想定したクエリ

「hoge」と検索して、この文字列を含むメッセージとスレッドメッセージを両方とも取得する（検索したユーザが入っているチャネル内のメッセージに限る）

```sql
SELECT * FROM (
    SELECT m.message_id as id, m.user_id, m.channel_id, m.message, m.created_at
    FROM T_MESSAGES m
    JOIN R_USERS_AND_CHANNELS uc ON m.channel_id = uc.channel_id
    WHERE
      uc.user_id = UUID_TO_BIN('f3ea110d-ecb3-5a5c-910c-92e4e710ba81', 1)
      AND message LIKE '%hoge%'

    UNION

    SELECT t.thread_id, t.user_id, null, t.thread_message, t.created_at
    FROM T_THREADS t
    JOIN T_MESSAGES m ON t.message_id = m.message_id
    JOIN R_USERS_AND_CHANNELS uc ON m.channel_id = uc.channel_id
    WHERE
      uc.user_id = UUID_TO_BIN('f3ea110d-ecb3-5a5c-910c-92e4e710ba81', 1)
      AND thread_message LIKE '%hoge%'
) as messages_and_threads
ORDER BY created_at DESC;
```