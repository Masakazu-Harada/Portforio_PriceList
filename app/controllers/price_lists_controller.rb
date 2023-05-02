class PriceListsController < ApplicationController
  def index
    @q = Customer.ransack(params[:q])
    @customers = @q.result
  end

  def show
    @customer = Customer.find(params[:id])
    @products = Product.order(:catalog_page_number)
  end
end
