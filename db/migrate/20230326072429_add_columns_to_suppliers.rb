class AddColumnsToSuppliers < ActiveRecord::Migration[7.0]
  def change
    add_column :suppliers, :address, :string
    add_column :suppliers, :phone_number, :string
    add_column :suppliers, :cost, :integer
    add_column :suppliers, :spec, :string
    add_column :suppliers, :shipping_unit, :integer
    add_column :suppliers, :unit, :string
    add_column :suppliers, :prepayment_unit, :integer
  end
end
