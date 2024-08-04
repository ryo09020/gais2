class Chat < ApplicationRecord
    belongs_to :conversation
    validates :prompt, presence: true
   
      
    def get_response(system_prompt, prompt, model_id)
        messages = JSON.parse(self.conversation.talk_history || '[]')
        if model_id == 2
            messages << { role: "user", content: prompt }
            message_content = get_gemini_response(system_prompt,prompt, messages)

        else
            messages << { role: "user", content: prompt }
            message_content = case model_id
            when 0
            get_openai_response(system_prompt, messages)
            else
            get_anthropic_response(system_prompt, messages)
            end
            messages << { role: "assistant", content: message_content }
            self.conversation.update(talk_history: messages.to_json)
        end

        message_content
    end
    
    private
    
    def get_openai_response(system_prompt, messages)
        client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
        request_messages = messages + [{ role: "system", content: system_prompt }]
        response = client.chat(
        parameters: {
            model: "gpt-4o",
            messages: request_messages,
        }
        )
        response.dig("choices", 0, "message", "content")
    end
    
    def get_anthropic_response(system_prompt, messages)
        client = Anthropic::Client.new(access_token: ENV['CLAUDE_API_KEY'])
        response = client.messages(
        parameters: {
            model: "claude-3-5-sonnet-20240620",
            system: system_prompt,
            messages: messages,
            max_tokens: 1000
        }
        )
        response["content"].first["text"]
    end
    
    

    def get_gemini_response(system_prompt, prompt,messages)
        require 'net/http'
        require 'uri'
        require 'json'

        # APIエンドポイントとリクエストURL
        uri = URI.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-001:generateContent?key=#{ENV['GEMINI_API_KEY']}")
        # HTTPリクエストの設定
        request = Net::HTTP::Post.new(uri)
        request["Content-Type"] = "application/json"
        
        
        # リクエストボディの設定
        request.body = {
            "contents": [
            {
                "parts": [
                {
                    "text": prompt,
                }
                ]
            }
            ],
            "systemInstruction": {
                "parts": [
                {
                    "text": system_prompt,
                }
                ]
            },
        }.to_json

        # リクエストを送信してレスポンスを取得
        http = Net::HTTP.new(uri.hostname, uri.port)
        http.use_ssl = true
        response = http.request(request)

        # レスポンスを表示
        
        puts "Response Code: #{response.code}"
        puts "Response Body: #{response.body}"
        
        # レスポンスの内容を出力
        response_json = JSON.parse(response.body)
        text_value = response_json["candidates"][0]["content"]["parts"][0]["text"]
        text_value
    end
end