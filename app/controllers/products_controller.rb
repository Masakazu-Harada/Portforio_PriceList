class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    product = Product.new(product_params)
    product.save!
    redirect_to products_url, notice: "「#{product.name}」をカタログへ追記しました。"
  end

  def edit
  end

  private

  def product_params
    params.require(:product).permit(:name, :code, :catalog_page_number, :spec, :is_original)
  end
end
