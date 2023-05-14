class Products::SuppliersController < ApplicationController
  before_action :set_product

  def new
    @suppliers = Supplier.all
    @ranks = Rank.all
  end

  def create
    @product.product_suppliers.destroy_all
    suppliers_ids = params[:suppliers].compact_blank
    suppliers = Supplier.where(id: suppliers_ids)
    @product.suppliers << suppliers
    if @product.save
      redirect_to product_path(@product)
    else
      render :new, notice: "仕入先の設定に失敗しました。"
    end
  end

  def cost_update
    params["cost"].each do |cost|
      prod_supp = @product.product_suppliers.find(cost["supplier_id"])
      prod_supp.current_cost = cost["current_cost"]
      prod_supp.future_cost = cost["future_cost"]
      prod_supp.price_revision_date = cost["cost_revision_date"]
      prod_supp.save
    end
    redirect_to product_path(@product)
  end

  def new_cost
    @suppliers = Supplier.all
    @ranks = Rank.all
  end

  def create_cost
    cost_data = params[:cost].map { |cost| cost_params(cost) }
    cost_data.each do |cost|
      product_supplier = @product.product_suppliers.find_or_initialize_by(supplier_id: cost[:supplier_id])
      product_supplier.future_cost = cost[:raise_cost]
      product_supplier.cost_revision_date = cost[:cost_revision_date]
      product_supplier.save
    end
    redirect_to product_path(@product)
  end

  def cost_increase_history
    @cost_increase_histories = @product.cost_increase_histories.order(cost_revision_date: :desc)
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def cost_params(cost)
    cost.permit(:current_cost, :supplier_id, :raise_cost, :cost_revision_date)
  end 

  def product_supplier_params
    params.require(:product_supplier).permit(:current_cost, :supplier_id, :future_cost, :cost_revision_date)
  end
end
