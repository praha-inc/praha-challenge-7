```mermaid

erDiagram

Assignee{
    id INT PK
    name VARCHAR
}

Issue{
    id INT PK
    text VARCHAR
}

AssignedIssue{
    asingee_id INT FK
    issue_id INT FK
}

Assignee ||--o{ AssignedIssue : ""
Issue ||--o| AssignedIssue : ""

```