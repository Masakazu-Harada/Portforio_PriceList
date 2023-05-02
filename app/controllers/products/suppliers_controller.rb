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
    cost_data = params[:cost].map { |cost| cost_params(cost) } # ストロングパラメータを適用
  
    cost_data.each do |cost|
      product_supplier = @product.product_suppliers.find_or_initialize_by(supplier_id: cost[:supplier_id])
      product_supplier.current_cost = cost[:cost_price]
      product_supplier.future_cost = cost[:raise_cost]
      product_supplier.price_revision_date = cost[:price_revision_date]
      product_supplier.save

      # 値上げ情報が変更された場合、PriceIncreaseRecord を作成
      if previous_cost != product_supplier.current_cost
        PriceIncreaseHistory.create!(
          product_supplier_id: product_supplier.id,
          price_revision_date: product_supplier.price_revision_date
          old_cost: previous_cost,
          new_cost: product_supplier.current_cost
        )
      end
    end

    redirect_to @product
  end

  private

  def cost_params(cost)
    cost.permit(:cost_price, :supplier_id, :raise_cost, :price_revision_date)
  end  
end
