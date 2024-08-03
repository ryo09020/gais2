class Chat < ApplicationRecord
    belongs_to :conversation
    validates :prompt, presence: true
   
      
    def get_response(system_prompt, prompt, model_id)
        messages = JSON.parse(self.conversation.talk_history || '[]')
        messages << { role: "user", content: prompt }
    
        message_content = case model_id
        when 0
        get_openai_response(system_prompt, messages)
        when 1
        get_anthropic_response(system_prompt, messages)
        else
        get_gemini_response(prompt, messages)
        end
    
        messages << { role: "assistant", content: message_content }
        self.conversation.update(talk_history: messages.to_json)
    
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
    
    

    def get_gemini_response(system_prompt, messages)
        require 'net/http'
        require 'uri'
        require 'json'

        # APIエンドポイントとリクエストURL
        uri = URI.parse("https://generativelanguage.googleapis.com/v1beta3/models/gemini-1.5-pro-001:generateText?key=#{ENV['GEMINI_API_KEY']}")
        # HTTPリクエストの設定
        request = Net::HTTP::Post.new(uri)
        request["Content-Type"] = "application/json"
        request["system_instruction"] = system_prompt
        
        
        # リクエストボディの設定
        request.body = JSON.dump({
            "prompt" => {
            "text" => prompt,
            }
        })

        # リクエストを送信してレスポンスを取得
        http = Net::HTTP.new(uri.hostname, uri.port)
        http.use_ssl = true
        response = http.request(request)

        # レスポンスを表示
        
        puts "Response Code: #{response.code}"
        puts "Response Body: #{response.body}"
        puts 11111111
        # レスポンスの内容を出力
        response_json = JSON.parse(response.body)
        output = response_json.dig('candidates', 0, 'output')

        output
    end
end