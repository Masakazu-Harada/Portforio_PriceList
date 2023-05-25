class ProductSuppliersController < ApplicationController
  before_action :set_product
  before_action :set_product_supplier, only: [:show]

  def index
    @product_suppliers = @product.product_suppliers
  end

  def show
    # 実装予定
  end

  def new
    @product_supplier = @product.product_suppliers.new
  end

  def create
    @product_supplier = @product.product_suppliers.new(product_supplier_params)
    if @product_supplier.save
      redirect_to product_product_suppliers_path(@product), notice: "#{@product.name}の仕入れ先を登録しました。"
    else
      render :new
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_product_supplier
    @product_supplier = @product.product_suppliers.find(params[:id])
  end

  def product_supplier_params
    params.require(:product_supplier).permit(:supplier_id)
  end
end
