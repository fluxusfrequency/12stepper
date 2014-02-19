class MeetingsController < ApplicationController

  def index

  end

  def search_meetings
    coords = MeetingFinder::Search.find_lat_long_from(params[:zipcode])
    @meetings = MeetingFinder::Search.by_lat_lng(coords.first, coords.last)
  end

end
