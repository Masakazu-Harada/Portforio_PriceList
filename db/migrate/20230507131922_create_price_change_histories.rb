class CreatePriceChangeHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :price_change_histories do |t|
      t.references :price, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :old_price
      t.integer :new_price
      t.date :change_price_date

      t.timestamps
    end
  end
end
