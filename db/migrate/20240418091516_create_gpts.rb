class CreateGpts < ActiveRecord::Migration[7.1]
  def change
    create_table :gpts do |t|

      t.integer :user_id
      t.text :prompt
      t.text :system
      t.text :response
      t.text :messages
      t.timestamps
    end
  end
end
