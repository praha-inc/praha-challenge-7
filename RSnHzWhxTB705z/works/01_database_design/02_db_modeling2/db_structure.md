# テーブル構造

## users : ユーザーテーブル
| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | CHAR(36) | ※ |  | NOT NULL |  | ※ |  |  |  |
| name | ユーザー名 | VARCHAR(255) |  |  | NOT NULL |  |  |  |  |  |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |

## workspaces : ワークスペーステーブル
| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | CHAR(36) | ※ |  | NOT NULL |  | ※ |  |  |  |
| name | ワークスペース名 | VARCHAR(255) |  |  | NOT NULL |  |  |  |  |  |
| is_deleted | 論理削除フラグ | TINYINT(1) |  |  | NOT NULL | 0 |  |  |  |  |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |

## users_workspaces : ユーザー ワークスペース 中間テーブル
| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | CHAR(36) | ※ |  | NOT NULL |  | ※ |  |  |  |
| user_id |  | CHAR(36) |  | FOREIGN KEY | NOT NULL |  |  |  |  |  |
| workspace_id |  | CHAR(36) |  | FOREIGN KEY | NOT NULL |  |  |  |  |  |
| is_deleted | 論理削除フラグ | TINYINT(1) |  |  | NOT NULL | 0 |  |  |  |  |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |

## channels : チャンネルテーブル
| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | CHAR(36) | ※ |  | NOT NULL |  | ※ |  |  |  |
| workspace_id |  | CHAR(36) |  | FOREIGN KEY | NOT NULL |  |  |  |  |  |
| name | ワークスペース名 | VARCHAR(255) |  |  | NOT NULL |  |  |  |  |  |
| is_deleted | 論理削除フラグ | TINYINT(1) |  |  | NOT NULL | 0 |  |  |  |  |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |

## users_channels : ユーザー チャンネル 中間テーブル
| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | CHAR(36) | ※ |  | NOT NULL |  | ※ |  |  |  |
| user_id |  | CHAR(36) |  | FOREIGN KEY | NOT NULL |  |  |  |  |  |
| channel_id |  | CHAR(36) |  | FOREIGN KEY | NOT NULL |  |  |  |  |  |
| is_deleted | 論理削除フラグ | TINYINT(1) |  |  | NOT NULL | 0 |  |  |  |  |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |

## messages : メッセージテーブル
| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | CHAR(36) | ※ |  | NOT NULL |  | ※ |  |  |  |
| user_id |  | CHAR(36) |  | FOREIGN KEY | NOT NULL |  |  |  |  |  |
| channel_id |  | CHAR(36) |  | FOREIGN KEY | NOT NULL |  |  |  |  |  |
| content | 内容 | VARCHAR(2000) |  |  | NOT NULL |  |  |  |  |  |
| is_deleted | 論理削除フラグ | TINYINT(1) |  |  | NOT NULL | 0 |  |  |  |  |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |

## thread_messages : スレッドメッセージテーブル
| カラム名 | 項目名 | 型 | 主キー | 属性 | NULL | 初期値 | ユニーク | インデックス | 条件 | 備考 | 
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| id |  | CHAR(36) | ※ |  | NOT NULL |  | ※ |  |  |  |
| user_id |  | CHAR(36) |  | FOREIGN KEY | NOT NULL |  |  |  |  |  |
| message_id |  | CHAR(36) |  | FOREIGN KEY | NOT NULL |  |  |  |  |  |
| content | 内容 | VARCHAR(2000) |  |  | NOT NULL |  |  |  |  |  |
| is_deleted | 論理削除フラグ | TINYINT(1) |  |  | NOT NULL | 0 |  |  |  |  |
| created_at | 作成日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
| updated_at | 更新日 | DATETIME |  | DEFAULT CURRENT_TIMESTAMP <br> ON UPDATE CURRENT_TIMESTAMP | NOT NULL |  |  |  |  |  |
