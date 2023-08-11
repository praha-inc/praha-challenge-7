``` mermaid

erDiagram

Comments ||--o{ MangaComments : ""
Comments ||--o{ NovelComments : ""
MangaComments }o--|| Manga : ""
NovelComments }o--|| Novel : ""

Comments{
    id int PK
    text text
}

Manga{
    id int PK
    name varchar
}

Novel{
    id int PK
    name varchar
}

MangaComments{
    manga_id int FK
    comment_id int FK
}

NovelComments{
    novel_id int FK
    comment_id int FK
}

```