class ProductsController < ApplicationController
  def index
    @q = Product.order("catalog_page_number").ransack(params[:q])
    @products = @q.result
  end

  def show
    @product = Product.find(params[:id])
    
    @rank_prices = {}
    Rank.all.default_order.each do |rank|
      price = @product.prices.find_by(rank: rank)
    @rank_prices[rank.name] = price.present? ? price.price : nil
    end
    @price_revisions = @product.product_suppliers.pluck(:cost_revision_date, :future_cost)
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
    params.require(:product).permit(:name, :code, :catalog_page_number, :spec, :is_original)
  end
end
