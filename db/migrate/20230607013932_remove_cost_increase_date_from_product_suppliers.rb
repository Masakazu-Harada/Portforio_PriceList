class RemoveCostIncreaseDateFromProductSuppliers < ActiveRecord::Migration[7.0]
  def change
    remove_column :product_suppliers, :cost_increase_date
  end
end
