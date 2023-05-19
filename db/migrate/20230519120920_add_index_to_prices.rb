class AddIndexToPrices < ActiveRecord::Migration[7.0]
  def change
    add_index :prices, [:product_id, :rank_id], unique: true
  end
end
