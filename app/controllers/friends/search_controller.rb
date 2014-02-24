class Friends::SearchController < ApplicationController
  def new
  end

  def create
    
  end

  def index
    @users = User.where(:username == params[:friend_name])
  end

end