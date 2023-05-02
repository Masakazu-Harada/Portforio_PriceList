class Suppliers::PriceIncreaseRecordsController < ApplicationController
  def index
    @supplier = Supplier.find(params[:supplier_id])
    @products = @supplier.products
  end
end
