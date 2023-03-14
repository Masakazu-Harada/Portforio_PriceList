class PricesController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @price = @product.prices.new(price_params)
  end

  def create
  end

  def show
  end

  def update
  end

  private

  def price_params
    params.require(:price).permit(:price)
  end
end
