class BigBook::ChaptersController < ApplicationController
  def index
    @chapters = BigBook::Chapter.all
  end

  # def edit
  #   @chapter = BigBook::Chapter.find(params[:id])
  # end

  # def update
  #   @chapter = BigBook::Chapter.find(params[:id])
  #   I18n.locale = :fr
  #   @chapter.update_attributes(title: params[:big_book_chapter][:title])
  #   @chapter.update_attributes(body: params[:big_book_chapter][:body])
  #   @chapter.save
  #   redirect_to big_book_path, :notice => "success!"
  # end

  # def chapter_params
  #   params.require(:big_book_chapter).permit(:title, :body)
  # end

end