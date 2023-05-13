class RenamePriceRevisionDateInProductSuppliers < ActiveRecord::Migration[7.0]
  def change
    rename_column :product_suppliers, :price_revision_date, :cost_revision_date
  end
end
