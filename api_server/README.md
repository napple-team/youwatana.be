# API Server

## Setup

### データベースを立ち上げる

データベースなどのミドルウェア群のみが Docker 上で実行される。

```sh
docker-compose up -d database
```

### .env ファイルを用意する

環境変数を設定する .env ファイルをコピーする。ミドルウェア(データベース)を Docker で実行していれば、それぞれコピーするだけで動くようになる。

```sh
# for RAILS_ENV=test
cp dot.env.test .env.test

# for RAILS_ENV=development
cp dot.env.development .env.development
```

### Install Gems

```sh
bundle install
```

### マイグレーションを実行する

以下のコマンドを実行して特にエラーがでないことを確認する。

```sh
# for RAILS_ENV=test
bundle exec rake db:create db:migrate RAILS_ENV=test

# for RAILS_ENV=development
bundle exec rake db:create db:migrate
```
