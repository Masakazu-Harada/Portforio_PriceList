class PriceListsController < ApplicationController
  def index
    @q = Customer.ransack(params[:q])
    @customers = @q.result
  end

  def show
    @q = Product.ransack(params[:q])
    @products = @q.result.order(:catalog_page_number)
    @customer = Customer.find(params[:id])

    if params[:q].present?
      @products = @products.where("name LIKE ?", "%#{params[:q][:name]}%")
    end
  end
end
