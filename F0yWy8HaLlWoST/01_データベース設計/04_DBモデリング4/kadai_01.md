# 課題1

- メッセージはDM想定。複数名ユーザが指定された場合は、複数名にDMする
- cycle_xの制御はアプリ側で行う想定

```mermaid
erDiagram

  M_CYCLES {
    uuid cycle_id PK "ID"
    varchar name "<Not null> 名前"
    boolean is_deleted "<Not null> 削除されたか"
    date created_at "<Not null> 作成日"
    date updated_at "更新日"
  }

  T_REMINDERS {
    uuid reminder_id PK "ID"
    uuid cycle_id FK "<Not null> 周期ID"
    int cycle_x FK "周期 <毎日の場合はnull/x日おきの場合はint/毎週X曜日は0-6/毎月X日は1-31>"
    varchar detail "<Not null> 内容"
    boolean is_deleted "<Not null> 削除されたか"
    date created_at "<Not null> 作成日"
    date updated_at "更新日"
  }

  T_MENTIONED_USERS {
    uuid　mentioned_user_id PK "ID"
    uuid reminder_id FK "<Not null> リマインダID"
    varchar slack_user_name "<Not null> slackユーザ名"
    boolean is_deleted "<Not null> 削除されたか"
    date created_at "<Not null> 作成日"
    date updated_at "更新日"
  }

  M_CYCLES ||--o{ T_REMINDERS: "1つの周期は0以上のリマインダをもつ"
  T_REMINDERS ||--|{ T_MENTIONED_USERS: "1つのリマインダは1以上のメンションユーザをもつ"
```

## 疑問点メモ
