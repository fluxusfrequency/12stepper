class BigBook::ChaptersController < ApplicationController
  def index
    @chapter = BigBook::Chapter.first
    @chapter_titles = BigBook::Chapter.all.select(:title)
  end

end