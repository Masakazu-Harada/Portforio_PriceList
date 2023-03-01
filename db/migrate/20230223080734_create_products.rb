class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :code
      t.integer :catalog_page_number
      t.string :spec
      t.boolean :is_original

      t.timestamps
    end
  end
end
