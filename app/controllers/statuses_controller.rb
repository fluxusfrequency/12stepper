class StatusesController < ApplicationController
  before_action :authorize!, only: [:create]

  def index
    return redirect_to login_path unless current_user
      
    @statuses = current_user.statuses.take(10)
    @statuses << current_user.approved_friends.map {|friend| friend.statuses.take(10)}
    @statuses.flatten!

    @status = current_user.statuses.new
  end

  def create
    @status = Status.new(user_id: current_user.id, content: params[:status][:content])
    if @status.save
      flash[:notice] = t('flash.status_save_success')
    else
      flash[:notice] = t('flash.status_save_failure')
    end
    redirect_to root_path
  end
end