class ChangeCloumnsNotnullAddProducts < ActiveRecord::Migration[7.0]
  def change
    change_column :products, :is_original, :boolean, default: false, null: false
  end
end
