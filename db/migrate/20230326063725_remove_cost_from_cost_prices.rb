class RemoveCostFromCostPrices < ActiveRecord::Migration[7.0]
  def change
    remove_column :cost_prices, :cost, :integer
  end
end
