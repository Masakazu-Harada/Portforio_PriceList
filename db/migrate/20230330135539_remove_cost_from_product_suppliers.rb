class RemoveCostFromProductSuppliers < ActiveRecord::Migration[7.0]
  def change
    remove_column :product_suppliers, :cost, :integer
  end
end
