class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices do |t|
      t.references :product, null: false, foreign_key: true
      t.references :rank, null: false, foreign_key: true
      t.integer :price

      t.timestamps
    end
  end
end
