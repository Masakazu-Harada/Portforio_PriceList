class AddSupplierIdToRanks < ActiveRecord::Migration[7.0]
  def change
    add_reference :ranks, :supplier, null: false, foreign_key: true
  end
end
