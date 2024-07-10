class Gpt < ApplicationRecord
    require 'openai'

    # 初期化時に会話履歴を読み込む
    def initialize(attributes = {})
        super(attributes)
        @messages = JSON.parse(self.messages || '[]')
    end

    def get_response(system_prompt, prompt)
        client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
        
        # システムメッセージを追加（最初のみ）
        if @messages.empty?
        @messages << { role: "system", content: system_prompt }
        end
        
        # ユーザーメッセージを追加
        @messages << { role: "user", content: prompt }

        response = client.chat(
        parameters: {
            model: "gpt-3.5-turbo",
            messages: @messages,
        }
        )

        message_content = response.dig("choices", 0, "message", "content")
        
        # アシスタントの応答を追加
        @messages << { role: "assistant", content: message_content }
        
        
        # 会話履歴をデータベースに保存
        self.update(messages: @messages.to_json)

        return message_content
    end
end
