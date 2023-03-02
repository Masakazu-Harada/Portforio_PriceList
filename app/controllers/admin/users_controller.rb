class Admin::UsersController < ApplicationController
  def new
    @user = User.new
    department = Department.all
    @department = department.name
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_user_url(@user), notice: "社員「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def index
  end

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end
end
