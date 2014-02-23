class SessionsController < ApplicationController
  layout 'landing', only: [:new, :create]
  before_action :authorize!, only: :destroy
  include UsersHelper

  def new
    @user = User.new
  end

  def create
    email = params[:email]
    password = params[:password]

    @user = User.find_by(email: email)

    if @user
      result = @user.authenticate(password)
      if result
        session[:user_id] = result.id
        display_milestone_congrats(@user)
        flash[:notice] = t("flash.signin")
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

  def display_milestone_congrats(user)
    milestone = days_ago(user.last_drink)
    if [1, 10, 30, 90, 365].include?(milestone)
      flash[:success] = t("flash.milestone") + " " + milestone.to_s + " " +
        t("navbar.sober") + "!"
    end
  end


end

