# 課題１

> これからお伝えする仕様をもとにモデル図を作成してみてください。

[ドメインモデル図.dio](./ドメインモデル図.dio)

[ユースケース図.dio](./ユースケース図.dio)

Draw.io を使っています。

お手数ですが、

VSCode の拡張機能

「Draw.io Integration」
ID:hediet.vscode-drawio

をインストールして頂くと見やすいかもです。

環境を汚したくない場合、

https://app.diagrams.net/

↑ こちらにファイルをアップロードしたら見れます。

# 課題２

> 上記の課題で作成したモデル図を元に API サーバを node.js+TypeScript で「オニオンアーキテクチャ」に沿って実装してください

こちらです。
https://github.com/sutefu23/praha-ddd

```
├── controller 　コントローラー層
├── domain 　ドメイン層
│ ├── entity 　エンティティ
│ │ ├── base 　エンティティ基底クラス
│ │ └── collection 　エンティティ集合
│ ├── error 　エラーオブジェクト
│ ├── interface 　ドメイン層インターフェース
│ ├── mock 　　　テストモック
│ ├── service 　　ドメインサービス層
│ ├── usecase 　　ドメインユースケース
│ └── valueObject 　バリューオブジェクト
│ └── base 　バリューオブジェクト基底クラス
├── infra 　インフラ層
│ ├── api 　外部 API 関連実装
│ └── prisma 　プリズマ実装
└── util 　ユーティリティ関数
```

# 課題３

> 上記の仕様を満たすサーバサイドのアプリケーションが完成したら、ペアとレビューをしてください

またやりましょう。
