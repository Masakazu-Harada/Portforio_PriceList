class AddPriceRevisionDateAndRaiseCostToProductSuppliers < ActiveRecord::Migration[7.0]
  def change
    add_column :product_suppliers, :price_revision_date, :date
    add_column :product_suppliers, :raise_cost, :integer
  end
end
