```mermaid

erDiagram

Message{
    id varchar PK
    text varchar
}

TreePaths{
    ancestor varchar FK
    descendant varchar FK
}

Message ||--o{ TreePaths : ""
TreePaths }o--|| Message : ""

```