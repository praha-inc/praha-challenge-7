``` mermaid

erDiagram

Student{
    id varchar PK
    name varchar 
    status_id int FK
}

Status{
    id int PK
    status varchar
}

Student }o--|| Status : ""

```