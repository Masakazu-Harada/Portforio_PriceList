class AddCostToProductSuppliers < ActiveRecord::Migration[7.0]
  def change
    add_column :product_suppliers, :cost, :integer
  end
end
