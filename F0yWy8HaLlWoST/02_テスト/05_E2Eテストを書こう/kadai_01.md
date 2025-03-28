# 課題 1

- [Cypress で Draw!を表示するまで](https://github.com/kzk4043/react_tutorial/pull/1/files)

## 「Presentational」と「Container」コンポーネントについて調べる

https://zenn.dev/buyselltech/articles/9460c75b7cd8d1

> ロジックを責務とする Container Component と、UI を責務とする Presentational Component に分けて実装

## ある技術の登場により presentational/container の分け方が陳腐化しつつある？

> 元記事でも今は hooks が使え、恣意的な分割をせずともロジックと UI を分けることができるのでこのパターンにこだわりすぎないようにと述べられています。

hooks のことのよう。

> API リクエスト部分を hooks に切り出すことでロジックと UI の分離には成功しました。ただこれだと先ほどの例のようにユーザーに紐づく Todo だけを取得したいとなった時にこのままだと再利用ができません。

これに完全同意なので、presentational/container は今も有効だと思う。

storybook テスト追加
https://github.com/kzk4043/react_tutorial/pull/2/files

# 課題 2

## E2E テストのメリットとデメリット

- メリット
  - ユーザ観点でのテストができ、複数要素を跨いだチェックができるので、テストとしては最も効果が高い
- デメリット
  - 実行時間が遅い
  - 作成が大変
  - メンテナンスが大変
  - Flaky

## テスト手法（単体、統合、E2E など）を選択する際、どのような基準で選ぶと良いか

- 効果（実際の挙動との近さという意味での信頼性）
  - E2E > 結合 > 単体
- 作成、メンテナンスコストの低さ、安定性
  - 単体 > 結合 > E2E
- 実行時間、フィードバックのスピード
  - 単体 > 結合 > E2E

## 例えば要素の css の class を識別子に使うと、どのような時にどのような問題が起きるでしょうか？

- クラス名はテスト用ではないので、テストを意識せずに変えてしまう。気づかずに壊れる可能性が高いし、スタイルの変更時にテストを意識する必要が出てきてしまう。
- クラスはリストとか複数要素に当てることが多いので、一つに絞るのが難しい

## 例えば要素の css の id を識別子に使うと、どのような時にどのような問題が起きるでしょうか？

- ID もテスト用ではない問題はある（クラスほど問題にはならない気がする）

## 例えば要素の文言を識別子に使うと、どのような時にどのような問題が起きるでしょうか？

- 文言はすぐ変わるので、要素を特定するアンカとしては使いづらい。動的に出し分ける文言もあるし。
- 同じ文言が画面中他の箇所で使われる可能性は全然ある

## どのように要素を指定すればテストが壊れにくくなるでしょうか？ペアの方とお話ししてみてください

- テスト用の`data-hoge`プロパティ。`data-test`のようにテスト用であることを明示するのがよさそう
- ARIA 属性を使って、役割によって特定の要素を見つけ出す

重要なのは、

- 変更されにくさ
  - なので、他の目的で存在するプロパティは使いにくい
- ページ内での一意性

# 課題 3

https://github.com/kzk4043/react_tutorial/pull/3/files

# 課題 4

クイズ

- Q1. 流行りの E2E フレームワーク 3 選
- Q2. Playwright が他フレームワークより優れている点
- Q2. E2E と統合テストの境界線は？

- A1. 2022 のものだが、[state of js の結果](https://2022.stateofjs.com/en-US/libraries/testing/)。最近は Playwright 一択みたいな雰囲気すら感じる。
  - Playwright がやはり上がってきている
  - 次が Cypress だが下がってきてる
  - その次に Puppeteer。これも下がってきてる
  - Selenium はもはや…
- A2.
  - https://tech.willgate.co.jp/entry/2024/04/26/113724
  - https://zenn.dev/84q/articles/ed6f66ab80c7ce
    - Google で Puppeteer 作ってた人が MS に移って作ったっぽい？
    - auto-waiting を推す記事は結構多い
- A3. https://zenn.dev/ignorant_kenji/articles/6f740feabf6f30
  - [統合テスト](https://zenn.dev/aldagram_tech/articles/kanna-integration-test)
    - バックエンドサービス間やフロントエンドフレームワークのコンポーネント間など、サービス／コンポーネント間の相互作用をテスト
    - 最近であれば storybook を export して Playwright でごにょごにょするみたいななのが統合テスト手法として有力？
  - E2E
    - ユーザーがアプリケーションでアクションを実行しようとするときに遭遇し得る品質問題を想定し、アプリケーションのユーザ体験全体をテスト
