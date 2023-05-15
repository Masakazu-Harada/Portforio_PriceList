class PricesController < ApplicationController
  def index
    @products = Product.all.includes(:prices, :user)
    @ranks = Rank.all
  end

  def new
    @product = Product.find(params[:product_id])
    @prices = Rank.all.default_order.map do |rank|
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
    @price = Price.find(params[:id])
  end

  def update
    @price = Price.find(params[:id])
    if @price.update(price_params)
      redirect_to prices_path, notice: "価格が更新されました。"
    else
      flash.now[:alert] = "価格の更新に失敗しました。"
      render :edit
    end
  end

  private

  def price_params
    params.require(:price).permit(:price, :rank_id)
  end
end
