class SessionsController < ApplicationController
  layout 'landing', only: [:new, :create]
  before_action :authorize!, only: :destroy

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
        flash[:notice] = "Signed In!"
        redirect_to root_path
      else
        display_error_message
        render :new
      end
    else
      @user = User.new
      display_error_message
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Successfully signed out."
    redirect_to new_session_path
  end

  private

  def display_error_message
    flash[:error] = "You entered an invalid email or password, please try again."
  end


end

