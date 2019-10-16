# API Server

## Setup

### Docker イメージのビルド

```sh
docker-compose build
```

### .env ファイルを用意する

環境変数を設定する .env ファイルをコピーする。ミドルウェア(データベース)を Docker で実行していれば、それぞれコピーするだけで動くようになる。

```sh
cp .env.sample .env
```

### マイグレーションを実行する

以下のコマンドを実行して特にエラーがでないことを確認する。

```sh
docker-compsoe run --rm api_server bundle exec rake db:create db:migrate
```

### Docker コンテナの立ち上げ

```sh
docker-compose up -d
```

### 開発環境用にVoluemマウントする

`docker-compose.override.sample.yml` というファイルを用意しているので、これを `docker-compose.override.yml` にリネームすることで、ホストのディレクトリをマウントすることができる。

```sh
cp docker-compose.override.sample.yml docker-compose.override.yml
docker-compose up -d
```
