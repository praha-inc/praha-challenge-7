# docker mysql環境構築
1. mysql_text_env直下で以下のコマンドを実行
```
docker compose up -d
```
2. DBeaverをインストール  
https://dbeaver.io/
3. DBeaverの左上の`新しい接続`をクリック
4. 接続設定
    1. MySqlを選択
    2. 以下の値をセットして接続テストをクリック。問題なければOKをクリック。  
    Server Host: localhost  
    Port: 3306  
    Database: db_modeling  
    ユーザー名: root  
    パスワード: root

