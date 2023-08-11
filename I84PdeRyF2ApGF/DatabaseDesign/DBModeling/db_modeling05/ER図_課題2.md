```mermaid
erDiagram

authors ||--o{ articles : ""


authors{
    id serial PK
    name varchar
    email varchar
    created_at timestamp
}

articles{
    id serial PK
    version bigint PK
    posted_by serial FK
    title varchar
    content text
    created_at timestamp
    updated_at timestamp
    deleted_at timestamp
}

```