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
        redirect_to user_path(user)
      else
        render :text => "Found the user #{user}, but the PW was wrong"
      end
    else
      binding.pry
      render :new, flash[:error] => "You entered an invalid email or password, please try again."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to pages_path
  end


end

