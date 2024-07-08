class Chat < ApplicationRecord
    belongs_to :conversation

    validates :prompt, presence: true

    require 'openai'

    
    def get_response(system_prompt, prompt)
        client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
        
        @messages = JSON.parse(self.conversation.talk_history || '[]')

        
        puts "system_prompt: #{system_prompt}"
        puts "prompt: #{prompt}"

        
        
        # ユーザーメッセージを追加
        @messages << { role: "user", content: prompt }

        # システムプロンプトとユーザーメッセージを結合してリクエストを作成
        request_messages = [{ role: "system", content: system_prompt }] + @messages

        response = client.chat(
            parameters: {
            model: "gpt-3.5-turbo",
            messages: request_messages,
            }
        )

        message_content = response.dig("choices", 0, "message", "content")
        
        # アシスタントの応答を追加
        @messages << { role: "assistant", content: message_content }
        
        
        # 会話履歴を親モデル（conversation）に保存
        self.conversation.update(talk_history: @messages.to_json)
        return message_content
    end
end
