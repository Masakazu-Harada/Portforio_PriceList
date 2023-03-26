class RemoveColumnsFromSuppliers < ActiveRecord::Migration[7.0]
  def change
    remove_column :suppliers, :purchasing_cost, :integer
    remove_column :suppliers, :price_revision_date, :date
    remove_column :suppliers, :raise_price, :integer
    remove_column :suppliers, :minimum_shipping_unit, :integer
    remove_column :suppliers, :prepayshipping_unit, :integer
  end
end
