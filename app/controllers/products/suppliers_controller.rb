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

      prod_supp.current_cost = cost['cost_price']

      prod_supp.save
    end
  end

  def new_cost
    @product = Product.find(params[:product_id])
    @suppliers = Supplier.all
  end

  def create_cost
    @product = Product.find(params[:product_id])
    cost_params = params[:cost]

    cost_params.each do |cost|
      product_supplier = @product.product_suppliers.find_or_initialize_by(supplier_id: cost[:supplier_id])
      product_supplier.current_cost = cost[:cost_price]
      product_supplier.save
    end

    redirect_to @product
  end
end
