class Api::V1::Users::SearchController < ApplicationController
  respond_to :json

  def show
    found = User.where(username: params[:query].gsub("@", ""))

    names = found.pluck(:username)
    response = names.empty? ? 404 : names.to_json
    respond_with response
  end
  
end