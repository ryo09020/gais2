class ChatsController < ApplicationController
    def create
        chat = Chat.new(chat_params)
        
        
        chat.response = chat.get_response(chat.system, chat.prompt)
        
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
        params.require(:chat).permit(:prompt, :system, :conversation_id)
    end
end
