class BigBook::ChaptersController < ApplicationController
  def index
    @chapter = BigBook::Chapter.first
    @chapter_titles = BigBook::Chapter.all.select(:title)
  end

  # def edit
  #   @chapter = BigBook::Chapter.find(params[:id])
  # end

  # def update
  #   @chapter = BigBook::Chapter.find(params[:id])
  #   @chapter.update_attributes(chapter_params)
  #   @chapter.save
  #   redirect_to big_book_chapters_path
  # end

  # private

  # def chapter_params
  #   params.require(:big_book_chapter).permit(:body)
  # end
end