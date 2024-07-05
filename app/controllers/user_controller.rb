class UserController < ApplicationController
  def show
    @pre_system = current_user.chats.last.system if current_user.chats.last.present?
    @conversations = Conversation.where(user_id: current_user.id)
    @chats = current_user.chats
  end
end
