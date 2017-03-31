class UsersController < ApplicationController
  skip_before_action :require_login, :only => [:index]
  skip_before_action :get_user, :only => [:index, :edit]
  
  def index
  end

  def show
    @viewing = User.find(params[:user_id])
    @songs = Playlist.where(user: params[:user_id])
  end
end
