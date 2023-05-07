class RenamePriceIncreaseHistoryToCostIncreaseHistory < ActiveRecord::Migration[7.0]
  def change
    rename_table :price_increase_histories, :cost_increase_histories
  end
end
