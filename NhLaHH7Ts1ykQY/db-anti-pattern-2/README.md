## 課題1
一つのカラム内にカンマ区切りで格納する設計は以下のような問題があります。

- 値の検索が非常に難しくなる
    - 全てのカラムをOR条件で繋がなければヒットしない
    - 複数のカラムを検索する際にはさらにANDで指定する
- 値の追加が非常に難しくなる
    - 値追加時にそのカラムがNULLかどうかを判定しなければならない

## 課題2
ER図参照

## 課題3
- 書籍管理サービスの本のタグ機能