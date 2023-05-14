class AddDetailsToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :carton, :integer
    add_column :products, :unit, :string
    add_column :products, :is_separate, :boolean, default: false
    add_column :products, :location, :string
    add_column :products, :due_date, :string
    add_column :products, :same_day_shipping, :boolean, default: false
    add_column :products, :shipping_rate, :string
    add_column :products, :hokkaido_shipping_rate, :string
    add_column :products, :notes, :string
    add_column :products, :prepayment, :string
    add_column :products, :integer, :string
  end
end
