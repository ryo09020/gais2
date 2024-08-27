# ベースイメージを指定
FROM ruby:3.2.2

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# アプリケーションディレクトリを作成
RUN mkdir /myapp
WORKDIR /myapp

# GemfileとGemfile.lockをコピーしてbundle installを実行
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# アプリケーションコードをコピー
COPY . /myapp

# ポート3000を公開
EXPOSE 8080

# サーバーを起動
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "8080"]
