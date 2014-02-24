class WorksheetEntriesController < ApplicationController

  def new
    if params[:step]
      @entry = current_user.entries.find_or_create_by(step: params[:step].to_i)
    else
      @entry = Entry.new
    end
    @worksheet = Worksheet.where(step: 1, locale: I18n.locale.to_s).first
    @worksheet_entries = Worksheet.where(step: 1, locale: I18n.locale.to_s)
  end

  def create
    entry = Entry.find_by(id: params["entry"]["entry_id"].to_i)
    if entry
      entry.update_attributes(entry_params)
    else
      entry = Entry.new(entry_params)
    end
    entry.update_attributes(user_id: current_user.id)
    redirect_to entries_path
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :body, :step, :section)
  end
end
