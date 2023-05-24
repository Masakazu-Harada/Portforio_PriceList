class ProductSuppliersController < ApplicationController
  before_action :set_product
  before_action :set_product_supplier, only: [:show, :add_cost, :update_cost]

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

  def add_cost
    if @product_supplier.update(initial_cost: params[:initial_cost])
      redirect_to product_product_supplier_path(@product, @product_supplier), notice: "#{@product.name}の仕入れ原価を登録しました。"
    else
      flash.now[:alert] = "仕入れ原価の登録に失敗しました。"
      render :edit
    end
  end

  def update_cost
    if @product_supplier.update(cost: params[:cost], cost_changed_at: params[:cost_changed_at])
      redirect_to product_product_supplier_path(@product, @product_supplier), notice: "#{@product.name}の仕入れ原価を更新しました。"
    else
      flash.now[:alert] = "仕入れ原価の更新に失敗しました。"
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
    params.require(:product_supplier).permit(:supplier_id)
  end
end
