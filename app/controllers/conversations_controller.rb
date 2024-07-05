class ConversationsController < ApplicationController
    def create
        conversation = Conversation.new(conversation_params)
        conversation.response = conversation.get_response(conversation.system, conversation.prompt)
        conversation.user_id = current_user.id
        if conversation.save
        redirect_to conversations_path
        end
    end

    def destroy
        Conversation.find(params[:id]).destroy
        redirect_to conversations_path
    end
    
    
    def destroy_all
        Conversation.where(user_id: current_user.id).destroy_all
        redirect_to conversations_path
    end
    
    
    private
    
    def conversation_params
        params.require(:conversation).permit(:prompt, :system)
    end
end
