# ベースイメージを指定
FROM ruby:3.2.2

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# アプリケーションディレクトリを作成
RUN mkdir /myapp
WORKDIR /myapp

# 環境変数を設定
# ENV RAILS_ENV=production



# GemfileとGemfile.lockをコピーしてbundle installを実行
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# アプリケーションコードをコピー
COPY . /myapp

# ポート3000を公開
EXPOSE 8080

# Puma サーバーを起動するためのコマンド
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
