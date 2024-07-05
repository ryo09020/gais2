class ChatsController < ApplicationController
    def create
        chat = Chat.new(chat_params)
        chat.response = chat.get_response(chat.system, chat.prompt)
        chat.user_id = current_user.id
        if chat.save
            redirect_to chats_path
        end
    end

    def destroy_all
        Chat.where(user_id: current_user.id).destroy_all
        redirect_to chats_path
    end

    private

    def chat_params
        params.require(:chat).permit(:prompt, :system)
    end
end
