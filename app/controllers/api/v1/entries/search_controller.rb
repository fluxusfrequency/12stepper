class Api::V1::Entries::SearchController < ApplicationController
  respond_to :json

  def show
    found = Entry.where(user_id: current_user.id).select do |record|
      record.body.downcase.include?(params[:query].to_s.downcase)
    end

    respond_with found
  end
  
end