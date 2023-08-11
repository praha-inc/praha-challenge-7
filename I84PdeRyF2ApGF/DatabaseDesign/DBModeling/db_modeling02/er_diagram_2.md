``` mermaid
erDiagram
    %% イミュータブル考えないテーブル構造

    workspaces ||--o{ workspace_channels : ""
    users ||--o{ user_channels : ""
    user_channels }o--|| channels : ""
    workspace_channels }o--|| channels : ""
    users ||--o{ channel_messages : ""
    channels ||--o{ channel_messages : ""
    channel_messages ||--o{ threads : ""
    users ||--o{ user_direct_message_rooms : ""
    user_direct_message_rooms }o--|| direct_message_rooms : ""
    users ||--o{ direct_messages : ""
    direct_messages }o--|| direct_message_rooms : ""
    direct_messages ||--o{ threads : ""
    threads ||--o{ thread_messages : ""

    users{
        bigint id PK
        varchar display_name
        varchar first_name
        varchar last_name
        varchar email
        datetime created_at
        datetime updated_at
        datetime deleted_at
    }

    user_channels{
        bigint id PK
        bigint user_id FK
        bigint channel_id FK
    }

    channels{
        BIGINT id PK
        BIGINT created_by FK
        VARCHAR name
        VARCHAR description
        DATETIME created_at
        DATETIME updated_at
        DATETIME deleted_at
    }

    workspace_channels{
        bigint id PK
        bigint channel_id FK
        bigint workspace_id FK
    }

    workspaces{
        BIGINT id PK
        VARCHAR name
        BIGINT created_by
        DATETIME created_at
        DATETIME updated_at
        DATETIME deleted_at
    }

    channel_messages{
        bigint id PK
        bigint send_user_id FK
        bigint channel_id FK
        varchar content
        datetime sent_at
        datetime updated_at
        datetime deleted_at
    }

    threads{
        bigint id PK
        bigint channel_message_id FK
        bigint direct_message_id FK
        datetime created_at
    }

    thread_messages{
        bigint id PK
        bigint send_user_id FK
        bigint thread_id FK
        varchar content
        datetime sent_at
        datetime updated_at
        datetime deleted_at
    }

    direct_message_rooms{
        bigint id PK
    }

    user_direct_message_rooms{
        bigint id PK
        bigint user_id FK
        bigint direct_message_room_id FK
    }

    direct_messages{
        bigint id PK
        bigint send_user_id FK
        bigint direct_message_room_id FK
        varchar content
        datetime sent_at
        datetime updated_at
        datetime deleted_at
    }

```