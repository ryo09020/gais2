class Conversation < ApplicationRecord
    belongs_to :user
    has_many :chats, dependent: :destroy
    validates :title, presence: true

    # enum model_id: {chatgpt: 0, clude: 1, gemini: 2}
end
