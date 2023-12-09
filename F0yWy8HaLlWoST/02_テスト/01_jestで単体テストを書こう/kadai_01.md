# 課題1

レビュ不要
https://github.com/kzk4043/jest_tutorial

# 課題2

https://github.com/kzk4043/praha-challenge-templates/blob/master/jestSample/__tests__/functions.test.ts

# 課題3

上記の単体テストを書くためには、依存性の注入とモック化を行う必要がありました
- そもそも、なぜ元の関数はカバレッジ100%のテストを書けなかったのでしょうか？
  - 分岐がランダムで発生してしまうため
- 依存性の注入とは何でしょうか？どのような問題を解決するために考案されたのでしょうか？
  - [DIは制御の反転の一種で、オブジェクトの作成と利用について関心の分離を行い、疎結合なプログラムを実現することを目的としている。](https://ja.wikipedia.org/wiki/%E4%BE%9D%E5%AD%98%E6%80%A7%E3%81%AE%E6%B3%A8%E5%85%A5)
    - メリット
      - 結合度の低下によるコンポーネント化の促進
      - 単体テストの効率化
      - 特定のフレームワークへの依存度低下

「getFirstNameThrowIfLong」の関数はhttps://random-data-api.comからデータを取得しているようです。しかしテストの度に外部サービスと通信をするようでは、良い単体テストにならない可能性があります。
- 今回のような単体テストで外部サービスとの通信が発生すると、どのようなデメリットがあるでしょうか？
  - 通信発生によるテスト速度の低下
  - 通信の失敗、サーバダウンによるランダムなテスト失敗
  - DB更新等によるレスポンスの変更で、再現性が下がる
- （任意課題）テストには「単体テスト」「統合テスト」など様々な分類や定義があります。チーム内で「何を単体テストと呼ぶのか」「何を統合テストと呼ぶのか」など用語の定義集を作ってみても面白いかもしれません
  - 単体テスト
    - 単一の関数、メソッド、クラスに対するテスト。入力等で外部依存がある場合、モックを使用する
    - 分岐状態や境界条件とかが重要？
  - 結合テスト
    - 複数の関数、メソッド、クラスに対するテスト。入力等で外部依存がある場合、テスト対象の関数以外はモックを使用する
    - コンポーネントは際どいな…例えばStorybookなんかは結合テストな気がする。
    - 状態遷移が主な対象？

sumOfArrayに空の配列を渡すと例外が発生します。あまり好ましい挙動ではありませんね。
- なぜあまり好ましい挙動ではないでしょう？「こうなるべきだ」とご自身が考える形にコードを修正してみてください
  - 型的に許容しているのにエラーになるから？
  - 空配列の場合０として修正したが…どうなんやろか。使われ方次第な気もするが…

単体テストを作成する際は、挙動が変わる境界値を検討したり、テストで保証しなければならない挙動を開発者自身が事前に考えておく必要があります。しかし複雑な機能をテストする場合あらかじめ全てのテストケースを開発者が想定しきることは難しいかもしれません。「この特定の値の時だけ不具合が起きる」ケースを開発者が見落としてしまうと、テストケースが不完全になってしまいます。そんな時に役立つかもしれない概念として「Property Based Testing（プロパティベースのテスト）」があります（対照的な存在としてはExample Based Testingが挙げられます）。
- Property Based Testing
  - [Property Based Testing は、Haskell のライブラリ QuickCheck からはじまったテストスタイルで、定義された条件に合わせて自動生成された膨大な値に対してテストを行う手法です](https://zenn.dev/ryo_kawamata/articles/22d4408bd1f138)
- なぜこのテストの考え方がコード品質を向上してくれる可能性があるのでしょうか？
  - 「Example Based Testing」は開発者想定するテストケースを試すが、「Property Based Testing」はランダムな値を大量にテストするため、開発者の想定外の入力をテストしやすい。2つを組み合わせればコード品質があがりそう（大変そうでもあるけど。）
- 逆に採用しない方が良いケースはあるのでしょうか？
  - 入力と出力が1対1の場合？
    - ある程度の範囲の値に対して、一定の出力があるタイプ（0~10000までならAを返す、的な）じゃないと結果的にExample Based Testingみたいになりそう。
  - それなりの数をやるので、実行時間が問題になるケース


- 単体テストケースを増やしても可読性、保守性、実行速度などに問題が起きないよう工夫できることを3つ考えてみましょう
  - arrange-act-assert
  - https://qiita.com/hgsgtk/items/a3186a250d36d3b224d9
    - Write the Tests First
    - Design for Testability
    - Use the Front Door First
    - Communicate Intent
    - Don't Modify the SUT
    - Keep Tests Independent
    - Isolate the SUT
    - Minimize Test Overlap
    - Minimize Untestable Code
    - Keep Test Logic Out of Production
    - Verify One Condition per Test
    - Test Concerns Separately
  - https://speakerdeck.com/hgsgtk/practices-to-write-better-unit-test

# 課題4

- 引数を受け取り、何らかの値を返却する関数を3つ作成 -> 作成した関数の単体テストをトリオのメンバーに書いてもらう

```js
function divide(x, y) {
    if (y !== 0) {
        return x / y;
    } else {
        return 'Error: Division by zero';
    }
}

function checkPassword(password) {
    if (password.length < 8) {
        return "Password is too short.";
    } else if (!/\d/.test(password)) {
        return "Password should contain at least one number.";
    } else if (!/[a-z]/.test(password)) {
        return "Password should contain at least one lowercase letter.";
    } else if (!/[A-Z]/.test(password)) {
        return "Password should contain at least one uppercase letter.";
    } else {
        return "Password is strong.";
    }
}

// JSONPlaceholderから投稿を取得する関数
async function getPosts(userId) {
    const response = await fetch(`https://jsonplaceholder.typicode.com/posts?userId=${userId}`);
    if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
    } else {
        return await response.json();
    }
}
```

- クイズ
  - テストケースをスキップしたい時は？
  - 特定のテストだけを実行したい時は？
  - jest実行時のNODE_ENVの値は？

# 課題5

https://github.com/jestjs/jest/network/dependents

- ソートができないぽいので意味ありそうなリポジトリは絞り込めない

https://github.com/facebook/react/tree/main

- さすがというかテスト数も多いし、コメントも必要なところにはありそうな感じ
- jestのconfigが見当たらない…どこでどうやって管理しているんだろう。設定周りが一番むずい。
- テストは[対象関数の近くに置く](https://legacy.reactjs.org/docs/codebase-overview.html#colocated-tests)スタイル
- beforeEachで[resetModules](https://jestjs.io/ja/docs/jest-object#jestresetmodules)してる（[例](https://github.com/facebook/react/blob/main/packages/react/src/__tests__/ReactChildren-test.js)）
- itとtestが混ざってる？
- テスト名は割としっかり書いてある
- expectが最後に来てて見やすい。AAAが守られている感？
- reactと言えど一つ一つのテストはそこまで複雑じゃない印象。少なくとも1画面には収まってそうな長さのものがほとんど。
