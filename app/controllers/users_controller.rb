class UsersController < ApplicationController
    

    def show
        @new_conversation = Conversation.new
        @conversations = Conversation.where(user_id: current_user.id)
    end

    def destroy
        User.find(params[:id]).destroy
    end
end
