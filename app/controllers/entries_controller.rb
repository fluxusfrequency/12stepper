class EntriesController < ApplicationController
  before_action :authorize!

  def index
    @entries = current_user.entries
  end

  def new
    @entry = Entry.new
  end

  def create
    entry = Entry.new(entry_params)
    entry.update_attributes(user_id: current_user.id)

    if entry.save
      return share(entry) if params[:commit] == "Save and Share"
      flash[:notice] = t('flash.entry_save_success')
      redirect_to entries_path
    else
      flash[:notice] = t('flash.entry_save_failure')
      render :new
    end
  end

  def edit
    @entry = current_user.entries.where(id: params[:id]).first
    if @entry.section && @entry.step
      worksheets = Worksheet.where(step: @entry.step)
      @worksheet = worksheets.select {|worksheet| worksheet.title == @entry.section }.first
    end
  end

  def update
    entry = Entry.find(params[:id])
    entry.update_attributes(entry_params)
    if params[:commit] == "Save and Share" || params[:commit] == "Share"
      return share(entry)
    end
    redirect_to root_path
  end

  def destroy
    entry = Entry.find(params[:id])
    if entry.destroy
      flash[:notice] = t("flash.entry_delete_success")
      redirect_to entries_path
    else
      flash[:notice] = t("flash.entry_delete_failure")
      render :index
    end

  end

  def share_entry
    entry = current_user.entries.find(params[:id])
    return share(entry)
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :body, :step, :section)
  end

  def share(entry)
    status = current_user.statuses.build(content: entry.to_status)
    if status.valid? && entry.valid?
      status.save
      entry.save
      flash[:notice] = t('flash.entry_share_success')
      redirect_to root_path
    else
      flash[:notice] = ("flash.entry_share_failure")
      redirect_to :back
    end
  end

end
