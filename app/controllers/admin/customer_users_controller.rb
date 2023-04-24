class Admin::CustomerUsersController < ApplicationController
  before_action :set_customer_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @users = User.where(user_type: "Customer").includes(:affiliations)
  end

  def show
  end

  def new
    @user = User.new
    @customers = Customer.all
  end

  def create
    @user = User.new(user_params)
    @user.user_type = "Customer"
    if @user.save
      flash[:notice] = "お客様アカウントが登録されました。"
      redirect_to admin_customer_users_path
    else
      @customers = Customer.all
      render :new
    end
  end

  def edit
    @customers = Customer.all
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "お客様アカウントが更新されました。"
      redirect_to admin_customer_users_path
    else
      @customers = Customer.all
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_customer_users_path, notice: "お客様アカウントのレコードが削除されました。"
  end

  def set_customer_user
    @user = User.where(user_type: "Customer").includes(:affiliations).find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :department_id, :user_type, :customer_id)
  end
end
