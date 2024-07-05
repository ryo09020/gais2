class CreateConversations < ActiveRecord::Migration[7.1]
  def change
    create_table :conversations do |t|

      t.integer :user_id
      t.text :talk_history
      t.timestamps
    end
  end
end
