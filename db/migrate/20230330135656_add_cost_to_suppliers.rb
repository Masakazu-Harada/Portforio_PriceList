class AddCostToSuppliers < ActiveRecord::Migration[7.0]
  def change
    add_column :suppliers, :cost, :integer
  end
end
