class SessionsController < ApplicationController
  layout 'landing', only: [:new, :create]
  before_action :authorize!, only: :destroy

  def new
    @user = User.new
  end

  def create
    email = params[:email]
    password = params[:password]

    user = User.find_by(email: email)

    if user
      result = user.authenticate(password)
      if result
        @user = user.decorate
        I18n.locale = @user.locale
        session[:user_id] = result.id
        flash[:notice] = t("flash.signin")
        flash[:success] = @user.display_milestone_congrats if @user.display_milestone_congrats
        redirect_to root_path
      else
        display_error_message
        redirect_to login_path
      end
    else
      @user = User.new
      display_error_message
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = t("flash.signout")
    redirect_to new_session_path
  end

  private

  def display_error_message
    flash[:error] = t("flash.invalid_credentials")
  end


end

