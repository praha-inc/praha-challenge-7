# データベース設計のアンチパターンを学ぶ9

## 課題1

- Check制約
    - 使わないほうが良い
        - check制約で許容するドメインを指定している場合、変更が大変だったり、DBを見ないと許容されているドメインの一覧がわからないため
        - ドメインマスタを作成し、そちらで許容するドメインを管理するのが良いと思う。check制約はマスタに対してであれば使用して良い思う。アプリでドメインマスタをSELECTし、許容しないドメインはINSERT前にバリデーションで弾くのが良いのではないか

- Trigger
    - 使わないほうが良い
        - DBはあくまでもデータの入れ物として扱うほうが、アプリとデータを疎結合にできるため
            - 問題発生時にどこにアプローチするかが見えやすそう
            - 開発の効率も、SQLではなく、プログラミング言語で行ったほうが良さそう（オブジェクト指向やデザインパターン、テスト、デバッグ、IDEなどが使えるため）

- Enum
    - 使わないほうが良い
        - check制約と同じだが、male を man に変える場合など変更が大変だったり、DBを見ないと許容されているドメインの一覧がわからないため
        - これも性別マスタを作成し、そちらでcheck制約と合わせ許容する値を管理するのが良さそう
    - left, right, front, back など、候補が変更される可能性のないものについてはENUM型を使って良い（積極的に使う必要はないとも思う）
    
- Domain
    - 使ったほうが良い
        - 「特定の文字列」であればマスタを作ってそちらで管理するべきだと思うが、「特定形式の文字列」では、格納する値の形式を制限することができるため、使ったほうが良いと思う
    
- 制約をアプリケーション側で課すかデータベース側で課すか
    - アプリケーション側
        - ロジックが絡む場合
    - データベース側
        - 格納する値に制限をかけたい場合（マスタを利用する）
        - 格納する値の形式に制限をかけたい場合
        - データの整合性を保つような制約を課す場合（ユニーク制約や外部キー制約など）

## 課題2

- なし

## 課題3

- データの定義や持ち方全般についての問題なので、あらゆるサービスの開発で発生しうるアンチパターンだと思う
- 有料会員サービスを開発すると仮定する
    - クーポンをいくつか発行しているとして、登録時に使用できるのは特定の文字列（接頭辞がintroなど）が含まれているクーポンのみと制限する場合
    - member テーブルに gender カラムを持ち、「male」「female」「no response」が入る想定の場合
k