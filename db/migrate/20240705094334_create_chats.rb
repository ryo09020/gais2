class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats do |t|

      t.integer :conversation_id
      t.text :system
      t.text :prompt
      t.text :response
      t.timestamps
    end
  end
end
