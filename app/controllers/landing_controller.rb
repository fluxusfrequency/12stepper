class LandingController < ApplicationController

  def index
    if current_user
      redirect_to entries_path
    else
      @user = User.new
    end
  end

end
