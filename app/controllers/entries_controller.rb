class EntriesController < ApplicationController

  def index
    if current_user
      @entries = current_user.entries
    end
  end

  def new
    @entry = Entry.new
  end

  def create
    entry = Entry.new(entry_params)
    entry.user_id = current_user.id
    if entry.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @entry = current_user.entries.where(id: params[:id]).first
  end

  def update
    entry = Entry.find(params[:id])
    e = entry.update_attributes(entry_params)
    redirect_to root_path
  end


  def entry_params
    params.require(:entry).permit(:title, :body, :step)
  end

end
