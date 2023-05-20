class AddUserIdToPrices < ActiveRecord::Migration[7.0]
  def change
    add_column :prices, :user_id, :integer
    add_column :prices, :created_by, :integer
    add_index :prices, :user_id
    add_index :prices, :created_by
  end
end
