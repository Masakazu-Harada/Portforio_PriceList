class PricesController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @price = @product.prices.new
  end

  def create
  end

  def show
  end

  def update
  end
end
