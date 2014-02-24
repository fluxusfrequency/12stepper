class FriendshipsController < ApplicationController
  def index
    @friendships = current_user.friendships.approved 
    @inverse_friendships = current_user.inverse_friendships.approved
    @pending = current_user.inverse_friendships.pending
  end

  def create
    @friendship = current_user.friendships.new
    @friendship.update_attributes(status: 'pending', friend_id: params[:friendship][:user_id])
    if @friendship.save
      flash.notice = t("flash.friend_request_sent")
    else
      flash.notice = t("flash.friend_request_failed")
    end
    redirect_to new_friends_search_path
  end

  def update
    @friendship = current_user.inverse_friendships.find(params[:id])
    @friendship.update_attributes(status: "approved")
    flash[:notice] = t("flash.friendship_approved") + " " + @friendship.user.username + "."
    redirect_to :back
  end

end