class BigBook::ChaptersController < ApplicationController
  def index
    @chapters = BigBook::Chapter.all
  end

end