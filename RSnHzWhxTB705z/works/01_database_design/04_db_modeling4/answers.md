# DMモデリング4
## 課題1

※ 複数のメンションが指定された場合の挙動ですが、1人1人に送信されるのではなく、1つのリマインダーで複数人に送信される想定です。<br>
例：エンジニアAとエンジニアB向けのリマインドを作成したら、1通で2人にリマインダーが送信され、エンジニアAがそのリマインダーを終了すれば、エンジニアBにとってもそのリマインダーは終了となる。

### ER図
- er_diagram.puml   
- er_diagram.svg   

### DDL
ddl.sql
<br>
※ バッチが1時間に1回実行のため、リマインダーの時刻はすべて00分00秒で頭足します。
<br>
※ アプリ側で正規表現でユーザー名は切り取り、送信先ユーザーテーブルに格納する前提です。

### DML
dml.sql

### DML
dml.sql

### ユースケース（リマインダー作成）
usecase.sql

### ユースケース（リマインダー実行、「終わった！」実行）
check.sql

### DB削除
drop.sql

