class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.references :rank, null: false, foreign_key: true
      t.string :name
      t.text :share

      t.timestamps
    end
  end
end
