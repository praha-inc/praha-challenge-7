``` mermaid

erDiagram

Post{
    id int PK
    text varchar
}

Tags{
    id int PK
    name varchar
}

PostsTags{
    post_id int FK
    tag_id int FK
}

Post ||--o{ PostsTags : ""
Tags ||--o{ PostsTags : ""

```