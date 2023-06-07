class AddFutureCostAndCostIncreaseDateToProductSuppliers < ActiveRecord::Migration[7.0]
  def change
    add_column :product_suppliers, :future_cost, :integer
    add_column :product_suppliers, :cost_increase_date, :date
  end
end
