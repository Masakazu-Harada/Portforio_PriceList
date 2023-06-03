class RemoveOldCostFromCostIncreaseHistories < ActiveRecord::Migration[7.0]
  def change
    remove_column :cost_increase_histories, :old_cost, :integer
  end
end
