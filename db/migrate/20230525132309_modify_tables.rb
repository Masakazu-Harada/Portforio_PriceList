class ModifyTables < ActiveRecord::Migration[6.0]
  def change
    remove_column :product_suppliers, :current_cost
    remove_column :product_suppliers, :cost_revision_date
    remove_column :product_suppliers, :future_cost

    add_column :cost_increase_histories, :future_cost, :integer
  end
end
