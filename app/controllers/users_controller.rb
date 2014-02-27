class UsersController < ApplicationController
  before_action :authorize!, except: [:index, :create, :show]

  def index
    redirect_to login_path(locale: params[:locale])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.update_attributes(locale: params[:locale])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = t("flash.account_create_success")
      redirect_to help_index_path
    else
      render "sessions/new", :layout => "landing"
    end
  end

  def show
    @user = User.find_by(username: params[:username]).decorate
    if current_user.is_friends_with?(@user)
      @statuses = StatusDecorator.decorate_collection(@user.statuses.take(30))
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
    redirect_to edit_profile_path
  end

  def edit
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :bio, :password, :password_confirmation, :locale, :last_drink)
  end

end
