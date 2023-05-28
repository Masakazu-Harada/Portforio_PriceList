class ProductSuppliersController < ApplicationController
  before_action :set_product
  before_action :set_product_supplier, only: [:show, :edit, :update]

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
    @product.supplier_ids = product_supplier_params[:supplier_ids].reject(&:blank?)
    if @product.save
      redirect_to product_path(@product), notice: "#{@product.name}の仕入れ先を登録しました。"
    else
      render :new
    end
  end

  def edit
    #before_actionで設定
  end
  
  def update
    # before_actionで設定
    if @product_supplier.update(product_supplier_params)
      redirect_to product_product_suppliers_path(@product), notice: "商品と仕入先の紐付けを更新しました。"
    else
      render :edit
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
    params.require(:product_supplier).permit(supplier_ids: [])
  end
end
