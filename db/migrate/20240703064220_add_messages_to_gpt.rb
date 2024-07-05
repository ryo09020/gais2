class AddMessagesToGpt < ActiveRecord::Migration[7.1]
  def change
    add_column :gpts, :messages, :text
  end
end
