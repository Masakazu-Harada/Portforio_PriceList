class SetNotNullConstraintOnUserIdInCostIncreaseHistories < ActiveRecord::Migration[7.0]
  def change
    change_column_null :cost_increase_histories, :user_id, false
  end
end
