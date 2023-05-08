class Products::SuppliersController < ApplicationController
  def index
    @product = Product.find(params[:product_id])
  end
  
  def new
    @product = Product.find(params[:product_id])
    @suppliers = Supplier.all
    @ranks = Rank.all
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

  def cost_update
    @product = Product.find(params[:product_id])
  params['cost'].each do |cost|
    prod_supp = @product.product_suppliers.find(cost['supplier_id'])

    previous_cost = prod_supp.current_cost
    prod_supp.current_cost = cost["cost_price"]

    if prod_supp.save && previous_cost != prod_supp.current_cost
      CostIncreaseHistory.create!(
        product_supplier_id: prod_supp.id,
        price_revision_date: prod_supp.price_revision_date,
        old_cost: previous_cost,
        new_cost: prod_supp.current_cost,
        user_id: current_user.id
      )
    end
  end
  end

  def new_cost
    @product = Product.find(params[:product_id])
    @suppliers = Supplier.all
    @ranks = Rank.all
  end

  def create_cost
    @product = Product.find(params[:product_id])
    cost_data = params[:cost].map { |cost| cost_params(cost) } # ストロングパラメータを適用
    price_data = params[:price].map { |price| price_params(price) } # ストロングパラメータを適用

    cost_data.each do |cost|
      product_supplier = @product.product_suppliers.find_or_initialize_by(supplier_id: cost[:supplier_id])
      previous_cost = product_supplier.current_cost
      product_supplier.current_cost = cost[:cost_price]
      product_supplier.future_cost = cost[:raise_cost]
      product_supplier.price_revision_date = cost[:price_revision_date]
      product_supplier.save

      # 値上げ情報が変更された場合、CostIncreaseHistory を作成
      if previous_cost != product_supplier.current_cost
        CostIncreaseHistory.create!(
          product_supplier_id: product_supplier.id,
          price_revision_date: product_supplier.price_revision_date,
          old_cost: previous_cost,
          new_cost: product_supplier.current_cost,
          user_id: current_user.id
        )
      end
    end
    price_data.each do |price|
      product_price = @product.prices.find_or_initialize_by(rank_id: price[:rank_id])
      product_price.current_price = price[:price]
      product_price.save
    end

    redirect_to @product
  end

  def price_increase_history
    @product = Product.find(params[:product_id])
    @price_increase_histories = @product.price_increase_histories.order(price_revision_date: :desc)
  end

  private

  def cost_params(cost)
    cost.permit(:cost_price, :supplier_id, :raise_cost, :price_revision_date)
  end  

  def price_params(price)
    price.permit(:price, :rank_id)
  end
end
