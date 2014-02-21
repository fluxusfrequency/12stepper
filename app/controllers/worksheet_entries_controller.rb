class WorksheetEntriesController < ApplicationController

  def new
    @entry = Entry.new
  end
end
