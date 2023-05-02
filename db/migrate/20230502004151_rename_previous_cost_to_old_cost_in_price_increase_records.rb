class RenamePreviousCostToOldCostInPriceIncreaseRecords < ActiveRecord::Migration[7.0]
  def change
    rename_column :price_increase_histories, :previous_cost, :old_cost
  end
end
