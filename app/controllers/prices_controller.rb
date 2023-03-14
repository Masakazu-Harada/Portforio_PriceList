class PricesController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @price = @product.prices.new
    @ranks = Rank.all
  end

  def create
  end

  def show
  end

  def update
  end

end
