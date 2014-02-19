class Api::V1::BigBook::ChaptersController < ApplicationController
  respond_to :json

  def index
    respond_with BigBook::Chapter.all
  end

  def show
    @chapter = BigBook::Chapter.find(params[:id])
    respond_with @chapter
  end
  
end