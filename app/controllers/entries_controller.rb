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
    entry.user_id = current_user.id
    if entry.save
      redirect_to entries_path
    else
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
    e = entry.update_attributes(entry_params)
    redirect_to root_path
  end

  def destroy
    entry = Entry.find(params[:id])
    if entry.destroy
      flash[:notice] = "Entry was deleted!"
      redirect_to entries_path
    else
      flash[:notice] = "Couldn't delete your entry."
      render :index
    end

  end

  private

  def entry_params
    params.require(:entry).permit(:title, :body, :step)
  end

end
