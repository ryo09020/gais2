class User < ApplicationRecord

  has_many :conversations, dependent: :destroy
  has_many :chats, through: :conversations  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
