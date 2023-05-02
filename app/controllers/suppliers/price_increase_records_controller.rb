class Suppliers::PriceIncreaseRecordsController < ApplicationController
  def index
    @supplier = Suppkier.find(params[:supplier_id])
    @products = @supplier.products
  end
end
