```mermaid

erDiagram

%% テーブル
users{
    id BIGINT PK
    name VARCHAR
    email VARCHAR
    created_at DATETIME
    updated_at DATETIME
}

reminders{
    id BIGINT PK
    created_by BIGINT FK
    message VARCHAR
    frequency_pattern VARCHAR
    nortification_day_interval INT
    nortification_weekday　VARCHAR
    nortification_date INT
    nortification_time DATETIME
    last_sent_at DATETIME
    created_at DATETIME
    updated_at DATETIME
}

user_tasks{
    id BIGINT PK
    user_id BIGINT FK
    reminder_id BIGINT FK
    status VARCHAR
}

%% リレーション
users ||--o{ reminders : ""
reminders ||--o{ user_tasks : ""
users ||--o{ user_tasks : ""

```