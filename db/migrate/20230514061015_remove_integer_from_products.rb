class RemoveIntegerFromProducts < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :integer, :string
  end
end
