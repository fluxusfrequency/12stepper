class MeetingsController < ApplicationController
  before_action :authorize!

  def index

  end

  def search_meetings
    coords = MeetingFinder::Search.find_lat_long_from(params[:address])
    @meetings = MeetingFinder::Search.by_lat_lng(coords.first, coords.last)
    respond_to do |format|
      format.html
      format.json { render json: @meetings }
    end
  end

end
