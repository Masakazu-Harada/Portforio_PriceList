class RenameCreatedByAndUpdateByInPrices < ActiveRecord::Migration[7.0]
  def change
    rename_column :prices, :created_by, :created_by_user_id
    rename_column :prices, :updated_by, :updated_by_user_id
  end
end
