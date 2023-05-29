class ChangeCostIncreaseHistories < ActiveRecord::Migration[6.0]
  def change
    remove_column :cost_increase_histories, :future_cost, :integer
    rename_column :cost_increase_histories, :new_cost, :current_cost
  end
end
