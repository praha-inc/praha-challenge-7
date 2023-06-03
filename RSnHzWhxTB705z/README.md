# hello PrAha Challenge

## Directories
.
├── praha_docker
│   ├── db
│   ├── web
│   │   └── Dockerfile
│   └── docker-compose.yml
├── www
│   ├── app
│   └── RSnHzWhxTB705z              // 公開ディレクトリ
└── README.md

## Docker
### 環境構築
http://blog.eszett-design.com/2022/01/docker-php-apache-mysql.html

### 起動
docker-compose up -d

### コンテナに入る
docker-compose exec サービス名 bash
#### MySQLの場所
- /var/lib/mysql/
#### error_logの場所
- /var/log/php/php_error.log

### 終了
docker-compose stop

### 終了&廃棄
docker-compose down

### 確認など
docker ps
docker ps -a
docker images

## .pumlを.svgに変換する
plantuml -tsvg foo.puml
