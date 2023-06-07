class CostIncreaseHistoriesController < ApplicationController
  before_action :set_product_supplier, only: [:new, :create, :edit, :update]

  def index
    @product_suppliers = ProductSupplier.includes(:product, :supplier, :cost_increase_histories).order("products.catalog_page_number asc").page(params[:page])
  end 

  def new
    @cost_increase_history = @product_supplier.cost_increase_histories.new
  end

  def create
    if @product_supplier.handle_cost_increase_history(cost_increase_history_params, current_user)
      redirect_to cost_increase_histories_path, notice: "仕入先#{@product_supplier.supplier.name}の#{@product_supplier.product.name}の仕入原価を登録しました。"
    else
      flash[:alert] = @product_supplier.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    @cost_increase_history = @product_supplier.cost_increase_histories.find(params[:id])
  end

  def update
    if @product_supplier.handle_cost_increase_history(cost_increase_history_params, current_user)
      redirect_to cost_increase_histories_path, notice: "仕入先#{@product_supplier.supplier.name}の#{@product_supplier.product.name}の仕入原価を更新しました。"
    else
      flash[:alert] = @product_supplier.errors.full_messages.join(", ")
      render :edit
    end
  end

  private

  def set_product_supplier
    @product_supplier = ProductSupplier.find(params[:product_supplier_id])
  end

  def cost_increase_history_params
    params.require(:cost_increase_history).permit(:current_cost, :cost_revision_date, :future_cost)
  end
end
