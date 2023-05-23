class PriceChangeHistoriesController < ApplicationController
  def index
    @price = Price.find(params[:price_id])
    @price_change_histories = @price.price_change_histories
  end
end
