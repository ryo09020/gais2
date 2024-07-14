class Chat < ApplicationRecord
    belongs_to :conversation
    validates :prompt, presence: true

    

    
    def get_response(system_prompt, prompt, model_id)
        
        @messages = JSON.parse(self.conversation.talk_history || '[]')
        
        
        # ユーザーメッセージを追加
        @messages << { role: "user", content: prompt }
        
        # システムプロンプトとユーザーメッセージを結合してリクエストを作成
        request_messages = [{ role: "system", content: system_prompt }] + @messages


        if model_id == 0

            require 'openai'

            client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
            response = client.chat(
                parameters: {
                model: "gpt-3.5-turbo",
                messages: request_messages,
                }
            )

            message_content = response.dig("choices", 0, "message", "content")
        
        elsif model_id == 1

            require "anthropic"

            client = Anthropic::Client.new(access_token: ENV['CLAUDE_API_KEY'])

            response = client.messages(
                parameters: {
                model: "claude-3-haiku-20240307", 
                messages: request_messages
                }
            )
            message_content = response["content"].first["text"]

        elsif model_id == 2

        end
        
        # アシスタントの応答を追加
        @messages << { role: "assistant", content: message_content }
        
        
        # 会話履歴を親モデル（conversation）に保存
        self.conversation.update(talk_history: @messages.to_json)
        return message_content
    end
end
