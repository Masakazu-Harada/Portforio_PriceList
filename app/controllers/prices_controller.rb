class PricesController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
  end

  def create
    @product = Product.find(params[:product_id])
    params['price'].each do |price_record|
      price = @product.prices.find_by(rank_id: price_record['rank_id'])
      price.price = price_record['price']
      price.save
    end
    redirect_to products_url
  end

  def show
  end

  def update
  end

end
