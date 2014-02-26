class Friends::SearchController < ApplicationController
  def new
    @pending = current_user.friendships.pending
  end

  def create
    
  end

  def index
    @users = User.where(username: params[:friend_search_input]).reject do |u| 
      current_user.all_friendships_and_inverse_friendships.include?(u) || u == current_user
    end
  end

end