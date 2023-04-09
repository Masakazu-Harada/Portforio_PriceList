class PriceListsController < ApplicationController
  def index
    @q = Customer.ransack(params[:q])
    @customers = @q.result
  end

  def show
    @customer = Customer.find(params[:id])
    @products = Product.all
  end
end
