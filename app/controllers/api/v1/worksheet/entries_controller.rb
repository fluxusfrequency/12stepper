class Api::V1::Worksheet::EntriesController < ApplicationController
  respond_to :json

  def index
    entry = []
    step_id = params[:step] ? params[:step].to_i : nil
    if params[:section]
      entry = current_user.entries.where(step: step_id).select {|entry| entry.section == params[:section]}
      worksheet = Worksheet.where(step: step_id, locale: I18n.locale.to_s).select{|s| s.title == params["section"]}.first
      if worksheet.nil?
        worksheet = Worksheet.find(params["section"].to_i)
      end
      package = {entry: entry, worksheet: worksheet, step: step_id}
    else
      entry = current_user.entries.where(step: step_id).first
      worksheets = Worksheet.where(step: step_id, locale: I18n.locale.to_s)
      package = {entry: entry, worksheets: worksheets, step: step_id}
    end

    respond_with package
  end

  def create
    respond_with params
  end



end
