class CustomerPriceListsController < ApplicationController
  before_action :set_rank


  def index
    @q = Product.ransack(params[:q])
    @products = @q.result.order(:catalog_page_number)

    if params[:q].present?
      @products = @products.where("name LIKE ?", "%#{params[:q][:name]}%")
    end
  end


  def show
    @product = Product.includes(:prices).find(params[:id])
  end

  private

  def set_rank
    @rank = current_user.customer.rank if current_user.present?
  end
end
