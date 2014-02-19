class Api::V1::BigBook::SearchController < ApplicationController
  respond_to :json

  def show
    respond_with Search.in_big_book(params[:query])
  end
  
end