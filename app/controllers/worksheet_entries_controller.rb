class WorksheetEntriesController < ApplicationController

  def new
    entry = current_user.entries.select{|entry| entry.step == 1 && entry.section == "Session 1"}.first
    # entry = current_user.entries.find_or_create_by(step: 1, section: "Session 1")
    @entry = entry ? entry : Entry.new
    @worksheet = Worksheet.where(step: 1, locale: I18n.locale.to_s).first
    @worksheet_entries = Worksheet.where(step: 1, locale: I18n.locale.to_s)
  end

  def create
    entry = current_user.entries.select{|entry| entry.id == params["entry"]["entry_id"].to_i}.first
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
