class SessionsController < ApplicationController
  skip_before_action :login_required
  
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      if user.employee? # 社員の場合
        redirect_to root_url, notice: "ログインしました。"
      else # お客様の場合
        redirect_to customer_dashboards_url, notice: "ログインしました。"
      end
    else
      render :new
    end
  end

  #def create
    #user = User.find_by(email: session_params[:email]) || Customer.find_by(email: session_params[:email])
    #if user&.authenticate(session_params[:password])
      #session[:user_id] = user.id
      #if user.employee? # 社員の場合
        #redirect_to root_url, notice: "ログインしました。"
      #else # お客様の場合
        #redirect_to customer_dashboards_url, notice: "ログインしました。"
      #end
    #else
      #render :new
    #end
  #end

  def destroy
    reset_session
    redirect_to login_url, notice: "ログアウトしました。"
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
