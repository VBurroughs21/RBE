class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login

  before_action :get_user

  private
  def require_login
    unless session[:user_id]
      flash[:error] = "You must be logged in."
      redirect_to '/'
    end
  end

  def get_user
    @user = User.find(session[:user_id])
  end
end
