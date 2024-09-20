class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable,
       :timeoutable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :conversations, dependent: :destroy
  has_many :chats, through: :conversations  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      # user.name = auth.info.name   # Assuming the user model has a name
      # user.image = auth.info.image # Assuming the user model has an image
    end
  end
end
