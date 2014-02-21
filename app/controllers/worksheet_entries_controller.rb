class WorksheetEntriesController < ApplicationController

  def new
    @entry = Entry.new(step: params[:step].to_i)
    @worksheets = Kaminari.paginate_array(Worksheet.where(step: params[:step].to_i)).page(params[:page]).per(1)


  end
end
