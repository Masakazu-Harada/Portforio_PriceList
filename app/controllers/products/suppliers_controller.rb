class Products::SuppliersController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @suppliers = Supplier.all
  end
  def create
    @product = Product.find(params[:product_id])
    @product.product_suppliers.each { |v| v.delete }
    suppliers_ids = params[:suppliers].compact_blank
    suppliers = Supplier.where(id: suppliers_ids)
    @product.suppliers << suppliers
    if @product.save
      redirect_to @product
    else
      render :new, notice: '仕入先の設定に失敗しました'
    end
  end

  def index
    @product = Product.find(params[:product_id])
  end

  def cost_update
    @product = Product.find(params[:product_id])
    params['cost'].each do |cost|
      prod_supp = @product.product_suppliers.find(cost['supplier_id'])

      #prod_supp.update(cost_price: cost['cost_price'])

      prod_supp.cost_price = cost['cost_price']

      prod_supp.save
    end
  end
end
