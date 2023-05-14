class RenamePriceRevisionDateToCostRevisionDateInCostIncreaseHistories < ActiveRecord::Migration[7.0]
  def change
    rename_column :cost_increase_histories, :price_revision_date, :cost_revision_date
  end
end
