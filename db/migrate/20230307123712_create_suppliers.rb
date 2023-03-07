class CreateSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.integer :purchasing_cost
      t.date :price_revision_date
      t.integer :raise_price
      t.integer :minimum_shipping_unit
      t.integer :prepayshipping_unit
      t.string :location
      t.string :closing_time
      t.string :note

      t.timestamps
    end
  end
end
