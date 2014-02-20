class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    # redirect_to user_path(user)
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Your account has been created"
      redirect_to user_path(@user)
    else
      render "new"
    end
  end

  def edit
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
