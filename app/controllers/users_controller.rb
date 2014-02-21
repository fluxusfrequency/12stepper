class UsersController < ApplicationController

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
      render "new"
    end
  end

  def update
    raw_date = user_params["last_drink"].split("/")
    formatted_date = [raw_date[-1], raw_date[0], raw_date[1]].join("-")

    current_user.update(user_params)
    current_user.update_attributes(last_drink: formatted_date)
    redirect_to edit_user_path(current_user)
  end

  def edit

  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :last_drink)
  end

end
