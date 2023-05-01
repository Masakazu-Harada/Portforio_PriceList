class CreatePriceIncreaseHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :price_increase_histories do |t|
      t.references :product_supplier, null: false, foreign_key: true
      t.date :price_revision_date
      t.integer :previous_cost
      t.integer :new_cost

      t.timestamps
    end
  end
end
