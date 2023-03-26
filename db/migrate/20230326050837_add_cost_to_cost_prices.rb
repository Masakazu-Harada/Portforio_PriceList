class AddCostToCostPrices < ActiveRecord::Migration[7.0]
  def change
    add_column :cost_prices, :cost, :integer
  end
end
