```mermaid
erDiagram

authors ||--o{ post_article : ""
articles ||--o{ edit_article : ""
authors ||--o{ edit_article : ""
authors ||--o{ delete_article : ""
post_article ||--|| articles : ""
articles ||--o| delete_article : ""

authors{
    id serial PK
    name varchar
    email varchar
    created_at timestamp
}

articles{
    id serial PK
    post_article_id serial FK
}

post_article{
    id serial PK
    posted_by serial FK
    title varchar
    content text
    posted_at timestamp
}

edit_article{
    id serial PK
    article_id uuid FK
    edited_by uuid FK
    title varchar
    content text
    edited_at timestamp
}

delete_article{
    id serial PK
    article_id uuid FK
    deleted_by uuid FK
    deleted_at timestamp
}


```