# 外部キー制約について考える

## 課題1

### 外部キー制約を定義しない場合
- Bookテーブルにレコードが存在するものの、親テーブルであるAuthorテーブルからはレコードを削除することができてしまうため、書籍としてデータがあるもののその著者の情報を参照することができない、といった問題が発生する
- 親テーブルに存在しない値を子テーブルのauthor_idに使用することができるため、Authorテーブルから著者一覧を取得する場合、そこに存在しない著者が書いた本が存在する可能性があるという問題が発生する
- 

### 外部キー制約を定義する場合

- 外部キー制約の種類を知らないと適切に設定することができず、意図しないデータを削除や更新してしまう可能性がある（ON DELETE CASCADE など）
- 外部キーで参照しているテーブルもロックしてしまうため、デッドロックが発生する可能性がある

## 課題2

### MySQLで選択可能なアクション
- CASCADE
    - 親テーブルから行を削除または更新し、子テーブル内の一致する行を自動的に削除または更新する
    - 選択すべきケース：テーブル作成時にからこれを選択するべきケースは思いつかなかった（開発者が意識して実装しないと、意図しないデータの変更があり得るため）。使用ケースとして、同じDB同じスキームでマルチテナントを実現していて、退会や解約などでテナントをまるごと削除する場合、該当のテナントのみアクションをCASCADEに変更して、親テーブルからデータを削除するなどの場合に検討しても良さそう
- SET NULL
    - 親テーブルから行を削除または更新し、子テーブルの外部キーカラムを NULL に設定する
    - 選択すべきケース：親子のリレーションで多重度が0以上の場合は、こちらを選択することを検討できる。あるクラブ活動で、チームがいくつかあり、メンバーはチームに所属してもしなくてもよく、途中で所属したり脱退したりしても良い場合など。
- RESTRICT
    - 親テーブルに対する削除または更新操作を拒否する
    - 選択すべきケース：基本的にはこちらのケースを選択してよいと思う。ある企業で部署があり、社員はいずれかの部署に在籍しており、どの部署にも在籍しないことを許容しない場合など。
- NO ACTION
    - 標準SQLのキーワード。 MySQLでは、RESTRICTと同等
- SET DEFAULT
    - MySQL8.0でデフォルトで採用されているInnoDBでは、ON DELETE SET DEFAULT または ON UPDATE SET DEFAULT 句を含むテーブル定義を拒否する
    - 選択すべきケース：具体的な例は思いつかないが、ユーザーにすべての値を明示的に指定させたい場合...？

### 従業員管理サービス
- 統合などで部署がなくなる場合などで、先に従業員の部署情報を異動先に変更しておかないと、従業員のレコードごと削除されてしまう

### プロジェクトマネジメントツール
- 退職などで担当者のレコードを削除した場合、担当者が任命されていない案件が存在してしまう

### ORM
- Eloquent
    - Laravelのソースコードを確認したところ、下記のような実装がされていた。cascadeOnDelete(), restrictOnDelete()などを呼ばないと、$commandのonDeletedに値を格納していなかったため、明示的に指定しない限りデフォルトの値（MySQLなら「NO ACTION」）が適用されると思われる。
```php
// Once we have the basic foreign key creation statement constructed we can
// build out the syntax for what should happen on an update or delete of
// the affected columns, which will get something like "cascade", etc.
if (! is_null($command->onDelete)) {
    $sql .= " on delete {$command->onDelete}";
}
```

- TypeORM
    - 下記のような実装がされており、TableForeignKeyクラスのcreateメソッドの引数にForeignKeyMetadataを持っていたため、明示的に指定しない限り「NO ACTION」が適用されると思われる。
```typescript
// ForeignKeyMetadata.ts （一部抜粋）

/**
 * Contains all information about entity's foreign key.
 */
export class ForeignKeyMetadata {
    // -------------------------------------------------------------------------
    // Public Properties
    // -------------------------------------------------------------------------

    /**
     * What to do with a relation on deletion of the row containing a foreign key.
     */
    onDelete?: OnDeleteType

    // ---------------------------------------------------------------------
    // Constructor
    // ---------------------------------------------------------------------

    constructor(options: {
        entityMetadata: EntityMetadata
        referencedEntityMetadata: EntityMetadata
        namingStrategy?: NamingStrategyInterface
        columns: ColumnMetadata[]
        referencedColumns: ColumnMetadata[]
        onDelete?: OnDeleteType
        onUpdate?: OnUpdateType
        deferrable?: DeferrableType
        name?: string
    }) {
        this.entityMetadata = options.entityMetadata
        this.referencedEntityMetadata = options.referencedEntityMetadata
        this.columns = options.columns
        this.referencedColumns = options.referencedColumns
        this.onDelete = options.onDelete || "NO ACTION"
        this.onUpdate = options.onUpdate || "NO ACTION"
        this.deferrable = options.deferrable
        this.givenName = options.name
        if (options.namingStrategy) this.build(options.namingStrategy)
    }
}
```

### MySQLとPostgreSQLでのrestrictとno actionの扱いの違い
- MySQLではrestrictとno actionに違いはなく、外部キー制約はただちにチェックされる。
- 一方PostgreSQLでは、restrictはMySQLと同様、外部キー制約を即時チェックするのに対し、no actionは制約のチェックをトランザクション中で後回しにすることができる。
    - restrictは参照先をDELETEする時点でトランザクションが失敗する
    - no actionはトランザクション中で最終的に参照先をDELETEしないとトランザクションが失敗する
    
## 課題3

### 問題1
#### Q
Oracle Database, SQL Serverでは、どのようなアクションを指定できるでしょうか。

#### A
- Oracle Database 
    - NO ACTIONが遅延チェックを備えていることも含め、PostgreSQLと同様。
- SQL Server
    - NO ACTION, CASCADE, SET NULL, SET DEFAULTの4種。
  
### 問題2
#### Q
外部キー制約は無効化することができます。どのような場合に、無効化が役立つでしょうか。
#### A
- 外部キー制約によって参照されるテーブルを削除する場合

### 問題3
#### Q
外部キー制約を意図的に貼らないケースはどのようなものがあるでしょうか。
#### A
外部キー制約をサポートしていないDBMSを使用する場合や、外部キー制約をつかった関連付けを行うことができない場合。<br>
なお、『SQLアンチパターン』では「外部キー嫌い」という章があり、基本的に外部キーを使用するべきという結論だが、ネット上では上記を検討した上で外部キーを使用していないケースがあるようだ。<br>
自分を含め、外部キーを貼らないほうがよいと考える経験があったら、そのときに改めて検討する必要があるように思う。

## 参考
- https://qiita.com/kamillle/items/5ca2db470f199c1bc3ef
- https://zenn.dev/nasu/articles/40ba32d259dc47
- https://zenn.dev/praha/articles/2667cbb1ab7233
- https://dev.mysql.com/doc/refman/8.0/ja/create-table-foreign-keys.html
- https://github.com/laravel/framework/blob/4fbf4813734c42decc4d1c2de86ca318ce3606ff/src/Illuminate/Database/Schema/Grammars/Grammar.php#L154
- https://www.postgresql.jp/document/15/html/ddl-constraints.html#DDL-CONSTRAINTS-FK