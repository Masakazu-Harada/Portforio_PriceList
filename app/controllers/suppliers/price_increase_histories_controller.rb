class Suppliers::PriceIncreaseHistoriesController < ApplicationController
  before_action :set_price_increase_history, only: [:destroy]
  
  def index
    @supplier = Supplier.find(params[:supplier_id])
    @products = @supplier.products
  end

  def destroy
    @price_increase_history.destroy
    product_name = @price_increase_history.product_supplier.product.name
    redirect_to supplier_price_increase_histories_path, notice: "#{product_name}のレコードの価格改定履歴を削除しました。"
  end

  private

  def set_price_increase_history
    @price_increase_history = PriceIncreaseHistory.find(params[:id])
  end

  def price_increase_history_params
    params.require(:price_increase_history).permit(:product_supplier_id, :price_revision_date, :old_cost, :new_cost)
  end
end
