# 課題 1

レビュ不要
https://github.com/kzk4043/react_tutorial/tree/main

# 課題 2

https://github.com/kzk4043/react_tutorial/tree/main/src/stories/App

# 課題 3

- メリット
  - 適切に分離されたコンポーネントなら、独立して表示確認ができる
  - コンポーネントテストもできる
  - テスタブルなコードを書きやすい
  - コンポーネントの Docs みたいなやつができてて便利
- デメリット
  - 環境構築でつまずきがち
  - 書く工数。コンポーネントごとにファイル分けるのめんどくさい。
  - メンテナンスが大変

# 課題 4

- storybook における arguments と parameters の違い
  - arguments: story の引数などを設定するためのもの
  - parameters: story の背景色など、ストーリーブックの機能やアドオンの動作を制御するためのもの
- storybook において、ユーザアクションのテストをする方法
  - play function(実質 Testing Library?)を使ってユーザアクションを定義し、test-runner 等を使って表示チェック
- arguments などほとんどのものが設定できる 3 つのレベルは？（ちょっと聞き方が悪くてすみません）
  - ほとんどの設定類が、下記 3 つのレベルで設定できる。
    - story 単位
    - component（1 ファイル）単位
    - global（stories 全体）単位
