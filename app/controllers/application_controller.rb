class ApplicationController < ActionController::Base
  
  add_flash_types :success, :info, :warning, :danger
  helper_method :current_user
  before_action :login_required

  private

  def current_user
    if session[:user_type] = "user"
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    elsif session[:user_type] = "customer"
      @current_user ||= Customer.find_by(id: session[:user_id]) if session[:user_id]
    end
  end

  def login_required
    redirect_to login_url unless current_user
  end
end
