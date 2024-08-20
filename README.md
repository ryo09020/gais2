
markdown
# アプリケーションのセットアップ

## 必要な環境
このアプリケーションを動作させるには、以下の環境が必要です。

- Docker
- Docker Compose

## セットアップ手順

1. Dockerコンテナのビルド:
   ```bash
   docker-compose build
   ```

2. アプリケーションの起動:
   ```bash
   docker-compose up
   ```

3. `.env`ファイルの作成:
   `.env`ファイルをプロジェクトのルートディレクトリに作成し、以下のAPIキーを設定します。

   ```plaintext
   OPENAI_API_KEY=<Your OpenAI API Key>
   CLAUDE_API_KEY=<Your Claude API Key>
   GEMINI_API_KEY=<Your Gemini API Key>
   GOOGLE_CLIENT_ID=<Your Google Client ID>
   GOOGLE_CLIENT_SECRET=<Your Google Client Secret>
   ```

4. Google APIの設定:
   - `omniauth-oauth2` を利用して、Google Cloud Platform (GCP) 上でAPIを設定する必要があります。

## 基本機能

- **認証**:
  - 組織内のGoogleアカウントのみログインが可能です。
  - （現在は手動でサインアップできる機能もありますが、将来的に削除される可能性があります。）

- **AIとの対話**:
  - ログイン後、以下の3種類のAIと対話が可能です:
    1. ChatGPT
    2. Gemini（継続的な会話はできません）
    3. Claude

これでアプリケーションが立ち上がり、使用可能になります。
```

