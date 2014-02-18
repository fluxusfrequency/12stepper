class SessionsController < ApplicationController

  def new

  end

  def create
    email = params[:email]
    password = params[:password]

    user = User.find_by(email: email)

    if user
      result = user.authenticate(password)
      if result
        session[:user_id] = result.id
        flash[:notice] = "Signed In!"
        redirect_to user_path(user)
      else
        display_error_message
        render :new
      end
    else
      display_error_message
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Successfully signed out."
    redirect_to root_path
  end

  def display_error_message
    flash[:error] = "You entered an invalid email or password, please try again."
  end


end
