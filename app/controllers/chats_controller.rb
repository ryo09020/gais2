class ChatsController < ApplicationController
    def create
        chat = Chat.new(chat_params)
        conversation = Conversation.find(chat.conversation_id)
        chat.response = chat.get_response(chat.system, chat.prompt, conversation.model_id)
        
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
        params.require(:chat).permit(:prompt, :system, :conversation_id)
    end
end
