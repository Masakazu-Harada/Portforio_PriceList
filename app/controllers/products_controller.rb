class ProductsController < ApplicationController
  def index
    @q = Product.order("catalog_page_number").ransack(params[:q])
    @products = @q.result
  end

  def show
    @product = Product.includes(:suppliers).find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    
    if @product.save
      redirect_to products_url, notice: "「#{@product.name}」をカタログへ追記しました。"
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to action: :show, notice: "「#{@product.name}」の情報を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_url, notice: "「#{@product.name}」のレコードを削除しました。"
  end

  private

  def product_params
    params.require(:product).permit(
      :catalog_page_number, :code, :name, :spec, :carton, :unit, :prepayment, :is_separate, 
      :is_original, :location, :due_date, :same_day_shipping, :shipping_rate, 
      :hokkaido_shipping_rate, :notes, :status)
  end
end
