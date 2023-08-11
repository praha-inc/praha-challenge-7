``` mermaid

erDiagram

NewCustomer{
    id varchar PK
}

Call{
    id varchar PK
    customer_id varchar FK
    note varchar
    calledAt timestamp
}

Meet{
    id varchar PK
    customer_id varchar FK
    note varchar
    metAt timestamp
}

Close{
    id varchar PK
    customer_id varchar FK
    closedAt timestamp
    cancelledAt timestamp
}

NewCustomer ||--o{ Call : ""
NewCustomer ||--o{ Meet : ""
NewCustomer ||--o{ Close : ""

```