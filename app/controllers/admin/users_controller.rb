class Admin::UsersController < ApplicationController
  before_action :set_departments, only: %i[new edit create update]

  def index
    @users = User.where.not(user_type: "Customer").includes(:affiliations)
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_url(@user), notice: "社員「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_url(@user), notice: "「#{@user.name}」のレコードを更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_url, notice: "「#{@user.name}」のレコードを削除しました。"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation, department_ids:[])
  end

  def set_departments
    @departments = Department.all
  end
end
