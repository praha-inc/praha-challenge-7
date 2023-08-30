``` mermaid

erDiagram

Student{
    id varchar PK
    name varchar
}

Resign{
    id varchar PK
    student_id varchar FK
    resigned_at timestamp
}

Student ||--o{ Resign : ""

```