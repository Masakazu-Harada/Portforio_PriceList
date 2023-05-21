class PricesController < ApplicationController
  def index
    @products = Product.all.includes(:prices).order(:catalog_page_number)
    @ranks = Rank.all
    @price_change_histories = PriceChangeHistory.includes(:user).all
  end

  def new
    @product = Product.find(params[:product_id])
    @prices = Rank.all.default_order.map do |rank|
      @product.prices.build(rank: rank)
    end
  end

  def create
    @product = Product.find(params[:product_id])
    errors = []
    params[:price].each do |price_params|
      rank = Rank.find(price_params[:rank_id])
      price = @product.prices.new(
        price: price_params[:price], 
        future_price: price_params[:future_price], 
        price_increase_date: price_params[:price_increase_date],
        rank: rank
      )
      unless price.save
        errors << "#{rank.name}の価格の登録に失敗しました"
      end
    end
    if erros.empty?
      redirect_to prices_path, notice: "「#{@product.name}」の売価をカタログへ登録しました。"
    else
      flash[:alert] = errors.join(", ")
      redirect_to new_product_price_path(@product)
    end
  end

  #def edit
    #@product = Product.find(params[:product_id])
    #@price = @product.prices.find(params[:id])
  #end

  #def update
    #@product = Product.find(params[:product_id])
    #@price = @product.prices.find(params[:id])
    #if @price.update(price_params)
      #redirect_to prices_path, notice: "価格が更新されました。"
    #else
      #flash.now[:alert] = "価格の更新に失敗しました。"
      #render :edit
    #end
  #end

  def bulk_edit
    @product = Product.find(params[:product_id])
    @prices = Price.where(product_id: @product.id).order(rank_id: :asc)
  end

  def bulk_update
    @product = Product.find(params[:product_id])
    price_params = params.require(:product).permit(prices: [:id, :rank_id, :price, :future_price, :price_increase_date])
    price_update_success = true
  
    price_params[:prices].each do |price_data|
      price = Price.find(price_data[:id])
      unless price.update(
        price: price_data[:price],
        future_price: price_data[:future_price],
        price_increase_date: price_data[:price_increase_date]
      )
        price_update_success = false
        flash.now[:alert] = "#{price.rank.name}の価格の更新に失敗しました。"
        @prices = Price.where(product_id: @product.id).order(rank_id: :asc) 
        render :bulk_edit
        return
      end
    end
  
    if price_update_success
      redirect_to prices_path, notice: "価格が一括で更新されました。"
    end
  end

  private

  def price_params
    params.require(:price).map do |price|
      price.permit(:price, :future_price, :price_increase_date, :rank_id)
    end
  end
end
