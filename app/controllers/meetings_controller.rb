class MeetingsController < ApplicationController
  before_action :authorize!
  # layout 'meetings'

  def index

  end

  def search_meetings
    coords = MeetingFinder::Search.find_lat_long_from(params[:address])
    lat_lng =
    @meetings = MeetingFinder::Search.by_lat_lng(coords.first, coords.last)
    package = {meetings: @meetings, search: lat_lng}
    respond_to do |format|
      format.html
      format.json { render json: @meetings }
    end
  end

end
