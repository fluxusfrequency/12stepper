class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    # redirect_to user_path(user)
    user = User.new(user_params)
    if user.save
      redirect_to user_path(user), :notice => "Signed up!"
    else
      render "new"
    end
  end

  def show

  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
