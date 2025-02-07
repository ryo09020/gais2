
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

- ### 画面設計
     - [rootページ](https://gais.sb.ecei.tohoku.ac.jp/)
       アプリのtopページとしてログインをお願いするページ
     - aboutページ
       <img width="1352" alt="スクリーンショット 2025-01-05 21 16 09" src="https://github.com/user-attachments/assets/57ae2a67-f90b-4317-ba90-9a62b5a1c51d" />

       リリースノートを表示し、どのような更新が行われたかを確認できるページ

  ---
  --- ログイン後 ---
     - usersページ
     <img width="1363" alt="スクリーンショット 2025-01-05 21 03 00" src="https://github.com/user-attachments/assets/e54fea28-5ab8-4d0d-9c81-2ed89ca09009" />

   AIモデルを選択し、スレッドを作成、遷移することができるページ
     - conversation/idページ
       <img width="1369" alt="スクリーンショット 2025-01-05 21 18 13" src="https://github.com/user-attachments/assets/2fb34357-f2cc-4971-823f-e9359a5a693e" />

       スレッドページで各種AIと会話をすることができるページ

※東北大アカウントでのログイン時はAPIキーを入力するフィールドは存在しない
