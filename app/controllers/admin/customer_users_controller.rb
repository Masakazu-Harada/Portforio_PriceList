class Admin::CustomerUsersController < ApplicationController
  before_action :set_customer_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @users = User.customer.includes(:customer)
  end

  def show
  end

  def new
    @user = User.new
    @customer = Customer.all
  end

  def create
    @user = User.new(user_params)
    @user.user_type = "customer"

    if @user.save
      redirect_to admin_customer_user_url(@user), notice: "お客様アカウントのレコードが更新されました。"
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_customer_users_path, notice: "お客様アカウントのレコードが削除されました。"
  end

  def set_customer_user
    @user = User.customers.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :customer_id)
  end
end
