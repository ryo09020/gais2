class CreateGpts < ActiveRecord::Migration[7.1]
  def change
    create_table :gpts do |t|

      t.text :prompt
      t.text :system
      t.text :response
      t.timestamps
    end
  end
end
