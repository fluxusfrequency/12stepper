class UsersController < ApplicationController
  before_action :authorize!, except: :create

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Your account has been created"
      redirect_to root_path
    else
      render "sessions/new", :layout => "landing"
    end
  end

  def update
    I18n.locale = params[:user][:locale]
    current_user.update(user_params)
    if current_user.save
      flash[:notice] = t("flash.account_update_success")
    else
      flash[:notice] = t("flash.account_update_failure")
    end
    redirect_to edit_user_path(current_user)
  end

  def edit

  end

  def show
    unless params[:id] == current_user.id
      redirect_to root_path, :notice => "You aren't authorized to do that."
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :last_drink, :locale)
  end

end
