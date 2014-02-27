class StatusesController < ApplicationController
  before_action :authorize!, only: [:create, :edit, :update]

  def index
    return redirect_to login_path unless current_user
      
    @statuses = current_user.statuses.take(10)
    unless current_user.approved_friends.compact.empty?
      @statuses << current_user.approved_friends.map {|friend| friend.statuses.take(10)}
    end
    @statuses = StatusDecorator.decorate_collection(@statuses.flatten.sort)

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

  def edit
    authorize_status_user
  end

  def update
    authorize_status_user

    @status.update_attributes(content: params[:status][:content])
    if
      flash[:notice] = t('flash.status_update_success')
    else
      flash[:notice] = t('flash.status_save_failure')
    end
    redirect_to root_path
  end

  def destroy
    authorize_status_user
    if @status.destroy
      flash[:notice] = t('flash.status_delete_success')
    else
      flash[:notice] = t('flash.status_delete_failure')
    end
    redirect_to root_path
  end

  private

  def authorize_status_user
    @status = Status.find(params[:id]).decorate
    if @status.user != current_user
      flash[:notice] = t('flash.unauthorized')
      return redirect_to root_path
    end
  end

end