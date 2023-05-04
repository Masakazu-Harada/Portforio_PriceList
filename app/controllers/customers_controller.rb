class CustomersController < ApplicationController
  def index
    @q = Customer.ransack(params[:q])
    @customers = @q.result
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(
      name: params[:customer][:name],
      rank: Rank.find(params[:customer][:rank_id]),
      share: params[:customer][:share]
    )
    @customer.save!
    redirect_to customers_url, notice: "「#{@customer.name}」のレコードを追加しました。"
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    customer = Customer.find(params[:id])
    customer.update!(customer_params)
    redirect_to customers_url, notice: "「#{customer.name}」のレコードを更新しました。"
  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to customers_url, notice: "「#{@customer.name}」のレコードを削除しました。"
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :share, :rank_id)
  end
end
