class ChatsController < ApplicationController
    def create
        chat = Chat.new(chat_params)
        conversation = Conversation.find(chat.conversation_id)
        
        if (6..35).include?(current_user.id)
            api_key = chat_params[:api_key]
        else
            if conversation.model_id == 0
                api_key = ENV['OPENAI_API_KEY']
            elsif conversation.model_id == 1
                api_key = ENV['CLAUDE_API_KEY']
            else
                api_key = ENV['GEMINI_API_KEY']
            end
        end

        chat.response = chat.get_response(chat.system, chat.prompt, conversation.model_id, api_key)

        if conversation.chats.empty?
            conversation.title = chat.prompt[0, 10]
            conversation.save!
        end

        if chat.save!
            redirect_to conversation_path(chat.conversation_id)
        end
    end

    def show

    end

    def destroy_all
        conversation = Conversation.find(params[:conversation_id])
        Chat.where(conversation_id: conversation.id).destroy_all
        redirect_to conversation_path(conversation.id)
    end

    private

    def chat_params
        params.require(:chat).permit(:prompt, :system, :conversation_id, :api_key)
    end
end
