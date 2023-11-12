## 課題1

- クエリが複雑化する
    - 検索時に必ず削除フラグのWHERE句が入る
- UNIQUE KEYが使えなくなる
    deleteフラグで削除後、同じデータを新たに投入した場合、UNIQUE KEYを貼れなくなるカラムが発生してしまう
- カーディナリティが低くなる

## 課題2

## 課題3
物理削除で注意する点は以下です
- 取り消し処理を復活させたいニーズがある場合は論理削除を採用する
- 削除対象のレコードが他のテーブルと関連している場合、参照整合性に関連する問題が発生する可能性があるため考慮が必要
- 削除処理が途中で失敗した場合でもロールバックできるようにトランザクションを管理する
- データベースのロックが発生し、他のクエリの実行に影響を与える可能性があるため実行タイミングの考慮が必要