class UsersController < ApplicationController
    

    def show
        @new_conversation = Conversation.new
        @conversations = Conversation.where(user_id: current_user.id)
    end
end
