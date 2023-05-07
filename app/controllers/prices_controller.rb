class PricesController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
  end

  def create
    @product = Product.find(params[:product_id])
    params['price'].each do |price_record|
      price = @product.prices.find_by(rank_id: price_record['rank_id'])
      price.current_price = price_record['price']
      price.save
    end
    redirect_to products_url, notice: "「#{@product.name}」の売価をカタログへ登録しました。"
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
  end

end
