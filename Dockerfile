# ベースイメージを指定
FROM ruby:3.2.2

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# アプリケーションディレクトリを作成
WORKDIR /gais

ENV RAILS_ENV production

# GemfileとGemfile.lockをコピーしてbundle installを実行
COPY Gemfile /gais/Gemfile
COPY Gemfile.lock /gais/Gemfile.lock
RUN bundle install

# アプリケーションコードをコピー
COPY . /gais

# BuildKit を使ってシークレットをマウント
RUN --mount=type=secret,id=master_key,target=config/master.key,required=true \
    bundle exec rails assets:precompile


# Railsサーバーの起動時に使用するポート番号を指定
ENV PORT 8080

# ポート8080を公開
EXPOSE 8080

# Puma サーバーを起動するためのコマンド
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
