``` mermaid
erDiagram

Post{
	id varchar PK
	text varchar
}

Tag{
	id varchar PK
  content varchar
}

PostsTag{
	post_id varchar FK
  tag_id varchar FK
}

Post ||--o{ PostsTag : ""
Tag ||--o{ PostsTag : ""

```