class RemoveSupplierIdFromRanks < ActiveRecord::Migration[7.0]
  def change
    remove_column :ranks, :supplier_id, :integer
  end
end
