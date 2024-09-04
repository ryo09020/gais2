# ベースイメージを指定
FROM ruby:3.2.2

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# アプリケーションディレクトリを作成
WORKDIR /gais


# GemfileとGemfile.lockをコピーしてbundle installを実行
COPY Gemfile /gais/Gemfile
COPY Gemfile.lock /gais/Gemfile.lock
RUN bundle install

# アプリケーションコードをコピー
COPY . /gais

# アセットをプリコンパイル
RUN bundle exec rails assets:precompile RAILS_ENV=production

# Railsサーバーの起動時に使用するポート番号を指定
ENV PORT 8080

# ポート8080を公開
EXPOSE 8080

# Puma サーバーを起動するためのコマンド
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
