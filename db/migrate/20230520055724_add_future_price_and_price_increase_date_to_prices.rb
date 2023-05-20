class AddFuturePriceAndPriceIncreaseDateToPrices < ActiveRecord::Migration[7.0]
  def change
    add_column :prices, :future_price, :integer
    add_column :prices, :price_increase_date, :date
  end
end
