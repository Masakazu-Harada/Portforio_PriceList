class PricesController < ApplicationController
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result.includes(:prices).order(:catalog_page_number)
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
    @prices = Price.where(product_id: @product.id).order(rank_id: :asc)
    
    @price_params = price_params
    
    Price.transaction do
      @price_params.each do |price_data| 
        price = Price.find(price_data[:id])
        unless price.update(price_data)  
          flash.now[:alert] = "#{price.rank.name}の価格の更新に失敗しました。"
          @prices = Price.where(product_id: @product.id).order(rank_id: :asc)
          raise ActiveRecord::Rollback
        end
      end
    end
    
    if flash[:alert]
      render :bulk_edit
    else
      redirect_to prices_path, notice: "価格の更新が成功しました"
    end
  end

  private

  def price_params
    prices_params = params.require(:product).permit(:price_increase_date, prices: [:id, :rank_id, :price, :future_price])
    prices_params[:prices].map do |price|
      price.permit(:id, :price, :future_price, :rank_id).merge(price_increase_date: prices_params[:price_increase_date])
    end
  end  
end
