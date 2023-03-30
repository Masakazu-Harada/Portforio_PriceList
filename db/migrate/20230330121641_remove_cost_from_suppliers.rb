class RemoveCostFromSuppliers < ActiveRecord::Migration[7.0]
  def change
    remove_column :suppliers, :cost, :integer
  end
end
