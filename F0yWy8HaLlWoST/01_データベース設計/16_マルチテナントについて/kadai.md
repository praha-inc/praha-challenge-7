# 課題1

- シングルテナントにする
- マルチテナント
  - RLS
  - テナントごとにテーブルを用意する
  - テナントごとにスキーマを作成
  - テナントごとにDBを作成

# 課題2

## パターン別メリデメ

| パターン | メリット | デメリット |
| ---- | ---- | ---- |
| テナント毎にデータベースを分割する | データが混ざらない | ・スキーマ変更コスト<br>・アプリからDB接続コスト<br>・テナント作成時にDB初期化処理が必要<br>・テナントとDBのリレーションが別途必要 |
| テナント毎にスキーマを分割する（Postgre） | スキーマ単位で所有者を決められる | ・スキーマ変更コスト<br>・アプリからDB接続コスト<br>・テナント作成時にスキーマ初期化処理が必要<br>・テナントとスキーマのリレーションが別途必要 |
| テナント毎にテーブルを分割する | 一つのDB内でテナントのデータを保持できる | ・スキーマ変更コスト<br>・テナント作成時にテーブル初期化処理が必要<br>・テナントとテーブル名のリレーションが別途必要<br>・テナントのテーブル間で外部キーが煩雑になる |
| テーブルにテナント識別カラムを持ち、行単位で制御 | ・テーブルスキーマ変更コストが低い<br>・DB側での設定コストが低い | ・他テナントへのアクセスが容易<br>・ロジックの実装が必要（where句での制御、またはRLSなど） |

## RLS

https://qiita.com/revenue-hack/items/db66ce9d7cc4fa347111
https://buildersbox.corp-sansan.com/entry/2021/05/10/110000

1. テーブルに tenant_id カラムを作る
2. 作成したテーブルに対して、 `ENABLE ROW LEVEL SECURITY` を適用する
   1. OwnerユーザにRLSを効かせるためには`FORCE ROW LEVEL SECURITY`する
3. 作成したテーブルに対して、 CREATE POLICY する

```sql:マイグレーションSQLサンプル
CREATE TABLE invoice (
    tenant_id varchar(20) NOT NULL,
    invoice_uuid uuid NOT NULL PRIMARY KEY,
    publisher varchar(50) NOT NULL
);

ALTER TABLE invoice ENABLE ROW LEVEL SECURITY;

CREATE POLICY tenant_policy ON invoice
    USING (tenant_id = current_setting('app.tenant_id'));
```