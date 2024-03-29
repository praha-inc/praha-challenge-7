# マルチテナントについて

## 課題1

- テーブルによってテナントを分けるのではなく、DBによってテナントを分ける（スキーマで分けられるDBMSを使用している場合は、スキーマで分けることも検討する）
- テナントの指定の箇所など、致命的な部分については最低限テストを導入し、開発者が意識しなくてもデータが混濁しない仕組みをつくる

## 課題2

### マルチテナントアーキテクチャについてのメリット・デメリット
#### テナント毎にデータベースを分割する
- メリット
    - 扱うDBを明示的に切り替える必要があるため、データの混濁の可能性が低い
    - シングルテナントを前提に作られているWebフレームワークやO/Rマッパーを含むDBフレームワークの恩恵を受けつつマルチテナントを実現できる
    - テナント固有にスケールアップなどのチューニングやカスタマイズが可能
- デメリット
    - マイグレーションがDB数分かかるため、作業時間の見積もりが困難（メンテナンスのために必要な停止時間が読めない）
    - テナントの数だけDBを用意しなければならないため、費用と運用双方の面でコストがかかる
    - テナントをまたいで共通の概念を取り扱いできない（課金、サブドメインなど）

#### テナント毎にスキーマを分割する
- メリット
    - テナントをまたいで共通の概念を取り扱いできる
    - DBはひとつにまとまっているため、CPU、メモリ、ディスクの監視と管理がシンプル
    - シングルテナントを前提に作られているWebフレームワークやO/Rマッパーを含むDBフレームワークの恩恵を受けつつマルチテナントを実現できる
- デメリット
    - ノイジーネイバー問題
        - 一部のテナントが他のテナント分のリソースを使い尽くす可能性がある
    - マイグレーションがテナント数分かかるため、作業時間の見積もりが困難（メンテナンスのために必要な停止時間が読めない）
    - DBに障害が発生した場合、すべてのテナントでサービスが停止する

#### すべてのテナントで同じスキーマを使う
- メリット
    - インフラや運用を共通化できる、デプロイが1度で済むなど、効率が良い
    - アジア、ヨーロッパ、アメリカなど、ビジネスアワーの分散した顧客がいれば、サーバーが常に高効率で稼働できる   
    - テーブル構成変更や機能拡張など、チューニングやカスタマイズが容易
- デメリット
    - 実装の仕方によってはデータ混濁の可能性が高い
    - ノイジーネイバー問題
        - 一部のテナントが他のテナント分のリソースを使い尽くす可能性がある
    - DBに障害が発生した場合、すべてのテナントでサービスが停止する

### RLSとを活用したマルチテナントアーキテクチャの実装方法について
#### RLSについて
- 通常の問い合わせでどの行が戻され、データ更新のコマンドでどの行を挿入、更新、削除できるかをユーザ単位で制限する行セキュリティポリシーをテーブルに定義できる機能
- サービスの拡大につれて契約する企業が増えると、DBやスキーマを分割するのが費用面・運用面でコストが比例的に増えていくため、すべてのテナントを同じDB同じスキーマで扱うパターンがあると思われる
    - このときデータの混濁が問題となるが、RLSを使うと開発者が意識しなくてもテナント間のデータの混濁を防げるのが大きなメリットとなる

#### 実装方法について
1. テーブルを作成する
2. テーブルに対してRLSを有効にする（ALTER TABLE）
3. ロールを作成する
4. ポリシーを作成する（CREATE POLICY）
5. 特有のロールに対してRLS制御用の権限を付与する
6. すべてのロールに対して、テーブルにおけるすべての権限を付与する


## 参考
- https://qiita.com/revenue-hack/items/db66ce9d7cc4fa347111
- https://mitomasan.hatenablog.com/entry/2016/05/25/210151
- https://www.publickey1.jp/blog/09/1saas.html
- https://techplay.jp/column/1649
- https://speakerdeck.com/purintai/builderscon-2018
- https://www.slideshare.net/AmazonWebServicesJapan/20220107-multi-tenant-database
- https://www.postgresql.jp/document/15/html/ddl-rowsecurity.html