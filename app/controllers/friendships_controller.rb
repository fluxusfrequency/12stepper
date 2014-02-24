class FriendshipsController < ApplicationController
  def index
    @friendships = current_user.friendships
  end

  def create
    @friendship = current_user.friendships.new
    @friendship.update_attributes(status: 'pending', friend_id: params[:friendship][:user_id])
    if @friendship.save
      flash.notice = "Your friend request was sent."
    else
      flash.notice = "There was a problem submitting your friend request."
    end
    redirect_to new_friends_search_path
  end

end