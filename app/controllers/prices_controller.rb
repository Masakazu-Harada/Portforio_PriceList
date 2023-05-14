class PricesController < ApplicationController
  def index
    @product = Product.find(params[:product_id])
    @prices = @product.prices
  end

  
  def new
    @product = Product.find(params[:product_id])
      Rank.all.default_order.each do |rank|
        @product.prices.build(rank: rank)
      end
  end

  def create
    @product = Product.find(params[:product_id])
    params[:price].each do |price_params|
      rank = Rank.find(price_params[:rank_id])
      price = @product.prices.new(price: price_params[:price], rank: rank)
      unless price.save
        redirect_to products_path, alert: "価格の登録に失敗しました。"
        return
      end
    end
    redirect_to product_path(@product), notice: "「#{@product.name}」の売価をカタログへ登録しました。"
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
  end

  def price_params
    params.require(:price).map do |price|
      price.permit(:price, :rank_id)
    end
  end
end
