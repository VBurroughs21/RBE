class SessionsController < ApplicationController
   skip_before_action :require_login, :only => [:login, :register, :logout]
   skip_before_action :get_user, :only => [:login, :register, :logout]

  # Login in user
  def login
    user = User.find_by_email(params[:user]['email']).try(:authenticate, params[:user]['password'])

    if user
      session[:user_id] = user.id
      redirect_to '/songs'
    else
      flash[:notice] = "Invalid login"
      redirect_to '/'
    end
  end

  # Register new user
  def register
    user = User.new(user_params)
    if user.valid?
      user.save
      session[:user_id] = user.id
      redirect_to '/songs'
    else 
      flash[:errors] = user.errors.messages
      redirect_to '/'
    end
  end

  
  def logout
    session.clear
    redirect_to '/'
  end

  private 
  def user_params
   params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
