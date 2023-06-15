class CostIncreaseHistoriesController < ApplicationController
  before_action :set_product_supplier, except: [:index]
  def index
    @q = ProductSupplier.joins(:product).ransack(params[:q])
    @product_suppliers = @q.result.includes(:product).order("products.name ASC")
  end

  def show
    @cost_increase_history = @product_supplier.cost_increase_histories.find(params[:id])
    @cost_increase_histories = @product_supplier.cost_increase_histories.order(cost_revision_date: :desc)
  end

  def new
    @cost_increase_history = @product_supplier.cost_increase_histories.new
  end

  def create
    if @product_supplier.handle_cost_increase_history_on_create(cost_increase_history_params, current_user)
      redirect_to cost_increase_histories_path, notice: "仕入先#{@product_supplier.supplier.name}の#{@product_supplier.product.name}の仕入原価を登録しました。"
    else
      flash[:alert] = @product_supplier.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    @cost_increase_history = @product_supplier.cost_increase_histories.find(params[:id])
    #@cost_increase_history = CostIncreaseHistory.find(params[:id])
  end

  def update
    if @product_supplier.handle_cost_increase_history_on_update(cost_increase_history_params, current_user)
      redirect_to cost_increase_histories_path, notice: "仕入先#{@product_supplier.supplier.name}の#{@product_supplier.product.name}の仕入原価を更新しました。"
    else
      flash[:alert] = @product_supplier.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    @cost_increase_history = @product_supplier.cost_increase_histories.find(params[:id])
    @cost_increase_history.destroy
    
      # レコードが全て削除されたらindexページにリダイレクト
    if @product_supplier.cost_increase_histories.empty?
      redirect_to cost_increase_histories_path, notice: "全ての履歴を削除しました。"
    else
      # 最新の履歴レコードにリダイレクト
    @latest_cost_increase_history = @product_supplier.cost_increase_histories.order(cost_revision_date: :desc).first
      redirect_to product_product_supplier_cost_path(@latest_cost_increase_history.product_supplier.product, @latest_cost_increase_history.product_supplier, @latest_cost_increase_history), notice: "履歴を削除しました。"
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
