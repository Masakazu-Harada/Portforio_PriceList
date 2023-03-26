class RenameProductSuppliersToCostPrices < ActiveRecord::Migration[7.0]
  def up
    rename_table :product_suppliers, :cost_prices
  end

  def down
    rename_table :cost_prices, :product_suppliers
  end
end
