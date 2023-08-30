# 課題1

- 定義しない場合
  - 不正なIDが入力可能になる
  - 正しい値だったとしても、Authorテーブルのデータ削除時にも何かしら対応をしないと不整合が発生する。それをアプリでやるのは抜け道ができそうだし怖い。
- 定義する場合
  - Authorのデータ削除時の考慮が必要→考慮自体は定義しない場合でも必要なので問題とは言えないかもしれないが…
    - 設定としては下記があるっぽい
      - 削除できない
      - nullに更新
      - 削除対象のauthor_idを持つBookデータすべて削除
  - 自動削除にした場合に、予期せぬデータ削除が起こりうる

# 課題2

https://dev.mysql.com/doc/refman/8.0/ja/create-table-foreign-keys.html
https://zenn.dev/praha/articles/2667cbb1ab7233

- CASCADE: 親テーブルから行を削除または更新し、子テーブル内の一致する行を自動的に削除または更新します。
  - かなりドラスティックな設定で、あまり採用されないとのこと。即時関連データの削除が必要な場合のみ。
- SET NULL: 親テーブルから行を削除または更新し、子テーブルの外部キーカラムを NULL に設定します。SET NULL アクションを指定する場合は、子テーブル内のカラムを NOT NULL として宣言していないことを確認してください。
  - CASCADEよりはゆるいが、結局Nullを挿入する時間が存在するので、どの程度処理時間を許容できるか
- RESTRICT: 親テーブルに対する削除または更新操作を拒否します。 RESTRICT (または NO ACTION) を指定することは、ON DELETE または ON UPDATE 句を省略することと同じです。
  - 基本的にはこの設定にして、物理削除する場合はBook側から削除して、Authorを削除する。
- NO ACTION: 標準 SQL のキーワード。 MySQL では、RESTRICT と同等です。 MySQL Server は、参照されるテーブル内に関連する外部キー値が存在する場合、親テーブルに対する削除または更新操作を拒否します。 一部のデータベースシステムは遅延チェックを備えており、その場合、NO ACTION は遅延チェックです。 MySQL では、外部キー制約はただちにチェックされるため、NO ACTION は RESTRICT と同じです。
- SET DEFAULT: このアクションは MySQL パーサーによって認識されますが、InnoDB と NDB はどちらも、ON DELETE SET DEFAULT または ON UPDATE SET DEFAULT 句を含むテーブル定義を拒否します。

- 従業員管理サービス
  - 部署が消えると従業員が消える
- プロジェクトマネジメントツール
  - 担当者が削除された場合、担当者不在の案件が出てしまう

## ORM

そもそもORM知らなかった…[なるほど](https://utouto97.hatenablog.com/entry/2021/07/21/224759)

- [Prisma](https://www.prisma.io/docs/concepts/components/prisma-schema/relations/referential-actions#referential-action-defaults)
  - onDelete
    - NotNull: Restrict→RestrictかCascadeだが、Cascadeはデフォルトにするには強すぎる挙動だから
    - NotNullでない: SetNull→Cascadeは強すぎるし、Restrictも柔軟性に欠けるケースがあるので、デフォルトとしてはSetNullが無難だから？
  - onUpdate
    - NotNull: Cascade→親が更新された時子も更新するのはそう
    - NotNullでない: Cascade→親が更新された時子も更新するのはそう
- [TypeORM](https://typeorm.io/relations#relation-options)
  - うーん、ちょっとデフォ値は試してみないとドキュメントからはわからんか…？それともデフォ値なしで明示する必要あり？
- [Doctrine](https://www.doctrine-project.org/projects/doctrine1/en/latest/manual/defining-models.html#integrity-actions)
  - 記載なし


- MySQLとPostgreのNoActionの違い
  - https://www.prisma.io/docs/concepts/components/prisma-schema/relations/referential-actions#noaction
    - MySQLはRestrictと同等
    - Postgreもほぼ同等だが、No actionはチェックをトランザクション中で後回しにすることができる

# 課題3

- 外部キー制約が使えないのはどのようなケースか
  - シャーディング、パーティショニング
  - その他使わないケースはテストがめんどくさいとかそういう話が多いいがする…それくらいなら貼っといた方が良いのでは…？[この記事](https://blog.j5ik2o.me/entry/2020/06/16/105311)はよくわからんかった…
- 外部キー制約を一時的に無効化するコマンドは？
  - MySQL: `SET foreign_key_checks = 0;`
  - Postgre: `SET CONSTRAINTS ALL DEFERRED;`
  - [その他](https://ito-u-oti.com/post-1053/#outline__2)
- SQL Serverの参照アクションにRestrictがないのはなぜか
  - NoActionが同等の動作をするため
