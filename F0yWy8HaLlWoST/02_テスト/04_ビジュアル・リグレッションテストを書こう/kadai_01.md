# 課題 1

test-runner にて実装
https://github.com/kzk4043/react_tutorial/tree/feat/vrt

# 課題 2

- ビジュアルリグレッションテストのメリット
  - 実際の見た目で比較できる（ブラウザ差異、グローバルスタイルによる差異なども検出可）
- スナップショットテストのメリット
  - 早い、軽い、安定
  - 設定が簡単
  - 空の余計な DOM が追加されたとかも検知できる。あとはアクセシビリティ系の変更も場合によっては検知できるかも？

# 課題 3

- リグレッションテストとはなにか
  - regression = デグレ。プログラムの一部分を変更したことで、ほかの箇所に不具合が出ていないかを確認するためのテストのこと。ビジュアルリグレッションテストは、リグレッションテストをビジュアル（画像）によって行うもの。
- ビジュアルリグレッションテストの現時点での代表的な構成例
  - storybook + chromatic
  - storybook/test-runner
  - storycap + reg-suit
  - playwright
- 各実装者の環境でビジュアルリグレッションテストの差分が出た場合に、それを承認してもいいかどうかの判定の場はどのように作るのがよいか
  - chromatic を使う。承認プロセスまで容易されているが、お金がかかる
  - diff ファイルごと一旦 github にアップしてレビュする（-u オプションで更新前に一旦レビュする）。それなりに機能しそうだが、承認後に-u オプションによる更新プロセスが必要で少し混乱があるかも？
  - storycap + reg-suit で頑張って設定する。[この辺](https://zenn.dev/loglass/articles/visual-regression-testing-comparison#1.-reg-suit-%2B-storycap)
  - playwright でがんばる。[この辺](https://zenn.dev/loglass/articles/visual-regression-testing-comparison#3.-playwright)。まだ機能としては微妙？
