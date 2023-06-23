class ChangeLocationInProducts < ActiveRecord::Migration[7.0]
  def up
    remove_column :products, :location
    add_column :products, :location, :integer, default: 12
  end
  
  def down
    remove_column :products, :location
    add_column :products, :location, :string
  end
end
