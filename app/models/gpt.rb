class Gpt < ApplicationRecord
    require 'openai'
  
    def get_response(system_prompt,prompt)
        client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
      
        response = client.chat(
            parameters: {
                model: "gpt-3.5-turbo",
                messages: [
                    { role: "system", content: system_prompt },
                    { role: "user", content: prompt }
                ],
            })
        return response.dig("choices", 0, "message", "content")
    end
  end