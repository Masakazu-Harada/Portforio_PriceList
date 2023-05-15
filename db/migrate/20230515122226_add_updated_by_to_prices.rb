class AddUpdatedByToPrices < ActiveRecord::Migration[7.0]
  def change
    add_column :prices, :updated_by, :integer
  end
end
