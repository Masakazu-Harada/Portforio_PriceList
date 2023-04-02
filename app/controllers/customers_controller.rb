class CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def create
    customer = Customer.new
    customer.save!
    redirect_to customers_url, notice: "「#{customer.name}」のレコードを追加しました。"
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :share)
    params.require(:rank).permit(:name)
  end
end
