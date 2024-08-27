# ベースイメージを指定
FROM ruby:3.2.2

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# アプリケーションディレクトリを作成
WORKDIR /myapp

# 環境変数を設定
# ENV RAILS_ENV=production
# master.key を Docker イメージにコピー
COPY config/master.key /myapp/config/master.key
# credentials.yml.enc を Docker イメージにコピー
COPY config/credentials.yml.enc /myapp/config/credentials.yml.enc



# GemfileとGemfile.lockをコピーしてbundle installを実行
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# アプリケーションコードをコピー
COPY . /myapp


# アセットをプリコンパイル
RUN bundle exec rails assets:precompile

# Railsサーバーの起動時に使用するポート番号を指定
ENV PORT 8080

# ポート8080を公開
EXPOSE 8080

# サーバーを起動。Cloud Runが提供するPORT環境変数を使用
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "${PORT}"]
