class RenameProductSupplierColumns < ActiveRecord::Migration[7.0]
  def change
    rename_column :product_suppliers, :cost, :current_cost
    rename_column :product_suppliers, :raise_cost, :future_cost
  end
end
