class AddUserIdToCostIncreaseHistories < ActiveRecord::Migration[7.0]
  def change
    add_reference :cost_increase_histories, :user, null: true, foreign_key: true
  end
end
